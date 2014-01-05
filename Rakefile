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
  sh 'bundle exec foodcritic -f any .'
end # task
