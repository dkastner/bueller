require 'spec_helper'

describe Jeweler::Generator::Application do
  context 'when options indicate version' do
    let(:application) { App.run_application('-v') }

    it 'exits with code 1' do
      application.should == 1
    end

    it 'puts version information' do
      application
      App.stderr.should =~ /Version:/
    end
  end

  context "when options indicate help usage" do
    let(:application) { App.run_application('-h') }

    it "should exit with code 1" do
      application.should == 1
    end

    it 'should should puts option usage' do
      application
      App.stderr.should =~ /Usage:/
    end

    it 'should not display anything on stdout' do
      application
      App.stdout.squeeze.strip.should == ''
    end
  end

  context "when options indicate an invalid argument" do
    let(:application) { App.run_application('--invalid-argument') }

    it "should exit with code 1" do
      application.should == 1
    end

    it 'should display invalid argument' do
      application
      App.stderr.should =~ /--invalid-argument/
    end

    it 'should display usage on stderr' do
      application
      App.stderr.should =~ /Usage:/
    end

    it 'should not display anything on stdout' do
      App.stdout.squeeze.strip.should == ''
    end
  end

  context "when options are good" do
    let(:application) { App.run_application 'foo' }

    before :each do
      Jeweler::Generator.stub!(:run)
    end

    it "should exit with code 1" do
      application.should == 0
    end

    it "should run generator" do
      Jeweler::Generator.should_receive :run
      application
    end
  end

end
