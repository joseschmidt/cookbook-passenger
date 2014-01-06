# coding: utf-8
#
# Cookbook Name:: passenger
# Attributes:: default
#

default['passenger']['version']                   = '3.0.19'
default['passenger']['version_map'] = {
  '3.0.19' => '1.2.6',
  '3.0.18' => '1.2.4',
  '3.9.1.beta' => '1.2.4', # problems building this
  '3.0.17' => '1.2.3',
  '3.0.15' => '1.2.2',
  '3.0.14' => '1.2.2',
  '3.0.13' => '1.2.1',
  '3.0.12' => '1.0.15',
  '3.0.11' => '1.0.10'
} # map versions: passenger => nginx

default['passenger']['nginx']['prefix']           = '/opt/nginx'
default['passenger']['nginx']['user']             = 'nginx'

default['passenger']['nginx']['conf_path']        =
  "#{node['passenger']['nginx']['prefix']}/conf/nginx.conf"

default['passenger']['nginx']['configure_flags']  = [
  'auto', 'auto-download', "prefix=#{node['passenger']['nginx']['prefix']}"
]
default['passenger']['nginx']['modules']          = [
  'http_gzip_static_module', # not needed with passenger-3.0.19
]
