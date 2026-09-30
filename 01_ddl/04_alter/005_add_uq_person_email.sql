ALTER TABLE iam.person
    ADD CONSTRAINT uq_person_email UNIQUE (email);
