# TODO

- Gtk::Window
- Gtk::Button
- Gtk::Entry
- Gtk::Box (:horizontal and :vertical)

Consider supporting `app` keyword like:

```ruby
application('org.glimmer.hello-world', :flags_none) {
  on_activate do |app|
    window(app) {
      title 'Hello, World!'
    }.present
  end
}.run
```
