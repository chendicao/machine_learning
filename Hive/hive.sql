gremlin00:~> hive

hive> show databases;

hive> create database cis761;

hive> use cis761;

gremlin00:~> hadoop fs -put hive/bible

gremlin00:~> hadoop fs -put hive/shakespeare

hive> create table biblewords(word STRING, freq INT) row format delimited fields terminated by '\t';

hive> create table shakespearewords(word STRING, freq INT) row format delimited fields terminated by '\t';

hive> describe biblewords;

hive> describe shakespearewords;

hive> load data local inpath 'hive/bible' into table biblewords;

hive> load data local inpath 'hive/shakespeare' into table shakespearewords;

gremlin00:~> hdfs dfs -ls -R /hive

hive> select count(*) from biblewords;

hive> select count(*) from shakespearewords;

hive> SELECT word FROM shakespearewords WHERE freq >= 10 LIMIT 10;

hive> SELECT s.word, s.freq, b.freq FROM shakespearewords s JOIN biblewords b ON (s.word = b.word) WHERE s.freq >= 1 AND b.freq >= 1  LIMIT 10;

hive> SELECT s.word, s.freq, b.freq FROM shakespearewords s JOIN biblewords b ON (s.word = b.word) WHERE s.freq >= 1 AND b.freq >= 1 ORDER BY s.freq DESC LIMIT 10;


hive> create table partbiblewords(word STRING) partitioned by (freq int) clustered by (word) into 10 buckets row format delimited fields terminated by '\t';

hive> set hive.exec.dynamic.partition=true;
hive> set hive.exec.dynamic.partition.mode=nonstrict; 

hive> from biblewords b insert overwrite table partbiblewords partition(freq=1) select b.word where b.freq=1;

hive> from biblewords b insert overwrite table partbiblewords partition(freq=2) select b.word where b.freq=2;

hive> from biblewords b insert overwrite table partbiblewords partition(freq=3) select b.word where b.freq=3;

hive> from biblewords b insert overwrite table partbiblewords partition(freq=4) select b.word where b.freq=4;

hive> from biblewords b insert overwrite table partbiblewords partition(freq=5) select b.word where b.freq=5;


hive>  select word from partbiblewords tablesample (bucket 1 out of 32);

hive>  select word from partbiblewords where freq = 1;

hive>  select word from partbiblewords where freq = 1;

hive> create table users(uid string, dob string, genre string) row format delimited fields terminated by '\t';

hive> load data local inpath 'hive/users.tsv' into table users;

hive> create table partusers(uid string, dob string) partitioned by (genre string) clustered by (dob) into 2 buckets row format delimited fields terminated by '\t';

hive> from users u insert overwrite table partusers partition(genre) select u.uid, u.dob, u.genre;

