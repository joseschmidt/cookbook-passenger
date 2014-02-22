#!/usr/bin/env rake
# encoding: utf-8
require 'bundler/setup'
require 'rubocop/rake_task'

# Style guide for this Rakefile:
# - place default task at the beginning of the file
# - individual tasks are listed in alphabetical order

#---------------------------------------------- automatically run by travis-ci
task :default => [:build_ci]

desc 'Builds the package for ci server.'
task :build_ci do
  Rake::Task[:knife].execute
  Rake::Task[:rubocop].execute
  Rake::Task[:foodcritic].execute
  Rake::Task[:chefspec].execute
end # task

#------------------------------------------------------------------ unit tests
desc 'Runs chefspec unit tests against the cookbook.'
task :chefspec do
  sh 'bundle exec rspec'
end # task

#-------------------------------------------------- cookbook lint/style checks
desc 'Runs foodcritic lint tool against the cookbook.'
task :foodcritic do
  Rake::Task['foodcritic:default'].execute
end # task

namespace :foodcritic do
  task :default do
    sh 'bundle exec foodcritic -I spec/foodcritic/* -f any .'
  end # task

  desc 'Updates 3rd-party foodcritic rules.'
  task :update do
    sh 'git submodule update --init --recursive'
  end # task
end # namespace

#----------------------------------------------------------- integration tests
begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new

  desc 'Run all test instances'
  task :kitchen => ['kitchen:all']
rescue LoadError
  STDOUT.puts '[WARN] Kitchen::RakeTasks not loaded'
end

#--------------------------------------------------------------- syntax checks
desc 'Runs knife cookbook syntax checks against the cookbook.'
task :knife do
  sh 'bundle exec knife cookbook test -a -c spec/chef/knife.rb'
end # task

#-------------------------------------------------------------- release/tagger
begin
  require 'emeril/rake_tasks'
  Emeril::RakeTasks.new do |t|
    t.config[:publish_to_community] = false
  end
rescue LoadError
  STDOUT.puts '[WARN] Emeril::RakeTasks not loaded'
end

#------------------------------------------------------ ruby lint/style checks
desc 'Runs rubocop lint tool against the cookbook.'
task :rubocop do
  Rubocop::RakeTask.new(:rubocop) do |task|
    # task.fail_on_error = true
  end
end # task
