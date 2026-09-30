-- Schema for cross-cutting tables written by every service (today only audit). Migrated by
-- rtm-iam-db because audit has an FK to iam.[user] and iam runs first (ADR-009).
IF SCHEMA_ID('shared') IS NULL
    EXEC('CREATE SCHEMA shared');
