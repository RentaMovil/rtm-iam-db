-- El CHECK anterior no tiene PENDING_VERIFICATION: se rechaza el rollback mientras existan
-- usuarios en ese estado, en vez de perderlos o agregar el CHECK con NOCHECK.
IF EXISTS (SELECT 1 FROM iam.[user] WHERE status = 'PENDING_VERIFICATION')
    THROW 50000, 'Cannot roll back: iam.[user] has PENDING_VERIFICATION rows', 1;

ALTER TABLE iam.[user] DROP CONSTRAINT ck_user_status;

ALTER TABLE iam.[user] ADD CONSTRAINT ck_user_status
    CHECK (status IN ('ACTIVE', 'INACTIVE', 'BLOCKED'));
