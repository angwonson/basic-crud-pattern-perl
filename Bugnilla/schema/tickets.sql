--
-- Create a very simple database to hold ticket, ticket status, and user/role information
--
PRAGMA foreign_keys = ON;

--
-- Add users and role tables, along with a many-to-many join table
--
PRAGMA foreign_keys = ON;
CREATE TABLE users (
    id            INTEGER PRIMARY KEY,
    username      TEXT,
    password      TEXT,
    email_address TEXT,
    first_name    TEXT,
    last_name     TEXT,
    active        INTEGER
);
CREATE TABLE role (
    id   INTEGER PRIMARY KEY,
    role TEXT
);
CREATE TABLE user_role (
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);
--
-- Load up some initial test data
--
INSERT INTO users VALUES (1, 'test01', 'mypass', 't01@na.com', 'Alice',  'Smith', 1);
INSERT INTO users VALUES (2, 'test02', 'mypass', 't02@na.com', 'Bob', 'Lee',  1);
INSERT INTO users VALUES (3, 'test03', 'mypass', 't03@na.com', 'Charlie',   'Jones',   0);
INSERT INTO role VALUES (1, 'Admin');
INSERT INTO role VALUES (2, 'Developer');
INSERT INTO user_role VALUES (1, 1);
INSERT INTO user_role VALUES (1, 2);
INSERT INTO user_role VALUES (2, 2);

--
-- Add ticket and ticket status,link to users for ticket assignment
--
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
        title       TEXT NOT NULL,
        description       TEXT,
        createdby_user_id        INTEGER REFERENCES users(id),
        assignedto_user_id        INTEGER REFERENCES users(id),
        status_id      INTEGER REFERENCES status(id) DEFAULT 1,
        created TIMESTAMP,
        updated TIMESTAMP
);
--
-- Load up some initial test data
--
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (1, 'Build a website', 3, 1, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (2, 'Have some coffee', 1, 2, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (3, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (4, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (5, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (6, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (7, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (8, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (9, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (10, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (11, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (12, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (13, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (14, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (15, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (16, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (17, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (18, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
INSERT INTO ticket ('id','title','assignedto_user_id','status_id','created','updated') VALUES (19, 'Read a magazine', 2, 5, datetime('now'), datetime('now'));
