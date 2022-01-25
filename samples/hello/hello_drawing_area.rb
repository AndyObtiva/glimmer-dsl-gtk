require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, World!'
  default_size 360, 260
  
  drawing_area {
    rectangle(0, 0, 360, 260) {
      fill 255, 255, 255
    }
    
#     arc(85, 85, 45, (Math::PI/180)*100, -(Math::PI/180)*30) {
#       line_width 3
#       fill 255, 0, 0
#       stroke 0, 128, 255
#     }
#
#     arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30) {
#       fill 255, 0, 0
#       stroke 0, 128, 255
#       line_width 3
#     }
    
    rectangle(140, 40, 180, 90) {
      fill 255, 255, 0
      stroke 255, 0, 0
      line_width 3
    }
    
#     rounded_rectangle(140, 40, 180, 90, 30, 20) {
#       fill 255, 255, 0
#       stroke 255, 0, 0
#       line_width 3
#     }
#
#     path {
#       move_to 160, 100
#       curve_to 190, 60, 200, 80, 210, 70
#       curve_to 240, 80, 250, 100, 260, 90
#       curve_to 290, 90, 300, 110, 310, 100
#
#       fill 0, 255, 0
#       stroke 0, 0, 255
#       line_width 3
#     }
#
#     path {
#       move_to 200, 150
#       line_to 270, 170
#       line_to 250, 220
#       line_to 220, 190
#       line_to 200, 200
#       line_to 180, 170
#       close_path
#
#       fill 0, 255, 0
#       stroke 0, 0, 255
#       line_width 3
#     }
  }
}.show
