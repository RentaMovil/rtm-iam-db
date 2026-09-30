ALTER TABLE iam.role_permission DROP CONSTRAINT IF EXISTS fk_role_permission_permission;
ALTER TABLE iam.role_permission DROP CONSTRAINT IF EXISTS fk_role_permission_role;
