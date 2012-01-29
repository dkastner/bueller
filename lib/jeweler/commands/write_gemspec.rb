class Jeweler
  module Commands
    class WriteGemspec
      attr_accessor :base_dir, :output, :gemspec_helper, :version_helper

      def initialize(jeweler)
        self.output = $stdout
        self.base_dir = jeweler.base_dir
        self.output = jeweler.output
        self.gemspec_helper = jeweler.gemspec_helper
        self.version_helper = jeweler.version_helper
      end

      def run
        gemspec_helper.set_date
        gemspec_helper.write

        output.puts "Generated: #{gemspec_helper.path}"  
      end

      def self.run_for(jeweler)
        command = new(jeweler)
        command.run
        command
      end
    end
  end
end
