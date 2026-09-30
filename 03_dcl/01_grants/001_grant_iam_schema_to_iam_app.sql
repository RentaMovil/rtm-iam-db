-- Data access only, and only on the iam schema: no DDL (that's Liquibase's job with its own
-- account), no access to other services' schemas or to dbo (Liquibase history tables).
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::iam TO iam_app;
