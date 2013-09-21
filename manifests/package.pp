class openvpn::package {
  package { 'openvpn':
    ensure => installed,
  }
}
