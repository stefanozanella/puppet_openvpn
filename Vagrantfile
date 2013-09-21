# -*- mode: ruby -*-
# vi: set ft=ruby :
def examples_in(dir)
  Dir.new(dir).entries.reject { |subdir| subdir =~ /^\./ }
end

def fixture_module_path_for(example_dir)
  module_path = [ ".modules" ]
  module_path << "#{example_dir}/modules" if Dir.exists? "#{example_dir}/modules"
  module_path
end

Vagrant.configure("2") do |config|
  examples_in("tests").each do |example|
    config.vm.define example do |conf|
      conf.vm.box = "centos-base-oss"
      conf.vm.box_url = "http://vagrantboxes.derecom.it/boxes/centos-base-oss.box"
      conf.vm.provision :puppet do |puppet|
        puppet.module_path = fixture_module_path_for "tests/#{example}"
        puppet.manifests_path = "tests"
        puppet.manifest_file  = "#{example}/manifests/init.pp"
      end
    end
  end
end
