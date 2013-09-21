define openvpn::server (
  $vpn_name = $title,
  $port = 1194,
  $dev = 'tun',
  $proto = 'udp',
  $server_network = '10.8.0.0',
  $server_netmask = '255.255.255.0',
  $dh_size = 1024,
  $ca,
  $cert,
  $key,
) {

  include openvpn::package
  include openvpn::service

  $base_dir = "/etc/openvpn"
  $dh_params = "${base_dir}/${vpn_name}_dh${dh_size}.pem"

  file { 'server_conf':
    ensure  => present,
    path    => "${base_dir}/${vpn_name}.conf",
    content => template('openvpn/server.conf.erb'),
    require => Class['openvpn::package'],
    before  => Class['openvpn::service'],
    notify  => Class['openvpn::service'],
  }

  exec { 'diffie-hellman parameters':
    command => "/usr/bin/openssl dhparam -out ${dh_params} ${dh_size}",
    creates => $dh_params,
    require   => Class['openvpn::package'],
    before    => Class['openvpn::service'],
  }
}
