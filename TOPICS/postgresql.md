Install Postgresql with homebrew :
```
  brew install postgresql
```

The installation will create a PostgreSQL database cluster needed to run pg
with this command :

```
initdb /usr/local/var/postgres/ -E utf8
```

If you look in this folder you can see a bunch of important configuration files 
like :
- postgresql.conf
- PG_VERSION

When you lunch the 'postgres' command you can pass the -D option to specify
which folder you want to use as cluster configuration

You can create your own cluster with initdb, and then use postgres command to
specify this folder
```
initdb /your/custom/folder/ -E utf8
```

2 ways to run the server :
```
postgres -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log
```
or via the pg control command
```
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

You can create a db with createdb command:
```
createdb mydbname
```

Enter into psql, by default the dbname will be your username
```
psql
```
If you want to see all available database use:
```
psql -l
```

Then you can select which database you want to login with:
```
psql -d dbname
```

To exit
```
\q
```

Now you want type command, you can get help for that with:
```
\h sql command
```
Create a table :
```
create table authors (name varchar(100));
```

Display list of tables :
```
\d
```

Detail view of table (see the type of each fields)
```
\d authors
```

Edit the command in your editor (need EDITOR variable in your bash)
```
\e
```

Add a primary key using a serial type.
Serial type: notational convenience for creating unique
identifier columns (similar to the AUTO_INCREMENT in mysql)"

Nice things : it creates the ids for the existing entries
```
 alter table authors
 add column author_id serial primary key;
 ```

 Create table with references to another with foreign key constraint
 and multiple fields;
 ```
create table tutorials (
  tutorial_id serial primary key,
  title text,
  author_id, integer references authors(author_id)
);
```

Make you first join:
```
select tutorials.title, authors.name from tutorials join authors on tutorials.author_id = authors.author_id;
```

Drop multiple table:
```
drop table authors, tutorials;
```

Insert multiple row at the same time:
```
insert into authors(name) values ('hector'), ('jeannot'), ('toto');
```

You can alter a table to add constraint on a column.
```
ju=# alter table authors add column email varchar(100) not null;
ERROR:  column "email" contains null values
```
But if you add constraint like not nul you should add a default value
```
alter table authors add column email varchar(100) not null default 'invalid@email.com;
```

Update rows on a condition with:
```
update authors set email='hector@contact.com' where name ='hector';
```

Delete rows on a condition with :
```
delete from authors where name='toto';
```

Add empty table then edit it 
```
create table tutorials();

\e

alter table tutorials
add column tutorial_id serial primary key,
add column title text,
add column author_id integer,
add constraint unique_title unique(title),
add foreign key(author_id) references authors(author_id);
```
You can check the constraint
```
Check uniqueness
ju=# insert into tutorials(title, author_id) values ('lol mon gros', 1);
ERROR:  duplicate key value violates unique constraint "unique_title"
DETAIL:  Key (title)=(lol mon gros) already exists.

Check type
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', 1df);
ERROR:  syntax error at or near "df"
LINE 1: ...o tutorials(title, author_id) values ('lol mon gros2', 1df);

Check references constraint
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', 23);
ERROR:  insert or update on table "tutorials" violates foreign key constraint "tutorials_author_id_fkey"
DETAIL:  Key (author_id)=(23) is not present in table "authors".
```

You can put null on author_id to let's change it :
```
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', null);
INSERT 0 1
```
TODO : constraint on foreign key, validate presence

Update a field
```
update tutorials set author_id=3 where tutorial_id=1
```
A schema : group of table. Organizing principle for table.
View schema
```
\dS
```
View schema  lookup
```
show search_path;
```
#SCHEMA

Create a schema
```
create schema temp;
```
Create table in this schema
```
create table temp.test();
```

Modify search path
```
set search_path=public,temp;
```
Logs :
You can see after the operation you can see the table
```
ju=# create schema temp;
CREATE SCHEMA
ju=# create table temp.test(toto varchar(100));
CREATE TABLE
ju=# \d
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | authors                   | table    | ju
 public | authors_author_id_seq     | sequence | ju
 public | tutorials                 | table    | ju
 public | tutorials_tutorial_id_seq | sequence | ju
(4 rows)

ju=# set search_path=public,temp
ju-# ;
SET
ju=# show search_path
ju-# ;
 search_path
