# Change Log

## 0.0.1

- Initial version of Glimmer DSL for GTK
- General widget support with keyword arguments (e.g. `window(:toplevel).show`)
- General widget property support (e.g. `title 'Hello, Application!'`)
- General signal connect support via nested `on` keyword (e.g. `on(:activate) { ... }`)
- Have `window` automatically call `::Gtk::main_quit` upon hitting `window` close (destroy) button
- Automatically set `window` `default_size` to `190, 150` by default
- Automatically set `application` first arg to `'org.glimmer-dsl-gtk.application'` and second arg to `:flags_none` when not supplied
- Hello, World! sample
- Hello, Application! sample
- Hello, Button! sample
