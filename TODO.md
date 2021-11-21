# TODO

## HIGHER PRIORITY
#### Form Processing
- [ ] FormFu / FormHandler
- [ ] fix error message on login screen. Should not complain about missing u/p when you first land on the page
#### Ticket Features
- [ ] show individual ticket page with comments
- [ ] comment on a ticket
- [ ] assign a ticket to me link on list page
- [ ] change status link on list page
- [ ] edit ticket title, status, developer assignment
- [ ] filter by status
- [ ] padding and maybe some color in the table
#### Anonymous Features
- [ ] disable authentication option - maybe config flag to let the system run without logins at all?
- [ ] allow form to submit without status or developer (default status is New and default developer should be undefined)
- [ ] allow form to submit without being logged in - [ ] add created_by column and make 'anonymous' the default

## LOWER PRIORITY
- [ ] navbar highlighting could be reduced to avoid repeating the same if statement in wrapper.tt2:
```
[% IF c.req.path == 'logout' %] menu- [ ]item- [ ]divided pure- [ ]menu- [ ]selected [% END %]">
```
- [ ] REST API
- [ ] auto crud
- [ ] user/role management for admins
- [ ] Add git hooks to prevent untracked files
