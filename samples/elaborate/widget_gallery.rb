require 'glimmer-dsl-gtk'

include Glimmer

application('org.glimmer.hello-application') {
  on(:activate) do |app|
    application_window(app) {
      title 'Widget Gallery'
      
      notebook { |n|
        f1 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
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
              
              label('Combo Box Text')
              cb = combo_box_text {
              }
              3.times { |n| cb.append_text "Option #{n + 1}" }
            }
          }
        }
        n.set_tab_label_text(f1.gtk, 'Text')
        
        f2 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Button')
              button('Push Me')
              
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
            }
          }
        }
        n.set_tab_label_text(f2.gtk, 'Button')
        
        f3 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
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
        }
        n.set_tab_label_text(f3.gtk, 'Selection')
        
        f4 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
              label('Expander')
              3.times do |n|
                expander {
                  label "Item #{n + 1}"
                  
                  label("Item #{n + 1} Expanded") {
                  }
                }
              end
            }
          }
        }
        n.set_tab_label_text(f4.gtk, 'Organizer')
        
        f5 = frame {
          alignment(1, 1, 1, 1) {
            padding 15, 15, 15, 15
            
            box(:vertical) {
              spacing 10
              
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
        n.set_tab_label_text(f5.gtk, 'Progress')
      }
    }.present
  end
}.run
