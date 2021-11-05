require 'glimmer-dsl-gtk'

include Glimmer

window { |w|
  title 'Hello, Entry!'
  default_size 300, 50
    
  box(:vertical) {
    e = entry {
      on(:changed) do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      on(:clicked) do
        message_dialog(w) { |md|
          title 'You entered'
          text e.text
          
          on(:response) do
            md.destroy
          end
        }.show
      end
    }
  }
}.show
