class Jeweler
  module Commands
    module Version
      class Write < Base
        def self.run_for(jeweler, major, minor, patch, build)
          command = new jeweler
          command.major = major
          command.minor = minor
          command.patch = patch
          command.build = build
          command.run
        end

        attr_accessor :major, :minor, :patch, :build
        def update_version
          version_helper.update_to major, minor, patch, build
        end
      end
    end
  end
end
