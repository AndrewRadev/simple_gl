require 'opengl'
require 'simple_gl/gl/context'
require 'simple_gl/glut/context'

module SimpleGl
  module Glut
    # The abstract base class for Glut apps. Any class inheriting it needs to
    # implement at least the following methods:
    #
    #   - display
    #
    # Optionally, these methods are also available for overriding:
    #
    #   - init
    #   - reshape
    #   - keyboard
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

        if self.respond_to? :animate
          glut.timer_func(0, method(:animation_timer).to_proc, 0)
        end

        glut.display_func(method(:display).to_proc)
        glut.reshape_func(method(:reshape).to_proc)
        glut.keyboard_func(method(:keyboard).to_proc)

        glut.main_loop
      end

      # Invoked when starting the main loop. Override this method to change the
      # screen and window setup.
      def init
        glut.init_display_mode(:double, :rgb)
        glut.init_window_size(500, 500)
        glut.init_window_position(100, 100)
        glut.create_window

        gl.clear_color(0, 0, 0, 0)
        gl.shade_model = :flat
      end

      # Invoked in order to draw the stage. All the rendering code should be
      # put in this method.
      def display
        raise "Not implemented"
      end

      # Invoked on every keypress. Does nothing by default.
      def keyboard(key, x, y)
      end

      # Invoked on resizing the Glut window. Does nothing by default
      def reshape(w, h)
      end

      private

      def animation_timer(miliseconds)
        @frame_length ||= 1000 / 50.0
        self.animate(miliseconds)
        glut.post_redisplay
        glut.timer_func(@frame_length, method(:animation_timer).to_proc, miliseconds + @frame_length)
      end
    end
  end
end
