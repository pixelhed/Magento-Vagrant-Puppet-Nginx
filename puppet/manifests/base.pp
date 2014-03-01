node default {

    apt::source { 'servergrove':
        location => "http://repos.servergrove.com/servergrove-ubuntu-precise",
        release => 'precise',
        repos => 'main',
        key_source => 'http://repos.servergrove.com/servergrove-ubuntu-precise/servergrove-ubuntu-precise.gpg.key'
    }

    class { "apt":
        always_apt_update => true
    }

    Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin", "/usr/local/sbin"] }

    package { 'vim': ensure => installed }
    package { 'wget': ensure => latest }
    package { 'curl': ensure => latest }
    include git

    # Installs Magento
    #
    # Valid versions are:
    #
    #   magento-ce-1.6.2.0
    #   magento-ce-1.7.0.2
    #   mageplus-master
    #   magento-mirror-1.4.2.0
    #   magento-mirror-1.5.1.0
    #   magento-mirror-1.6.2.0
    #   magento-ce-2.0.0.0-dev
    class { "magento":
      install_magento     => true,
      magento_version     => "magento-ce-1.8.1.0",
      install_sample_data => true
    }

    exec { 'wget -O /home/vagrant/bin/modman https://raw.github.com/colinmollenhour/modman/master/modman':
      creates => "/home/vagrant/bin/modman",
      require => Package['wget'],
    }
}
