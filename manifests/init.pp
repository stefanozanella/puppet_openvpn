# == Class: openvpn
#
# Full description of class openvpn here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { openvpn:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class openvpn {
  $vpn_name = 'server'

  $base_dir = '/etc/openvpn'
  $ca_file = "${base_dir}/ca.crt"
  $cert_file = "${base_dir}/${vpn_name}.crt"
  $key_file = "${base_dir}/${vpn_name}.key"

  include openvpn::package
  include openvpn::service

  openvpn::server { $vpn_name :
    ca        => $ca_file,
    cert      => $cert_file,
    key       => $key_file,
    dh_size   => 2048,
    require   => Class['openvpn::package'],
    before    => Class['openvpn::service'],
    notify    => Class['openvpn::service'],
  }

  file { $ca_file:
    ensure    => present,
    source    => 'puppet:///modules/openvpn/ca.crt',
    owner     => 'root',
    group     => 'root',
    mode      => 0644,
    require   => Class['openvpn::package'],
    before    => Class['openvpn::service'],
  }

  file { $cert_file:
    ensure    => present,
    source    => 'puppet:///modules/openvpn/server.crt',
    owner     => 'root',
    group     => 'root',
    mode      => 0644,
    require   => Class['openvpn::package'],
    before    => Class['openvpn::service'],
  }

  file { $key_file:
    ensure  => present,
    source  => 'puppet:///modules/openvpn/server.key',
    owner   => 'root',
    group   => 'root',
    mode    => 0440,
    require => Class['openvpn::package'],
    before  => Class['openvpn::service'],
  }
}
