require 'glimmer-dsl-gtk'
require 'net/http'

image_content = Net::HTTP.get(URI('https://raw.githubusercontent.com/AndyObtiva/glimmer-dsl-gtk/master/images/breaking-blue-wave.png'))
image_file = File.join(Dir.home, 'breaking-blue-wave.png')
File.write(image_file, image_content)

include Glimmer

window {
  title 'Image Gradient'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    image = Cairo::ImageSurface.from_png(image_file)
    w = image.width
    h = image.height
    
    # Load the image as a surface pattern
    pattern = Cairo::SurfacePattern.new(image)
    pattern.extend = Cairo::EXTEND_REPEAT
    
    # Set up the scale matrix
    pattern.matrix = Cairo::Matrix.scale(w/256.0 * 5.0, h/256.0 * 5.0)
    
    rectangle(0, 0, 256, 256) {
      translate 128.0, 128.0
      rotate Math::PI / 4
      scale 1/Math.sqrt(2), 1/Math.sqrt(2)
      translate -128.0, -128.0
        
      fill pattern
    }
  }
}.show
