ALTER TABLE iam.session
    ADD CONSTRAINT fk_session_user
    FOREIGN KEY (user_id) REFERENCES iam.[user] (user_id);
