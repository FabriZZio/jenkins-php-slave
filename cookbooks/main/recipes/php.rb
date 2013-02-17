include_recipe "php"

# overrules PHP settings (necessary for php.ini via apache)
template "#{node['php']['ext_conf_dir']}/custom.ini" do
  source "custom.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# xdebug
php_pear "xdebug" do
  zend_extensions ['xdebug.so']
  directives(:profiler_enable_trigger => 1)
  action :install
end

# apc
package "php-apc"
template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# curl
package "php5-curl"

# gd
package "php5-gd"

# sqlite
package "php5-sqlite"

# mysql
package "php5-mysql"

# php xml-rpc
package "php5-xmlrpc"

# php mcrypt
package "php5-mcrypt"

# php xsl
package "php5-xsl"

# upgrade pear
php_pear "PEAR" do
    action :upgrade
end

# qa channels
php_pear_channel "pear.phpunit.de" do
  action :discover
end

# pear phpunit channel
php_pear_channel "pear.phpqatools.org" do
  action :discover
end

# pear phpunit channel
php_pear_channel "pear.netpirates.net" do
  action :discover
end

# pear auto-discover
execute "pear-auto-discover" do
    command "pear config-set auto_discover 1"
end

# php qa tools
php_pear "phpqatools" do
    channel "pear.phpqatools.org"
    action :install
end

php_pear "phpDox" do
    channel "pear.netpirates.net"
    action :install
end
