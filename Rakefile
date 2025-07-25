require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

task default: [:test]

desc 'Run unit tests'
Rake::TestTask.new('test') do |t|
  t.pattern = 'test/test_google_drive.rb'
  t.verbose = false
  t.warning = false
end

desc 'Run unit test for ci'
Rake::TestTask.new('test_ci') do |t|
  t.pattern = 'test/test_ci.rb'
  t.verbose = false
  t.warning = false
end
