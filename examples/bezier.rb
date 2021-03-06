require 'rubygems'
require 'simple_gl'

$ctrlpoints = [
  [ -4, -4, 0 ],
  [ -2,  4, 0 ],
  [  2, -4, 0 ],
  [  4,  4, 0 ],
]

class BezierApp < SimpleGl::Glut::App
  def init
    glut.init_display_mode(:double, :rgb)
    glut.init_window_size(500, 500)
    glut.init_window_position(100, 100)
    glut.create_window

    gl.clear_color(0, 0, 0, 0)
    gl.shade_model = :flat
    gl.map1d(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4, $ctrlpoints.flatten)
    gl.enable(GL_MAP1_VERTEX_3)
  end

  def display
    gl.clear
    gl.color 1, 1, 1
    gl.begin :line_strip do |gl|
      for i in 0..30
        gl.eval_coord1d(i.to_f/30.0)
      end
    end

    # The following code displays the control points as dots.
    gl.point_size = 5
    gl.color 1, 1, 0

    gl.begin :points do |gl|
      gl.vertex -4, -4, 0
      gl.vertex -2,  4, 0
      gl.vertex  2, -4, 0
      gl.vertex  4,  4, 0
    end

    glut.swap_buffers
  end

  def reshape(w, h)
    gl.viewport(0, 0, w, h)

    gl.matrix_mode = :projection
    gl.load_identity
    if (w <= h)
      gl.ortho(-5.0, 5.0, -5.0*h/w, 5.0*h/w, -5.0, 5.0)
    else
      gl.ortho(-5.0*w/h, 5.0*w/h, -5.0, 5.0, -5.0, 5.0)
    end
    gl.matrix_mode = :modelview
    gl.load_identity
  end

  def keyboard(key, x, y)
    case (key)
    when ?\e
      exit(0)
    end
  end
end

BezierApp.new.main_loop
