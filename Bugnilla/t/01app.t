#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'Bugnilla';

#ok( request('/')->is_success, 'Request should succeed' );
ok( request('/')->is_redirect, 'Request should succeed' );

done_testing();
