CREATE TABLE iam.role (
    role_id      INT IDENTITY(1,1) NOT NULL,
    name         VARCHAR(50)       NOT NULL,
    description  VARCHAR(255)      NULL,

    CONSTRAINT pk_role PRIMARY KEY (role_id),
    CONSTRAINT uq_role_name UNIQUE (name)
);
