class Jeweler
  class Generator
    module RspecMixin
      def self.extended(generator)
        generator.development_dependencies << ["rspec", "~> 2.8.0"]
      end

      def default_task
        'spec'
      end

      def feature_support_require
        'rspec/expectations'
      end

      def feature_support_extend
        nil # Cucumber is smart enough extend Spec::Expectations on its own
      end

      def test_dir
        'spec'
      end

      def test_task
        'spec'
      end

      def test_pattern
        'spec/**/*_spec.rb'
      end

      def test_filename
        "#{require_name}_spec.rb"
      end

      def test_helper_filename
        "spec_helper.rb"
      end

      module InstanceMethods
        def create_files
          super

          output_template_in_target File.join(testing_framework.to_s, '.rspec'),
                                    '.rspec'
        end
      end
    end
  end
end
