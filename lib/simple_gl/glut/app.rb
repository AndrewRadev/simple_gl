require 'opengl'
require 'simple_gl/gl/context'
require 'simple_gl/glut/context'

module SimpleGl
  # Acts as a basic glut application with convenience methods to initialize the
  # window and set some standard parameters.
  #
  # TODO: Needs to be much more configurable, although that'll have to wait
  # until more examples are collected.
  module Glut
    class App
      attr_reader :gl, :glut

      def initialize(&block)
        @gl   = Gl::Context.instance
        @glut = Glut::Context.instance

        instance_eval(&block) unless block.nil?
      end

      def main_loop
        glut.init

        if @init_proc
          instance_eval(&@init_proc)
        else
          default_init
        end

        glut.display_func(@display_proc)

        glut.keyboard_func(@keyboard_proc) if @keyboard_proc
        glut.reshape_func(@reshape_proc) if @reshape_proc
        glut.main_loop
      end

      def default_init
        glut.init_display_mode(:double, :rgb)
        glut.init_window_size(500, 500)
        glut.init_window_position(100, 100)
        glut.create_window

        gl.clear_color(0, 0, 0, 0)
        gl.shade_model = :flat
      end

      module Callbacks
        def init(&block)
          @init_proc = block
        end

        def display(&block)
          @display_proc = block
        end

        def keyboard(&block)
          @keyboard_proc = block
        end

        def reshape(&block)
          @reshape_proc = block
        end
      end

      include Callbacks
    end
  end
end
