module SimpleGl
  # Provides mappings from symbols to standard OpenGL and GLUT constants.
  #
  # The mappings rely on a standard transformation -- the symbol is upcased and
  # prefixed with "GL_" or "GLUT_".
  #
  # Examples:
  #
  #   glut_constant(:double) # => GLUT_DOUBLE
  #
  module Glut
    module Constants
      def glut_constant(type)
        ::GLUT.const_get("GL_#{type.to_s.upcase}")
      end
    end
  end
end
