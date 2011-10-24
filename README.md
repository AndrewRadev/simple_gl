Since the OpenGL functions in the ruby bindings don't seem very ruby-esque,
this little project aims to provide a (hopefully) nicer API to drawing with
opengl.

Apart from converting camelCased methods to their underscored versions, this
gem also provides glut "apps" that can be used to build small applications
fairly quickly. A few examples can be found in the `examples` directory. The
fastest way to get something on the screen would be `Glut.simple_render`:

``` ruby
require 'simple_gl'

SimpleGl::Glut.simple_render do |gl, glut|
  gl.clear
  gl.color 1, 1, 1
  gl.begin :line_loop do |gl|
    gl.vertex 0,  0,  0
    gl.vertex 0,  10, 0
    gl.vertex 10, 10, 0
    gl.vertex 10, 0,  0
  end
  glut.swap_buffers
end
```

This uses the given block as the OpenGL `display` callback, sets up some
default resize and keyboard functions that should mostly work, and fires up the
main loop.
