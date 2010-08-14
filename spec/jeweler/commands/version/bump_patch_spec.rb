require 'spec_helper'

describe Jeweler::Commands::Version::BumpPatch do
  it "should call bump_patch on version_helper in update_version" do
    jeweler = Jeweler.new FileSystem.fixture_path('existing-project')
    command = Jeweler::Commands::Version::BumpPatch.new jeweler

    command.update_version

    command.version_helper.patch.should == 4
  end
end