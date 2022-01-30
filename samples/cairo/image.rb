require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Image'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
        
    image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
    w = image.width
    h = image.height
    
    translate 128.0, 128.0
    rotate 45*Math::PI/180
    scale 256.0/w, 256.0/h
    translate -0.5*w, -0.5*h
    
    paint image, 0, 0
  }
}.show
