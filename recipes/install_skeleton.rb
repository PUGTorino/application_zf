#
# Cookbook Name:: application_zf
# Recipe:: install_skeleton
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

path_on_disk = String.new(node['zf']['version'])
if path_on_disk.index("/") != nil
    path_on_disk["/"] = "_"
end

package = node['zf']['version']
if package == "latest"
    package = "master"
end

remote_file "#{Chef::Config[:file_cache_path]}/#{path_on_disk}.tar.gz" do
    source "#{node['zf']['skeleton']['repository']}/archive/#{package}.tar.gz"
    mode "0644"
end

directory "#{node['zf']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "unzip-zend" do
  cwd node['zf']['dir']
  command "tar -xzf #{Chef::Config[:file_cache_path]}/#{path_on_disk}.tar.gz --strip 1"
end

directory "#{node['zf']['dir']}/data" do
  owner "root"
  group "root"
  mode "0777"
  recursive false
end

directory "#{node['zf']['dir']}/data/cache" do
  owner "root"
  group "root"
  mode "0777"
  recursive false
end

execute "update-composer" do
    cwd node['zf']['dir']
    command "php composer.phar self-update"
end

execute "base-install" do
    cwd node['zf']['dir']
    command "php composer.phar install"
end

