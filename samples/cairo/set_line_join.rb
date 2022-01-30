require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Set line join'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    # The main code
    path {
      move_to 76.8, 84.48
      rel_line_to 51.2, -51.2
      rel_line_to 51.2, 51.2
      
      line_join Cairo::LINE_JOIN_MITER # default
      line_width 40.96
      stroke 0, 0, 0
    }
    
    path {
      move_to 76.8, 161.28
      rel_line_to 51.2, -51.2
      rel_line_to 51.2, 51.2
      
      line_join Cairo::LINE_JOIN_BEVEL
      line_width 40.96
      stroke 0, 0, 0
    }
    
    path {
      move_to 76.8, 238.08
      rel_line_to 51.2, -51.2
      rel_line_to 51.2, 51.2
      
      line_join Cairo::LINE_JOIN_ROUND
      line_width 40.96
      stroke 0, 0, 0
    }
  }
}.show
