class profile::foreman{
    include epel
    yum::install { 'foreman-installer':
      ensure => present,
      source => 'sudo yum -y install https://yum.theforeman.org/releases/1.23/el7/x86_64/foreman-release.rpm',
    }
}
