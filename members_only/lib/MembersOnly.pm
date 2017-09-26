package MembersOnly;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::Authentication;
use Mojo::Util qw(secure_compare);
use MembersOnly::Controller::Members;


my %user_password = (
  rob    => 'red',
  dean   => 'ninja',
  brenda => 'secret',
  rita   => 'banana',
);

sub load_user {
  my ($app, $uid) = @_;

  exists $user_password{$uid} ? $uid : undef;
}

sub validate_user {
  my ($app, $username, $password, $extradata) = @_;
  if (exists($user_password{$username}) && secure_compare($password, $user_password{$username})) {
    return $username;
  }
  return;
}

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  $self->plugin('authentication' => {
      'load_user' => \&load_user,
      'validate_user' => \&validate_user,
    });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#new_session');
  $r->post('/login')->to('example#create_session');

  # Members Only Area
  my $auth = $r->route('/members')->over(authenticated => 1);
  $auth->get('/')->to('members#index');
  $auth->get('logout')->to('members#signout')->name('logout');
}

1;





