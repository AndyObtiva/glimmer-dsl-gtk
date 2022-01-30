require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Arc'
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
