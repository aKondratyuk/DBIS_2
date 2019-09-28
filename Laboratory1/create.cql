CREATE KEYSPACE IF NOT EXISTS "User_Keyspace" 
  WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 3
  }
AND DURABLE_WRITES = true; 

USE "User_Keyspace";

CREATE TYPE IF NOT EXISTS "User_Keyspace".size (
  "width" int,
  "height" int
);

CREATE TYPE IF NOT EXISTS "User_Keyspace".phone (
  "country_code" int,
  "number" text
);

CREATE TYPE IF NOT EXISTS "User_Keyspace".address (
  "city" text,
  "country" text,
  "postal_code" text,
  "state_or_province" text,
  "street" text,
  "phones" map<text, frozen<phone>>
);

CREATE TYPE IF NOT EXISTS "User_Keyspace".user_name (
  "first_name" text,
  "last_name" text
);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."User" (
  "email" varchar,
  "salt" text,
  "hash" text,
  "user_name" frozen<user_name> STATIC,
  "addresses" map<text, frozen<address>>,
  "register_on" timestamp,
  PRIMARY KEY ("email", "register_on")
)
WITH CLUSTERING ORDER BY ("register_on" DESC);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Image" (
  "path" text,
  "image_name" text,
  "format" text,
  "size" frozen<size>,
  "time_upload" timestamp,
  PRIMARY KEY ("image_name", "time_upload")
)
WITH CLUSTERING ORDER BY ("time_upload" DESC);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Tag" (
  "tag_id" timeuuid,
  "tags" set<text>,
  PRIMARY KEY ("tag_id")
);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Code" (
  "code_id" timeuuid,
  "html_code" text,
  PRIMARY KEY ("code_id")
);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Image_by_email" (
  "path" text,
  "format" text,
  "size" frozen<size>,
  "time_upload" timestamp,
  "email" varchar,
  "image_name" text,
  PRIMARY KEY (("email", "image_name"), "time_upload")
)
WITH CLUSTERING ORDER BY ("time_upload" DESC);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Images_uploaded_by_email" (
  "email" varchar,
  "images_counter" counter,
  "pages_counter" counter,
  PRIMARY KEY ("email")
);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Generated_html_pages" (
  "email" varchar,
  "pages_counter" counter,
  "image_name" text,
  PRIMARY KEY (("email", "image_name"))
);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Generation" (
  "email" varchar,
  "image_name" text,
  "result_time" timeuuid,
  "tags" set<text>,
  "html_code" text,
  PRIMARY KEY ("email", "image_name", "result_time")
)
WITH CLUSTERING ORDER BY ("image_name" ASC, "result_time" DESC);

CREATE TABLE IF NOT EXISTS "User_Keyspace"."Confirmed_generation" (
  "email" varchar,
  "image_name" text,
  "confirmed_time" timeuuid,
  "tags" set<text>,
  "html_code" text,
  PRIMARY KEY (("email", "image_name"), "confirmed_time")
)
WITH CLUSTERING ORDER BY ("confirmed_time" DESC);
