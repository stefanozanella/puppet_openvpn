require 'rake'
require 'rspec/core/rake_task'

MODULE_NAME = "openvpn".freeze
MODULES_ROOT = ".modules".freeze

desc "Run serverspec tests, provisioning the machine beforehand"
task :spec => [:modules_prep, :provision, :run_spec]

desc "Run serverspec tests on a clean box"
task :full_spec => [:vagrant_clean, :spec]

desc "Provision the vagrant box"
task :provision do
  command = vm_running ? "provision" : "up"
  system "vagrant #{command} default"
end

desc "Destroy the vagrant box"
task :vagrant_clean do
  puts "Wiping SUT"
  system "vagrant destroy -f default"
end

desc "Prepare module folder so that Vagrant box can be provisioned"
task :modules_prep do
  puts "Syncing module #{MODULE_NAME} into box shared module path"

  # This is a pretty naive way to synchronize files into a directory, but at
  # the moment I can figure out a better way without complicating things too
  # much...
  FileUtils.rm_rf MODULES_ROOT
  FileUtils.mkdir MODULES_ROOT
  FileUtils.mkdir module_sync_dir
  FileUtils.cp_r module_dirs, module_sync_dir
end

RSpec::Core::RakeTask.new(:run_spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

def vm_running
  `vagrant status` =~ /running/
end

def module_dirs
  %w(manifests files templates data lib).select { |dir| Dir.exists? dir }
end

def module_sync_dir
  File.join(MODULES_ROOT, MODULE_NAME)
end
