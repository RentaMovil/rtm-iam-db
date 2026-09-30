CREATE TABLE iam.session (
    session_id     INT IDENTITY(1,1) NOT NULL,
    user_id        INT               NOT NULL,
    refresh_token  VARCHAR(255)      NOT NULL,
    created_at     DATETIME          NOT NULL,
    expires_at     DATETIME          NOT NULL,
    ip_address     VARCHAR(45)       NULL,
    user_agent     VARCHAR(255)      NULL,
    revoked        BIT               NOT NULL,

    CONSTRAINT pk_session PRIMARY KEY (session_id)
);