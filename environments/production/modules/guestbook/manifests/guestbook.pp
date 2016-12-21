class guestbook::guestbook(
  $tag    = hiera('guestbook.tag'),
  $db_url = hiera('guestbook.db_url'),
){
  swarm_mode::service{"guestbook":
    service_replicas => hiera('guestbook.replicas'),
    service_network  => network1,
    service_name     => guestbook,
    service_mount    => [{"type" => "bind" ,source=>'/opt/guestbook/guestbook',destination=>'/guestbook'}],
    service_env      => [{var=>"REDIS_HOST",value=>"redis"},{var=>"DATABASE_URL",value=>"${db_url}"}],
    service_d_image  => "guestbook:${tag}",
    require          => Class['guestbook::guestbook_image'], 
  }
}
