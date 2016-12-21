class guestbook::nginx { 
  swarm_mode::service{"nginx":
    service_replicas  => hiera('nginx.replicas'),
    service_network   => "network1",
    service_name      => "nginx",
    service_mount     => [{"type"=>"bind","source"=>"/vagrant/nginx.conf","destination"=>"/etc/nginx/nginx.conf"}],
    service_d_image   => "nginx",
    service_ports     => [{ target_port => "80", service_port => "80" }]
  }
}
