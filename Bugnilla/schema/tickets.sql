--
-- Create a very simple database to hold ticket and developer information
--
PRAGMA foreign_keys = ON;
CREATE TABLE status (
        id          INTEGER PRIMARY KEY,
        status  TEXT
);
INSERT INTO status VALUES (1, 'New');
INSERT INTO status VALUES (2, 'In progress');
INSERT INTO status VALUES (3, 'QA');
INSERT INTO status VALUES (4, 'Done');
INSERT INTO status VALUES (5, "Won't Fix");

CREATE TABLE ticket (
        id          INTEGER PRIMARY KEY,
        title       TEXT ,
        status_id      INTEGER REFERENCES status(id) DEFAULT 1
);
-- 'ticket_developer' is a many-to-many join table between tickets & developers
CREATE TABLE ticket_developer (
        ticket_id     INTEGER REFERENCES ticket(id) ON DELETE CASCADE ON UPDATE CASCADE,
        developer_id   INTEGER REFERENCES developer(id) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (ticket_id, developer_id)
);
CREATE TABLE developer (
        id          INTEGER PRIMARY KEY,
        first_name  TEXT
);
---
--- Load some sample data
---
INSERT INTO ticket VALUES (1, 'Build a website', 3);
INSERT INTO ticket VALUES (2, 'Have some coffee', 1);
INSERT INTO ticket VALUES (3, 'Read a book', 2);

INSERT INTO developer VALUES (1, 'Alice');
INSERT INTO developer VALUES (2, 'Bob');
INSERT INTO developer VALUES (3, 'Charlie');

INSERT INTO ticket_developer VALUES (1, 1);
INSERT INTO ticket_developer VALUES (2, 3);
INSERT INTO ticket_developer VALUES (3, 2);
