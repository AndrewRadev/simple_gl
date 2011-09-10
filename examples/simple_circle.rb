require 'simple_gl/glut_app'

app = SimpleGl::GlutApp.new do
  display do
    radius = 30

    gl.color 1, 1, 1
    gl.begin :line_strip do
      (0..360).each do |degrees|
        radians = degrees * (Math::PI / 180)

        x = radius * Math.cos(radians)
        y = radius * Math.sin(radians)

        vertex x, y, 0
      end
    end

    glut.swap_buffers
  end

  # TODO (2011-09-10) Need something here by default
  reshape do |w, h|
    gl.viewport(0, 0, w, h)

    gl.matrix_mode = :projection
    gl.load_identity
    if (w <= h)
      gl.ortho(-100, 100, -100.0*h/w, 100.0*h/w, -100, 100)
    else
      gl.ortho(-100.0*w/h, 100.0*w/h, -100, 100, -100, 100)
    end
    gl.matrix_mode = :modelview
    gl.load_identity
  end
end

app.start
app.main_loop
