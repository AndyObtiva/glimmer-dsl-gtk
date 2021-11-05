# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Glimmer
  module Gtk
    # Proxy for Gtk widget objects
    #
    # Follows the Proxy Design Pattern
    class WidgetProxy
      class << self
        def exists?(keyword)
          ::Gtk.const_get(gtk_constant_symbol(keyword)) ||
            widget_proxy_class(keyword)
        end
        
        def create(keyword, parent, args, &block)
          widget_proxy_class(keyword).new(keyword, parent, args, &block)
        end
        
        def widget_proxy_class(keyword)
          descendant_keyword_constant_map[keyword] || WidgetProxy
        end
        
        def new_widget(keyword, args)
        end
        
        def constant_symbol(keyword)
          "#{keyword.camelcase(:upper)}Proxy".to_sym
        end
        
        def gtk_constant_symbol(keyword)
          keyword.camelcase(:upper).to_sym
        end
        
        def keyword(constant_symbol)
          constant_symbol.to_s.underscore.sub(/_proxy$/, '')
        end
        
        def descendant_keyword_constant_map
          @descendant_keyword_constant_map ||= add_aliases_to_keyword_constant_map(map_descendant_keyword_constants_for(self))
        end
        
        def reset_descendant_keyword_constant_map
          @descendant_keyword_constant_map = nil
          descendant_keyword_constant_map
        end
        
        def map_descendant_keyword_constants_for(klass, accumulator: {})
          klass.constants.map do |constant_symbol|
            [constant_symbol, klass.const_get(constant_symbol)]
          end.select do |constant_symbol, constant|
            constant.is_a?(Module) && !accumulator.values.include?(constant)
          end.each do |constant_symbol, constant|
            accumulator[keyword(constant_symbol)] = constant
            map_descendant_keyword_constants_for(constant, accumulator: accumulator)
          end
          accumulator
        end
        
        private
        
        def add_aliases_to_keyword_constant_map(keyword_constant_map)
          KEYWORD_ALIASES.each do |keyword, alias_keyword|
            keyword_constant_map[alias_keyword] = keyword_constant_map[keyword]
          end
          keyword_constant_map
        end
      end
      
      KEYWORD_ALIASES = {
#         'msg_box'       => 'message_box',
      }
      
      # gtk returns the contained Gtk object
      attr_reader :parent_proxy, :gtk, :args, :keyword, :block
      
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        build_widget
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent_proxy&.post_initialize_child(self)
      end
      
      # Subclasses may override to perform post initialization work on an added child (normally must also call super)
      def post_initialize_child(child)
        @gtk.add(child.gtk)
        child.gtk.show
      end
      
      def window_proxy
        found_proxy = self
        until found_proxy.nil? || found_proxy.is_a?(WindowProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end

      def respond_to?(method_name, *args, &block)
        respond_to_gtk?(method_name, *args, &block) ||
          super(method_name, true)
      end
      
      def respond_to_gtk?(method_name, *args, &block)
        @gtk.respond_to?(method_name, true) || @gtk.respond_to?("set_#{method_name}", true)
      end
      
      def method_missing(method_name, *args, &block)
        if @gtk.respond_to?("set_#{method_name}", true) && !args.empty?
          send_to_gtk("set_#{method_name}", *args, &block)
        elsif @gtk.respond_to?(method_name, true)
          send_to_gtk(method_name, *args, &block)
        else
          super
        end
      end
      
      def send_to_gtk(method_name, *args, &block)
        @gtk.send(method_name, *args, &block)
      end
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Libui::WidgetExpression.new, @keyword, &block)
      end
            
      private
      
      def build_widget
        @gtk = ::Gtk.const_get(WidgetProxy.gtk_constant_symbol(@keyword)).new(*normalize_args(@args))
      end
      
      def normalize_args(args)
        args.map do |arg|
          arg.is_a?(WidgetProxy) ? arg.gtk : arg
        end
      end
    end
  end
end

Dir[File.expand_path('./widget_proxy/*.rb', __dir__)].each {|f| require f}
