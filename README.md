# Description

This cookbook installs and configures Zend Skeleton Application according to the instructions at https://github.com/zendframework/ZendSkeletonApplication

## Requirements

### Platform

 * Debian
 * Ubuntu

### Cookbooks

 * apt
 * build-essential
 * php
 * apache2
 * openssl

## Attributes

* `node['zend']['version']` - Set the version to download. Using 'latest' (the default) will install the most current version.
* `node['zend']['dir']` - Set the location to place zend skeleton application files. Default is `/var/www`.
* `node['zend']['server_name']` - Set the ServerName used in apache vhost. Default is `node['fqdn']`.
* `node['zend']['server_aliases']` - Array of ServerAliases used in apache vhost. Default is `node['fqdn']`.
* `node['zend']['modules']` - Array of Module names that you want to enable in your `application.config.php` 
* `node['zend']['composer']['packages']` - Array of composer modules to install see dedicated section
* `node['zend']['dev']['version']` - Set the version of `ZendDeveloperTools` module. Default is `dev-master`

## Example of usage in Vagrant


    # ...
    config.vm.provision :chef_solo do |chef|
    # ...
    chef.add_recipe "application_zf"
        chef.json = {
            :zend => {
                :version => 'zf/release-2.1.0',
                :server_name => 'zend.local',
                :server_aliases => 'my.local'
            }
        }
    end
    # ...

### Vagrant, develop your module using shared folders

Always is your `Vagrantfile`

    config.vm.share_folder("my-name-module", "/var/www/zend/module/MyNameModule", "../MyNameModule")

## Add your module in the configuration

    chef.json = {
        :zend => {
            :modules => [
                "Application",
                "MyNameModule"
            ],
    # ...

## Add third parties libraries with Composer

You can use the 

    chef.json = {
        :zend => {
            :modules => [
                "Application",
                "ZfcBase",
                "ZfcUser"
            ],
            :composer => {
                :packages => [
                    {
                        :version => "0.1.*",
                        :name => "zf-commons/zfc-user"
                    }
                ]
            }
        }
    }

## ZendDeveloperTools integration

If want to enable the Zend Developer Tools you can add dev_tools in your
configuration

    chef.add_recipe "application_zf::dev_tools"

And remember to add the `ZendDeveloperTools` in your module list

    chef.json = {
        :zend => {
            :modules => [
                "ZendDeveloperTools",
                "Application"	
            ]
        }
    }

### Tune the ZendDeveloperTools version

Set the `dev` version

    node['zend']['dev']['version'] = "dev-master"

### Add Zend\Db profiler

Is simple, add the `bjyoungblood/BjyProfiler` package

    :composer => {
        :packages =>[
            {
                :version => "dev-master",
                :name => "bjyoungblood/BjyProfiler"
            }
        ]
    }

And also enable module `BjyProfiler` after `ZendDeveloperTools`

    :modules => [
        "ZendDeveloperTools",
        "BjyProfiler"

