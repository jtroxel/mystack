CREATE TABLE "restaurants" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "rating" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20150220035900');

