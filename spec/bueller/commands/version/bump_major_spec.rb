require 'spec_helper'

describe Jeweler::Commands::Version::BumpMajor do
  it "should call bump_major on version_helper in update_version" do
    bueller = Jeweler.new FileSystem.fixture_path('existing-project')
    command = Jeweler::Commands::Version::BumpMajor.new bueller

    command.update_version

    command.version_helper.major.should == 2
  end
end
