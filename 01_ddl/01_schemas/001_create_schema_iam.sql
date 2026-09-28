-- Schema that holds every table owned by the iam service inside the shared rentamovil database.
-- CREATE SCHEMA must be the only statement in its batch, hence the EXEC wrapper.
IF SCHEMA_ID('iam') IS NULL
    EXEC('CREATE SCHEMA iam');
