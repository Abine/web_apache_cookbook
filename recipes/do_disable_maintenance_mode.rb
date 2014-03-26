#
# Cookbook Name:: web_apache
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

maintenance_file = "/home/webapp/system/#{node[:web_apache][:maintenance_file]}"
# Removes maintenance.html file.
log "  Removing #{maintenance_file}"
file maintenance_file do
  action :delete
  backup false
  only_if { ::File.exists?(maintenance_file) }
end
