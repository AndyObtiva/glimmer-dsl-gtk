# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for GTK 0.0.5
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

NOTE: Glimmer DSL for GTK is currently in early alpha mode (incomplete proof-of-concept). If you want it developed faster, then [open an issue report](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues/new). I have completed some GitHub project features much faster before due to [issue reports](https://github.com/AndyObtiva/glimmer-dsl-gtk/issues) and [pull requests](https://github.com/AndyObtiva/glimmer-dsl-gtk/pulls). Please help make better by contributing, adopting for small or low risk projects, and providing feedback. It is still an early alpha, so the more feedback and issues you report the better.

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
- (Optional) You can upgrade your GTK3/GTK4/GTK+ by running: `brew install gtk+3` / `brew install gtk+4` / `brew install gtk+`

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
gem 'glimmer-dsl-gtk', '~> 0.0.5'
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

### MVC Observer Pattern

In Smalltalk-MVC ([Model View Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) Architectural Pattern), the View is an active View that observes the Model for changes and updates itself.

![MVC](http://3.bp.blogspot.com/-4eW59Ao0ess/ToiBzAiYdZI/AAAAAAAAAOg/SiYa6XHwBFE/s320/Screen+shot+2011-10-02+at+10.22.11+AM.png)

This can be achieved with the Glimmer GUI DSL using the `observe` keyword, which takes a model (any object, including `self`) and attribute Symbol or String expression (e.g. `:count` or `'address.street'`).

The model is automatically enhanced as an `Glimmer::DataBinding::ObservableModel` / `Glimmer::DataBinding::ObservableHash` / `Glimmer::DataBinding::ObservableArray` depending on its type to support notifying observers of attribute changes (when performed using the attribute writer, which automatically calls added method `notify_observers(attribute)`)

Note that it is usually recommended to observe external model objects (not `self`), but `self` is OK in very simple cases or presentation-related attributes only.

### Declarative Cairo Graphics

[Cairo](https://www.cairographics.org/) is the engine behind drawing arbitrary 2D geometric shapes in [GTK](https://www.gtk.org/).

In [Glimmer DSL for GTK](https://rubygems.org/gems/glimmer-dsl-gtk), you can draw Cairo shapes declaratively in a way similar to how SVG works, but using one language; Ruby, thus being able to utilize Ruby logic (e.g. if statement or each loop) with it effortlessly when needed. Declarative syntax also yields less code that is simpler, not dependent on ordering of nested properties, and more understandable/maintainable.

Below is a quick tutorial consisting of samples inspired and ported from [Mohit Sindhwani's blog post "Cairo with Ruby - Samples using RCairo"](https://notepad.onghu.com/2021/cairo-samples-in-ruby/).

### Arc

[samples/cairo/arc.rb](/samples/cairo/arc.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, Drawing Area!'
  default_size 256, 256
  
  drawing_area {
    # Surface Paint
    paint 242.25, 242.25, 242.25
    
    # Set up the parameters
    xc = 128.0
    yc = 128.0
    radius = 100.0
    angle1 = 45.0  * (Math::PI/180.0) # angles are specified
    angle2 = 180.0  * (Math::PI/180.0) # in radians
    
    # The main arc
    arc(xc, yc, radius, angle1, angle2) {
      stroke 0, 0, 0
      line_width 10
    }
    
    # Draw helping lines
    
    # First, the circle at the centre
    arc(xc, yc, 10.0, 0, 2*Math::PI) {
      fill 255, 51, 51, 0.6
    }
    
    # Then, the lines reaching out
    path {
      arc xc, yc, radius, angle1, angle1
      line_to xc, yc
      arc xc, yc, radius, angle2, angle2
      line_to xc, yc
      
      stroke 255, 51, 51, 0.6
      line_width 6
    }
  }
}.show
```

![Arc](/screenshots/glimmer-dsl-gtk-mac-cairo-arc.png)

### Arc Negative

[samples/cairo/arc_negative.rb](/samples/cairo/arc_negative.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Arc Negative'
  default_size 256, 256
  
  drawing_area {
    # Surface Paint
    paint 255, 255, 255
    
    # Set up the parameters
    xc = 128.0
    yc = 128.0
    radius = 100.0
    angle1 = 45.0  * (Math::PI/180.0) # angles are specified
    angle2 = 180.0  * (Math::PI/180.0) # in radians
    
    # The main negative arc
    arc_negative(xc, yc, radius, angle1, angle2) {
      stroke 0, 0, 0
      line_width 10
    }
    
    # Draw helping lines
    
    # First, the circle at the centre
    arc(xc, yc, 10.0, 0, 2*Math::PI) {
      fill 255, 51, 51, 0.6
    }
    
    # Then, the lines reaching out
    path {
      arc(xc, yc, radius, angle1, angle1)
      line_to(xc, yc)
      arc(xc, yc, radius, angle2, angle2)
      line_to(xc, yc)
      
      stroke 255, 51, 51, 0.6
      line_width 6
    }
  }
}.show
```

![Arc Negative](/screenshots/glimmer-dsl-gtk-mac-cairo-arc-negative.png)

### Clip

[samples/cairo/clip.rb](/samples/cairo/clip.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Clip'
  default_size 256, 256
  
  drawing_area {
    # Surface Paint
    paint 255, 255, 255
    
    # Designate arc as the clipping area
    arc(128.0, 128.0, 76.8, 0, 2 * Math::PI) {
      clip true
    }
    
    # Rectangle will get clipped by arc
    rectangle(0, 0, 256, 256) {
      fill 0, 0, 0
    }
    
    # Path will get clipped by arc
    path {
      move_to 0, 0
      line_to 256, 256
      move_to 256, 0
      line_to 0, 256
      
      stroke 0, 255, 0
      line_width 10
    }
  }
}.show
```

![Clip](/screenshots/glimmer-dsl-gtk-mac-cairo-clip.png)

### Clip Image

[samples/cairo/clip_image.rb](/samples/cairo/clip_image.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Clip Image'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25

    arc(128.0, 128.0, 76.8, 0, 2 * Math::PI) {
      clip true # designate arc as the clipping area
    }

    rectangle(0, 0, 256, 256) {
      # Source image is from:
      # - https://www.publicdomainpictures.net/en/view-image.php?image=7683&picture=breaking-blue-wave
      # Converted to PNG before using it
      image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
      w = image.width
      h = image.height
  
      scale 256.0/w, 256.0/h, exclude: :shape # applies scale to fill source image only
      fill image, 0, 0
    }
  }
}.show
```

![Clip Image](/screenshots/glimmer-dsl-gtk-mac-cairo-clip-image.png)

### Curve to

[samples/cairo/curve_to.rb](/samples/cairo/curve_to.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Curve to'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    x=25.6
    y=128.0
    x1=102.4
    y1=230.4
    x2=153.6
    y2=25.6
    x3=230.4
    y3=128.0
    
    path {
      move_to x, y
      curve_to x1, y1, x2, y2, x3, y3
      
      line_width 10
      stroke 0, 0, 0
    }
    
    path {
      move_to x,y
      line_to x1,y1
      move_to x2,y2
      line_to x3,y3
      
      line_width 6
      stroke 255, 51, 51, 0.6
    }
  }
}.show
```

![Curve to](/screenshots/glimmer-dsl-gtk-mac-cairo-curve-to.png)

### Dashes

[samples/cairo/dashes.rb](/samples/cairo/dashes.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Dashes'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25

    dashes = [ 50.0, # ink
                       10.0,  # skip
                       10.0,  # ink
                       10.0   # skip
            ]
    offset = -50.0
    
    path {
      move_to 128.0, 25.6
      line_to 230.4, 230.4
      rel_line_to -102.4, 0.0
      curve_to 51.2, 230.4, 51.2, 128.0, 128.0, 128.0
      
      line_width 10
      dash dashes, offset
      stroke 0, 0, 0
    }
  }
}.show
```

![Dashes](/screenshots/glimmer-dsl-gtk-mac-cairo-dashes.png)

### Fill and Stroke 2

(note: there is no Fill and Stroke 1; this was adopted from [Mohit's blog post](https://notepad.onghu.com/2021/cairo-samples-in-ruby/), which only mentioned Fill and Stroke 2)

[samples/cairo/fill_and_stroke2.rb](/samples/cairo/fill_and_stroke2.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Fill and Stroke 2'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    path {
      move_to 128.0, 25.6
      line_to 230.4, 230.4
      rel_line_to -102.4, 0.0
      curve_to 51.2, 230.4, 51.2, 128.0, 128.0, 128.0
      close_path

      fill 0, 0, 255
      stroke 0, 0, 0
      line_width 10
    }
    
    path {
      move_to 64.0, 25.6
      rel_line_to 51.2, 51.2
      rel_line_to -51.2, 51.2
      rel_line_to -51.2, -51.2
      close_path

      fill 0, 0, 255
      stroke 0, 0, 0
      line_width 10
    }
  }
}.show
```

![Fill and Stroke 2](/screenshots/glimmer-dsl-gtk-mac-cairo-fill-and-stroke2.png)

### Fill Style

[samples/cairo/fill_style.rb](/samples/cairo/fill_style.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Fill Style'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    path {
      rectangle 12, 12, 232, 70
      path { # sub-path
        arc 64, 64, 40, 0, 2*Math::PI
      }
      path { # sub-path
        arc_negative 192, 64, 40, 0, -2*Math::PI
      }
      
      fill_rule Cairo::FILL_RULE_EVEN_ODD
      line_width 6
      fill 0, 178.5, 0
      stroke 0, 0, 0
    }
    
    path {
      rectangle 12, 12, 232, 70
      path { # sub-path
        arc 64, 64, 40, 0, 2*Math::PI
      }
      path { # sub-path
        arc_negative 192, 64, 40, 0, -2*Math::PI
      }
      
      translate 0, 128
      fill_rule Cairo::FILL_RULE_WINDING
      line_width 6
      fill 0, 0, 229.5
      stroke 0, 0, 0
    }
  }
}.show
```

![Fill Style](/screenshots/glimmer-dsl-gtk-mac-cairo-fill-style.png)

### Gradient

[samples/cairo/gradient.rb](/samples/cairo/gradient.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Gradient'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
        
    # Create the Linear Pattern
    rectangle(0, 0, 256, 256) {
      pat = Cairo::LinearPattern.new(0.0, 0.0,  0.0, 256.0)
      pat.add_color_stop_rgba(1, 0, 0, 0, 1)
      pat.add_color_stop_rgba(0, 1, 1, 1, 1)
      
      fill pat
    }
    
    # Create the radial pattern
    arc(128.0, 128.0, 76.8, 0, 2 * Math::PI) {
      pat = Cairo::RadialPattern.new(115.2, 102.4, 25.6,
                                         102.4,  102.4, 128.0)
      pat.add_color_stop_rgba(0, 1, 1, 1, 1)
      pat.add_color_stop_rgba(1, 0, 0, 0, 1)
      
      fill pat
    }
  }
}.show
```

![Gradient](/screenshots/glimmer-dsl-gtk-mac-cairo-gradient.png)

### Image

[samples/cairo/image.rb](/samples/cairo/image.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Image'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
        
    image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
    w = image.width
    h = image.height
    
    translate 128.0, 128.0
    rotate 45*Math::PI/180
    scale 256.0/w, 256.0/h
    translate -0.5*w, -0.5*h
    
    paint image, 0, 0
  }
}.show
```

![Image](/screenshots/glimmer-dsl-gtk-mac-cairo-image.png)

### Image Gradient

[samples/cairo/image_gradient.rb](/samples/cairo/image_gradient.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Image Gradient'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
    w = image.width
    h = image.height
    
    # Load the image as a surface pattern
    pattern = Cairo::SurfacePattern.new(image)
    pattern.extend = Cairo::EXTEND_REPEAT
    
    # Set up the scale matrix
    pattern.matrix = Cairo::Matrix.scale(w/256.0 * 5.0, h/256.0 * 5.0)
    
    rectangle(0, 0, 256, 256) {
      translate 128.0, 128.0
      rotate Math::PI / 4
      scale 1/Math.sqrt(2), 1/Math.sqrt(2)
      translate -128.0, -128.0
        
      fill pattern
    }
  }
}.show
```

![Image Gradient](/screenshots/glimmer-dsl-gtk-mac-cairo-image-gradient.png)

### Multi Segment Caps

[samples/cairo/multi_segment_caps.rb](/samples/cairo/multi_segment_caps.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Multi Segment Caps'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    path {
      move_to 50.0, 75.0
      line_to 200.0, 75.0
      
      move_to 50.0, 125.0
      line_to 200.0, 125.0
      
      move_to 50.0, 175.0
      line_to 200.0, 175.0
      
      line_width 30
      line_cap Cairo::LINE_CAP_ROUND
      stroke 0, 0, 0
    }
  }
}.show
```

![Multi Segment Caps](/screenshots/glimmer-dsl-gtk-mac-cairo-multi-segment-caps.png)

### Rounded Rectangle

[samples/cairo/rounded_rectangle.rb](/samples/cairo/rounded_rectangle.rb)

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Rounded Rectangle'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    path {
      rounded_rectangle(25.6, 25.6, 204.8, 204.8, 20)
    
      fill 127.5, 127.5, 255
      line_width 10.0
      stroke 127.5, 0, 0, 0.5
    }
  }
}.show
```

![Rounded Rectangle](/screenshots/glimmer-dsl-gtk-mac-cairo-rounded-rectangle.png)

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
    paint 255, 255, 255
    
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
      cairo_context.set_source_rgb(255/255.0, 255/255.0, 255/255.0)
      cairo_context.paint
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(0, 128/255.0, 255/255.0)
      cairo_context.set_line_width(3)
      cairo_context.stroke

      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(255/255.0, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(0, 128/255.0, 255/255.0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(255/255.0, 0, 0)
      cairo_context.fill
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(0, 128/255.0, 255/255.0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255/255.0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255/255.0, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255/255.0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255/255.0, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255/255.0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255/255.0, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 0, 255/255.0)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255/255.0)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255/255.0, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255/255.0)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.move_to 270, 320
      cairo_context.line_to 250, 340
      cairo_context.line_to 220, 340
      cairo_context.line_to 200, 330
      cairo_context.line_to 180, 320
      cairo_context.set_source_rgb(0, 0, 255/255.0)
      cairo_context.stroke
    end
  }
}.show
```

