module SimpleGl
  # Provides mappings from symbols to standard OpenGL constants.
  #
  # The mappings rely on a standard transformation -- the symbol is upcased and
  # prefixed with "GL_"
  #
  # Examples:
  #
  #   gl_constant(:line_strip) # => GL_LINE_STRIP
  #   gl_constant(:points)     # => GL_POINTS
  #
  module Gl
    module Constants
      def gl_constant(type)
        ::GL.const_get("GL_#{type.to_s.upcase}")
      end
    end
  end
end
