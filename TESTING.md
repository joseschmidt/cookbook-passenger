Testing
=======
This cookbook uses a variety of testing components:

- Syntax: [Knife](http://docs.opscode.com/chef/knife.html#test)
- Chef Style lints: [Foodcritic](https://github.com/acrmp/foodcritic)
- Ruby Style lints: [Rubocop](https://github.com/bbatsov/rubocop)
- Unit tests: [ChefSpec](https://github.com/acrmp/chefspec)
- Integration tests: [Test Kitchen](https://github.com/opscode/test-kitchen)


Prerequisites
-------------
To develop on this cookbook, you must have a sane Ruby 1.9+ environment. Given the nature of this installation process (and it's variance across multiple operating systems), we will leave this installation process to the user.

You must also have `bundler` installed:

    $ gem install bundler

You must also have Vagrant and VirtualBox installed:

- [Vagrant](https://vagrantup.com)
- [VirtualBox](https://virtualbox.org)

Once installed, you must install the `vagrant-berkshelf` plugin:

    $ vagrant plugin install vagrant-berkshelf


Development
-----------

- Clone the git repository from GitHub:

        $ git clone git@github.com:jhx/COOKBOOK.git

- Install the dependencies using bundler:

        $ bundle install

- Create a branch for your changes:

        $ git checkout -b my_bug_fix

- Make any changes
- Write tests to support those changes. It is highly recommended you write both unit and integration tests.
- Run the tests:

    - `bundle exec rake`

    or run the tests individually:

    - `bundle exec rake knife`
    - `bundle exec rake rubocop`
    - `bundle exec rake foodcritic`
    - `bundle exec rake chefspec`
    - `bundle exec rake kitchen`

- Assuming the tests pass, open a Pull Request on GitHub


Directory structure
-------------------
Below is the structure of the `spec` and `test` directories:

````text
.
├── spec                                # unit tests
│   ├── chef
│   │   └── knife.rb                    # knife configuration
│   ├── *_spec.rb                       # recipe specs (match recipe name)
│   ├── foodcritic                      # custom foodcritic rules
│   └── spec_helper.rb
└── test
    └── integration                     # integration tests
        ├── helpers
        │   └── serverspec
        │       └── spec_helper.rb
        └── passenger                   # suite (match cookbook name)
            └── serverspec              # busser
                └── *_spec.rb           # suite specs (match recipe name)
````
