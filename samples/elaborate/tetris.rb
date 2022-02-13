require 'glimmer-dsl-gtk'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = [192, 192, 192]
    
  def initialize
    @game = Model::Game.new
  end
  
  def launch
    create_gui
    register_observers
    @game.start!
    @main_window.show
  end
  
  def create_gui
    @main_window = window {
      title 'Glimmer Tetris'
      default_size Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE # + 98
      
      box(:vertical) {
        tetris_menu_bar

        box(:horizontal) {
          @playfield_blocks = playfield(playfield_width: @game.playfield_width, playfield_height: @game.playfield_height, block_size: BLOCK_SIZE)
          
          score_board
        }
        
      }
      
      on(:key_press_event) do |widget, key_event|
        case key_event.keyval
        when 65364 # down arrow
          @game.down!
        when 32 # space
          @game.down!(instant: true)
        when 65362 # up arrow
          case @game.up_arrow_action
          when :instant_down
            @game.down!(instant: true)
          when :rotate_right
            @game.rotate!(:right)
          when :rotate_left
            @game.rotate!(:left)
          end
        when 65361 # left arrow
          @game.left!
        when 65363 # right arrow
          @game.right!
        when 65506 # right shift
          @game.rotate!(:right)
        when 65505 # left shift
          @game.rotate!(:left)
        else
          # Do Nothing
        end
      end
    }
  end
  
  def register_observers
    observe(@game, :game_over) do |game_over|
      if game_over
        show_game_over_dialog
      else
        start_moving_tetrominos_down
      end
    end
    
    @game.playfield_height.times do |row|
      @game.playfield_width.times do |column|
        observe(@game.playfield[row][column], :color) do |new_color|
          color = new_color
          block = @playfield_blocks[row][column]
          block[:background_square].fill = color
          block[:top_bevel_edge].fill = [color[0] + 4*BEVEL_CONSTANT, color[1] + 4*BEVEL_CONSTANT, color[2] + 4*BEVEL_CONSTANT]
          block[:right_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:bottom_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:left_bevel_edge].fill = [color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT]
          block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          block[:drawing_area].queue_draw
          false
        end
      end
    end
    
    Model::Game::PREVIEW_PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PREVIEW_PLAYFIELD_WIDTH.times do |column|
        preview_updater = proc do
          block = @preview_playfield_blocks[row][column]
          if @game.show_preview_tetromino?
            new_color = @game.preview_playfield[row][column].color
            block[:background_square].fill = new_color
            block[:top_bevel_edge].fill = [new_color[0] + 4*BEVEL_CONSTANT, new_color[1] + 4*BEVEL_CONSTANT, new_color[2] + 4*BEVEL_CONSTANT]
            block[:right_bevel_edge].fill = [new_color[0] - BEVEL_CONSTANT, new_color[1] - BEVEL_CONSTANT, new_color[2] - BEVEL_CONSTANT]
            block[:bottom_bevel_edge].fill = [new_color[0] - BEVEL_CONSTANT, new_color[1] - BEVEL_CONSTANT, new_color[2] - BEVEL_CONSTANT]
            block[:left_bevel_edge].fill = [new_color[0] - BEVEL_CONSTANT, new_color[1] - BEVEL_CONSTANT, new_color[2] - BEVEL_CONSTANT]
            block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : new_color
            @next_label.text = 'Next'
          else
            transparent_color = [0, 0, 0, 0]
            block[:background_square].fill = transparent_color
            block[:top_bevel_edge].fill = transparent_color
            block[:right_bevel_edge].fill = transparent_color
            block[:bottom_bevel_edge].fill = transparent_color
            block[:left_bevel_edge].fill = transparent_color
            block[:border_square].stroke = transparent_color
            @next_label.text = ''
          end
          block[:drawing_area].queue_draw
        end
      
        observe(@game.preview_playfield[row][column], :color, &preview_updater)
        observe(@game, :show_preview_tetromino, &preview_updater)
      end
    end
    
    observe(@game, :score) do |new_score|
      @score_label.text = new_score.to_s
    end

    observe(@game, :lines) do |new_lines|
      @lines_label.text = new_lines.to_s
    end

    observe(@game, :level) do |new_level|
      @level_label.text = new_level.to_s
    end
  end
  
  def tetris_menu_bar
    menu_bar {
      menu_item(label: 'Game') { |mi|
        m = menu {
          check_menu_item(label: 'Pause') {
            on(:activate) do
              @game.paused = !@game.paused?
            end
          }
          
          menu_item(label: 'Restart') {
            on(:activate) do
              @game.restart!
            end
          }
          
          separator_menu_item
          
          menu_item(label: 'Exit') {
            on(:activate) do
              @main_window.close
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'View') { |mi|
        m = menu {
          check_menu_item('Show Next Block Preview') {
            active @game.show_preview_tetromino?
          
            on(:activate) do
              @game.show_preview_tetromino = !@game.show_preview_tetromino?
            end
          }
          
          separator_menu_item
          
          menu_item(label: 'Show High Scores') {
            on(:activate) do
              show_high_score_dialog
            end
          }
          
          menu_item(label: 'Clear High Scores') {
            on(:activate) do
              @game.clear_high_scores!
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'Options') { |mi|
        m = menu {
          rmi = radio_menu_item(nil, 'Instant Down on Up') {
            on(:activate) do
              @game.instant_down_on_up!
            end
          }
          
          default_rmi = radio_menu_item(rmi.group, 'Rotate Right on Up') {
            on(:activate) do
              @game.rotate_right_on_up!
            end
          }
          default_rmi.activate
          
          radio_menu_item(rmi.group, 'Rotate Left on Up') {
            on(:activate) do
              @game.rotate_left_on_up!
            end
          }
        }
        mi.submenu = m.gtk
      }
      
      menu_item(label: 'Help') { |mi|
        m = menu {
          menu_item(label: 'About') {
            on(:activate) do
              show_about_dialog
            end
          }
        }
        mi.submenu = m.gtk
      }
    }
  end
  
  def score_board
    box(:vertical) {
      label
      @next_label = label('Next')
      @preview_playfield_blocks = playfield(playfield_width: Model::Game::PREVIEW_PLAYFIELD_WIDTH, playfield_height: Model::Game::PREVIEW_PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
      
      label
      label('Score')
      @score_label = label

      label
      label('Lines')
      @lines_label = label

      label
      label('Level')
      @level_label = label
      label
    }
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: , &extra_content)
    blocks = []
    box(:vertical) {
      playfield_height.times.map do |row|
        blocks << []
        box(:horizontal) {
          playfield_width.times.map do |column|
            blocks.last << block(row: row, column: column, block_size: block_size)
          end
        }
      end
      
      extra_content&.call
    }
    blocks
  end
  
  def block(row: , column: , block_size: , &extra_content)
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Model::Block::COLOR_CLEAR
    block[:drawing_area] = drawing_area {
      size_request block_size, block_size
      
      block[:background_square] = square(0, 0, block_size) {
        fill *color
      }
      
      block[:top_bevel_edge] = polygon(0, 0, block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size, bevel_pixel_size) {
        fill color[0] + 4*BEVEL_CONSTANT, color[1] + 4*BEVEL_CONSTANT, color[2] + 4*BEVEL_CONSTANT
      }
       
      block[:right_bevel_edge] = polygon(block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size, block_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
       
      block[:bottom_bevel_edge] = polygon(block_size, block_size, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
      
      block[:left_bevel_edge] = polygon(0, 0, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size) {
        fill color[0] - BEVEL_CONSTANT, color[1] - BEVEL_CONSTANT, color[2] - BEVEL_CONSTANT
      }
      
      block[:border_square] = square(0, 0, block_size) {
        stroke *COLOR_GRAY
      }
      
      extra_content&.call
    }
    block
  end
  
  def start_moving_tetrominos_down
    unless @tetrominos_start_moving_down
      @tetrominos_start_moving_down = true
      GLib::Timeout.add(@game.delay*1000) do
        @game.down! if !@game.game_over? && !@game.paused?
        true
      end
    end
  end
  
  def show_game_over_dialog
    message_dialog(parent: @main_window) { |md|
      title 'Game Over!'
      text "Score: #{@game.high_scores.first.score}\nLines: #{@game.high_scores.first.lines}\nLevel: #{@game.high_scores.first.level}"
      
      on(:response) do
        md.destroy
      end
    }.show
    
    @game.restart!
    false
  end
  
  def show_high_score_dialog
    game_paused = !!@game.paused
    @game.paused = true
    
    if @game.high_scores.empty?
      high_scores_string = "No games have been scored yet."
    else
      high_scores_string = @game.high_scores.map do |high_score|
        "#{high_score.name} | Score: #{high_score.score} | Lines: #{high_score.lines} | Level: #{high_score.level}"
      end.join("\n")
    end
    
    message_dialog(parent: @main_window) { |md|
      title 'High Scores'
      text high_scores_string
      
      on(:response) do
        md.destroy
      end
    }.show
    
    @game.paused = game_paused
  end
  
  def show_about_dialog
    message_dialog(parent: @main_window) { |md|
      title 'About'
      text "Glimmer Tetris\n\nGlimmer DSL for GTK\n\nElaborate Sample\n\nCopyright (c) 2021-2022 Andy Maleh"
      
      on(:response) do
        md.destroy
      end
    }.show
  end
end

Tetris.new.launch
