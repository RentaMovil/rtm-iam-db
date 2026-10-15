CREATE TABLE iam.verification_code (
    verification_code_id  INT IDENTITY(1,1) NOT NULL,
    user_id               INT               NOT NULL,
    code                  VARCHAR(10)       NOT NULL,
    type                  VARCHAR(30)       NOT NULL,
    created_at            DATETIME          NOT NULL,
    expires_at            DATETIME          NOT NULL,
    used                  BIT               NOT NULL,

    CONSTRAINT pk_verification_code PRIMARY KEY (verification_code_id)
);
