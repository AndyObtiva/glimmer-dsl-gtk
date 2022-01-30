require 'glimmer-dsl-gtk'

include Glimmer

window {
  title 'Image Gradient'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25
    
    image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
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
