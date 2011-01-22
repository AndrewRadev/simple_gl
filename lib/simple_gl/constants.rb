module SimpleGl
  # Provides mappings from symbols to standard OpenGL and GLUT constants.
  #
  # The mappings rely on a standard transformation -- the symbol is upcased and
  # added the "GL_" or "GLUT_" prefix.
  #
  # Examples:
  #
  #   :line_strip # => GL_LINE_STRIP
  #   :points     # => GL_POINTS
  #
  module Constants
    def gl_constant(type)
      GL.const_get("GL_#{type.to_s.upcase}")
    end

    def glut_constant(type)
      GLUT.const_get("GL_#{type.to_s.upcase}")
    end
  end
end
