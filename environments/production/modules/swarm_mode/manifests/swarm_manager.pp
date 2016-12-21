define swarm_mode::swarm_manager(
  $manager_ip = undef
){
  exec { 'create swarm':
    command =>  "/usr/bin/docker swarm init --advertise-addr ${manager_ip}",
    unless  =>  "/usr/bin/test $(/usr/bin/docker info | /bin/grep Swarm | /usr/bin/cut -d ':' -f 2) = active "
  }
}
