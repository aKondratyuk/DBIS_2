CREATE KEYSPACE IF NOT EXISTS image2code 
  WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 3
  }
AND DURABLE_WRITES = true; 

USE image2code;

CREATE TYPE IF NOT EXISTS image2code.page (
  "generation_time" timestamp,
  "tags" set<text>,
  "html_code" text
);

CREATE TYPE IF NOT EXISTS image2code.role (
  "profession" text,
  "company" text,
  "why_use_service" text
);

CREATE TABLE IF NOT EXISTS image2code.user_details (
  "email" text,
  "password" blob,
  "register_on" timestamp,
  "country" text,
  "city" text,
  "role" frozen<role>,
  PRIMARY KEY ("email")
);

CREATE TABLE IF NOT EXISTS image2code.user_pages (
  "email" text,
  "image_name" text,
  "image_path" text STATIC,
  "image_size" tuple<int, int>,
  "confirmed_page" boolean,
  "pages" list<frozen<page>>,
  PRIMARY KEY ("email", "confirmed_page", "image_name")
)
WITH CLUSTERING ORDER BY ("confirmed_page" DESC, "image_name" ASC);

CREATE TABLE IF NOT EXISTS image2code.num_of_uploaded_images_by_user (
  "email" text,
  "images_counter" counter,
  "total_pages_counter" counter,
  PRIMARY KEY ("email")
);

CREATE TABLE IF NOT EXISTS image2code.num_of_generated_pages (
  "email" text,
  "pages_counter" counter,
  "image_name" text,
  PRIMARY KEY (("email", "image_name"))
);
