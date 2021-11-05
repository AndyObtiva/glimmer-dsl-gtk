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

require 'glimmer/gtk/widget_proxy'

module Glimmer
  module Gtk
    class WidgetProxy
      # Proxy for Gtk window objects
      #
      # Follows the Proxy Design Pattern
      class WindowProxy < WidgetProxy
        DEFAULT_WIDTH = 190
        DEFAULT_HEIGHT = 150
        
        def post_add_content
          unless @initial_content_added
            @initial_content_added = true
            self.set_default_size(DEFAULT_WIDTH, DEFAULT_HEIGHT)
          end
        end
        
        def show
          super
          unless @shown_at_least_once
            @shown_at_least_once = true
            ::Gtk.main
          end
        end
        
        def present
          super
          unless @shown_at_least_once
            @shown_at_least_once = true
            ::Gtk.main
          end
        end
        
        def signal_connect(signal, &block)
          @destroy_signal_connected = true if signal.to_s.downcase == 'destroy'
          super
        end
        
        private
        
        def build_widget
          @gtk = ::Gtk::Window.new(*(@args.empty? ? [:toplevel] : normalize_args(@args))).tap do |new_window|
            new_window.signal_connect(:destroy) do
              # TODO in the future, make this yield to external signal connections that do not want to quit app on hitting the window close button
              ::Gtk.main_quit unless @destroy_signal_connected
            end
          end
        end
      end
    end
  end
end
