# encoding: utf-8
require 'spec_helper'

describe 'passenger::nginx' do
  describe file('/etc/rc.d/init.d/nginx') do
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

    it 'includes expected comment' do
      expect(subject.content).to include(
        'this script starts and stops the nginx daemon'
      )
    end # it
  end # describe

  describe file('/var/log/nginx') do
    it 'is a directory' do
      expect(subject).to be_directory
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
  end # describe

  describe file('/etc/logrotate.d/nginx') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by root' do
      expect(subject).to be_owned_by('root')
    end # it

    it 'is in group root' do
      expect(subject).to be_grouped_into('root')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it

    it 'includes expected path' do
      expect(subject.content).to include('/var/log/nginx/*.log')
    end # it

    it 'includes expected frequency' do
      expect(subject.content).to include('daily')
    end # it

    it 'includes expected rotate limit' do
      expect(subject.content).to include('rotate 30')
    end # it

    it 'includes expected options (missingok)' do
      expect(subject.content).to include('missingok')
    end # it

    it 'includes expected options (compress)' do
      expect(subject.content).to include('compress')
    end # it

    it 'includes expected options (delaycompress)' do
      expect(subject.content).to include('delaycompress')
    end # it

    it 'includes expected postrotate command' do
      expect(subject.content).to include(
        '[ ! -f /var/run/nginx.pid ] || kill -USR1 `cat /var/run/nginx.pid`'
      )
    end # it
  end # describe

  describe user('nginx-qa') do
    it 'exists' do
      expect(subject).to exist
    end # it

    it 'has expected home directory' do
      expect(subject).to have_home_directory('/var/www')
    end # it

    it 'has expected login shell' do
      expect(subject).to have_login_shell('/bin/nologin')
    end # it
  end # describe

  # ensure path to `gem` script executable has been set in spec_helper
  describe package('passenger') do
    it 'is installed (gem)' do
      expect(subject).to be_installed.by('gem')
    end # it
  end # describe

  describe service('nginx') do
    it 'is enabled' do
      expect(subject).to be_enabled
    end # it

    it 'is running' do
      expect(subject).to be_running
    end # it
  end # describe

  describe file('/opt/nginx-qa/conf/nginx.conf') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by root' do
      expect(subject).to be_owned_by('root')
    end # it

    it 'is in group root' do
      expect(subject).to be_grouped_into('root')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it

    it 'includes expected passenger_root' do
      expect(subject.content).to include('passenger_root ' \
        '/usr/local/rvm/gems/ruby-1.9.3-p327@global/gems/passenger-3.0.19;'
      )
    end # it

    it 'includes expected passenger_ruby' do
      expect(subject.content).to include('passenger_ruby ' \
        '/usr/local/rvm/wrappers/ruby-1.9.3-p327@global/ruby;'
      )
    end # it
  end # describe

end # describe
