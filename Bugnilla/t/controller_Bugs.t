use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Bugnilla';
use Bugnilla::Controller::Bugs;

ok( request('/bugs')->is_success, 'Request should succeed' );
done_testing();
