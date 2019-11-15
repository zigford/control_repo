node default {
    file {'/root/README':
        ensure  => file,
        content => 'This is a stupid readme',
        owner   => root,
    }
    file {'/root/README':
        owner   => root,
    }
}
