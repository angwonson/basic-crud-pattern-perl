#!/usr/bin/env perl
 
use strict;
use warnings;
use Test::More;
 
# Need to specify the name of your app as arg on next line
# Can also do:
#   use Test::WWW::Mechanize::Catalyst "Bugnilla";
 
BEGIN { use_ok("Test::WWW::Mechanize::Catalyst" => "Bugnilla") }
 
# Create two 'user agents' to simulate two different users ('test01' & 'test02' & 'test03')
my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;
my $ua3 = Test::WWW::Mechanize::Catalyst->new;
 
# Use a simplified for loop to do tests that are common to both users
# Use get_ok() to make sure we can hit the base URL
# Second arg = optional description of test (will be displayed for failed tests)
# Note that in test scripts you send everything to 'http://localhost'
$_->get_ok("http://localhost/login", "Get login page") for $ua1, $ua2, $ua3;
# Use title_is() to check the contents of the <title>...</title> tags
$_->title_is("Login", "Check for login title") for $ua1, $ua2, $ua3;
# Use content_contains() to match on text in the html body
$_->content_contains("You need to log in to use this application",
    "Check we are NOT logged in") for $ua1, $ua2, $ua3;

# Log in as each user
# Specify username and password on the URL
$ua1->get_ok("http://localhost/login?username=test01&password=mypass", "Login 'test01'");
# Could make user2 like user1 above, but use the form to show another way
$ua2->submit_form(
    fields => {
        username => 'test02',
        password => 'mypass',
    });
$ua3->submit_form(
    fields => {
        username => 'test03',
        password => 'mypass',
    });
 
# Go back to the login page and it should show that we are already logged in
$_->get_ok("http://localhost/login", "Return to '/login'") for $ua1, $ua2;
$_->title_is("Login", "Check for login page") for $ua1, $ua2;
$_->content_contains("Please Note: You are already logged in as ",
    "Check we ARE logged in" ) for $ua1, $ua2;
 
# 'Click' the 'Logout' link (see also 'text_regex' and 'url_regex' options)
#$_->follow_link_ok({n => 4}, "Logout via first link on page") for $ua1, $ua2;
# yikes can't count on it being #4 every time
$_->get_ok("http://localhost/logout", "Logout is a redirect currently") for $ua1, $ua2, $ua3;
$_->title_is("Login", "Check for login title") for $ua1, $ua2;
$_->content_contains("You need to log in to use this application",
    "Check we are NOT logged in") for $ua1, $ua2;

# anonymous users should see the create link on the left nav
$_->content_contains("/tickets/create_form\" class=\"pure-menu-link\">Create</a>",
    "All users should have a create link") for $ua1, $ua2, $ua3;

# Log back in
$ua1->get_ok("http://localhost/login?username=test01&password=mypass",
    "Login 'test01'");
$ua2->get_ok("http://localhost/login?username=test02&password=mypass",
    "Login 'test02'");
$ua3->get_ok("http://localhost/login?username=test03&password=mypass",
    "Login 'test03'");
# Should be at the Ticket List page... do some checks to confirm
$_->title_is("Ticket List", "Check for ticket list title") for $ua1, $ua2;
 
# why the following 3 lines instead of just one?
$ua1->get_ok("http://localhost/tickets/list", "'test01' ticket list");
$ua1->get_ok("http://localhost/login", "Login Page");
$ua1->get_ok("http://localhost/tickets/list", "'test01' ticket list");
 
$_->content_contains("Ticket List", "Check for ticket list title") for $ua1, $ua2;
# Make sure the appropriate logout buttons are displayed
$_->content_contains("/logout\" class=\"pure-menu-link\">Logout</a>",
    "All users should have a 'Logout Link'") for $ua1, $ua2, $ua3;
$_->content_contains("/tickets/create_form\" class=\"pure-menu-link\">Create</a>",
    "All users should have a create link") for $ua1, $ua2, $ua3;

$ua1->get_ok("http://localhost/tickets/list", "View ticket list as 'test01'");
 
# User 'test01' should be able to create a ticket with the "formless create" URL
$ua1->get_ok("http://localhost/tickets/url_create/TestTitle/1/1",
    "'test01' formless create");
$ua1->title_is("Ticket Created", "Ticket created title");
$ua1->content_contains("Added ticket 'TestTitle'", "Check title added OK");
$ua1->content_contains("assigned to 'Alice'", "Check user assigned to ticket OK");
$ua1->content_contains("with status 'New'.", "Check status added OK");
# Try a regular expression to combine the previous 3 checks & account for whitespace
$ua1->content_like(qr/Added ticket 'TestTitle'\s+assigned to 'Alice'\s+with status 'New'./,
    "Regex check");
 
# Make sure the new ticket shows in the list
$ua1->get_ok("http://localhost/tickets/list", "'test01' ticket list");
$ua1->title_is("Ticket List", "Check logged in and at ticket list");
$ua1->content_contains("Ticket List", "Ticket List page test");
$ua1->content_contains("TestTitle", "Look for 'TestTitle'");
 
# Make sure the new ticket can be deleted
# Get all the Delete links on the list page
my @delLinks = $ua1->find_all_links(text => 'Delete');
# Use the final link to delete the last ticket
$ua1->get_ok($delLinks[$#delLinks]->url, 'Delete last ticket');
# Check that delete worked
$ua1->content_contains("Ticket List", "Ticket List page test");
$ua1->content_like(qr/Deleted ticket \d+/, "Deleted ticket #");
 
# User 'test03' should not be able to add a ticket - remove this once we allow anonymous submissions
$ua3->get_ok("http://localhost/tickets/url_create/TestTitle2/2/2", "'test03' add");
$ua3->content_contains("Unauthorized!", "Check 'test03' cannot add a ticket via GET url");

done_testing;
