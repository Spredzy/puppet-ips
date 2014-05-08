define ips::repository (
  $port = 8080,
) {

  include ::ips

  file { "/etc/init/pkg.depotd${name}.conf" :
    ensure  => present,
    content => template('ips/pkg.depotd.conf.erb'),
    notify  => Service["pkg.depotd${name}"],
  }

  file {"/etc/init.d/pkg.depotd${name}" :
    ensure => link,
    target => '/lib/init/upstart-job',
    notify => Service["pkg.depotd${name}"],
  }

  file { "/srv/ips/ips${name}" :
    ensure => directory,
    owner  => 'ips',
    group  => 'ips',
  }

  exec { "seed${name}" :
    command => '/bin/tar xvzf ../empty-repo.tgz',
    cwd     => "/srv/ips/ips${name}",
    unless  => "/usr/bin/test -f /srv/ips/ips${name}/cfg_cache",
    require => File["/srv/ips/ips${name}"],
  }

  service { "pkg.depotd${name}" :
    ensure  => running,
    status  => "status pkg.depotd$name | grep -q 'running'",
    require => Exec["seed${name}"],
  }

}
