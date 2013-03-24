name             "application_zend"
maintainer       "Walter Dal Mut"
maintainer_email "walter.dalmut@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures ZendSkeletonApplication"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "ZendSkeletonApplication", "Installs and configures Zend Skeleton Application on a single system"

%w{ php openssl }.each do |cb|
  depends cb
end

depends "apache2", ">= 0.99.4"

%w{ debian ubuntu }.each do |os|
  supports os
end

attribute "ZendSkeletonApplication/version",
  :display_name => "ZendSkeletonApplication download version",
  :description => "Version of ZendSkeletonApplication to download from the ZendSkeletonApplication site or 'latest' for the current release.",
  :default => "latest"

attribute "ZendSkeletonApplication/dir",
  :display_name => "ZendSkeletonApplication installation directory",
  :description => "Location to place ZendSkeletonApplication files.",
  :default => "/var/www/zend"

attribute "ZendSkeletonApplication/server_aliases",
  :display_name => "ZendSkeletonApplication Server Aliases",
  :description => "ZendSkeletonApplication Server Aliases",
  :default => "FQDN"