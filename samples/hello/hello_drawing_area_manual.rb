require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Hello, Drawing Area (Manual)!'
  default_size 400, 400
  
  drawing_area {
    on(:draw) do |drawing_area_widget, cairo_context|
      cairo_context.rectangle(0, 0, 400, 400)
      cairo_context.set_source_rgb(255, 255, 255)
      cairo_context.fill
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 85, 45, (Math::PI/180)*90, -(Math::PI/180)*90)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke

      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.arc(85, 185, 45, (Math::PI/180)*100, -(Math::PI/180)*30)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.fill
      
      cairo_context.circle(85, 285, 45)
      cairo_context.set_source_rgb(0, 128, 255)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.rectangle(140, 40, 180, 90)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.rounded_rectangle(140, 140, 180, 90, 30, 20)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255, 255, 0)
      cairo_context.fill
      
      cairo_context.triangle(140, 240, 320, 240, 230, 330)
      cairo_context.set_source_rgb(255, 0, 0)
      cairo_context.set_line_width(3)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 160, 100
      cairo_context.curve_to 190, 60, 200, 80, 210, 70
      cairo_context.curve_to 240, 80, 250, 100, 260, 90
      cairo_context.curve_to 290, 90, 300, 110, 310, 100
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 150
      cairo_context.line_to 270, 170
      cairo_context.line_to 250, 220
      cairo_context.line_to 220, 190
      cairo_context.line_to 200, 200
      cairo_context.line_to 180, 170
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 255, 0)
      cairo_context.fill
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.line_to 270, 270
      cairo_context.line_to 250, 290
      cairo_context.line_to 220, 290
      cairo_context.line_to 200, 280
      cairo_context.line_to 180, 270
      cairo_context.close_path
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
      
      cairo_context.new_path
      cairo_context.move_to 200, 260
      cairo_context.move_to 270, 320
      cairo_context.line_to 250, 340
      cairo_context.line_to 220, 340
      cairo_context.line_to 200, 330
      cairo_context.line_to 180, 320
      cairo_context.set_source_rgb(0, 0, 255)
      cairo_context.stroke
    end
  }
}.show
