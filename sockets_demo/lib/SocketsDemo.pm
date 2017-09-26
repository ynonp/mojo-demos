package SocketsDemo;
use Mojo::Base 'Mojolicious';
use Minion;

sub tr_task {
  my ($job, $cmd) = @_;
  $job->app->log->debug('Start process.sh');
  my ($escaped) = $cmd =~ /([a-zA-Z]+)/;
  my $line = "bash utils/process.sh $escaped >> tmp/result.log";
  $job->app->log->debug("cmd = $line");
  system($line);
}

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  $self->plugin(Minion => { SQLite => 'sqlite:jobs.db' });
  $self->minion->add_task(tr => \&tr_task);

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#prepare');
  $r->post('/run')->to('example#run');
  $r->websocket('/progress')->to('example#progress');
}

1;
