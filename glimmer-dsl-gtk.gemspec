# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer-dsl-gtk 0.0.5 ruby lib .

Gem::Specification.new do |s|
  s.name = "glimmer-dsl-gtk".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, ".".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2022-01-29"
  s.description = "Glimmer DSL for GTK - Ruby-GNOME Desktop Development GUI Library".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["girb".freeze]
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "bin/girb",
    "bin/girb_runner.rb",
    "glimmer-dsl-gtk.gemspec",
    "lib/glimmer-dsl-gtk.rb",
    "lib/glimmer/dsl/gtk/dsl.rb",
    "lib/glimmer/dsl/gtk/observe_expression.rb",
    "lib/glimmer/dsl/gtk/on_expression.rb",
    "lib/glimmer/dsl/gtk/operation_expression.rb",
    "lib/glimmer/dsl/gtk/property_expression.rb",
    "lib/glimmer/dsl/gtk/shape_expression.rb",
    "lib/glimmer/dsl/gtk/widget_expression.rb",
    "lib/glimmer/gtk.rb",
    "lib/glimmer/gtk/shape.rb",
    "lib/glimmer/gtk/shape/arc.rb",
    "lib/glimmer/gtk/shape/arc_negative.rb",
    "lib/glimmer/gtk/shape/circle.rb",
    "lib/glimmer/gtk/shape/path.rb",
    "lib/glimmer/gtk/shape/polygon.rb",
    "lib/glimmer/gtk/shape/polyline.rb",
    "lib/glimmer/gtk/shape/rectangle.rb",
    "lib/glimmer/gtk/shape/rounded_rectangle.rb",
    "lib/glimmer/gtk/shape/square.rb",
    "lib/glimmer/gtk/shape/triangle.rb",
    "lib/glimmer/gtk/widget_proxy.rb",
    "lib/glimmer/gtk/widget_proxy/application_proxy.rb",
    "lib/glimmer/gtk/widget_proxy/box_proxy.rb",
    "lib/glimmer/gtk/widget_proxy/drawing_area_proxy.rb",
    "lib/glimmer/gtk/widget_proxy/message_dialog_proxy.rb",
    "lib/glimmer/gtk/widget_proxy/window_proxy.rb",
    "samples/elaborate/tetris.rb",
    "samples/elaborate/tetris/model/block.rb",
    "samples/elaborate/tetris/model/game.rb",
    "samples/elaborate/tetris/model/past_game.rb",
    "samples/elaborate/tetris/model/tetromino.rb",
    "samples/elaborate/widget_gallery.rb",
    "samples/hello/hello_application.rb",
    "samples/hello/hello_button.rb",
    "samples/hello/hello_drawing_area.rb",
    "samples/hello/hello_drawing_area_manual.rb",
    "samples/hello/hello_entry.rb",
    "samples/hello/hello_world.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer-dsl-gtk".freeze
  s.licenses = ["LGPL".freeze]
  s.rubygems_version = "3.3.1".freeze
  s.summary = "Glimmer DSL for GTK".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer>.freeze, ["~> 2.6.0"])
    s.add_runtime_dependency(%q<os>.freeze, [">= 1.0.0", "< 2.0.0"])
    s.add_runtime_dependency(%q<gtk3>.freeze, ["~> 3.4.9"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, ["> 0"])
    s.add_development_dependency(%q<rake-tui>.freeze, ["> 0"])
  else
    s.add_dependency(%q<glimmer>.freeze, ["~> 2.6.0"])
    s.add_dependency(%q<os>.freeze, [">= 1.0.0", "< 2.0.0"])
    s.add_dependency(%q<gtk3>.freeze, ["~> 3.4.9"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["> 0"])
    s.add_dependency(%q<rake-tui>.freeze, ["> 0"])
  end
end

