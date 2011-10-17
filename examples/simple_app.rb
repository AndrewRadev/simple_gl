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
