require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Set line cap'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    # The main code
    path {
      move_to 64.0, 50.0
      line_to 64.0, 200.0
      
      line_cap Cairo::LINE_CAP_BUTT #  default
      line_width 30
      stroke 0, 0, 0
    }
    
    path {
      move_to 128.0, 50.0
      line_to 128.0, 200.0
      
      line_cap Cairo::LINE_CAP_ROUND
      line_width 30
      stroke 0, 0, 0
    }
    
    path {
      move_to 192.0, 50.0
      line_to 192.0, 200.0
      
      line_cap Cairo::LINE_CAP_SQUARE
      line_width 30
      stroke 0, 0, 0
    }
    
    #  draw helping lines */
    path {
      move_to 64.0, 50.0
      line_to 64.0, 200.0
      move_to 128.0, 50.0
      line_to 128.0, 200.0
      move_to 192.0, 50.0
      line_to 192.0, 200.0
      
      line_width 2.56
      stroke 255, 51, 51
    }
  }
}.show
