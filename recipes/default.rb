# coding: utf-8
#
# Cookbook Name:: passenger
# Recipe:: default
#
# Copyright 2013, James Hardie Building Products, Inc.
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

#--------------------------------------------------- include dependent recipes
include_recipe 'build-essential'

include_recipe 'passenger::ohai_plugin'

include_recipe 'rails_app'

include_recipe 'rvm'
include_recipe 'rvm::system'
include_recipe 'rvm::gem_package'

#------------------------------------------------ install package dependencies
%w(ruby-devel curl-devel).each do |pkg|
  package pkg
end

#------------------------------------------------------ install passenger ruby
rvm_environment node['passenger']['ruby_string']

#---------------------------------------------------- install gem dependencies
rvm_global_gem 'rake'
rvm_global_gem 'ohai'
rvm_global_gem 'passenger' do
  version node['passenger']['version']
  action :install
end
