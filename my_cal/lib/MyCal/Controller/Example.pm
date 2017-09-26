package MyCal::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use SVG::Calendar;

sub cal {
  my ($c) = @_;
  my $svg = SVG::Calendar->new( page => 'A4' );
  my $mon = $c->param('mon') || '10';
  my $year = $c->param('year') || '2017';
  my $dt = "$year-$mon";
  $c->render(data => $svg->output_month( $dt ), format => 'svg');
}

sub cal_form {
  my ($c) = @_;
  my @months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
  my $idx = 0;
  my $all_months = [ map { [ $_ => ++$idx ] } @months ];
  my $mon = $c->param('mon') || 01;
  my $year = $c->param('year') || 2017;
  $c->stash('months_for_select', $all_months);
  $c->stash('cal_img', "/cal.svg?mon=$mon&year=$year");
  $c->render;
}

1;
