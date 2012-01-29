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
      tasks.instance_variable_defined?(:@bueller).should be_false
    end
    it 'should set self as the application-wide bueller tasks' do
      tasks.should == Rake.application.bueller_tasks
    end
  end
  describe '#bueller' do
    it 'should initailize Jeweler' do
      tasks.bueller
      tasks.instance_variable_defined?(:@bueller).should be_true
    end
  end
end
