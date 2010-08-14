require 'spec_helper'

describe Jeweler::Commands::WriteGemspec do
  let(:jeweler) { Jeweler.new FileSystem.fixture_path('existing-project') }
  let(:command) { Jeweler::Commands::WriteGemspec.new(jeweler) }
  let(:now) { Time.now }

  context "after run" do
    before :each do
      jeweler.gemspec_helper.stub!(:write)
      jeweler.gemspec_helper.stub!(:reload_spec)
      Time.stub!(:now).and_return Time.parse('2011-01-13 04:22:33')
    end
    it "updates the gemspec date to the beginning of today" do
      command.run
      jeweler.gemspec_helper.spec_source.should =~ /2011-01-13/
    end
    it "should write gemspec" do
      jeweler.gemspec_helper.should_receive :write
      command.run
    end
    it "should output that the gemspec was written" do
      jeweler.output = StringIO.new
      command.run
      jeweler.output.string.should =~ /Generated: .*existing-project\.gemspec/
    end
  end
end