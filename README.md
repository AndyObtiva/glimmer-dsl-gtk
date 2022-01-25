# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for GTK 0.0.2
## Ruby-GNOME Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-gtk.svg)](http://badge.fury.io/rb/glimmer-dsl-gtk)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [GTK](https://www.gtk.org/) enables building desktop applications with [Ruby-GNOME](https://github.com/ruby-gnome/ruby-gnome).

[GTK](https://www.gtk.org/) (aka GIMP-Toolkit or [incorrectly] GNOME-Toolkit) is the premiere desktop GUI toolkit on [Linux](https://www.gtk.org/docs/installations/linux/), which also runs on [Mac](https://www.gtk.org/docs/installations/macos/) ([Quartz GTK+](https://wiki.gnome.org/Projects/GTK/OSX)) and [Windows](https://www.gtk.org/docs/installations/windows).

[Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk) aims to supercharge productivity and maintainability in developing [Ruby-GNOME](https://github.com/ruby-gnome/ruby-gnome) applications by providing a DSL similar to [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) having:
- Declarative DSL syntax that visually maps to the GUI widget hierarchy
- Convention over configuration via smart defaults and automation of low-level details
- Requiring the least amount of syntax possible to build GUI
- Custom Keyword support
- Bidirectional Data-Binding to declaratively wire and automatically synchronize GUI with Business Models
- Scaffolding for new custom widgets, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux.

Hello, World!

```ruby
window {
  title 'Hello, World!'
  
  label('Hello, World!')
}.show
```

Linux | Mac | Windows
------|-----|--------
![hello world screenshot Windows](/screenshots/glimmer-dsl-gtk-linux-hello-world.png) | ![hello world screenshot Mac](/screenshots/glimmer-dsl-gtk-mac-hello-world.png) | ![hello world screenshot Windows](/screenshots/glimmer-dsl-gtk-windows-hello-world.png)

NOTE: Glimmer DSL for GTK is currently in early alpha mode (incomplete proof-of-concept). If you want it developed faster, then [open an issue report](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues/new). I have completed some GitHub project features much faster before due to [issue reports](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues) and [pull requests](https://github.com/AndyObtiva/glimmer-dsl-gtk/pulls). Please help make better by contributing, adopting for small or low risk projects, and providing feedback. It is still an early alpha, so the more feedback and issues you report the better. Please help make better by contributing, adopting for small or low risk projects, and providing feedback. It is still an early alpha, so the more feedback and issues you report the better.

Other [Glimmer](https://rubygems.org/gems/glimmer) DSL gems you might be interested in:
- [glimmer-dsl-swt](https://github.com/AndyObtiva/glimmer-dsl-swt): Glimmer DSL for SWT (JRuby Desktop Development GUI Framework)
- [glimmer-dsl-opal](https://github.com/AndyObtiva/glimmer-dsl-opal): Glimmer DSL for Opal (Pure Ruby Web GUI and Auto-Webifier of Desktop Apps)
- [glimmer-dsl-tk](https://github.com/AndyObtiva/glimmer-dsl-tk): Glimmer DSL for Tk (MRI Ruby Desktop Development GUI Library)
- [glimmer-dsl-libui](https://github.com/AndyObtiva/glimmer-dsl-libui): Glimmer DSL for Tk (Prerequisite-Free Ruby Desktop Development GUI Library)
- [glimmer-dsl-xml](https://github.com/AndyObtiva/glimmer-dsl-xml): Glimmer DSL for XML (& HTML)
- [glimmer-dsl-css](https://github.com/AndyObtiva/glimmer-dsl-css): Glimmer DSL for CSS

## Prerequisites

### Linux

GNOME-based Linux installations do not need any pre-requisites since they have GTK built-in, so you can skip to [Setup](#setup) right away.

Still, if you run into issues installing the GTK gem in [Setup](#setup), you may try these commands first:
```
sudo apt-get install libgtk-3-dev
```

Or run this command if all else fails:
```
sudo apt install -y -V libgirepository1.0-dev
```

### Mac

On the Mac, make sure to:
- Have [Homebrew](https://brew.sh/) installed
- Run this [Homebrew](https://brew.sh/) command to have GTK display GUI icons: `brew install adwaita-icon-theme`

### Windows

Make sure to install [Ruby](https://www.ruby-lang.org) with MSYS & MING toolchains from [RubyInstaller](https://rubyinstaller.org/downloads/)

## Setup

### Option 1: Install

Run this command to install directly:
```
gem install glimmer-dsl-gtk
```

### Option 2: Bundler

Add the following to `Gemfile`:
```
gem 'glimmer-dsl-gtk', '~> 0.0.2'
```

And, then run:
```
bundle
```

## Usage

Require the library and mixin the `Glimmer` module to utilize the Glimmer GUI DSL for GTK:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Demo'
  
  on(:destroy) do
    puts 'Bye Bye'
    ::Gtk.main_quit
  end
}.show
```

For actual application development outside of simple demos, mixin the `Glimmer` module into a custom application class instead:

```ruby
require 'glimmer-dsl-gtk'

class SomeGlimmerApplication
  include Glimmer
  
  def launch
    application('org.glimmer.hello-application', :flags_none) {
      on(:activate) do |app|
        application_window(app) {
          title 'Actual Application'
        }.present
      end
    }.run
  end
end

SomeGlimmerApplication.new.launch
```

### Glimmer GUI DSL

- Keywords: All GTK widgets are supported via lowercase underscored names accepting their constructor args (e.g. `application_window(app)` for `Gtk::ApplicationWindow.new(app)`). Keywords can be nested under other keywords to represent the true hierarchy of nested widgets on the screen (e.g. `window { label('Hello') }` is a `label` nested under a `window`). Note that widget objects returned are proxies of the GTK widget counterparts. This shields consumers of GTK from its lower-level details via composition (Proxy Design Pattern). To access lower-level GTK widget, simply call `#gtk` method on widget proxy object (e.g. `@w = window {...}; @w.gtk # Gtk::Window widget object`).
- Content: widget keywords can have a block of content that could contain nested widget keywords, properties, and signals. The block can optionally receive one argument representing the widget (e.g. `window {|w| ... }`):
  - Properties: All GTK widget properties can be set via lowercase underscored names (without the 'set_' prefix) nested under widget keywords (e.g. `window {title 'Hello, World'}` sets `title` property of `window`)
  - Signals: All GTK signals can be wired with `on(signal) { ... }` syntax (e.g. `on(:activate) { do_something }`)

## Girb (Glimmer IRB)

You can run the `girb` command (`bin/girb` if you cloned the project locally):

```
girb
```

Linux

![girb screenshot linux](/screenshots/glimmer-dsl-gtk-linux-girb.png)

Mac

![girb screenshot mac](/screenshots/glimmer-dsl-gtk-mac-girb.png)

Windows

![girb screenshot windows](/screenshots/glimmer-dsl-gtk-windows-girb.png)

This gives you `irb` with the `glimmer-dsl-gtk` gem loaded and the `Glimmer` module mixed into the main object for easy experimentation with GUI.

Gotcha: On the Mac, when you close a window opened in `girb`, it remains open until you enter exit or open another GUI window.

## Samples

You may checkout the [samples](samples) directory for examples of using [Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk).

### Hello Samples

#### Hello, World!

[samples/hello/hello_world.rb](/samples/hello/hello_world.rb)

Linux | Mac | Windows
------|-----|--------
![hello world screenshot Windows](/screenshots/glimmer-dsl-gtk-linux-hello-world.png) | ![hello world screenshot Mac](/screenshots/glimmer-dsl-gtk-mac-hello-world.png) | ![hello world screenshot Windows](/screenshots/glimmer-dsl-gtk-windows-hello-world.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_world'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_world.rb
```

Code:

```ruby
window {
  title 'Hello, World!'
  
  label('Hello, World!')
}.show
```

#### Hello, Application!

[samples/hello/hello_application.rb](/samples/hello/hello_application.rb)

Linux | Mac | Windows
------|-----|--------
![hello application screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-application.png) | ![hello application screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-application.png) | ![hello application screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-application.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_application'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_application.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application', :flags_none) {
  on(:activate) do |app|
    application_window(app) {
      title 'Hello, Application!'
    }.present
  end
}.run
```

#### Hello, Button!

[samples/hello/hello_button.rb](/samples/hello/hello_button.rb)

Linux | Mac | Windows
------|-----|--------
![hello button screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-button.png) ![hello button clicked screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-button-clicked.png) | ![hello button screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-button.png) ![hello button clicked screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-button-clicked.png) | ![hello button screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-button.png) ![hello button clicked screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-button-clicked.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_button'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_button.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window { |w|
  title 'Hello, Button!'
  
  button('Button') {
    on(:clicked) do
      message_dialog(w) { |md|
        title 'Information'
        text 'You clicked the button'
        
        on(:response) do
          md.destroy
        end
      }.show
    end
  }
}.show
```

#### Hello, Entry!

[samples/hello/hello_entry.rb](/samples/hello/hello_entry.rb)

Linux | Mac | Windows
------|-----|--------
![hello entry screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-entry.png) ![hello entry submitted screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-entry-submitted.png) | ![hello entry screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-entry.png) ![hello entry submitted screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-entry-submitted.png) | ![hello entry screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-entry.png) ![hello entry submitted screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-entry-submitted.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_entry'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_entry.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window { |w|
  title 'Hello, Entry!'
  default_size 300, 50
    
  box(:vertical) {
    e = entry {
      on(:changed) do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      on(:clicked) do
        message_dialog(w) { |md|
          title 'You entered'
          text e.text
          
          on(:response) do
            md.destroy
          end
        }.show
      end
    }
  }
}.show
```

#### Hello, Drawing Area!

This demonstrates the very intuitive (Glimmer-only) declarative cairo shape drawing syntax for the `drawing_area` widget.

[samples/hello/hello_drawing_area.rb](/samples/hello/hello_drawing_area.rb)

Linux | Mac | Windows
------|-----|--------
![hello drawing area screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-drawing-area.png) | ![hello drawing area screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-drawing-area.png) | ![hello drawing area screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-drawing-area.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_drawing_area'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_drawing_area.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, Drawing Area!'
  default_size 400, 400
  
  drawing_area {
    rectangle(0, 0, 400, 400) {
      fill 255, 255, 255
    }
    
    arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }

    arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }
    
    circle(85, 285, 45) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }
    
    rectangle(140, 40, 180, 90) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }
    
    rounded_rectangle(140, 140, 180, 90, 30, 20) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }

    triangle(140, 240, 320, 240, 230, 330) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }

    path {
      move_to 160, 100
      curve_to 190, 60, 200, 80, 210, 70
      curve_to 240, 80, 250, 100, 260, 90
      curve_to 290, 90, 300, 110, 310, 100

      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }

    path {
      move_to 200, 150
      line_to 270, 170
      line_to 250, 220
      line_to 220, 190
      line_to 200, 200
      line_to 180, 170
      close_path

      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }
    
    polygon(200, 260, 270, 270, 250, 290, 220, 290, 200, 280, 180, 270) {
      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }
    
    polyline(270, 320, 250, 340, 220, 340, 200, 330, 180, 320) {
      stroke 0, 0, 255
      line_width 3
    }
  }
}.show
```

#### Hello, Drawing Area (Manual)!

This demonstrates the manual (non-Glimmer) imperative cairo shape drawing syntax for the `drawing_area` widget (might be useful in very exceptional rare cases).

[samples/hello/hello_drawing_area_manual.rb](/samples/hello/hello_drawing_area_manual.rb)

Linux | Mac | Windows
------|-----|--------
![hello drawing area manual screenshot](/screenshots/glimmer-dsl-gtk-linux-hello-drawing-area-manual.png) | ![hello drawing area manual screenshot](/screenshots/glimmer-dsl-gtk-mac-hello-drawing-area-manual.png) | ![hello drawing area manual screenshot](/screenshots/glimmer-dsl-gtk-windows-hello-drawing-area-manual.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/hello/hello_drawing_area_manual'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/hello/hello_drawing_area_manual.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, Drawing Area (Manual)!'
  default_size 400, 400
  
  drawing_area {
    on(:draw) do |drawing_area_widget, cairo_context|
      cairo_context.rectangle(0, 0, 400, 400)
      cairo_context.set_source_rgb(255, 255, 255)
      cairo_context.fill
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke

      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.move_to 270, 320
      cairo_context.line_to 250, 340
      cairo_context.line_to 220, 340
      cairo_context.line_to 200, 330
      cairo_context.line_to 180, 320
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
    end
  }
}.show
```

## Resources

- Ruby-Gnome Project: https://github.com/ruby-gnome/ruby-gnome
- GTK3 API Documentation: https://gnome.pages.gitlab.gnome.org/gtk/gtk3/
- GTK3 Widget Gallery: https://docs.gtk.org/gtk3/visual_index.html

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Help

### Issues

If you encounter [issues](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues) that are not reported, discover missing features that are not mentioned in [TODO.md](TODO.md), or think up better ways to use GTK than what is possible with [Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk), you may submit an [issue](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues/new) or [pull request](https://github.com/AndyObtiva/glimmer-dsl-gtk/compare) on [GitHub](https://github.com). In the meantime while waiting for a fix, you may try older gem versions of [Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk) in case you find one that does not have the issue and actually works.

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Planned Features and Feature Suggestions

These features have been planned or suggested. You might see them in a future version of [Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk). You are welcome to contribute more feature suggestions.

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Contributors

* [Andy Maleh](https://github.com/AndyObtiva) (Founder)

[Click here to view contributor commits.](https://github.com/AndyObtiva/glimmer-dsl-gtk/graphs/contributors)

## Copyright

[LGPL](LICENSE.txt)

Copyright (c) 2021 Andy Maleh.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
