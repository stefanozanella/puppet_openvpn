require 'spec_helper_system'

describe 'server with custom options' do
  before :all do
    puppet_fixture_module_install 'openvpn_test_files'
    puppet_apply manifest 'custom_server.pp'
  end

  describe package('openvpn') do
    it { should be_installed }
  end

  describe service('openvpn') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(1195) do
    it { should be_listening }
  end

  describe file('/etc/openvpn/vpn.example.com.conf') do
    it { should be_file }
    it { should contain "server 10.100.0.0 255.255.0.0" }
    it { should contain "port 1195" }
    it { should contain "proto tcp" }
    it { should contain "dev tun" }
    it { should contain("vpn.example.com_dh2048.pem").after(/^dh/) }
    it { should contain("test_ca.pem").after(/^ca/) }
    it { should contain("test_cert.pem").after(/^cert/) }
    it { should contain("test_key.pem").after(/^key/) }
    it { should contain "client-to-client" }
    it { should contain "user nobody" }
    it { should contain "group nobody" }
    it { should contain "comp-lzo" }
    it { should contain "persist-key" }
    it { should contain "persist-tun" }
    it { should contain "verb 3" }
    it { should contain "keepalive 10 120" }
    it { should contain "status vpn.example.com-status.log" }
    it { should contain "ifconfig-pool-persist vpn.example.com-ipp.txt" }
    it { should contain "client-config-dir /etc/openvpn/vpn.example.com-ccd" }
  end
end
