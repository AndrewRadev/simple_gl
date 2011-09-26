require 'spec_helper'
require 'simple_gl/gl/constants'

module SimpleGl
  describe Gl::Constants do
    let(:subject) { Object.new.send(:extend, Gl::Constants) }

    it "translates symbols to OpenGL constants" do
      ensure_constant_defined(::GL, 'GL_TEST_CONSTANT')
      subject.gl_constant(:test_constant).should eq ::GL::GL_TEST_CONSTANT
    end
  end
end
