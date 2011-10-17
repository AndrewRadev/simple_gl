module SimpleGl
  module Glut
    # The simple_render method simply instantiates a new Glut::SimpleApp with
    # the given block as a renderer. It can be used as a quick shortcut for
    # experimentation.
    def self.simple_render(&block)
      SimpleGl::Glut::SimpleApp.start(&block)
    end

    # The Glut::SimpleApp class is possibly the simplest way to get a quick
    # Glut app up and running.
    #
    # Instead of instantiating the app, you could simply call #start with a
    # block that's used for the rendering process. Redrawing, key controls and
    # so on are implemented to give quick results.
    #
    # Example:
    #
    #   app = SimpleGl::Glut::SimpleApp.start do |gl, glut|
    #     gl.begin :points do |gl|
    #       gl.vertex 1, 2, 3
    #     end
    #   end
    class SimpleApp < App
      def self.start(&block)
        new(&block).main_loop
      end

      def initialize(&block)
        super

        @renderer = block
      end

      # The display method only calls the renderer that is set on
      # initialization
      def display
        @renderer.call(gl, glut)
      end

      # The standard keyboard behaviour is to exit the app on pressing Escape
      def keyboard(key, x, y)
        case (key)
        when ?\e
          exit(0)
        end
      end

      # Maintains a simple 2d view of the world
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
  end
end
