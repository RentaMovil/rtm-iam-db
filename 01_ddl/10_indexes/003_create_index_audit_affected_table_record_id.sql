-- One record's history: WHERE affected_table = 'reservation' AND affected_record_id = 42
CREATE INDEX ix_audit_affected_table_record_id
    ON shared.audit (affected_table, affected_record_id);
