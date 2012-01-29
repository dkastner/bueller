require 'spec_helper'

describe Jeweler do
  let(:jeweler_with_git) { Jeweler.new(git_dir_path) }
  let(:jeweler_without_git) { Jeweler.new(non_git_dir_path) }
  let(:jeweler) { Jeweler.new(git_dir_path) }
  let(:git_dir_path) { File.join(FileSystem.tmp_dir, 'git') }
  let(:non_git_dir_path) { File.join(FileSystem.tmp_dir, 'nongit') }

  describe '#in_git_repo?' do
    it 'should return true if it is in a git repo' do
      FileUtils.mkdir_p git_dir_path
      Dir.chdir git_dir_path do
        Git.init
      end
      jeweler_with_git.should be_in_git_repo
    end
    it 'should return false if it is not in a git repo' do
      FileUtils.mkdir_p non_git_dir_path
      jeweler_without_git.should_not be_in_git_repo
    end
  end

  describe '#git_base_dir' do
    it 'should find the base repo' do
      jeweler = Jeweler.new(File.dirname(File.expand_path(__FILE__)))
      jeweler.git_base_dir.should == File.dirname(File.dirname(File.expand_path(__FILE__)))
    end
  end

  describe '#write_gemspec' do
    it 'should build and run write gemspec command when writing gemspec' do
      Jeweler::Commands::WriteGemspec.should_receive(:run_for).with(jeweler)

      jeweler.write_gemspec
    end
  end

  describe '#bump_major_version' do
    it 'should build and run bump major version command when bumping major version' do
      Jeweler::Commands::Version::BumpMajor.should_receive(:run_for).with(jeweler)

      jeweler.bump_major_version
    end
  end

  describe '#bump_major_version' do
    it 'should build and run bump minor version command when bumping minor version' do
      Jeweler::Commands::Version::BumpMinor.should_receive(:run_for).with(jeweler)

      jeweler.bump_minor_version
    end
  end

  describe '#bump_major_version' do
    it 'should build and run write version command when writing version' do
      Jeweler::Commands::Version::Write.should_receive(:run_for).with(jeweler, 1, 5, 2, 'a1')

      jeweler.write_version(1, 5, 2, 'a1')
    end
  end
end
