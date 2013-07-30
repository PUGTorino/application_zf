name             "application_zf"
maintainer       "Walter Dal Mut"
maintainer_email "walter.dalmut@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures ZendSkeletonApplication"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.0"

recipe "application_zf::default", "Installs and configures Zend Skeleton Application on a single system using also apache2 recipe"
recipe "application_zf::install", "Install and configures Zend Skeleton Application without web server suppport"
recipe "application_zf::dev_tools", "Install ZendDeveloperTools"

%w{ php openssl build-essential apt }.each do |cb|
  depends cb
end

depends "apache2", ">= 0.99.4"

%w{ debian ubuntu centos fedora rhel }.each do |os|
  supports os
end

attribute "application_zf/zf/version",
  :display_name => "ZendSkeletonApplication download version",
  :description => "Version of ZendSkeletonApplication to download from the ZendSkeletonApplication site or 'latest' for the current release.",
  :default => "latest"

attribute "application_zf/zf/dir",
  :display_name => "ZendSkeletonApplication installation directory",
  :description => "Location to place ZendSkeletonApplication files.",
  :default => "/var/www/zend"

attribute "application_zf/zf/server_aliases",
  :display_name => "ZendSkeletonApplication Server Aliases",
  :description => "ZendSkeletonApplication Server Aliases",
  :default => ["FQDN"]

attribute "application_zf/zf/modules",
  :display_name => "ZendSkeletonApplication Enable modules",
  :description => "Array of Module names that you want to enable in your application.config.php",
  :default => ["Application"]

attribute "application_zf/zf/composer/packages",
  :display_name => "ZendSkeletonApplication extra composer packages",
  :description => "Array of Module names that you want to enable in your application.config.php",
  :default => []

attribute "application_zf/zf/dev/version",
  :display_name => "ZendDeveloperTools version",
  :description => "Set the version of ZendDeveloperTools module",
  :default => "dev-master"

attribute "application_zf/zf/deploy/modules/git",
    :display_name => "Deploy git based modules",
    :description => "Add a new module using git strategy",
    :default => []

