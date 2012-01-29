Given 'a working directory' do
  @sandbox = Sandbox.new
  @working_dir = @sandbox.path
end

After do
  @sandbox.close if @sandbox
end

Given /^I use the jeweler command to generate the "([^"]+)" project in the working directory$/ do |name|
  @name = name

  return_to = Dir.pwd
  path_to_jeweler = File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'bin', 'jeweler')

  begin
    FileUtils.cd @working_dir
    @stdout = `#{path_to_jeweler} #{@name}`
  ensure
    FileUtils.cd return_to
  end
end

Given /^"([^"]+)" does not exist$/ do |file|
  File.exists?(File.join(@working_dir, file)).should be_false
end

When /^I run "([^"]+)" in "([^"]+)"$/ do |command, directory|
  full_path = File.join(@working_dir, directory)

  lib_path = File.expand_path 'lib'
  command.gsub!(/^rake /, "rake --trace -I#{lib_path} ")

  File.directory?(full_path).should be_true

  @stdout = `cd #{full_path} && #{command}`
  @exited_cleanly = $?.exited?
end

Then /^the updated version, (.*), is displayed$/ do |version|
  @stdout.should =~ /Updated version: #{version}/
end

Then /^the current version, (\d+\.\d+\.\d+), is displayed$/ do |version|
  @stdout.should =~ /Current version: #{version}/
end

Then /^the process should exit cleanly$/ do
  @exited_cleanly.should be_true # "Process did not exit cleanly: #{@stdout}"
end

Then /^the process should not exit cleanly$/ do
  @exited_cleanly.should be_true # "Process did exit cleanly: #{@stdout}"
end

Given /^I use the existing project "([^"]+)" as a template$/ do |fixture_project|
  @name = fixture_project
  FileUtils.cp_r File.join(fixture_dir, fixture_project), @working_dir
end

Then /^the gemspec has version \"(.*)"$/ do |version|
  gemspec = Dir.glob(File.join(@working_dir, '*.gemspec')).first
  raise "gemspec missing in #{@working_dir}" if gemspec.nil?
  spec = File.read gemspec
  spec.should =~ /#{version.gsub(/\./,'\.')}/
end
