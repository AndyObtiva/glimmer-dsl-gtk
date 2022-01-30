# Change Log

## 0.0.8

- Download `images/breaking-blue-wave.png` from web in Cairo examples that use it (`image.rb`, `clip_image.rb`, `image_gradient.rb`) to avoid bloating Ruby gem

## 0.0.7

- samples/cairo/text.rb
- Support for `path` nested `show_text`, `text_path`, `show_glyphs`, `glyph_path`, `new_sub_path` operations

## 0.0.6

- samples/cairo/clip_image.rb
- samples/cairo/curve_to.rb
- samples/cairo/dashes.rb
- samples/cairo/fill_and_stroke2.rb
- samples/cairo/fill_style.rb
- samples/cairo/gradient.rb
- samples/cairo/image.rb
- samples/cairo/image_gradient.rb
- samples/cairo/multi_segment_caps.rb
- samples/cairo/rounded_rectangle.rb
- samples/cairo/set_line_cap.rb
- samples/cairo/set_line_join.rb
- Supported nested sub-paths (nesting `path` within another `path`)
- Support declarative `fill`/`paint` of `image, x, y` in cairo graphics
- Support declarative transforms on cairo graphics shapes: `translate`, `scale`, `rotate`
- Support applying transform on `drawing_area` `paint`
- Support for `path` nested `rectangle`, `rounded_rectangle`, and `arc_negative` operations

## 0.0.5

- Support `drawing_area#paint(red, green, blue)` operation to set the initial `drawing_area` paint color base
- Support `arc` as an operation inside `path` in Cairo declarative shape syntax
- Support `arc_negative` cairo graphics shape
- Support cairo graphics shape `clip`

## 0.0.4

- Tetris Menu Bar
- Tetris Score Board
- Tetris Next Tetromino Preview

## 0.0.3

- samples/elaborate/tetris.rb (basic Tetris implementation)
- `observe` keyword for observing Model attributes to update the View
- Ensure `fill`/`stroke` properties in `drawin_area` shapes accept 255-based rgb colors (or rgba with 1-based transparency)
- Support setting all cairo shape attributes (e.g. `line_width`, `line_cap`, etc...) with declarative syntax (whichever is specified)
- Upgrade to glimmer 2.6.0

## 0.0.2

- Support re-opening any widget proxy content with `#content {}` block to add more nested widgets inside
- Draw `drawing_area` Cairo shapes declaratively with keywords: `rectangle`, `rounded_rectangle`, `arc`, `triangle`, `circle`, `polygon`, `polyline`, `path`
- samples/hello/hello_drawing_area.rb (declarative cairo drawing)
- samples/hello/hello_drawing_area_manual.rb (use cairo manually with imperative syntax)
- samples/elaborate/widget_gallery.rb

## 0.0.1

- Initial version of Glimmer DSL for GTK
- General widget support with keyword arguments (e.g. `window(:toplevel).show`)
- General widget property support (e.g. `title 'Hello, Application!'`)
- General signal connect support via nested `on` keyword (e.g. `on(:activate) { ... }`)
- Have `window` automatically call `::Gtk::main_quit` upon hitting `window` close (destroy) button
- Automatically set `window` `default_size` to `190, 150` by default
- Automatically set `message_dialog` `default_width` to `190` by default
- Automatically set `application` first arg to `'org.glimmer-dsl-gtk.application'` and second arg to `:flags_none` when not supplied
- Automatically set `box` orientation to `:vertical` if not specified
- Hello, World! sample
- Hello, Application! sample
- Hello, Button! sample
