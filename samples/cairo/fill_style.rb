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
