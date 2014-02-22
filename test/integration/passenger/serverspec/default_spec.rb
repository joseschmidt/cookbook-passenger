# coding: utf-8
require 'spec_helper'

describe 'passenger::default' do
  describe package('ruby-devel') do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('curl-devel'), :if => rhel5? do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('libcurl-devel'), :if => rhel6? do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe command('which ruby') do
    it 'is installed' do
      expect(subject).to return_stdout(
        '/usr/local/rvm/rubies/ruby-1.9.3-p327/bin/ruby'
      )
    end # it
  end # describe

  # ensure path to `gem` script executable has been set in spec_helper
  describe package('rake') do
    it 'is installed (gem)' do
      expect(subject).to be_installed.by('gem')
    end # it
  end # describe

  # ensure path to `gem` script executable has been set in spec_helper
  describe package('ohai') do
    it 'is installed (gem)' do
      expect(subject).to be_installed.by('gem')
    end # it
  end # describe

  # ensure path to `gem` script executable has been set in spec_helper
  describe package('passenger') do
    it 'is installed (gem) v3.0.19' do
      expect(subject).to be_installed.by('gem').with_version('3.0.19')
    end # it
  end # describe

end # describe
