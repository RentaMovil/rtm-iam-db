-- Database identity the rtm-iam service connects with (never sa).
-- LOGIN = credentials to enter the SQL Server instance; USER = its identity inside rentamovil.
-- The password comes from liquibase.properties (parameter.iamAppPassword), never from this repo.

-- Fail fast if the parameter wasn't provided: Liquibase would otherwise leave the literal text.
IF '${iamAppPassword}' = '$' + '{iamAppPassword}'
    THROW 50000, 'Missing parameter.iamAppPassword in liquibase.properties', 1;

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'iam_app')
    CREATE LOGIN iam_app WITH PASSWORD = '${iamAppPassword}', CHECK_POLICY = ON;

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'iam_app')
    CREATE USER iam_app FOR LOGIN iam_app WITH DEFAULT_SCHEMA = iam;
