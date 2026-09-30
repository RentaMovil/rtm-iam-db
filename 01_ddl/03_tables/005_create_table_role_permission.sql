CREATE TABLE iam.role_permission (
    role_id        INT NOT NULL,
    permission_id  INT NOT NULL,

    CONSTRAINT pk_role_permission PRIMARY KEY (role_id, permission_id)
);
