ALTER TABLE iam.[user]
    ADD CONSTRAINT fk_user_person
    FOREIGN KEY (person_id) REFERENCES iam.person (person_id);

ALTER TABLE iam.[user]
    ADD CONSTRAINT fk_user_role
    FOREIGN KEY (role_id) REFERENCES iam.role (role_id);
