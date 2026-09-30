CREATE TABLE iam.[user] (
    user_id        INT IDENTITY(1,1) NOT NULL,
    person_id      INT               NOT NULL,
    role_id        INT               NOT NULL,
    username       VARCHAR(50)       NOT NULL,
    password_hash  VARCHAR(255)      NOT NULL,
    status         VARCHAR(20)       NOT NULL,
    last_login     DATETIME          NULL,

    CONSTRAINT pk_user PRIMARY KEY (user_id),
    CONSTRAINT uq_user_person_id UNIQUE (person_id),
    CONSTRAINT uq_user_username UNIQUE (username),
    CONSTRAINT ck_user_status CHECK (status IN ('ACTIVE', 'INACTIVE', 'BLOCKED'))
);
