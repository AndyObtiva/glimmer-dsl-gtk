require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, Drawing Area!'
  default_size 400, 400
  
  drawing_area {
    paint 255, 255, 255
    
    arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }

    arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }
    
    circle(85, 285, 45) {
      fill 255, 0, 0
      stroke 0, 128, 255
      line_width 3
    }
    
    rectangle(140, 40, 180, 90) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }
    
    rounded_rectangle(140, 140, 180, 90, 30, 20) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }

    triangle(140, 240, 320, 240, 230, 330) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }

    path {
      move_to 160, 100
      curve_to 190, 60, 200, 80, 210, 70
      curve_to 240, 80, 250, 100, 260, 90
      curve_to 290, 90, 300, 110, 310, 100

      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }

    path {
      move_to 200, 150
      line_to 270, 170
      line_to 250, 220
      line_to 220, 190
      line_to 200, 200
      line_to 180, 170
      close_path

      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }
    
    polygon(200, 260, 270, 270, 250, 290, 220, 290, 200, 280, 180, 270) {
      fill 0, 255, 0
      stroke 0, 0, 255
      line_width 3
    }
    
    polyline(270, 320, 250, 340, 220, 340, 200, 330, 180, 320) {
      stroke 0, 0, 255
      line_width 3
    }
  }
}.show
