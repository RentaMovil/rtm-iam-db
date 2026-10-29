CREATE TABLE iam.device_token (
    device_token_id INT IDENTITY(1,1) NOT NULL,
    user_id         INT               NOT NULL,
    token           VARCHAR(255)      NOT NULL,
    platform        VARCHAR(20)       NOT NULL,
    created_at      DATETIME          NOT NULL,

    CONSTRAINT pk_device_token PRIMARY KEY (device_token_id),
    CONSTRAINT uq_device_token_token UNIQUE (token),
    CONSTRAINT ck_device_token_platform CHECK (platform IN ('ios', 'android'))
);
