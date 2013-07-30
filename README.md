# Description

This cookbook installs and configures Zend Skeleton Application according to
the instructions at https://github.com/zendframework/ZendSkeletonApplication

## Requirements

This project is platform independent `application_zf::install_skeleton`.

The recipe `application_zf::default` install a typical system (Apache2 - PHP5 - ZF Skeleton).

### Platform

 * Debian
 * Ubuntu
 * Rhel     (not tested)
 * Fedora   (not tested)
 * CentOS   (not tested)

### Cookbooks

 * apt
 * yum
 * build-essential
 * php
 * apache2
 * openssl

## Attributes

* `node['zf']['version']` - Set the version (Skeleton) to download. Using 'latest' (the default) will install the most current version.
* `node['zf']['dir']` - Set the location to place zend skeleton application files. Default is `/var/www`.
* `node['zf']['server_aliases']` - Array of ServerAliases used in apache vhost. Default is `[node['fqdn']]`.
* `node['zf']['modules']` - Array of Module names that you want to enable in your `application.config.php`
* `node['zf']['composer']['packages']` - Array of composer modules to install see dedicated section
* `node['zf']['dev']['version']` - Set the version of `ZendDeveloperTools` module. Default is `dev-master`
* `node['zf']['skeleton']['repository']` - Repository used to download Skeleton App. Default is `https://github.com/zendframework/ZendSkeletonApplication)`
* `node['zf']['deploy']['modules']['git']` - Array of git zf2 module repositories that you want to deploy

## Getting Started

This group of recipes install and configure a Zend Framework Standard Skeleton
application or something based on it.

Essentially you have to use the `application_zf::default` to install a standard
system (Apache2 + PHP + ZendFramework/SkeletonApplication). If you prefer, you
can use single recipes in order to create your personal infrastructure.

## Deploy cycles

 * `application_zf::deploy_git_modules`
    * Deploy your git modules in `module` folder
 * `application_zf::deploy_composer_packages`
    * Deploy composer packages `vendor` folder
 * `application_zf::deploy_modules_list`
    * Deploy your module list `application.config.php` configuration file

## Example of usage in Vagrant

    # ...
    config.vm.provision :chef_solo do |chef|
    # ...
    chef.add_recipe "application_zf"
        chef.json = {
            :zf => {
                :version => 'zf/release-2.1.0',
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
        :zf => {
            :modules => [
                "Application",
                "MyNameModule"
            ],
    # ...

To update your module list you have to use the `application_zf::deploy_module_list`

## Add third parties libraries with Composer

You can use the

    chef.json = {
        :zf => {
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

To deploy your additional composer packages you have to use `application_zf::deploy_composer_packages`

## Deploy your modules

If you want to deploy your module you have to add the `application_zf::deploy_module_git` recipe.

    chef.json = {
        :zf => {
            :deploy => {
                :modules => {
                    :git => [
                        {
                            :name => "YourDevModule",
                            :uri => "http://github.com/username/YourDevModule.git",
                            :branch => "master"
                        }
                    ]
                }
            }
        }
    }

The `branch` key, is in fact the `revision`, for that reason you can also use a
git commit id.

To deploy your additional module you have to use `application_zf::deploy_module_git`

## ZendDeveloperTools integration

If want to enable the Zend Developer Tools you can add `application_zf::dev_tools` in your
configuration

    chef.add_recipe "application_zf::dev_tools"

And remember to add the `ZendDeveloperTools` in your module list

    chef.json = {
        :zf => {
            :modules => [
                "ZendDeveloperTools",
                "Application"
            ]
        }
    }

### Tune the ZendDeveloperTools version

Set the `dev` version

    node['zf']['dev']['version'] = "dev-master"

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

