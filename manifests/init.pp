class docker-install {
  file {
    '/etc/docker':
      ensure => 'directory'
  }

  file {
    '/etc/docker/daemon.json':
      mode => '600',
      owner => 'root',
      group => 'root',
      source => "puppet:///modules/docker-install/daemon.json";
  }

  file {
    '/etc/puppet/modules/docker-install/files/install.sh':
      source => "puppet:///modules/docker-install/install.sh",
      owner => 'root',
      group => 'root',
      mode  => '0755', # Use 0700 if it is sensitive
      notify => Exec['extract_editor_script'],
  }

  exec { 'extract_editor_script':
    command => "/bin/bash -c '/etc/server-config/install.sh'",
  }
}
