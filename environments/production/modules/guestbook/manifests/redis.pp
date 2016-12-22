class guestbook::redis {

  file{'/var/data':
    ensure => directory,
  }

  swarm_mode::service{"redis":
    service_replicas  => hiera('redis.replicas'),
    service_network   => "network1",
    service_name      => "redis",
    service_mount     => [{"type"=>"bind","source"=>"/var/data","destination"=>"/data"}],
    service_d_image   => "redis",
    service_x_options => "redis-server --appendonly yes",
    require           => File['/var/data']
  }
}
