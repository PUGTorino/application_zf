#
# Author:: Walter Dal Mut (<walter.dalmut@gmail.com>)
# Cookbook Name:: application_zf
# Attributes:: application_zf
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

# General settings
default['zend']['version'] = "latest"
default['zend']['dir'] = "/var/www/zend"
default['zend']['server_name'] = node['fqdn']
default['zend']['server_aliases'] = [node['fqdn']]
default['zend']['modules'] = ["Application"]
default['zend']['composer']['packages'] = []
default['zend']['dev']['version'] = "dev-master"