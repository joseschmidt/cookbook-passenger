#!/usr/bin/env rake
# coding: utf-8
require 'bundler/setup'

# Style guide for this Rakefile:
# - place default task at the beginning of the file
# - individual tasks are listed in alphabetical order

task :default => [:foodcritic]

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
