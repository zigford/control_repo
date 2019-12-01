class profile::ssh_server {
  package {'openssh-server':
    ensure => present,
  }
  service {'sshd':
    ensure => 'running',
    enable =>  'true',
  }
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCuaoZXNK61FsXQEXRB5LkW+VF6oGXGGnJhHYH5n69RKn8wAb1IYxJ98/pRm5c4UtS263nb7tPxk4m/+V11cMlbEVaIa/XhxrXNF/q3Kx0EH8bfvsc+DSMoRTxtEQYFgoH3w1HVBghX10N4VuucA2Wl4L+vfM3hCYih+phzMZE2uK24R47ZiG5H1XCWZOiQrXpvedqBkYjJsPbYy3w0HiDWDwoRWN8gf0YZKMsQbbG6/RRRdIm/Bew/Gp6NkFJUm8og67m3gCZo3vQGZsRj0Zr+gDKLU4Tx+uHQ5uezZtXri/37lmgU92GGLvIM/ekmeM/Um8MmOCh/vj018fxcFgU5 root@master.puppet.vm',
  }
}
