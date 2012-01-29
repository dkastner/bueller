require 'spec_helper'

describe Jeweler::Commands::Version::BumpMinor do
  it "should call bump_minor on version_helper in update_version" do
    bueller = Jeweler.new FileSystem.fixture_path('existing-project')
    command = Jeweler::Commands::Version::BumpMinor.new bueller

    command.update_version

    command.version_helper.minor.should == 6
  end
end
