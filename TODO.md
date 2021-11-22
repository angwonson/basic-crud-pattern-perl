# TODO

## HIGHER PRIORITY
#### Form Processing
- [x] FormFu / FormHandler
- [x] fix error message on login screen. Should not complain about missing u/p when you first land on the page
#### Ticket Features
- [x] show individual ticket page with comments
- [ ] comment on a ticket
- [x] filter by status
- [ ] assign a ticket to myself link on list page
- [x] change status link on list page
- [x] edit ticket title, description, status, developer assignment
#### Anonymous Features
- [ ] disable authentication option - maybe config flag to let the system run without logins at all?
- [ ] allow form to submit without status or developer (default status is New and default developer should be undefined)
- [x] allow form to submit without being logged in
- [x] add created_by column and make 'anonymous' the default

## LOWER PRIORITY
- [ ] REST API
- [ ] auto crud
- [ ] user/role management for admins
- [x] padding and maybe some color in the list and comment list table
- [ ] show and edit full_name instead of first_name
- [ ] Add git hooks to prevent untracked files
- [x] Make a list of cpan modules for those who are not running RPM based distro, so they can use cpanm to install all the dependencies
- [ ] navbar item code could be reduced to avoid repeating the same if statement in wrapper.tt2
