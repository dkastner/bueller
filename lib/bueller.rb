require 'date'
require 'git'

# Jeweler helps you craft the perfect Rubygem. Give him a gemspec, and he takes care of the rest.
#
# See Jeweler::Tasks for examples of how to get started.
class Jeweler
  require 'bueller/errors'
  require 'rubygems/user_interaction'

  autoload :Generator,      'bueller/generator'

  autoload :Commands,       'bueller/commands'
  
  autoload :VersionHelper,  'bueller/version_helper'
  autoload :GemSpecHelper,  'bueller/gemspec_helper'

  autoload :Tasks,          'bueller/tasks'
  autoload :RubyforgeTasks, 'bueller/rubyforge_tasks'

  attr_accessor :base_dir, :output, :repo, :gemspec_helper, :version_helper, :commit

  def initialize(base_dir = '.')
    self.base_dir = base_dir
  end

  def gemspec_helper
    @gemspec_helper ||= GemSpecHelper.new base_dir
  end

  def version_helper
    @version_helper ||= Jeweler::VersionHelper.new gemspec_helper
  end

  def repo
    @repo ||= Git.open(git_base_dir) if in_git_repo?
  end

  def commit
    @commit = @commit.nil? ? true : @commit
  end

  def output
    @output ||= $stdout
  end

  # Major version, as defined by the gemspec's Version module.
  # For 1.5.3, this would return 1.
  def major_version
    @version_helper.major
  end

  # Minor version, as defined by the gemspec's Version module.
  # For 1.5.3, this would return 5.
  def minor_version
    @version_helper.minor
  end

  # Patch version, as defined by the gemspec's Version module.
  # For 1.5.3, this would return 5.
  def patch_version
    @version_helper.patch
  end

  # Human readable version, which is used in the gemspec.
  def version
    version_helper.to_s
  end

  # Writes out the gemspec
  def write_gemspec
    Jeweler::Commands::WriteGemspec.run_for self
  end

  # Bumps the patch version.
  #
  # 1.5.1 -> 1.5.2
  def bump_patch_version
    Jeweler::Commands::Version::BumpPatch.run_for self
  end

  # Bumps the minor version.
  #
  # 1.5.1 -> 1.6.0
  def bump_minor_version
    Jeweler::Commands::Version::BumpMinor.run_for self
  end

  # Bumps the major version.
  #
  # 1.5.1 -> 2.0.0
  def bump_major_version
    Jeweler::Commands::Version::BumpMajor.run_for self
  end

  # Bumps the version, to the specific major/minor/patch version, writing out the appropriate version.rb, and then reloads it.
  def write_version(major, minor, patch, build)
    Jeweler::Commands::Version::Write.run_for self, major, minor, patch, build
  end

  def git_base_dir(base_dir = nil)
    if base_dir
      base_dir = File.dirname(base_dir)
    else
      base_dir = File.expand_path(self.base_dir || ".")
    end
    return nil if base_dir==File.dirname("/")
    return base_dir if File.exists?(File.join(base_dir, '.git'))
    git_base_dir(base_dir)
  end    

  def in_git_repo?
    !git_base_dir.nil?
  end
end
