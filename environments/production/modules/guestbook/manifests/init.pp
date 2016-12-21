class guestbook {
  include guestbook::swarm 
  include guestbook::guestbook
  include guestbook::redis
  include guestbook::nginx
  include guestbook::guestbook_image

  Class['guestbook::swarm']->Class['guestbook::redis']->Class['guestbook::nginx']->Class['guestbook::guestbook']

}
