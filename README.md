passenger Cookbook
==================
[![Build Status](https://travis-ci.org/jhx/cookbook-passenger.png?branch=master)](https://travis-ci.org/jhx/cookbook-passenger)
[![Dependency Status](https://gemnasium.com/jhx/cookbook-passenger.png)](https://gemnasium.com/jhx/cookbook-passenger)

Installs and configures passenger and nginx for the Rails app.


Requirements
------------
### Cookbooks
The following cookbooks are direct dependencies because they're used for common "default" functionality.

- [`build-essential`](https://github.com/opscode-cookbooks/build-essential)
- [`logrotate`](https://github.com/opscode-cookbooks/logrotate)
- [`ohai`](https://github.com/opscode-cookbooks/ohai)
- [`rails_app`](https://github.com/jhx/cookbook-rails_app)
- [`rvm`](https://github.com/fnichol/chef-rvm)
- [`yum-epel`](https://github.com/opscode-cookbooks/yum-epel)

### Platforms
The following platforms are supported and tested under Test Kitchen:

- CentosOS 5.10, 6.5

Other RHEL family distributions are assumed to work. See [TESTING](TESTING.md) for information about running tests in Opscode's Test Kitchen.


Attributes
----------
Refer to [`attributes/default.rb`](attributes/default.rb) for default values.

- `node['passenger']['version']` - version of passenger
- `node['passenger']['version_map']` - options hash to map passenger version to nginx version
- `node['passenger']['nginx']['prefix]` - path to nginx installation directory
- `node['passenger']['nginx']['user]` - nginx user
- `node['passenger']['nginx']['conf_path]` - path to nginx configuration file
- `node['passenger']['nginx']['configure_flags]` - nginx configuration flags applied during compilation
- `node['passenger']['nginx']['modules]` - nginx modules compiled incorporated into binary


Recipes
-------
This cookbook provides one main recipe for configuring a node.

- `default.rb` - *Use this recipe* to install required support packages and gems.
- `nginx.rb` - *Use this recipe* to install and configure passenger and nginx.
- `ohai_plugin.rb` - *Use this recipe* to install an ohai plugin to support the nginx install.

### default
This recipe installs required support packages, plugins, rvm, ruby, and gems.

### nginx
This recipe includes the default recipe, installs the nginx daemon control script, creates log files, configures logrotate, creates nginx user, and installs/configures nginx with the passenger module.

### ohai_plugin
This recipe installs an ohai plugin to support the nginx install.


Usage
-----
On client nodes, use the following recipes:

````javascript
{ "run_list": ["recipe[passenger::nginx]"] }
````

The following are the key items achieved by this cookbook:

- installs required support packages and plugins
- installs rvm, ruby, required gems
- installs nginx daemon control script
- creates log files, installs logrotate configuration file
- creates nginx user, installs/configures nginx with the passenger module


License & Authors
-----------------
- Author:: Doc Walker (<doc.walker@jameshardie.com>)

````text
Copyright 2013-2014, James Hardie Building Products, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
````
