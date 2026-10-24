ALTER TABLE iam.device_token
    ADD CONSTRAINT fk_device_token_user
    FOREIGN KEY (user_id) REFERENCES iam.[user] (user_id);
