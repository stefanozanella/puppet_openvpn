require 'spec_helper'

describe package('openvpn') do
  it { should be_installed }
end

describe service('openvpn') do
  it { should be_enabled }
  it { should be_running }
end

describe port(1194) do
  it { should be_listening }
end

describe file('/etc/openvpn/server.conf') do
  it { should be_file }
  it { should contain "server 10.8.0.0 255.255.255.0" }
  it { should contain "port 1194" }
  it { should contain "dev tun" }
  it { should contain("dh2048.pem").after(/^dh/) }
  it { should contain("ca.crt").after(/^ca/) }
  it { should contain("server.crt").after(/^cert/) }
  it { should contain("server.key").after(/^key/) }
end

describe file('/etc/openvpn/dh2048.pem') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/openvpn/ca.crt') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/openvpn/server.crt') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/openvpn/server.key') do
  it { should be_file }
  it { should be_mode 440 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
