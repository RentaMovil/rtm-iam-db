-- Un registro público queda PENDING_VERIFICATION hasta confirmar el código de su correo
-- (HU-IAM-001); no puede hacer login hasta pasar a ACTIVE. Un CHECK no se puede alterar en
-- SQL Server: se borra y se recrea con el mismo nombre.
ALTER TABLE iam.[user] DROP CONSTRAINT ck_user_status;

ALTER TABLE iam.[user] ADD CONSTRAINT ck_user_status
    CHECK (status IN ('ACTIVE', 'INACTIVE', 'BLOCKED', 'PENDING_VERIFICATION'));
