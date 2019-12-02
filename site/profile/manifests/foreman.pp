class profile::foreman{
    include epel
    yum::install { 'foreman-installer':
      ensure => present,
      source => 'https://yum.theforeman.org/releases/1.23/el7/x86_64/foreman-release.rpm',
    }
}
