require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Text'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    font_family = OS.linux? ? 'Sans' : (OS.mac? ? 'Helvetica' : 'Arial')
    
    # The main code
    path {
      move_to 10.0, 135.0
      show_text 'Hello'
      
      font_face font_family, Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD
      font_size 90.0
      line_width 2.56
      fill 0, 0, 0
      stroke 0, 0, 0
    }
    
    path {
      move_to 70.0, 165.0
      text_path 'void'
      
      font_face font_family, Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD
      font_size 90.0
      line_width 2.56
      fill 127.5, 127.5, 255
      stroke 0, 0, 0
    }
    
    # draw helping lines
    path {
      arc 10.0, 135.0, 5.12, 0, 2*Math::PI
      close_path
      arc 70.0, 165.0, 5.12, 0, 2*Math::PI
      
      fill 255, 51, 51, 0.6
    }
  }
}.show
