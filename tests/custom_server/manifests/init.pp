# Configures a custom tunnel in server mode.

openvpn::server { 'vpn.example.com':
  port           => 1195,
  proto          => 'tcp',
  dev            => 'tun',
  server_network => '10.100.0.0',
  server_netmask => '255.255.0.0',
  dh_size        => 1024,
  ca             => '/etc/pki/test_ca.pem',
  cert           => '/etc/pki/test_cert.pem',
  key            => '/etc/pki/test_key.pem',
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
