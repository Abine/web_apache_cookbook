maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs/configures the apache2 webserver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "13.4.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

recipe "web_apache::default",
  "Runs web_apache::install_apache."

recipe "web_apache::do_start",
  "Runs service apache start."

recipe "web_apache::do_stop",
  "Runs service apache stop."

recipe "web_apache::do_restart",
  "Runs service apache restart."

recipe "web_apache::do_enable_default_site",
  "Enables the default vhost."

recipe "web_apache::install_apache",
  "Installs and configures the Apache2 webserver."

recipe "web_apache::setup_frontend",
  "Sets up front-end apache vhost. Select ssl_enabled for SSL."

recipe "web_apache::setup_frontend_ssl_vhost",
  "Sets up front-end apache vhost with SSL enabled."

recipe "web_apache::setup_frontend_http_vhost",
  "Sets up front-end apache vhost on port 80."

recipe "web_apache::setup_monitoring",
  "Installs the collectd-apache plugin for monitoring support."

recipe "web_apache::do_enable_maintenance_mode",
  "Enables maintenance mode for Apache2 webserver"

recipe "web_apache::do_disable_maintenance_mode",
  "Disables maintenance mode for Apache2 webserver"

depends "apache2"
depends "rightscale"

attribute "apache2",
  :display_name => "Apache2",
  :description =>
    "Apache2",
  :type => "hash"

attribute "apache2/keepalive",
  :display_name => "Apache KeepAlive",
  :description => "HTTP persistent connections",
  :required => "optional",
  :recipes => [
        "apache::default",
        "web_apache::default",
        "web_apache::install_apache"
  ],
  :choice => ["Off", "On"],
  :default => "On"

attribute "apache2/timeout",
  :display_name => "Apache Timeout",
  :description => "The number of seconds before receives and sends time out." +
  "For Avira Servers currently using 15, for all other servers the value should be 300 (the default)",
  :required => "optional",
  :recipes => [
        "apache::default",
        "web_apache::default",
        "web_apache::install_apache"
  ],
  :default => "300"


attribute "apache2/prefork",
  :display_name => "Apache PreFork Configs",
  :description => "Apache PreFork Configs",
  :type => "hash"

attribute "apache2/prefork/serverlimit",
  :display_name => "Apache PreFork ServerLimit",
  :description => "Set this to the same value as MaxClients. MaxClients = maximum number of server processes allowed to start" +
  "For Avira Servers currently using 80, for all other servers the value should be 400 (the default)",
  :required => "optional",
  :recipes => [
        "apache::default",
        "web_apache::default",
        "web_apache::install_apache"
  ],
  :default => "400"

attribute "apache2/prefork/maxclients",
  :display_name => "Apache PreFork MaxClients",
  :description => "Set this to the same value as ServerLimit. MaxClients = maximum number of server processes allowed to start" +
  "For Avira Servers currently using 80, for all other servers the value should be 400 (the default)",
  :required => "optional",
  :recipes => [
        "apache::default",
        "web_apache::default",
        "web_apache::install_apache"
  ],
  :default => "400"


attribute "web_apache",
  :display_name => "apache hash",
  :description =>
    "Apache Web Server",
  :type => "hash"

attribute "web_apache/mpm",
  :display_name => "Multi-Processing Module",
  :description =>
    "Defines the multi-processing module setting in httpd.conf." +
    " Use 'worker' for Rails/Tomcat/Standalone frontends" +
    " and 'prefork' for PHP. Example: prefork",
  :required => "optional",
  :recipes => [
    "web_apache::default",
    "web_apache::install_apache",
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
  ],
  :choice => ["prefork", "worker"],
  :default => "prefork"

attribute "web_apache/system_log",
  :display_name => "Use system log",
  :description => "Use the system log daemon to log Apache events (the error log and access log) instead of a local log file. Works well when the system is set up to forward log data to a remote server.",
  :required => "recommended",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
    "web_apache::default"
  ],
  :choice => [ "true", "false" ],
  :default => "false"

