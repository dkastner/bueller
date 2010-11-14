require 'pathname'

class Jeweler
  module Commands
    module Version
      class Base
        def self.run_for(jeweler)
          command = new jeweler
          command.run
          command
        end

        attr_accessor :version_helper, :gemspec
        attr_reader :jeweler

        def initialize(jeweler)
          @jeweler = jeweler
        end

        def version_helper; jeweler.version_helper; end
        def gemspec_helper; jeweler.gemspec_helper; end
        def repo; jeweler.repo; end
        def commit; jeweler.commit; end

        def run
          update_version

          gemspec_helper.write
          version_helper.write_version

          commit_version
        end

        def update_version
          raise "Subclasses should implement this"
        end

        def commit_version
          if repo and commit
            repo.add gemspec_helper.path
            repo.add version_helper.path
            repo.commit "Version bump to #{version_helper.to_s}"
          end
        end
      end
    end
  end
end
