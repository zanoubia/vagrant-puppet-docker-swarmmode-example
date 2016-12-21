class guestbook::swarm(
  $manager_ip="10.0.2.15" 
){
  swarm_mode::swarm_manager{"manager1":
    manager_ip => $manager_ip 
  }
  swarm_mode::network{"network1":
    network_driver   => "overlay",
    network_subnet   => ["172.30.1.0/24"],
    network_name     => "network1"
  }
}
