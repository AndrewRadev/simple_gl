require 'simple_gl/glut/app'

class PulsatingSquare
  def initialize(side, limit, x, y)
    @base_side = side.to_f
    @side      = @base_side
    @limit     = limit.to_f
    @x, @y     = x.to_f, y.to_f
  end

  def animate(time)
    @direction ||= +1

    if @side > @base_side + @limit
      @direction = -1
    elsif @side < @base_side - @limit
      @direction = +1
    end

    @side += @direction * 2
  end

  def render(gl)
    gl.color 0, 0, 0

    side = @side
    x, y = @x, @y

    gl.begin :polygon do
      vertex(x - side/2, y - side/2, 0)
      vertex(x - side/2, y + side/2, 0)
      vertex(x + side/2, y + side/2, 0)
      vertex(x + side/2, y - side/2, 0)
    end
  end
end

class AnimatedSquaresApp < SimpleGl::Glut::App
  def init
    super

    @square_one = PulsatingSquare.new(20.0, 10.0, -50, 0)
    @square_two = PulsatingSquare.new(50.0, 10.0, 50, 0)

    gl.clear_color 1, 1, 1, 1
  end

  def display
    gl.clear
    @square_one.render(gl)
    @square_two.render(gl)
    glut.swap_buffers
  end

  def animate(time)
    @square_one.animate(time)
    @square_two.animate(time)
  end

  def reshape(w, h)
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

AnimatedSquaresApp.new.main_loop
