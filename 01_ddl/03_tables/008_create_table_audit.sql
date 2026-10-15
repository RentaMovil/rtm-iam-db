-- Append-only audit log written directly by every service (06-data/models.md -> Audit).
-- No per-row created_at/updated_at anywhere in the model: this table replaces them.
CREATE TABLE shared.audit (
    audit_id            INT IDENTITY(1,1) NOT NULL,
    user_id             INT               NULL,      -- NULL = system or anonymous action
    action              VARCHAR(50)       NOT NULL,
    affected_table      VARCHAR(50)       NOT NULL,
    affected_record_id  INT               NULL,
    date                DATETIME          NOT NULL,
    detail              NVARCHAR(MAX)     NULL,      -- adaptive JSON

    CONSTRAINT pk_audit PRIMARY KEY (audit_id),
    CONSTRAINT ck_audit_detail CHECK (detail IS NULL OR ISJSON(detail) = 1)
);
