require 'opengl'
require 'simple_gl/gl/context'
require 'simple_gl/glut/context'

module SimpleGl
  module Glut
    # The abstract base class for Glut apps. Any class inheriting it needs to
    # implement at least the following methods:
    #
    #   * display
    #
    # Optionally, these methods are also available for overriding:
    #
    #   * init
    #   * reshape
    #   * keyboard
    #
    class App
      attr_reader :gl, :glut

      def initialize(&block)
        @gl   = Gl::Context.instance
        @glut = Glut::Context.instance

        instance_eval(&block) unless block.nil?
      end

      def main_loop
        glut.init

        init

        glut.display_func(method(:display).to_proc)
        glut.reshape_func(method(:reshape).to_proc)
        glut.keyboard_func(method(:keyboard).to_proc)

        glut.main_loop
      end

      def init
        glut.init_display_mode(:double, :rgb)
        glut.init_window_size(500, 500)
        glut.init_window_position(100, 100)
        glut.create_window

        gl.clear_color(0, 0, 0, 0)
        gl.shade_model = :flat
      end

      def display
      end

      def keyboard(key, x, y)
      end

      def reshape(w, h)
      end
    end
  end
end
