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
