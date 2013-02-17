# dotdeb repository
#apt_repository "dotdeb" do
#  uri "http://packages.dotdeb.org"
#  distribution "stable"
#  components ["all"]
#  key "http://www.dotdeb.org/dotdeb.gpg"
#  deb_src true
#end

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  distribution "binary/"
  components [""]
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
end
