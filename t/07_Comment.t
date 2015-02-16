#!/usr/bin/env perl

use Test::Most tests => 28;
use Data::Dumper;

BEGIN {
    use_ok('Thingiverse');
    use_ok('Thingiverse::Comment');
}

my $id           = '547395';
my $target_id    = '316754';
my $target_type  = 'thing';
my $body         = qr(edge.*ratio.*1:4:9);
my $public_url   = sprintf 'http://www.thingiverse.com/%s:%s#comment-%s', $target_type, $target_id, $id;
my $url          = $Thingiverse::api_uri_base . Thingiverse::Comment->api_base() . $id;
my $target_url   = $Thingiverse::api_uri_base . '/' . $target_type . '/' . $target_id;
my $commenter_id = '16273';
my $parent_id    = '';
my $parent_url   = '';
my $is_deleted   = 0;

my $comment = Thingiverse::Comment->new( 'id' => $id, thingiverse => Thingiverse->new() );
# print Dumper($comment);

SKIP: {
    skip 'Comment fields not yet implemented.', 26 unless $comment->can('id');
    ok( defined $comment,            'Thingiverse::Comment object is defined' ); 
    ok( $comment->isa('Thingiverse::Comment'), 'can make an Thingiverse::Comment object' ); 
can_ok( $comment, qw( id ),          );
can_ok( $comment, qw( url ),         );
can_ok( $comment, qw( target_type ), );
can_ok( $comment, qw( target_id ),   );
can_ok( $comment, qw( public_url ),  );
can_ok( $comment, qw( target_url ),  );
can_ok( $comment, qw( body ),        );
can_ok( $comment, qw( user ),        );
can_ok( $comment, qw( added ),       );
can_ok( $comment, qw( modified ),    );
can_ok( $comment, qw( parent_id ),   );
can_ok( $comment, qw( parent_url ),  );
can_ok( $comment, qw( is_deleted ),  );

    is( $comment->id,                     $id,                     'id             accessor' ); 
    is( $comment->target_id,              $target_id,              'target_id      accessor' ); 
    is( $comment->target_url,             $target_url,             'target_url     accessor' ); 
  like( $comment->body,                   $body,                   'name           accessor' ); 
    is( $comment->public_url,             $public_url,             'public_url     accessor' ); 
    is( $comment->url,                    $url,                    'url            accessor' ); 
    is( $comment->parent_id,              $parent_url,             'parent_url     accessor' ); 
    is( $comment->parent_url,             $parent_url,             'parent_url     accessor' ); 
    is( ref($comment->user),              'HASH',                  'user           UserHash' ); 
    is( ${$comment->user}{id},            $commenter_id,           'user_id        accessor' ); 
    is( $comment->is_deleted,             $is_deleted,             'is_deleted     accessor' ); 
}

if ( 0 ) {
  print "nocomment\n";
}

exit 0;
__END__

aliases:
commenter for user
