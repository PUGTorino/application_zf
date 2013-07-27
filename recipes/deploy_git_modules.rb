#
# Cookbook Name:: application_zf
# Recipe:: deploy_git_modules
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

package "git"

node['zf']['deploy']['modules']['git'].each do |repo|
    deploy_revision "/tmp/#{repo.name}" do
        repo repo.uri
        branch repo.branch
        symlink_before_migrate.clear
        create_dirs_before_symlink.clear
        purge_before_symlink.clear
        symlinks.clear
        user "root"
        before_migrate do
            execute "remove_module_symlink" do
                command "rm #{node['zf']['dir']}/module/#{repo.name}"
                only_if { File.exist?("#{node['zf']['dir']}/module/#{repo.name}") }
            end
        end
        after_restart do
            execute "create_module_symlink" do
                command "ln -s /tmp/#{repo.name}/current #{node['zf']['dir']}/module/#{repo.name}"
                only_if { File.exist?("/tmp/#{repo.name}/current") }
            end
        end
        action :deploy
    end
end

