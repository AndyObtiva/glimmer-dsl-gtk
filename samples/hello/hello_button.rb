require 'glimmer-dsl-gtk'

include Glimmer

window { |w|
  title 'Hello, Button!'
  
  button(label: 'Button') {
    on(:clicked) do
      message_dialog(parent: w) { |md|
        title 'Information'
        text 'You clicked the button'
        
        on(:response) do
          md.destroy
        end
      }.show
    end
  }
}.show
