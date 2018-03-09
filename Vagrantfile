cluster = {}

UPPER_BOUND = (++ENV.fetch('VAGRANT_VM_COUNT', '1').to_i)

(1..UPPER_BOUND).map {|x| cluster["node-#{x}"] = { :vcpus => (++ENV.fetch('VAGRANT_VM_VCPUS', '2').to_i), :ram => (++ENV.fetch('VAGRANT_VM_RAM', '4096').to_i) }}

Vagrant.configure("2") do |config|
  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |node| 
      node.ssh.username = "vagrant"
      node.ssh.private_key_path = "files/vagrant"
      node.vm.box = "centos7-libvirt"
      node.vm.provision "shell", inline: "hostnamectl set-hostname #{hostname}.example.com"
      node.vm.provision "shell", path: "files/proxy-provisioner.sh", args: [ "-h#{ENV.fetch('VAGRANT_PROXY_HOST' ,'')}", "-p#{ENV.fetch('VAGRANT_PROXY_PORT', '3128')}" ]
      node.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
      node.vm.provider :libvirt do |domain|
        domain.driver = "kvm"
        domain.cpus = info[:vcpus]
        domain.memory = info[:ram]
        domain.nested = "true"
        domain.machine_type = "pc"
        domain.machine_arch = "x86_64"
        domain.suspend_mode = "managedsave"
        domain.disk_bus = "virtio"
        domain.disk_device = "vda"
        domain.cpu_mode = "host-model"
        domain.cpu_model = "qemu64"
	domain.storage :file, :size => '10G', :device => 'vdb'
      end
    end
  end
end
