module SimpleGl
  # Provides mappings from symbols to standard OpenGL and GLUT constants.
  #
  # The mappings rely on a standard transformation -- the symbol is upcased and
  # prefixed with "GL_" or "GLUT_".
  #
  # Examples:
  #
  #   gl_constant(:line_strip) # => GL_LINE_STRIP
  #   gl_constant(:points)     # => GL_POINTS
  #   glut_constant(:double)   # => GLUT_DOUBLE
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
