CREATE TABLE iam.person (
    person_id   INT IDENTITY(1,1) NOT NULL,
    first_name  VARCHAR(100)      NOT NULL,
    last_name  VARCHAR(100)      NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NULL,
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);