package MembersOnly::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub create_session {
  my $c = shift;
  my $username = $c->param('username');
  my $password = $c->param('password');
  if ($c->authenticate($username, $password)) {
    $c->redirect_to($c->url_for('members'));
  } else {
    $c->stash('error', 'Invalid User Or Password');
    $c->render(template => 'example/new_session');
  }
}

1;
