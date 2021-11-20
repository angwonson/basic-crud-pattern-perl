# replace developer table and relations with auth users
# FormFu / FormHandler
# fix error message on login screen. Should not complain about missing u/p when you first land on the page
#
# show individual ticket page with comments
# comment on a ticket
# assign a ticket to me link on list page
# change status link on list page
# edit ticket title, status, developer assignment
# filter by status
# padding and maybe some color in the table
#
# disable authentication option
# allow form to submit without status or developer (default status is New and default developer should be undefined)
#
# pretty up the 404 page

## LOWER PRIORITY
# navbar highlighting could be reduced to avoid repeating the same if statement in wrapper.tt2:
[% IF c.req.path == 'logout' %] menu-item-divided pure-menu-selected [% END %]">
# REST API
# auto crud
# user/role management for admins
