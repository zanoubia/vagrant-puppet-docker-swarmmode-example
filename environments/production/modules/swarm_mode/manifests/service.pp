define swarm_mode::service(
  $service_replicas  = 1,
  $service_network   = undef,
  $service_name      = undef,
  $service_mount     = [],
  $service_env       = [],
  $service_ports     = [],
  $service_d_image   = "",
  $service_x_options = "", 
){
  $check_service_template = @(END)
/usr/bin/test $(docker service ls | while read c1 c2 c3 c4 c5; do echo $c2; done | grep <%= @service_name -%>) = <%= @service_name -%>
END
  
  exec{ "create ${service_name} service":
    command => template("${module_name}/create_service.erb"),
    unless  => inline_template($check_service_template)
  }

  exec{ "update ${service_name} service":
    command => "/usr/bin/docker service update --image ${service_d_image} ${service_name} ",
    onlyif  => inline_template($check_service_template)
  }

  exec{ "scale ${service_name} service":
    command => "/usr/bin/docker service scale ${service_name}=${service_replicas}",
    onlyif  => inline_template($check_service_template)
  }
}
