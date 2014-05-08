#
class ips::install {

  include apache
  include apache::mod::proxy
  include apache::mod::proxy_http

  file {
    '/srv' :
      ensure => directory;
    '/srv/ips' :
      ensure => directory;
    '/srv/ips/ips.deb' :
      ensure => present,
      source => 'puppet:///modules/ips/ips_2.3.54-0_all.deb';
    '/srv/ips/empty-repo.tgz' :
      ensure => present,
      source => 'puppet:///modules/ips/empty-repo.tgz',
  } ->
  package { 'ips' :
      ensure   => installed,
      provider => 'dpkg',
      source   => '/srv/ips/ips.deb',
  }

  user { 'ips' :
    ensure  => present,
    shell   => '/usr/sbin/nologin',
    home    => '/srv/ips',
  }

}
