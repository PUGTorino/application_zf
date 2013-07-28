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

case node['platform_family']
when
    "fedora", "rhel", "centos"
    include_recipe "yum"
when "debian", "ubuntu"
    include_recipe "apt"
end

include_recipe "build-essential"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "php"

package "git"
package "subversion"
case node['platform_family']
when
    "fedora", "rhel", "centos"
    package "php-intl"
    package "pcre-devel"
when
    "debian", "ubuntu"
    include_recipe "php::module_apc"
    package "php5-intl"
    package "libpcre3-dev"
end

# update the main channels
php_pear_channel 'pear.php.net' do
    action :update
end

include_recipe "application_zf::install_skeleton"

apache_site "000-default" do
    enable false
end

web_app "zf_app" do
    template "zf_app.conf.erb"
    docroot "#{node['zf']['dir']}"
    server_name node['fqdn']
    server_aliases node['zf']['server_aliases']
end

service "apache2" do
    action :restart
end
