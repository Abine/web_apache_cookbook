#
# Cookbook Name:: web_apache
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# Sending Apache logs to the system log provider
default[:web_apache][:system_log] = "false"

# Log format to use
default[:web_apache][:log_format] = "combined"

default[:web_apache][:abine_hack] = "false"


# worker = multithreaded (when you need a great deal of scalability)
# prefork = single-threaded (when you need stability or compatibility with older software)
# for more info please visit: http://httpd.apache.org/docs/2.0/en/mpm.html
default[:web_apache][:mpm] = "prefork"

# Distribution specific config dir
case platform
when "ubuntu"
  set[:web_apache][:config_subdir] = "apache2"
when "centos", "redhat"
  set[:web_apache][:config_subdir] = "httpd"
end

#Setup ServerAlias's
#set[:web_apache][:server_aliases] = 

# Disabling ssl by default
default[:web_apache][:ssl_enable] = false
default[:web_apache][:ssl_certificate] = nil
default[:web_apache][:ssl_certificate_chain] = nil
default[:web_apache][:ssl_key] = nil
default[:web_apache][:ssl_passphrase] = nil
default[:web_apache][:force_https] = 'false'

# Apache document root
set[:web_apache][:docroot] = "/home/webapp/#{web_apache[:application_name]}"

# Default servername for web_apache vhost file
set[:web_apache][:server_name] = "localhost"


# Allow override default value
default[:web_apache][:allow_override] = "None"
