require "bundler/gem_tasks"
require 'rake/testtask'
require 'rails'
require 'active_record'
require File.expand_path('../lib/pg_tenant', __FILE__)
require File.expand_path('../config/initializers/pg_tenant', __FILE__)


desc 'Runs all the pg_tenant tests'
task :test do
  $: << 'test'

  Rake::TestTask.new do |t|
    t.pattern = 'test/**/*_test.rb'
  end
end

namespace :test do
  

end


task default: [:test]
