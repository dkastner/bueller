class Bueller
  class Generator
    module MinitestMixin
      def self.extended(generator)
        generator.development_dependencies << 'minitest'
      end

      def default_task
        'test'
      end

      def feature_support_require
        'minitest/unit'
      end

      def feature_support_extend
        'MiniTest::Assertions'
      end

      def test_dir
        'test'
      end

      def test_task
        'test'
      end

      def test_pattern
        'test/**/test_*.rb'
      end

      def test_filename
        "test_#{require_name}.rb"
      end

      def test_helper_filename
        "helper.rb"
      end

    end
  end
end
