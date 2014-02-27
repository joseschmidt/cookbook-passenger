# encoding: utf-8
require 'serverspec'
require 'platform_helpers'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |config|
  config.before :all do
    config.path = '/usr/local/rvm/gems/ruby-1.9.3-p327@global/bin:' \
      '/usr/local/rvm/rubies/ruby-1.9.3-p327/bin:/usr/local/rvm/bin:' \
      '/sbin:/usr/sbin'
  end # config.before

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with
end # RSpec
