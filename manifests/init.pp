#
class ips {

  class { 'ips::install' : } ->
  class { 'ips::config' : }

}