attribute "web_apache/abine_hack",
  :display_name => "Enable Abine's hack",
  :description => "Enable the trademarked Abine 'Fall through to glass.abine.com' hack, necessary to get the website v2 off the ground. Only set true for an app server (not the load balancer).",
  :required => "recommended",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
    "web_apache::default"
  ],
  :choice => ["true", "false"],
  :default => "false"

attribute "web_apache/log_format",
  :display_name => "Apache Log format",
  :description => "Selects a format for the Apache access logs. These must be defined in the Apache configuration files ahead of time. Example: combined",
  :required => "recommended",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
    "web_apache::default"
  ],
  :choice => [ "combined", "common", "referer", "agent", "getabine_combined", "getabine_combined_forwarding"],
  :default => "combined"

attribute "web_apache/ssl_enable",
  :display_name => "SSL Enable",
  :description =>
    "Enables SSL ('https'). Example: true",
  :recipes => [
    "web_apache::install_apache",
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ],
  :required => "optional",
  :choice => ["true", "false"],
  :default => "false"

attribute "web_apache/ssl_certificate",
  :display_name => "SSL Certificate",
  :description =>
    "The name of your SSL Certificate. Example: cred:SSL_CERT",
  :required => "optional",
  :default => "",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/ssl_certificate_chain",
  :display_name => "SSL Certificate Chain",
  :description =>
    "Your SSL Certificate Chain. Example: cred:SSL_CERT_CHAIN",
  :required => "optional",
  :default => "",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/ssl_key",
  :display_name => "SSL Certificate Key",
  :description =>
    "Your SSL Certificate Key. Example: cred:SSL_KEY",
  :required => "optional",
  :default => "",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/ssl_passphrase",
  :display_name => "SSL Passphrase",
  :description =>
    "Your SSL passphrase. Example: cred:SSL_PASSPHRASE",
  :required => "optional",
  :default => "",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/force_https",
  :display_name => "Force HTTPS traffic",
  :description =>
    "Redirect HTTP traffic to HTTPS traffic",
  :required => "recommended",
  :default => "false",
  :choice => ["true", "false"],
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/application_name",
  :display_name => "Application Name",
  :description =>
    "Sets the directory for your application's web files" +
    " (/home/webapps/Application Name/). If you have multiple applications," +
    " you can run the code checkout script multiple times, each with a" +
    " different value for the 'Application Name' input, so each application" +
    " will be stored in a unique directory." +
    " This must be a valid directory name. Do not use symbols in the name." +
    " Example: myapp",
  :required => "optional",
  :default => "myapp",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
    "web_apache::default"
  ]

attribute "web_apache/allow_override",
  :display_name => "AllowOverride Directive",
  :description =>
    "Allows/disallows the use of .htaccess files in project web root" +
    " directory. Can be None (default), All, or any directive-type" +
    " as specified in Apache documentation. Example: None",
  :required => "optional",
  :choice => ["None", "All"],
  :default => "None",
  :recipes => [
    "web_apache::setup_frontend_ssl_vhost",
    "web_apache::setup_frontend_http_vhost",
    "web_apache::setup_frontend",
    "web_apache::default"
  ]
attribute "web_apache/maintenance_file",
  :display_name => "Select Maintenance File",
  :description =>
    "Choose .json for mm lbs and .html for others",
  :required => "required",
  :choice => ["maintenance.html", "maintenance.json"],
  :recipes => [
    "web_apache::do_enable_maintenance_mode",
    "web_apache::do_disable_maintenance_mode",
    "web_apache::install_apache",
    "web_apache::default"
  ]
attribute "web_apache/server_aliases",
  :display_name => "Select appropriate environment alias for apache Alias config",
  :description => "Select appropriate environment for apache Alias config, select None if this is abine.com LB",
  :required => "required",
  :choice => ["Production", "Stage", "Test", "Demo", "None"],
  :recipes => [
    "web_apache::default",
    "web_apache::setup_frontend"
  ]

attribute "web_apache/lb_type",
  :display_name => "Choose whether www.abine.com, abine.com, maskme, or other",
  :description => "Currently this is used to determine rules that go into abine.com servers only",
  :required => "required",
  :choice => ["www.abine.com","abine.com", "maskme", "other"],
  :recipes => [
    "web_apache::default",
    "web_apache::setup_frontend"
  ]
