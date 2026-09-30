CREATE INDEX ix_verification_code_user_id_type
    ON iam.verification_code (user_id, type);
