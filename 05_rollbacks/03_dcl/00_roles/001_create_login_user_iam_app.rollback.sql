DROP USER IF EXISTS iam_app;

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'iam_app')
    DROP LOGIN iam_app;
