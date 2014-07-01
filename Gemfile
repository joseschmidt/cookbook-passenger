# encoding: utf-8
source 'https://rubygems.org'

group :development do
  gem 'emeril', '~> 0.7.0'
  gem 'pimpmychangelog', '~> 0.1.2'
end # group

group :test do
  gem 'berkshelf', '~> 3.1.1'
  gem 'chefspec', '~> 3.4.0'
  gem 'foodcritic', '~> 3.0.3'

  # TODO: remove rspec dependency declaration;
  # chefspec specifies rspec ~2.14 and 2.99.0 breaks
  gem 'rspec', '~> 2.14.0'

  gem 'rubocop', '~> 0.23.0'
  gem 'rvm', '~> 1.11.3.8'
end # group

group :integration do
  gem 'test-kitchen', '~> 1.2.1'
  gem 'kitchen-vagrant', '~> 0.14.0'
end # group
