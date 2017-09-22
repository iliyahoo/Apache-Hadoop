boxes = {
    'ah-master-01' => ['cdh-agent-5.7', '8192', '192.168.0.41'],
    'ah-master-02' => ['apache_hadoop-node', '8192', '192.168.0.43'],
    'ah-master-03' => ['apache_hadoop-node', '8192', '192.168.0.44'],
    'ah-node-01' => ['apache_hadoop-node', '8192', '192.168.0.42'],
    'ah-node-02' => ['apache_hadoop-node', '8192', '192.168.0.45'],
    'ah-node-03' => ['apache_hadoop-node', '8192', '192.168.0.46']
}

# $script = <<SCRIPT
# chkconfig cloudera-scm-agent on
# if [[ "$?" -eq 0 ]]; then
#   echo "service enabled" >> /root/vagrant.log
# else
#   echo "cannot start and enable service" >> /root/vagrant.log
# fi
# SCRIPT


Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox"
  config.ssh.username = "root"
  config.ssh.password = "111538"
  config.vm.synced_folder "./", "/vagrant"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  boxes.each do |key, value|
    config.vm.define "#{key}" do |node|
      node.vm.box = "#{value[0]}"
      node.vm.hostname = "#{key}"
      node.vm.network "private_network", ip: "#{value[2]}"
      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", "#{value[1]}"]
        v.customize ["modifyvm", :id, "--name", "#{key}"]
      end
      # if "#{key}" != "cdh-manager-01"
      #   node.vm.provision "shell", inline: $script
      # else
      #   node.vm.provision "shell", inline: "/usr/sbin/reboot"
      # end
    end
  end
end

## RUN to fix hosts file on all agents
# for i in master-01 master-02 master-03 node-01 node-02 node-03; do
#     ssh root@cdh-$i 'sed --in-place -r "0,/127\.0\.0\.1\W+cdh-.*/{/127\.0\.0\.1\W+cdh-.*/d;}" /etc/hosts && \
#     systemctl start  cloudera-scm-agent.service'
# done
