Vagrant.configure('2') do |config|
  config.vm.box = 'generic/debian11'

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.gui = false
    virtualbox.memory = '1024'
  end

  config.vm.synced_folder '.', '/vagrant', type: 'rsync'
  config.vm.provision :ansible_local do |ansible|
    ansible.install = true
    ansible.limit = 'all'
    ansible.inventory_path = 'inventory'
    ansible.playbook = 'playbook.yml'
    ansible.verbose = false
  end
end
