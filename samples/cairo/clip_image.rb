require 'glimmer-dsl-gtk'
require 'net/http'

image_content = Net::HTTP.get(URI('https://raw.githubusercontent.com/AndyObtiva/glimmer-dsl-gtk/master/images/breaking-blue-wave.png'))
image_file = File.join(Dir.home, 'breaking-blue-wave.png')
File.write(image_file, image_content)

include Glimmer

window {
  title 'Clip Image'
  default_size 256, 256
  
  drawing_area {
    paint 242.25, 242.25, 242.25

    arc(128.0, 128.0, 76.8, 0, 2 * Math::PI) {
      clip true # designate arc as the clipping area
    }

    rectangle(0, 0, 256, 256) {
      # Source image is from:
      # - https://www.publicdomainpictures.net/en/view-image.php?image=7683&picture=breaking-blue-wave
      # Converted to PNG before using it
      image = Cairo::ImageSurface.from_png(image_file)
      w = image.width
      h = image.height
  
      scale 256.0/w, 256.0/h, exclude: :shape # applies scale to fill source image only
      fill image, 0, 0
    }
  }
}.show
