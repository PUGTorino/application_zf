#
# Cookbook Name:: application_zf
# Recipe:: dev_tools
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
include_recipe "application_zf"

package "git"

execute "install-requires" do
	cwd node['zend']['dir']
	command "php composer.phar require zendframework/zend-developer-tools:#{node['zend']['dev']['version']}"
end

execute "copy-dev-conf" do
	cwd node['zend']['dir']
	command "cp  vendor/zendframework/zend-developer-tools/config/zenddevelopertools.local.php.dist config/autoload/zenddevelopertools.local.php"
end

zend_dev_index "dev_module" do
	
end

apache_site "000-default" do
  enable false
end
