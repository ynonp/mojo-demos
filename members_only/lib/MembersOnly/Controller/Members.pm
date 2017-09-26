package MembersOnly::Controller::Members;
use Mojo::Base 'Mojolicious::Controller';

sub prepare {
}

sub run {
}

sub signout {
  my $c = shift;
  $c->logout;
  $c->redirect_to('/');
}

1;
