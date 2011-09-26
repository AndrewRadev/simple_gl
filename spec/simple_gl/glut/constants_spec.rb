require 'spec_helper'
require 'simple_gl/glut/constants'

module SimpleGl
  describe Glut::Constants do
    let(:subject) { Object.new.send(:extend, Glut::Constants) }

    it "translates symbols to GLUT constants" do
      ensure_constant_defined(::GLUT, 'GLUT_TEST_CONSTANT')
      subject.glut_constant(:test_constant).should eq ::GLUT::GLUT_TEST_CONSTANT
    end
  end
end
