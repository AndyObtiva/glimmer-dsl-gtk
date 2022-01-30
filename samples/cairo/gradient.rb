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
