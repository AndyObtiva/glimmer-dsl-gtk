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
