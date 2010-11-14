require 'spec_helper'
require 'time'

describe Jeweler::GemSpecHelper do
  let(:spec) { Gemspec.build }
  let(:helper) { Jeweler::GemSpecHelper.new('.') }

  describe "#write" do
    it 'should write the gemspec' do
      file = mock(File)
      File.stub!(:open).and_yield file
      file.should_receive(:puts).with(/\d{4}(-\d\d){2}/)
      helper.write
    end
  end

  describe '#path' do
    it 'should return the path to the gemspec' do
      Dir.stub!(:glob).and_return [File.join(File.dirname(__FILE__), 'test.gemspec')]
      helper.path.should == "spec/jeweler/test.gemspec"
    end
  end
end
