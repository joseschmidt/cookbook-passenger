# encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
Dir.glob(File.dirname(__FILE__) + '/helpers/**/*', &method(:require))

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with

  config.platform = 'centos'
  config.version = '6.5'
end # RSpec
