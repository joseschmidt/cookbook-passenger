# encoding: utf-8
require 'spec_helper'

describe 'passenger::nginx' do
  before do
    # required for travis-ci
    stub_command("bash -c \"source /etc/profile && type rvm | " \
      "cat | head -1 | grep -q '^rvm is a function$'\"").and_return(true)
    stub_command("bash -c \"source /etc/profile.d/rvm.sh && type rvm | " \
      "cat | head -1 | grep -q '^rvm is a function$'\"").and_return(true)
  end # before

  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['passenger']['nginx']['prefix'] = '/opt/nginx-qa'
      node.set['passenger']['nginx']['user'] = 'nginx-qa'
      node.set['passenger']['ruby_string'] = '1.9.3-fake'
      node.set['passenger']['version'] = '3.0.19-fake'
      node.set['passenger']['version_map']['3.0.19-fake'] = '1.2.6-fake'

      # required because default value is nil
      node.set['rvm']['install_pkgs'] = []

      # required for build-essential cookbook on travis-ci
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  describe 'passenger::default' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe '/etc/rc.d/init.d/nginx' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it

    it 'renders file with expected nginx=' do
      expect(chef_run).to render_file(subject)
        .with_content('nginx="/opt/nginx-qa/sbin/nginx"')
    end # it

    it 'renders file with expected NGINX_CONF_FILE=' do
      expect(chef_run).to render_file(subject)
        .with_content('NGINX_CONF_FILE="/opt/nginx-qa/conf/nginx.conf"')
    end # it

    it 'notifies service[nginx]' do
      resource = chef_run.template(subject)
      expect(resource).to notify('service[nginx]').to(:reload).delayed
    end # it
  end # describe

  describe '/var/log/nginx' do
    it 'creates directory with expected owner, group, mode' do
      expect(chef_run).to create_directory(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it
  end # describe

  describe '/etc/logrotate.d/nginx' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it

    it 'renders file with expected path' do
      expect(chef_run).to render_file(subject)
        .with_content('/var/log/nginx/*.log')
    end # it

    it 'renders file with expected frequency' do
      expect(chef_run).to render_file(subject)
        .with_content('daily')
    end # it

    it 'renders file with expected rotation limit' do
      expect(chef_run).to render_file(subject)
        .with_content('rotate 30')
    end # it

    it 'renders file with expected options (missingok)' do
      expect(chef_run).to render_file(subject)
        .with_content('missingok')
    end # it

    it 'renders file with expected options (compress)' do
      expect(chef_run).to render_file(subject)
        .with_content('compress')
    end # it

    it 'renders file with expected options (delaycompress)' do
      expect(chef_run).to render_file(subject)
        .with_content('delaycompress')
    end # it

    it 'renders file with expected options (sharedscripts)' do
      expect(chef_run).to render_file(subject)
        .with_content('sharedscripts')
    end # it

    it 'renders file with expected postrotate command' do
      expect(chef_run).to render_file(subject).with_content(
        '[ ! -f /var/run/nginx.pid ] || kill -USR1 `cat /var/run/nginx.pid`'
      )
    end # it
  end # describe

  it 'creates user nginx-qa' do
    expect(chef_run).to create_user('nginx-qa')
      .with(:system => true, :shell => '/bin/nologin', :home => '/var/www')
  end # it

  # TODO: write spec for rvm_shell

  it 'enables service nginx' do
    expect(chef_run).to enable_service('nginx')
  end # it

  it 'starts service nginx' do
    expect(chef_run).to start_service('nginx')
  end # it

  describe '/opt/nginx-qa/conf/nginx.conf' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0644')
    end # it

    it 'renders file with expected passenger_root' do
      expect(chef_run).to render_file(subject)
        .with_content('passenger_root ' \
        '/usr/local/rvm/gems/1.9.3-fake/gems/passenger-3.0.19-fake;')
    end # it

    it 'renders file with expected passenger_ruby' do
      expect(chef_run).to render_file(subject)
        .with_content('passenger_ruby ' \
        '/usr/local/rvm/wrappers/1.9.3-fake/ruby;')
    end # it

    it 'renders file with expected passenger_base_uri neo' do
      expect(chef_run).to render_file(subject)
        .with_content(/passenger_base_uri\s.*\/neo;/)
    end # it

    it 'renders file with expected passenger_base_uri morpheus' do
      expect(chef_run).to render_file(subject)
        .with_content(/passenger_base_uri\s.*\/morpheus;/)
    end # it

    it 'renders file with expected passenger_pre_start neo' do
      expect(chef_run).to render_file(subject)
        .with_content(%r{passenger_pre_start\s.*http://localhost/neo;})
    end # it

    it 'renders file with expected passenger_pre_start morpheus' do
      expect(chef_run).to render_file(subject)
        .with_content(%r{passenger_pre_start\s.*http://localhost/morpheus;})
    end # it

    it 'renders file with expected rewrite' do
      expect(chef_run).to render_file(subject)
        .with_content('rewrite ' \
        '^/$ $scheme://$http_host/neo permanent;')
    end # it

    it 'renders file with expected location /neo' do
      expect(chef_run).to render_file(subject)
        .with_content('location /neo {')
    end # it

    it 'renders file with expected location /morpheus' do
      expect(chef_run).to render_file(subject)
        .with_content('location /morpheus {')
    end # it

    it 'notifies service[nginx]' do
      resource = chef_run.template(subject)
      expect(resource).to notify('service[nginx]').to(:reload).delayed
    end # it
  end # describe

end # describe
