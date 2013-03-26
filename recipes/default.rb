#
# Cookbook Name:: application_zf
# Recipe:: default
#
# Copyright 2013, Walter Dal Mut.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"
include_recipe "apache2"
include_recipe "php"

#TODO: add apc

path_on_disk = String.new(node['zend']['version'])
path_on_disk["/"] = "_"

if node['zend']['version'] == 'latest'
  require 'open-uri'
  remote_file  "#{Chef::Config[:file_cache_path]}/latest.tar.gz" do
    source "https://github.com/zendframework/ZendSkeletonApplication/archive/master.tar.gz"
    mode "0644"
  end
else
  remote_file "#{Chef::Config[:file_cache_path]}/#{path_on_disk}.tar.gz" do
    source "https://github.com/zendframework/ZendSkeletonApplication/archive/#{node['zend']['version']}.tar.gz"
    mode "0644"
  end
end

directory "#{node['zend']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "unzip-zend" do
  cwd node['zend']['dir']
  command "tar -xzf #{Chef::Config[:file_cache_path]}/#{path_on_disk}.tar.gz --strip 1"
end

execute "update-composer" do
	cwd node['zend']['dir']
	command "php composer.phar self-update"
end

execute "base-install" do
    cwd node['zend']['dir']
	command "php composer.phar install"
end

execute "install-requires" do
    cwd node['zend']['dir']
    node['zend']['composer']['packages'].each do |package| 
        command "php composer.phar require #{package['name']}:#{package['version']}"
    end
    not_if { node['zend']['composer']['packages'].count == 0 }
end

zend_module "application_modules" do
	modules node['zend']['modules']
end

apache_site "000-default" do
  enable false
end

web_app "zend" do
  template "zend.conf.erb"
  docroot "#{node['zend']['dir']}"
  server_name node['zend']['server_name']
  server_aliases node['zend']['server_aliases']
end

service "apache2" do
  action :restart
end