package RemoteCommander::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

sub run {
  my $c = shift;
  my $cmd = $c->param('cmd');
  $c->stash(result => [qx/$cmd/]);
  $c->render;
}

1;
