-- GET /internal/users/{id}/push-tokens filtra por user_id.
CREATE INDEX ix_device_token_user_id ON iam.device_token (user_id);
