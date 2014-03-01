class repository {
  # We need cURL installed to import the key
  package { 'curl': ensure => installed }
 
  # Installs the GPG key
  exec { 'import-key':
    path    => '/bin:/usr/bin',
    command => 'curl http://repos.servergrove.com/servergrove-ubuntu-precise/servergrove-ubuntu-precise.gpg.key | apt-key add -',
    unless  => 'apt-key list | grep servergrove-ubuntu-precise',
    require => Package['curl'],
  }
 
  # Creates the source file for the ServerGrove repository
  file { 'servergrove.repo':
    path    => '/etc/apt/sources.list.d/servergrove.list',
    ensure  => present,
    content => 'deb http://repos.servergrove.com/servergrove-ubuntu-precise precise main',
    require => Exec['import-key'],
  }
 
  # Refreshes the list of packages
  exec { 'apt-get-update':
    command => 'apt-get update',
    path    => ['/bin', '/usr/bin'],
    require => File['servergrove.repo'],
  }
}
 
stage { pre: before => Stage[main] }