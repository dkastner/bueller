class Bueller
  class GemSpecHelper
    attr_accessor :spec, :base_dir

    def initialize(spec, base_dir = nil)
      self.spec = spec
      self.base_dir = base_dir || ''

      yield spec if block_given?
    end

    def valid?
      begin
        parse
        true
      rescue
        false
      end
    end

    def write
      File.open(path, 'w') do |f|
        f.write self.to_ruby
      end 
    end

    def to_ruby
      normalize_files(:files)
      normalize_files(:test_files)
      normalize_files(:extra_rdoc_files)

      gemspec_ruby = @spec.to_ruby
      gemspec_ruby = prettyify_array(gemspec_ruby, :files)
      gemspec_ruby = prettyify_array(gemspec_ruby, :test_files)
      gemspec_ruby = prettyify_array(gemspec_ruby, :extra_rdoc_files)
    end

    def path
      denormalized_path = File.join(@base_dir, "#{@spec.name}.gemspec")
      absolute_path = File.expand_path(denormalized_path)
      absolute_path.gsub(Dir.getwd + File::SEPARATOR, '') 
    end

    def parse
      data = self.to_ruby
      parsed_gemspec = nil
      Thread.new { parsed_gemspec = eval("$SAFE = 3\n#{data}", binding, path) }.join
      parsed_gemspec
    end

    def normalize_files(array_attribute)
      array = @spec.send(array_attribute)
      # only keep files, no directories, and sort
      array = array.select do |path|
        File.file? File.join(@base_dir, path)
      end.sort

      @spec.send("#{array_attribute}=", array)
    end

    # Adds extra space when outputting an array. This helps create better version control diffs, because otherwise it is all on the same line.
    def prettyify_array(gemspec_ruby, array_name)
      gemspec_ruby.gsub(/s\.#{array_name.to_s} = \[.+?\]/) do |match|
        leadin, files = match[0..-2].split("[")
        
        leadin + "[\n    #{files.gsub(%|", "|, %|",\n    "|)}\n  ]"
      end
    end

    def gem_path
      File.join(@base_dir, 'pkg', parse.file_name)
    end

    def update_version(version)
      @spec.version = version.to_s
    end
    
    # Checks whether it uses the version helper or the users defined version.
    def has_version?
      !@spec.version.nil?
    end
  end
end
