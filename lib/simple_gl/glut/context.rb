require 'glut'
require 'simple_gl/helpers'
require 'simple_gl/glut/constants'

require 'singleton'

module SimpleGl
  module Glut
    class Context
      include Glut::Constants
      include Helpers

      include Singleton

      def init_display_mode(*constants)
        constants.map { |c| glut_constant(c) }.inject(0) { |c, bits| c | bits }
      end

      # Delegates underscored ruby-style methods to standard camelcased OpenGL
      # ones.
      #
      # Example:
      #
      #   matrix_mode(GL_PROJECTION) # => GL.MatrixMode(GL_PROJECTION)
      #   ortho(1, 2, 3, 4, 5, 6)    # => GL.Ortho(1, 2, 3, 4, 5, 6)
      #   load_identity              # => GL.LoadIdentity
      def method_missing(m, *args, &block)
        Glut.send("glut#{camel_case(m)}", *args, &block)
      end
    end
  end
end
