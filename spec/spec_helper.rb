# coding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with
end # RSpec
