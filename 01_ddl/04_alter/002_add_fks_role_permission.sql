ALTER TABLE iam.role_permission
    ADD CONSTRAINT fk_role_permission_role
    FOREIGN KEY (role_id) REFERENCES iam.role (role_id);

ALTER TABLE iam.role_permission
    ADD CONSTRAINT fk_role_permission_permission
    FOREIGN KEY (permission_id) REFERENCES iam.permission (permission_id);