--------------
 public, temp
(1 row)

ju=# \d
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | authors                   | table    | ju
 public | authors_author_id_seq     | sequence | ju
 public | tutorials                 | table    | ju
 public | tutorials_tutorial_id_seq | sequence | ju
 temp   | test                      | table    | ju
(5 rows)
```

No nesting of schema.

Drop schema
```
drop schema temp cascade;
```

#TYPES

##NUMERIC
Create new table with some types. You can see we use the last created type publish_state, and some sexy types like
array of varchar, numeric(4,2) so values can go to 99,99.
```
create table books(
  book_id serial primary key,
  price_usd numeric(4,2),
  isbn varchar(20),
  title text,

  author_id integer references authors(author_id),
  tags varchar(30)[],

  publish_date date,
  last_updated timestamp,

  published boolean,
  state publish_state
);
```
You can't go above the limite of precision for numeric type
```
insert into books(price_usd) values(123.99);
ERROR:  numeric field overflow
DETAIL:  A field with precision 4, scale 2 must round to an absolute value less than 10^2.
```
##TAGS
Insert tags, collection of varchars
```
insert into books(title, tags) values
('Postgres Essentials', '{"sql", "video", "tuts", "database", "postgres"}');

ju=# select title, tags from books;
        title        |                tags
---------------------+------------------------------------
                     |
 Postgres Essentials | {sql,video,tuts,database,postgres}
```
You can retrieve index by slicing, 1 indexed not 0
```
ju=# select tags[1:3] from books
ju-# ;
       tags
------------------

 {sql,video,tuts}

(3 rows)
```
You can update a specific index :
```
ju=# select * from books;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date | last_updated | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+--------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    |              |              |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              |              |           |
       3 |     23.99 |      |                     |           | {a,b,c}                            |              |              |           |

ju=# update books set tags[2]='z' where book_id=3;
UPDATE 1
ju=# select * from books;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date | last_updated | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+--------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    |              |              |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              |              |           |
       3 |     23.99 |      |                     |           | {a,z,c}
```

##Date
You can pass a date in diffrent format :
2015-03-05
2015-Jan-01
03-24-2014
03/24/2013

There is a validation on the date.
You can modify the configuration for datestyle, to change the date convention
PG have built in validation for dates
```
ju=# update books set publish_date='2015-03-46' where book_id=1
;
ERROR:  date/time field value out of range: "2015-03-46"
LINE 1: update books set publish_date='2015-03-46' where book_id=1
                                      ^
HINT:  Perhaps you need a different "datestyle" setting.
```
##TIMESTAMP
You can specify an hour with pm and am
```
ju=# update books set last_updated='Apr 20 2015 03:20pm';
UPDATE 3
ju=# select * from books order by book_id;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date |    last_updated     | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+---------------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    | 2015-03-06   | 2015-04-20 15:20:00 |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              | 2015-04-20 15:20:00 |           |
       3 |     23.99 |      |                     |           | {a,z,c}                            |              | 2015-04-20 15:20:00 |           |
(3 rows)
```
PG have built in keyword for special moment like 'today', 'yesterday', 'tomorrow' or 'now'

##ENUM
Create a type, example with enum
```
create type publish_state as enum ('initial', 'approved', 'authored', 'edited','reviewd','scheduled','published');
```

You can see the datatype you created 
```
\dT+
```

```
ju=# \dT+
                                     List of data types
 Schema |     Name      | Internal name | Size | Elements  | Access privileges | Description
--------+---------------+---------------+------+-----------+-------------------+-------------
 public | publish_state | publish_state | 4    | initial  +|                   |
        |               |               |      | approved +|                   |
        |               |               |      | authored +|                   |
        |               |               |      | edited   +|                   |
        |               |               |      | reviewd  +|                   |
        |               |               |      | scheduled+|                   |
        |               |               |      | published |                   |
(1 row)

ju=# update books set state='initial';
UPDATE 3
```
PG validate you pass a value in enum
```
ju=# update books set state='initialsadf';
ERROR:  invalid input value for enum publish_state: "initialsadf"
LINE 1: update books set state='initialsadf';
                               ^
```
#TROUBLESHOUTING

If error with psql (psql: FATAL:  database "user" does not exist), it's you don't
have any db yet, create one with :
```
createdb
```
