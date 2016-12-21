define swarm_mode::network(
  $network_driver   = "brige",
  $network_subnet   = [],
  $network_ip_range = [],
  $network_gateway  = [],
  $network_internal = false,
  $network_name     = "mynetwork"
){
  $check_network_template = @(END)
/usr/bin/test $(/usr/bin/docker network ls | while read c1 c2 c3 c4; do /bin/echo $c2; done | /bin/grep <%= @network_name -%> ) = <%= @network_name -%>
END
 
  exec { "create ${network_name}  network":
    command => template("${module_name}/create_network.erb"),
    unless  => inline_template($check_network_template)
  }
}
