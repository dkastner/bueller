require 'rake/tasklib'

# Clean up after gem building
require 'rake/clean'
CLEAN.include('pkg/*.gem')

class Rake::Application
  attr_accessor :jeweler_tasks

  # The jeweler instance that has be instantiated in the current Rakefile.
  #
  # This is usually useful if you want to get at info like version from other files.
  def jeweler
    jeweler_tasks.jeweler
  end
end

class Jeweler
  # Rake tasks for managing your gem.
  #
  # Here's a basic usage example:
  #
  #   Jeweler::Tasks.new
  class Tasks < ::Rake::TaskLib
    attr_accessor :jeweler

    def initialize
      Rake.application.jeweler_tasks = self
      define
    end

    def jeweler
      @jeweler ||= Jeweler.new
    end

  private

    def define
      gem_helper = Bundler::GemHelper.install_tasks

      task :gemspec_required do
        unless File.exist?(jeweler.gemspec_helper.path)
          abort "Expected #{jeweler.gemspec_helper.path} to exist. See 'rake gemspec:write' to create it"
        end
      end

      desc "Displays the current version"
      task :version do
        $stdout.puts "Current version: #{jeweler.version}"
      end

      namespace :version do
        desc "Writes out an explicit version. Respects the following environment variables, or defaults to 0: MAJOR, MINOR, PATCH. Also recognizes BUILD, which defaults to nil"
        task :write do
          major, minor, patch, build = ENV['MAJOR'].to_i, ENV['MINOR'].to_i, ENV['PATCH'].to_i, (ENV['BUILD'] || nil )
          jeweler.write_version(major, minor, patch, build)
          $stdout.puts "Updated version: #{jeweler.version}"
        end

        namespace :bump do
          desc "Bump the gemspec by a major version."
          task :major => :version do
            jeweler.bump_major_version
            $stdout.puts "Updated version: #{jeweler.version}"
          end

          desc "Bump the gemspec by a minor version."
          task :minor => :version do
            jeweler.bump_minor_version
            $stdout.puts "Updated version: #{jeweler.version}"
          end

          desc "Bump the gemspec by a patch version."
          task :patch => :version do
            jeweler.bump_patch_version
            $stdout.puts "Updated version: #{jeweler.version}"
          end
        end
      end

      task :release => :clean

      desc "(deprecated) Start IRB with all runtime dependencies loaded"
      task :console, [:script] do |t, args|
        # TODO move to a command
        warn '`rake console` is deprecated in Jewler 2.0.0. Please use `bundle console` instead'
        if args.script
          load args.script
          cli = Bundler::CLI.new
          cli.console
        else
          exec 'bundle console'
        end
      end
    end
  end
end
