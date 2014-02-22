# coding: utf-8
require 'spec_helper'

describe 'passenger::default' do
  before do
    # required for travis-ci
    stub_command("bash -c \"source /etc/profile && type rvm | " \
      "cat | head -1 | grep -q '^rvm is a function$'\"").and_return(true)
    stub_command("bash -c \"source /etc/profile.d/rvm.sh && type rvm | " \
      "cat | head -1 | grep -q '^rvm is a function$'\"").and_return(true)
  end # before

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['passenger']['ruby_string'] = '1.9.3-fake'
      node.set['passenger']['version'] = '3.0.19-fake'

      # required because default value is nil
      node.set['rvm']['install_pkgs'] = []

      # required for build-essential cookbook on travis-ci
      node.set['platform_family'] = 'rhel'
    end.converge(described_recipe)
  end # let

  it 'includes recipe build-essential' do
    expect(chef_run).to include_recipe('build-essential')
  end # it

  it 'includes recipe passenger::ohai_plugin' do
    expect(chef_run).to include_recipe('passenger::ohai_plugin')
  end # it

  it 'includes recipe rails_app' do
    expect(chef_run).to include_recipe('rails_app')
  end # it

  it 'includes recipe rvm' do
    expect(chef_run).to include_recipe('rvm')
  end # it

  it 'includes recipe rvm::system' do
    expect(chef_run).to include_recipe('rvm::system')
  end # it

  it 'includes recipe rvm:gem_package' do
    expect(chef_run).to include_recipe('rvm::gem_package')
  end # it

  it 'installs package ruby-devel' do
    expect(chef_run).to install_package('ruby-devel')
  end # it

  it 'installs package curl-devel' do
    expect(chef_run).to install_package('curl-devel')
  end # it

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
