# Description

This cookbook installs and configures Zend Skeleton Application according to the instructions at https://github.com/zendframework/ZendSkeletonApplication

## Requirements

### Platform

### Cookbooks

 * php
 * apache2
 * openssl

## Attributes

* `node['zend']['version']` - Set the version to download. Using 'latest' (the default) will install the most current version.
* `node['zend']['dir']` - Set the location to place zend skeleton application files. Default is `/var/www`.
* `node['zend']['server_name']` - Set the ServerName used in apache vhost. Default is `node['fqdn']`.
* `node['zend']['server_aliases']` - Array of ServerAliases used in apache vhost. Default is `node['fqdn']`.

## Example of usage in Vagrant

```ruby
# ...
  config.vm.provision :chef_solo do |chef|
# ...
  chef.add_recipe "application_zend"
	chef.json = {
		:zend => {
			:version => 'zf/release-2.1.0',
			:server_name => 'zend.local',
			:server_aliases => 'my.local'
		}
	}
  end
# ...
```

### Vagrant, develop your module using shared folders

Always is your `Vagrantfile`

```ruby
config.vm.share_folder("my-name-module", "/var/www/zend/module/MyNameModule", "../MyNameModule")
```
