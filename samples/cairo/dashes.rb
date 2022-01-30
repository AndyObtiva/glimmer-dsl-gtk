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
