hadoop
------

# On masters have to remove from /etc/hosts a line appended by vagrant-hostmanager (1.8.7) plugin
127.0.0.1    <hostname>

ssh-copy-id -i .ssh/id_rsa.pub ah-node-01
ln -fs /vagrant/config/etc/profile.d/hadoop.sh /etc/profile.d/hadoop.sh

vim .bash_profile
PATH=$PATH:$HOME/bin:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin

vim .bashrc
alias jps='jps | grep -v Jps'

chmod +x /vagrant/config/jps_status.sh
cd /vagrant/hadoop/bin
ln -s ../../config/jps_status.sh



export YARN_EXAMPLES=/vagrant/hadoop/share/hadoop/mapreduce
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-2.7.4.jar pi 16 1000

hadoop-daemon.sh start journalnode

mr-jobhistory-daemon.sh start historyserver
