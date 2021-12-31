require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, World!'
  default_size 360, 260
  
  drawing_area {
    on(:draw) do |da, cr|
      cr.rectangle(0, 0, 360, 260)
      cr.set_source_rgb(255, 255, 255)
      cr.fill
      
      cr.arc(85, 85, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cr.set_source_rgb(255, 0, 0)
      cr.fill
      
      cr.arc(85, 85, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cr.set_source_rgb(0, 128, 255)
      cr.set_line_width(3)
      cr.stroke

      cr.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cr.set_source_rgb(255, 0, 0)
      cr.fill
      
      cr.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cr.set_source_rgb(0, 128, 255)
      cr.set_line_width(3)
      cr.stroke
      
      cr.rectangle(140, 40, 180, 90)
      cr.set_source_rgb(255, 255, 0)
      cr.fill
      
      cr.rectangle(140, 40, 180, 90)
      cr.set_source_rgb(255, 0, 0)
      cr.set_line_width(3)
      cr.stroke
      
      cr.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cr.set_source_rgb(255, 255, 0)
      cr.fill
      
      cr.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cr.set_source_rgb(255, 0, 0)
      cr.set_line_width(3)
      cr.stroke
      
      
      cr.new_path
      cr.move_to 160, 100
      cr.curve_to 190, 60, 200, 80, 210, 70
      cr.curve_to 240, 80, 250, 100, 260, 90
      cr.curve_to 290, 90, 300, 110, 310, 100
      cr.set_source_rgb(0, 255, 0)
      cr.fill
      
      cr.new_path
      cr.move_to 160, 100
      cr.curve_to 190, 60, 200, 80, 210, 70
      cr.curve_to 240, 80, 250, 100, 260, 90
      cr.curve_to 290, 90, 300, 110, 310, 100
      cr.set_source_rgb(0, 0, 255)
      cr.stroke
      
      cr.new_path
      cr.move_to 200, 150
      cr.line_to 270, 170
      cr.line_to 250, 220
      cr.line_to 220, 190
      cr.line_to 200, 200
      cr.line_to 180, 170
      cr.close_path
      cr.set_source_rgb(0, 255, 0)
      cr.fill
      
      cr.new_path
      cr.move_to 200, 150
      cr.line_to 270, 170
      cr.line_to 250, 220
      cr.line_to 220, 190
      cr.line_to 200, 200
      cr.line_to 180, 170
      cr.close_path
      cr.set_source_rgb(0, 0, 255)
      cr.stroke
    end
  }
}.show
