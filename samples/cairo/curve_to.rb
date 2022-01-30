require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Curve to'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    x=25.6
    y=128.0
    x1=102.4
    y1=230.4
    x2=153.6
    y2=25.6
    x3=230.4
    y3=128.0
    
    path {
      move_to x, y
      curve_to x1, y1, x2, y2, x3, y3
      
      line_width 10
      stroke 0, 0, 0
    }
    
    path {
      move_to x,y
      line_to x1,y1
      move_to x2,y2
      line_to x3,y3
      
      line_width 6
      stroke 255, 51, 51, 0.6
    }
  }
}.show
