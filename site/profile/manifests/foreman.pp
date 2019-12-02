class profile::foreman{
    include foreman
    include foreman_proxy
    class {'foreman_proxy':
      puppet   => true,
      puppetca => true,
      tftp     => false,
      dhcp     => false,
      dns      => false,
      bmc      => false,
      realm    => false,
    }
    #    yum::install { 'foreman-installer':
    #      ensure => present,
    #      source => 'https://yum.theforeman.org/releases/1.23/el7/x86_64/foreman-release.rpm',
    #    }
}
