require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application') {
  on(:activate) do |app|
    application_window(app) {
      title 'Widget Gallery'
      
      notebook {
        frame {
          box(:vertical) {
            label('Entry')
            entry {
              text 'Enter One Line of Text'
            }
            
            label('Search Entry')
            search_entry {
              text 'Enter Search Term'
            }
            
            label('Spin Button')
            spin_button(1, 100, 1) {
            }
          }
        }
        
        frame {
          box(:vertical) {
            label('Radio Button')
            box(:horizontal) {
              rb = radio_button('One')
              radio_button(rb, 'Two')
              radio_button(rb, 'Three')
            }
            
            label('Check Button')
            box(:horizontal) {
              check_button('One')
              check_button('Two')
              check_button('Three')
            }
            
            label('Combo Box Text')
            cb = combo_box_text {
            }
            3.times { |n| cb.append_text "Option #{n+1}" }
          }
        }
        
        frame {
          box(:vertical) {
            label('Horizontal Scale')
            h_scale(1, 100, 1) {
              visible true
            }
            
            label('Vertical Scale')
            v_scale(1, 100, 1) {
              visible true
              height_request 200
            }
          }
        }
        
        
        frame {
          box(:vertical) {
            label('Progress Bar')
            pb = progress_bar {
              text 'Progress Bar'
            }
            Thread.new do
              101.times.cycle do |n|
                pb.fraction = n / 100.0
                sleep(0.1) # yields back to main GUI thread
              end
            end
            
            label('Spinner')
            spinner {
              active true
            }
          }
        }
      }
    }.present
  end
}.run
