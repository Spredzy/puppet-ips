#
class ips::config {

  apache::vhost {'ips.jenkins-ci.org' :
    docroot             => '/var/www/ips.jenkins-ci.org',
    port                => 80,
    log_level           => 'warn',
    override            => ['All'],
    options             => ['Indexes','FollowSymLinks','MultiViews'],
    directories         => {'path'  => '/var/www/ips.jenkins-ci.org'},
    additional_includes => ['/etc/apache2/sites-available/ips*.conf'],
  }

}
