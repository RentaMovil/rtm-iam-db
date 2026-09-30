ALTER TABLE shared.audit
    ADD CONSTRAINT fk_audit_user
    FOREIGN KEY (user_id) REFERENCES iam.[user] (user_id);
