# encoding: utf-8
require 'spec_helper'

describe 'passenger::default' do
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
      node.set['passenger']['ruby_string'] = '1.9.3-fake'
      node.set['passenger']['version'] = '3.0.19-fake'

      # required because default value is nil
      node.set['rvm']['install_pkgs'] = []

      # required for build-essential cookbook on travis-ci
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # cached

  describe 'build-essential' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'passenger::ohai_plugin' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'rails_app' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'rvm' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'rvm::system' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'rvm::gem_package' do
    it 'includes described recipe' do
      expect(chef_run).to include_recipe(subject)
    end # it
  end # describe

  describe 'ruby-devel' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  describe 'curl-devel' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  it 'creates rvm environment' do
    expect(chef_run).to create_rvm_environment('1.9.3-fake')
  end # it

  it 'installs rvm global gem rake' do
    expect(chef_run).to install_rvm_global_gem('rake')
  end # it

  it 'installs rvm global gem ohai' do
    expect(chef_run).to install_rvm_global_gem('ohai')
  end # it

  it 'installs rvm global gem passenger v3.0.19-fake' do
    expect(chef_run).to install_rvm_global_gem('passenger')
      .with(:version => '3.0.19-fake')
  end # it

end # describe
