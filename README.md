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
except that you need to set the `driver.name` in your `.kitchen.yml`
to `vagrant_provision` and specify a `vagrantfile_erb`.

### Example .kitchen.yml

~~~~ {.yml}
---
driver:
  name: vagrant

platforms:
- name: ubuntu-12.04
- name: centos-6.4
- name: windows2012
  driver:
    name: vagrant_provision
  driver_config:
    box: windows-2012-standard
    box_url: http://example.com/vagrant/boxes/windows-2012-standard.box
    vagrantfile_erb: 'Vagrantfile.windows.erb'

suites:
- name: default
  run_list: ["recipe[git]"]
  attributes: {}
~~~~

### Example Vagrantfile.windows.erb

```erb
Vagrant.configure('2') do |c|
  c.vm.box = '<%= config[:box] %>'
  c.vm.box_url = '<%= config[:box_url] %>'

  c.vm.hostname = '<%= config[:vm_hostname] %>'
  c.vm.guest = :windows
  c.winrm.username = 'vagrant'
  c.winrm.password = 'vagrant'

  # Needed for WinRM
  c.vm.network(:forwarded_port, guest: 5985, host: 5985)
<% Array(config[:network]).each do |opts| %>
  c.vm.network(:<%= opts[0] %>, <%= opts[1..-1].join(", ") %>)
<% end %>

  c.vm.synced_folder '.', '/vagrant', disabled: true
<% config[:synced_folders].each do |source, destination, options|
     l_source = source.gsub("%{instance_name}", instance.name)
     l_destination = destination.gsub("%{instance_name}", instance.name)
     opt = (options.nil? ? '' : ", #{options}")
%>
  c.vm.synced_folder '<%= l_source %>', '<%= l_destination %>'<%= opt %>
<% end %>

  c.vm.provider :virtualbox do |p|
    p.gui = true
    p.customize ["modifyvm", :id, '--memory', '512']
  end

  c.berkshelf.berksfile_path = '<%= File.join(Dir.pwd, 'Berksfile') %>'
  c.berkshelf.enabled = true

  c.vm.provision :chef_solo do |chef|
    # chef.json = JSON.load(<%= instance.provisioner[:attributes].to_json.inspect %>)
    chef.json = <%= instance.provisioner[:attributes].to_hash.inspect %>
  <% instance.provisioner[:run_list].each do |recipe| %>
    chef.add_recipe '<%= recipe.match(/\[(.*)\]/)[1] %>'
  <% end %>
  end
end
```

Contributing
------------

1.  [Fork it!](https://github.com/docwhat/kitchen-driver-vagrant_provision/fork)
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request
