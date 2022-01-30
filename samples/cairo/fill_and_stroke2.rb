require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Fill and Stroke 2'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    path {
      move_to 128.0, 25.6
      line_to 230.4, 230.4
      rel_line_to -102.4, 0.0
      curve_to 51.2, 230.4, 51.2, 128.0, 128.0, 128.0
      close_path

      fill 0, 0, 255
      stroke 0, 0, 0
      line_width 10
    }
    
    path {
      move_to 64.0, 25.6
      rel_line_to 51.2, 51.2
      rel_line_to -51.2, 51.2
      rel_line_to -51.2, -51.2
      close_path

      fill 0, 0, 255
      stroke 0, 0, 0
      line_width 10
    }
  }
}.show
