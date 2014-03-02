# encoding: utf-8
name              'passenger'
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
description       'Installs and configures passenger and nginx for the ' \
                  'Rails app'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license           'Apache 2.0'
version           '0.1.1'

#--------------------------------------------------------------------- recipes
recipe            'passenger',
                  'Installs required support packages, plugins, rvm, ' \
                  'ruby, and gems'
recipe            'passenger::nginx',
                  'Includes the default recipe, ' \
                  'installs the nginx daemon control script, ' \
                  'creates log files, ' \
                  'configures logrotate, ' \
                  'creates nginx user, ' \
                  'and installs/configures nginx with the passenger module'
recipe            'passenger::ohai_plugin',
                  'Installs an ohai plugin to support the nginx install'

#------------------------------------------------------- cookbook dependencies
depends           'build-essential'
depends           'logrotate', '~> 1.5.0'
depends           'ohai', '>= 1.1.4'
depends           'rails_app'
depends           'rvm'
depends           'yum-epel'

#--------------------------------------------------------- supported platforms
# tested
supports          'centos'

# platform_family?('rhel'): not tested, but should work
supports          'amazon'
supports          'oracle'
supports          'redhat'
supports          'scientific'

# platform_family?('debian'): not tested, but may work
supports          'debian'
supports          'ubuntu'
