# encoding: UTF-8
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rdoc/task'

Dir.glob('lib/tasks/*.rake').each {|r| import r}

desc 'Default: run tests for all'
RSpec::Core::RakeTask.new
task :default => :spec
task :test => :spec

task :environment do
  require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))
end

# not yet!
# desc 'Generate documentation for nagios_monitor.'
# Rake::RDocTask.new(:rdoc) do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title    = 'NagiosMonitor'
#   rdoc.options << '--line-numbers' << '--inline-source'
#   rdoc.rdoc_files.include('README.md')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
