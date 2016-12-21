class guestbook::guestbook_image(
  $repo = hiera('guestbook.git_repo'),
  $tag  = hiera('guestbook.tag')
){
  
  file { '/opt/guestbook':
    ensure   => directory
  }

  file { '/opt/guestbook/Dockerfile':
    ensure   => present ,
    source   => "puppet:///modules/guestbook/Dockerfile",
    require  => File['/opt/guestbook']
  }

  vcsrepo { '/opt/guestbook/guestbook':
    ensure   => present,
    provider => git,
    source   => "${repo}",
    before   => Docker::Image['guestbook'],
  }
  
  docker::image { 'guestbook':
    docker_dir => '/opt/guestbook',
    image_tag   => "${tag}",
    subscribe => File['/opt/guestbook/Dockerfile'],
    require  => File['/opt/guestbook/Dockerfile'],
  }

}
