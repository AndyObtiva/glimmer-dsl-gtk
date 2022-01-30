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
