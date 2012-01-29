require 'spec_helper'
require 'rake'

describe Jeweler::Tasks do
  let(:tasks) do
    Dir.chdir(File.expand_path('../fixtures/bar', File.dirname(__FILE__))) do
      Jeweler::Tasks.new
    end
  end

  after :each do
    Rake::Task.clear
  end

  describe '#initialize' do
    it 'should not eagerly initialize Jeweler' do
      tasks.instance_variable_defined?(:@jeweler).should be_false
    end
    it 'should set self as the application-wide jeweler tasks' do
      tasks.should == Rake.application.jeweler_tasks
    end
  end
  describe '#jeweler' do
    it 'should initailize Jeweler' do
      tasks.jeweler
      tasks.instance_variable_defined?(:@jeweler).should be_true
    end
  end
end
