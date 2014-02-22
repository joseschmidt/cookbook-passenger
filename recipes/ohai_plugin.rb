# encoding: utf-8
#
# Cookbook Name:: passenger
# Recipe:: ohai_plugin
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Author:: Doc Walker (<doc.walker@jameshardie.com>)
#
# Copyright 2012, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ohai 'reload_passenger_nginx' do
  action :nothing
  plugin 'passenger'
end # ohai

template "#{node['ohai']['plugin_path']}/passenger.rb" do
  source 'plugins/passenger.rb.erb'
  owner 'root'
  group 'root'
  mode  '0755'
  variables(
    :passenger_nginx_prefix => node['passenger']['nginx']['prefix']
  )
  notifies :reload, 'ohai[reload_passenger_nginx]', :immediately
end # template

include_recipe 'ohai'
