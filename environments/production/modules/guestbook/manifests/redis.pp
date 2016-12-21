class guestbook::redis {
  swarm_mode::service{"redis":
    service_replicas  => hiera('redis.replicas'),
    service_network   => "network1",
    service_name      => "redis",
    service_d_image   => "redis",
    service_x_options =>"redis-server --appendonly yes"
  }
}
