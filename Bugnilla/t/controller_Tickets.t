use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Bugnilla';
use Bugnilla::Controller::Tickets;

#ok( request('/tickets')->is_success, 'Request should succeed' );
ok( request('/tickets')->is_redirect, 'Request should succeed' );
done_testing();
