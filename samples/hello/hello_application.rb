require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application', :flags_none) {
  on(:activate) do |app|
    window {
      title 'Hello, Application!'
    }.present
  end
}.run
