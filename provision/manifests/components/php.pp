class { '::php':
  ensure       => latest,
  manage_repos => true,
  phpunit      => true,
  extensions   => {
    mysql        => { },
    imagick      => { },
    curl         => { },
    gd           => { },
    memcache     => { },
    mcrypt       => { },
    redis        => { },
    xdebug       => {
      zend            => true,
      provider        => 'pecl',
      settings        => {
        'XDEBUG/xdebug.trace_enable_trigger'      => '1',
        'XDEBUG/xdebug.trace_output_dir'          => '/var/vagrant/userdata/debug',
        'XDEBUG/xdebug.collect_includes'          => '1',
        'XDEBUG/xdebug.collect_params'            => '1',
        'XDEBUG/xdebug.collect_vars'              => '1',
        'XDEBUG/xdebug.collect_return'            => '1',
        'XDEBUG/xdebug.dump_globals'              => '1',
        'XDEBUG/xdebug.idekey'                    => 'VAGRANT_DEBUG',
        'XDEBUG/xdebug.profiler_enable_trigger'   => '1',
        'XDEBUG/xdebug.profiler_output_name'      => 'cachegrind.out.%t-%s',
        'XDEBUG/xdebug.profiler_output_dir'       => '/var/vagrant/userdata/debug',
        'XDEBUG/xdebug.remote_enable'             => '1',
        'XDEBUG/xdebug.remote_mode'               => 'req',
        'XDEBUG/xdebug.remote_host'               => '192.168.13.1',
        'XDEBUG/xdebug.remote_log'                => '/var/vagrant/userdata/debug/xdebug-remote.log',
        'XDEBUG/xdebug.remote_port'               => '9000',
        'XDEBUG/xdebug.var_display_max_children'  => '-1',
        'XDEBUG/xdebug.var_display_max_data'      => '-1',
        'XDEBUG/xdebug.var_display_max_depth'     => '-1',
        'XDEBUG/xdebug.max_nesting_level'         => '256',
      },
    },
  },
  settings     => {
    'PHP/memory_limit'                       => '256M',
    'PHP/post_max_size'                      => '100M',
    'PHP/upload_max_filesize'                => '100M',
  },
}

exec { 'php_codesniffer':
  command => 'pear install PHP_CodeSniffer',
  require => Class['php'],
  creates => '/usr/bin/phpcs',
}

exec { 'wp_code_standards':
  command => 'git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /var/wpcs && phpcs --config-set installed_paths /var/wpcs',
  require => Class['php'],
  creates => '/var/wpcs/README.md',
}