### Elaborate Samples

#### Widget Gallery

[samples/elaborate/widget_gallery.rb](/samples/elaborate/widget_gallery.rb)

Linux | Mac | Windows
------|-----|--------
![widget gallery text](/screenshots/glimmer-dsl-gtk-linux-widget-gallery-text.png) ![widget gallery button](/screenshots/glimmer-dsl-gtk-linux-widget-gallery-button.png) ![widget gallery selection](/screenshots/glimmer-dsl-gtk-linux-widget-gallery-selection.png) ![widget gallery organizer](/screenshots/glimmer-dsl-gtk-linux-widget-gallery-organizer.png) ![widget gallery progress](/screenshots/glimmer-dsl-gtk-linux-widget-gallery-progress.png) | ![widget gallery text](/screenshots/glimmer-dsl-gtk-mac-widget-gallery-text.png) ![widget gallery button](/screenshots/glimmer-dsl-gtk-mac-widget-gallery-button.png) ![widget gallery selection](/screenshots/glimmer-dsl-gtk-mac-widget-gallery-selection.png) ![widget gallery organizer](/screenshots/glimmer-dsl-gtk-mac-widget-gallery-organizer.png) ![widget gallery progress](/screenshots/glimmer-dsl-gtk-mac-widget-gallery-progress.png) | ![widget gallery text](/screenshots/glimmer-dsl-gtk-windows-widget-gallery-text.png) ![widget gallery button](/screenshots/glimmer-dsl-gtk-windows-widget-gallery-button.png) ![widget gallery selection](/screenshots/glimmer-dsl-gtk-windows-widget-gallery-selection.png) ![widget gallery organizer](/screenshots/glimmer-dsl-gtk-windows-widget-gallery-organizer.png) ![widget gallery progress](/screenshots/glimmer-dsl-gtk-windows-widget-gallery-progress.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/elaborate/widget_gallery'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/elaborate/widget_gallery.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application') {
  on(:activate) do |app|
    application_window(app) {
      title 'Widget Gallery'
      
      notebook { |n|
        f1 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Entry')
              entry {
                text 'Enter One Line of Text'
              }
              
              label('Search Entry')
              search_entry {
                text 'Enter Search Term'
              }
              
              label('Spin Button')
              spin_button(1, 100, 1) {
              }
              
              label('Combo Box Text')
              cb = combo_box_text {
              }
              3.times { |n| cb.append_text "Option #{n + 1}" }
            }
          }
        }
        n.set_tab_label_text(f1.gtk, 'Text')
        
        f2 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Button')
              button('Push Me')
              
              label('Radio Button')
              box(:horizontal) {
                rb = radio_button('One')
                radio_button(rb, 'Two')
                radio_button(rb, 'Three')
              }
              
              label('Check Button')
              box(:horizontal) {
                check_button('One')
                check_button('Two')
                check_button('Three')
              }
            }
          }
        }
        n.set_tab_label_text(f2.gtk, 'Button')
        
        f3 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Horizontal Scale')
              h_scale(1, 100, 1) {
                visible true
              }
              
              label('Vertical Scale')
              v_scale(1, 100, 1) {
                visible true
                height_request 200
              }
            }
          }
        }
        n.set_tab_label_text(f3.gtk, 'Selection')
        
        f4 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Expander')
              3.times do |n|
                expander {
                  label "Item #{n + 1}"
                  
                  label("Item #{n + 1} Expanded") {
                  }
                }
              end
            }
          }
        }
        n.set_tab_label_text(f4.gtk, 'Organizer')
        
        f5 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Progress Bar')
              pb = progress_bar {
                text 'Progress Bar'
              }
              Thread.new do
                101.times.cycle do |n|
                  pb.fraction = n / 100.0
                  sleep(0.1) # yields back to main GUI thread
                end
              end
              
              label('Spinner')
              spinner {
                active true
              }
            }
          }
        }
        n.set_tab_label_text(f5.gtk, 'Progress')
      }
    }.present
  end
}.run
```

#### Tetris

[samples/elaborate/tetris.rb](/samples/elaborate/tetris.rb)

Linux | Mac | Windows
------|-----|--------
![tetris](/screenshots/glimmer-dsl-gtk-linux-tetris.png) | ![tetris](/screenshots/glimmer-dsl-gtk-mac-tetris.png) | ![tetris](/screenshots/glimmer-dsl-gtk-windows-tetris.png)

Run (via installed gem):

```
ruby -r glimmer-dsl-gtk -e "require 'samples/elaborate/tetris'"
```

Run (via locally cloned project):

```
ruby -r ./lib/glimmer-dsl-gtk.rb samples/elaborate/tetris.rb
```

Code:

```ruby
require 'glimmer-dsl-gtk'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = [192, 192, 192]
    
  def initialize
    @game = Model::Game.new
  end
  
  def launch
    create_gui
    register_observers
    @game.start!
    @main_window.show
  end
  
  def create_gui
    @main_window = window {
      title 'Glimmer Tetris'
      default_size Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE # + 98
      
      box(:vertical) {
        tetris_menu_bar

        box(:horizontal) {
          @playfield_blocks = playfield(playfield_width: @game.playfield_width, playfield_height: @game.playfield_height, block_size: BLOCK_SIZE)
          
          score_board
        }
        
      }
      
      on(:key_press_event) do |widget, key_event|
        case key_event.keyval
        when 65364 # down arrow
          @game.down!
        when 32 # space
          @game.down!(instant: true)
        when 65362 # up arrow
          case @game.up_arrow_action
          when :instant_down
            @game.down!(instant: true)
          when :rotate_right
            @game.rotate!(:right)
          when :rotate_left
            @game.rotate!(:left)
          end
        when 65361 # left arrow
          @game.left!
        when 65363 # right arrow
          @game.right!
        when 65506 # right shift
          @game.rotate!(:right)
        when 65505 # left shift
          @game.rotate!(:left)
        else
          # Do Nothing
        end
      end
    }
  end
  
  def register_observers
    observe(@game, :game_over) do |game_over|
      if game_over
        show_game_over_dialog
      else
        start_moving_tetrominos_down
      end
    end
    
    @game.playfield_height.times do |row|
      @game.playfield_width.times do |column|
        observe(@game.playfield[row][column], :color) do |new_color|
          color = new_color
          block = @playfield_blocks[row][column]
          block[:background_square].fill = color
          block[:top_bevel_edge].fill = [color[0] + 4*BEVEL_CONSTANT, color[1] + 4*BEVEL_CONSTANT, color[2] + 4*BEVEL_CONSTANT]
          block[:right_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:bottom_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:left_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          block[:drawing_area].queue_draw
          false
        end
      end
    end
    
    Model::Game::PREVIEW_PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PREVIEW_PLAYFIELD_WIDTH.times do |column|
        observe(@game.preview_playfield[row][column], :color) do |new_color|
          color = new_color
          block = @preview_playfield_blocks[row][column]
          block[:background_square].fill = color
          block[:top_bevel_edge].fill = [color[0] + 4*BEVEL_CONSTANT, color[1] + 4*BEVEL_CONSTANT, color[2] + 4*BEVEL_CONSTANT]
          block[:right_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:bottom_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:left_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          block[:drawing_area].queue_draw
        end
      end
    end
    
    observe(@game, :score) do |new_score|
      @score_label.text = new_score.to_s
    end

    observe(@game, :lines) do |new_lines|
      @lines_label.text = new_lines.to_s
    end

    observe(@game, :level) do |new_level|
      @level_label.text = new_level.to_s
    end
  end
  
  def tetris_menu_bar
    menu_bar {
      menu_item(label: 'Game') { |mi|
        m = menu {
          check_menu_item(label: 'Pause') {
            on(:activate) do
              @game.paused = !@game.paused?
            end
          }
          
          menu_item(label: 'Restart') {
            on(:activate) do
              @game.restart!
            end
          }
          
          separator_menu_item
          
          menu_item(label: 'Exit') {
            on(:activate) do
              @main_window.close
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'View') { |mi|
        m = menu {
          menu_item(label: 'Show High Scores') {
            on(:activate) do
              show_high_score_dialog
            end
          }
          
          menu_item(label: 'Clear High Scores') {
            on(:activate) do
              @game.clear_high_scores!
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'Options') { |mi|
        m = menu {
          rmi = radio_menu_item(nil, 'Instant Down on Up') {
            on(:activate) do
              @game.instant_down_on_up!
            end
          }
          
          default_rmi = radio_menu_item(rmi.group, 'Rotate Right on Up') {
            on(:activate) do
              @game.rotate_right_on_up!
            end
          }
          default_rmi.activate
          
          radio_menu_item(rmi.group, 'Rotate Left on Up') {
            on(:activate) do
              @game.rotate_left_on_up!
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'Options') { |mi|
        m = menu {
          menu_item(label: 'About') {
            on(:activate) do
              show_about_dialog
            end
          }
        }
        mi.submenu = m.gtk
      }
    }
  end
  
  def score_board
    box(:vertical) {
      label
      @preview_playfield_blocks = playfield(playfield_width: Model::Game::PREVIEW_PLAYFIELD_WIDTH, playfield_height: Model::Game::PREVIEW_PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
      
      label
      label('Score')
      @score_label = label

      label
      label('Lines')
      @lines_label = label

      label
      label('Level')
      @level_label = label
      label
    }
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: , &extra_content)
    blocks = []
    box(:vertical) {
      playfield_height.times.map do |row|
        blocks << []
        box(:horizontal) {
          playfield_width.times.map do |column|
            blocks.last << block(row: row, column: column, block_size: block_size)
          end
        }
      end
      
      extra_content&.call
    }
    blocks
  end
  
  def block(row: , column: , block_size: , &extra_content)
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Model::Block::COLOR_CLEAR
    block[:drawing_area] = drawing_area {
      size_request block_size, block_size
      
      block[:background_square] = square(0, 0, block_size) {
        fill *color
      }
      
      block[:top_bevel_edge] = polygon(0, 0, block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size, bevel_pixel_size) {
        fill color[0] + 4*BEVEL_CONSTANT, color[1] + 4*BEVEL_CONSTANT, color[2] + 4*BEVEL_CONSTANT
      }
       
      block[:right_bevel_edge] = polygon(block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size, block_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
       
      block[:bottom_bevel_edge] = polygon(block_size, block_size, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
      
      block[:left_bevel_edge] = polygon(0, 0, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
      
      block[:border_square] = square(0, 0, block_size) {
        stroke *COLOR_GRAY
      }
      
      extra_content&.call
    }
    block
  end
  
  def start_moving_tetrominos_down
    unless @tetrominos_start_moving_down
      @tetrominos_start_moving_down = true
      GLib::Timeout.add(@game.delay*1000) do
        @game.down! if !@game.game_over? && !@game.paused?
        true
      end
    end
  end
  
  def show_game_over_dialog
    message_dialog(@main_window) { |md|
      title 'Game Over!'
      text "Score: #{@game.high_scores.first.score}\nLines: #{@game.high_scores.first.lines}\nLevel: #{@game.high_scores.first.level}"
      
      on(:response) do
        md.destroy
      end
    }.show
    
    @game.restart!
    false
  end
  
  def show_high_score_dialog
    game_paused = !!@game.paused
    @game.paused = true
    
    if @game.high_scores.empty?
      high_scores_string = "No games have been scored yet."
    else
      high_scores_string = @game.high_scores.map do |high_score|
        "#{high_score.name} | Score: #{high_score.score} | Lines: #{high_score.lines} | Level: #{high_score.level}"
      end.join("\n")
    end
    
    message_dialog(@main_window) { |md|
      title 'High Scores'
      text high_scores_string
      
      on(:response) do
        md.destroy
      end
    }.show
    
    @game.paused = game_paused
  end
  
  def show_about_dialog
    message_dialog(@main_window) { |md|
      title 'About'
      text "Glimmer Tetris\n\nGlimmer DSL for GTK\n\nElaborate Sample\n\nCopyright (c) 2021-2022 Andy Maleh"
      
      on(:response) do
        md.destroy
      end
    }.show
  end
end

Tetris.new.launch
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
