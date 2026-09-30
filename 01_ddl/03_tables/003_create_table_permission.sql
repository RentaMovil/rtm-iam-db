CREATE TABLE iam.permission (
    permission_id  INT IDENTITY(1,1) NOT NULL,
    name           VARCHAR(50)       NOT NULL,
    description    VARCHAR(255)      NULL,

    CONSTRAINT pk_permission PRIMARY KEY (permission_id),
    CONSTRAINT uq_permission_name UNIQUE (name)
);
