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

# httpFS
hadoop/sbin/httpfs.sh start
curl -sS 'http://localhost:14000/webhdfs/v1?op=gethomedirectory&user.name=iliya'
curl -c ~/.httpfsauth "http://localhost:14000/webhdfs/v1?op=homedir&user.name=iliya"

curl -v -sS 'http://localhost:14000//webhdfs/v1/user/user.name=iliya&op=GETFILESTATUS'

curl -sS 'http://localhost:14000//webhdfs/v1/user?user.name=iliya&op=GETFILESTATUS'


curl -X POST http://localhost:14000/webhdfs/v1/user/root/bar?user.name=iliya&doas=root&op=mkdirs
curl http://localhost:14000/webhdfs/v1/user/root?op=list

# NFS Gateway
systemctl disable rpcbind.socket && systemctl stop rpcbind.socket
hadoop-daemon.sh --script hdfs start portmap
hadoop-daemon.sh --script hdfs start nfs3
