# encoding: utf-8
name              'passenger'
maintainer        'James Hardie Building Products, Inc.'
maintainer_email  'doc.walker@jameshardie.com'
license           'Apache 2.0'
description       'Installs/configures passenger'

version           '0.1.1'
depends           'build-essential'
depends           'logrotate', '~> 1.4.0'
depends           'ohai', '>= 1.1.4'
depends           'rails_app'
depends           'rvm'
depends           'yum'
