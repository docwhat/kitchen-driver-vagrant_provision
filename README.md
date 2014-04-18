Kitchen::Driver::VagrantProvision
=================================

This is identical to the
[`kitchen-vagrant`](https://github.com/test-kitchen/kitchen-vagrant/)
driver except that it uses [Vagrant](http://www.vagrantup.com/) for
provisioning via the `vagrant provision` command.

Installation
------------

Add this line to your application's `Gemfile`:

    gem 'kitchen-driver-vagrant_provision'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kitchen-driver-vagrant_provision

Usage
-----

This works exactly the same as
[`kitchen-vagrant`](https://github.com/test-kitchen/kitchen-vagrant/)
except that you need to set the `driver_plugin` in your `.kitchen.yml`
to `vagrant_provision`.

Example:

~~~~ {.yml}
---
driver_plugin: vagrant

platforms:
- name: ubuntu-12.04
- name: centos-6.4

suites:
- name: default
  run_list: ["recipe[git]"]
  attributes: {}
~~~~

Contributing
------------

1.  [Fork it!](https://github.com/docwhat/kitchen-driver-vagrant_provision/fork)
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request
