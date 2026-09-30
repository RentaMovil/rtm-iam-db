ALTER TABLE iam.verification_code
    ADD CONSTRAINT fk_verification_code_user
    FOREIGN KEY (user_id) REFERENCES iam.[user] (user_id);
