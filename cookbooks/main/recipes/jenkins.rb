package "jenkins"

script "jenkins-qa-plugins" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
sleep 10
cp /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar /home/vagrant/
sudo cp /var/cache/jenkins/war/WEB-INF/slave.jar /var/lib/jenkins/jobs/ && sudo chown jenkins:nogroup /var/lib/jenkins/jobs/slave.jar
java -jar /home/vagrant/jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit
java -jar /home/vagrant/jenkins-cli.jar -s http://localhost:8080 safe-restart
EOH
  not_if "test -f /home/vagrant/jenkins-cli.jar"
end

script "install-jenkins-master-pubkey" do
    interpreter "bash"
      user "root"
      cwd "/tmp"
      code <<-EOH
mkdir -p /var/lib/jenkins/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6XBHQ04E3wz19tK/mj/UdA9XGi0V0HDD8puKRx8Ec2ip6+WPgSAcUZYI1x8jqQQt5y8lo/oD2pDO7RHoQR9V12wnHOGaE06gX2/fKJrAZ8mMbZpoNetyhbc8R2xorIE7Y3MhgDJRociOX3jCoHlpjOPm8MjBhHsSljQMGpw4fi//dh0vHnGbs7OjIAhNnmGtwD1nNGW2+rzL3ZYKu4+vcMSq81cDjHUSZ9zGVYbnBbS68V87GeUq0aqtmzkE1bKfYnkSBeI+ArmTmFYhSbUULoQEJkNamKQjDlCS1OCbfsc85B09gVTKDbMpoo0HuVBqIR7mld8rUuWGlPQy3Gn0/ jenkins@cicero" > /var/lib/jenkins/.ssh/authorized_keys
chown -R jenkins:nogroup /var/lib/jenkins/.ssh
chmod 600 /var/lib/jenkins/.ssh/authorized_keys
EOH
end

# run from master as Launch slave via execution of command on the Master to allow agent forwarding
# before launching slave agent, login via SSH from master server to slave, setting up known_hosts + setup known_hosts for github on slave
