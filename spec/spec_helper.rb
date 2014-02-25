# encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'
Dir.glob(File.dirname(__FILE__) + '/helpers/**/*', &method(:require))

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with
end # RSpec
