# encoding: utf-8
require 'serverspec'

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

# returns true if os is rhel family v5
def rhel5?
  os = backend.check_os
  os[:family] == 'RedHat' && os[:release].to_i == 5
end # def

# returns true if os is rhel family v6
def rhel6?
  os = backend.check_os
  os[:family] == 'RedHat' && os[:release].to_i == 6
end # def
