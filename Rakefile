# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "acts_as_chattable"
  gem.email = "ben@logicbox.com.au"
  gem.summary = "Make user chattable!"
  gem.homepage = "https://github.com/logicbox-com-au/acts_as_chattable"
  gem.authors = ["Ben Bruscella"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['-fd -c --order random']
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec
