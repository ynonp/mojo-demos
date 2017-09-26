package HelloWorld::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub who {
  my $self = shift;

  $self->render(who => [`who`], variant => $self->param('v'));
}

1;
