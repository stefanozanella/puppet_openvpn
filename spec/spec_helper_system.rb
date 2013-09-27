require 'rspec-system/spec_helper'
require 'rspec-system-serverspec/helpers'
require 'rspec-system-puppet/helpers'

include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS
include RSpecSystemPuppet::Helpers

module LocalPuppetHelpers
  def manifest(file)
    File.read(File.join(manifest_path, file))
  end

  def puppet_fixture_module_install(module_name)
    puppet_module_install(:source => File.join(fixture_module_path, module_name), :module_name => module_name)
  end

  def manifest_path
    File.expand_path(File.join(File.dirname(__FILE__), 'system', 'manifests'))
  end

  def fixture_module_path
    File.expand_path(File.join(File.dirname(__FILE__), 'system', 'modules'))
  end
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.include ::LocalPuppetHelpers

  c.add_formatter 'progress'

  c.before :suite do
    puppet_module_install(:source => proj_root, :module_name => 'openvpn')
  end
end
