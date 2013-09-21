class openvpn::service {
  service { 'openvpn':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['openvpn::package'],
  }
}
