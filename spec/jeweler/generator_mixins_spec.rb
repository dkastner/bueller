require 'spec_helper'

# FIXME: use example groups/it_should_behave_like instead
describe 'Jeweler::Generator Mixins' do
  [Jeweler::Generator::BaconMixin,
   Jeweler::Generator::MicronautMixin,
   Jeweler::Generator::MinitestMixin,
   Jeweler::Generator::RspecMixin,
   Jeweler::Generator::ShouldaMixin,
   Jeweler::Generator::TestspecMixin,
   Jeweler::Generator::TestunitMixin,
  ].each do |mixin|
    describe "#{mixin}" do
      %w(default_task feature_support_require feature_support_extend
         test_dir test_task test_pattern test_filename
         test_helper_filename).each do |method|
          it "should define #{method}" do
            mixin.method_defined?(method).should be_true
          end
       end
    end
  end
end
