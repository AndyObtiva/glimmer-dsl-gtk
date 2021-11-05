require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application') {
  on(:activate) do |app|
    application_window(app) {
      title 'Hello, Application!'
    }.present
  end
}.run
