# encoding: utf-8
require 'spec_helper'

describe 'passenger::ohai_plugin' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['ohai']['plugin_path'] = '/etc/chef/ohai_plugins-qa'
      node.set['passenger']['nginx']['prefix'] = '/opt/nginx-qa'

      # required for build-essential cookbook on travis-ci
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  describe '/etc/chef/ohai_plugins-qa/passenger.rb' do
    it 'creates template with expected owner, group, mode' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root', :mode => '0755')
    end # it

    it 'renders file with expected provides' do
      expect(chef_run).to render_file(subject)
        .with_content("provides 'passenger'")
    end # it

    it 'renders file with expected cwd' do
      expect(chef_run).to render_file(subject)
        .with_content(":cwd => '/opt/nginx-qa'")
    end # it

    it 'notifies ohai[reload_passenger_nginx]' do
      resource = chef_run.template(subject)
      expect(resource).to notify('ohai[reload_passenger_nginx]').to(:reload)
        .immediately
    end # it
  end # describe

  describe 'ohai' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

end # describe
