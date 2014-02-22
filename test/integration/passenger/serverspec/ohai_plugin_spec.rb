# coding: utf-8
require 'spec_helper'

describe 'passenger::nginx' do
  describe file('/etc/chef/ohai_plugins/passenger.rb') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is mode 755' do
      expect(subject).to be_mode('755')
    end # it

    it 'is owned by root' do
      expect(subject).to be_owned_by('root')
    end # it

    it 'is grouped into root' do
      expect(subject).to be_grouped_into('root')
    end # it

    it 'includes expected plugin name' do
      expect(subject.content).to include(
        'Plugin Name:: passenger'
      )
    end # it

    it 'includes expected cwd' do
      expect(subject.content).to include(
        ":cwd => '/opt/nginx-qa'"
      )
    end # it

  end # describe
end # describe
