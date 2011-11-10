#
# Cookbook Name:: apache-tomcat
# Recipe:: default
#
# Copyright 2011
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

# TODO extract version to attributes

# currently tested jsut with Debian
if not node['platform'] == "debian" then
  raise RuntimeError, "Unsupported platform: #{node['platform']}"
end

# make install folder if it doesn't exist
execute "mkdir" do
  command "mkdir -p #{node[:installPath]}"
  action :run
end

# copy tomcat distrib to install folder
cookbook_file "#{node[:installPath]}/apache-tomcat-7.0.22.tar.gz" do
  source "apache-tomcat-7.0.22.tar.gz"
  mode "0644"
end

# extract tomcat
execute "tar" do
  command "tar -xvf #{node[:installPath]}/apache-tomcat-7.0.22.tar.gz --directory #{node[:installPath]}/" 
  action :run
end

# remove archive from install folder
execute "rm" do
  command "rm -i #{node[:installPath]}/apache-tomcat-7.0.22.tar.gz" 
  action :run
end

# configure context.xml
template "#{node[:installPath]}/apache-tomcat-7.0.22/conf/context.xml" do
  source "context.xml.erb"
  mode "0644"
end

# configure server.xml
template "#{node[:installPath]}/apache-tomcat-7.0.22/conf/server.xml" do
  source "server.xml.erb"
  mode "0644"
end