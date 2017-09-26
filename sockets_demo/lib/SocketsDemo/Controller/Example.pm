package SocketsDemo::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::IOLoop::Tail;

sub run {
  my $c = shift;
  my $cmd = $c->param('cmd');
  
  $c->minion->enqueue('tr', [$cmd]);
  $c->stash('result' => $cmd . "\n");
  $c->render;
}

sub progress {
  my $c = shift;
  my $pid = open my $log, '-|', 'tail', '-f', 'tmp/result.log';
  die "Could't spawn: $!" unless defined $pid;
  my $stream = Mojo::IOLoop::Stream->new($log);
  $stream->on(read  => sub { $c->send({text => pop}) });
  $stream->on(close => sub { kill KILL => $pid; close $log });

  my $sid = Mojo::IOLoop->stream($stream);
  $c->on(finish => sub { Mojo::IOLoop->remove($sid) });
}

1;
