# filter by status
# padding and maybe some color in the table
# FormFu
# disable authentication option
# comment on a ticket
# assign a ticket
# show individual ticket page with comments
# edit ticket title, status, developer assignment
# allow form to submit without status or developer (default status is New and default developer should be undefined)
# fix error message on login screen. Should not complain about missing u/p when you first land on the page
# only allow delete for admin. cascade to comments.
# highlight menu bar selection for current page
# REST API
# auto crud
# replace developer table and relations with auth users
# navbar highlighting could be reduced to avoid repeating the same if statement in wrapper.tt2:
[% IF c.req.path == 'logout' %] menu-item-divided pure-menu-selected [% END %]">

