# Configures a custom tunnel in server mode.

openvpn::server { 'vpn.example.com':
  port             => 1195,
  proto            => 'tcp',
  dev              => 'tun',
  server_network   => '10.100.0.0',
  server_netmask   => '255.255.0.0',
  dh_size          => 2048,
  ca               => '/etc/pki/test_ca.pem',
  cert             => '/etc/pki/test_cert.pem',
  key              => '/etc/pki/test_key.pem',
  client_to_client => true,
  run_user         => 'nobody',
  run_group        => 'nobody',
  compression      => true,
  persist_key      => true,
  persist_tun      => true,
  verbosity        => 3,
  keepalive        => { interval => 10, timeout => 120 },
  status_log       => 'vpn.example.com-status.log',
  pool_persist     => 'vpn.example.com-ipp.txt',
  ccd              => '/etc/openvpn/vpn.example.com-ccd',
  routes           => [
    { network => '172.16.1.0', netmask => '255.255.255.0' },
    { network => '10.156.0.0', netmask => '255.255.0.0' },
  ],
  push_dns         => [ '172.16.1.200', '10.156.1.2' ],
}

# Auxiliary files

file { '/etc/pki/test_ca.pem':
  ensure => present,
  source => 'puppet:///modules/openvpn_test_files/ca.crt',
  owner  => 'root',
  group  => 'root',
  mode   => 0644,
  before => Openvpn::Server['vpn.example.com'],
}

file { '/etc/pki/test_cert.pem':
  ensure => present,
  source => 'puppet:///modules/openvpn_test_files/server.crt',
  owner  => 'root',
  group  => 'root',
  mode   => 0644,
  before => Openvpn::Server['vpn.example.com'],
}

file { '/etc/pki/test_key.pem':
  ensure => present,
  source => 'puppet:///modules/openvpn_test_files/server.key',
  owner  => 'root',
  group  => 'root',
  mode   => 0440,
  before => Openvpn::Server['vpn.example.com'],
}

file { '/etc/openvpn/vpn.example.com-ccd':
  ensure => directory,
  owner  => 'root',
  group  => 'root',
}
