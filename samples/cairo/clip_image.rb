require 'glimmer-dsl-gtk'

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
      image = Cairo::ImageSurface.from_png(File.expand_path(File.join('..', '..', 'images', 'breaking-blue-wave.png'), __dir__))
      w = image.width
      h = image.height
  
      scale 256.0/w, 256.0/h, exclude: :shape # applies scale to fill source image only
      fill image, 0, 0
    }
  }
}.show
