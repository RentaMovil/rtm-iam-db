-- Full permission catalog, format [resource]:[action][:own].
-- Source of truth: 00-governance/security-policy.md -> "Permission catalog".
-- ":own" = the same action restricted to the caller's own records (checked by the owning service).
INSERT INTO iam.permission (name, description) VALUES
    -- fleet-maintenance
    ('vehicles:read',            'List and view vehicles'),
    ('vehicles:create',          'Register vehicles'),
    ('vehicles:update',          'Edit vehicles and change their status'),
    ('branches:manage',          'Create, edit and delete branches'),
    ('maintenance:create',       'Send a vehicle to maintenance'),
    ('maintenance:update',       'Complete an in-progress maintenance'),
    -- booking-reservation
    ('reservations:create',      'Create reservations'),
    ('reservations:read:own',    'View own reservations'),
    ('reservations:read',        'View all reservations'),
    ('reservations:update:own',  'Modify own reservations'),
    ('reservations:update',      'Modify any reservation'),
    ('reservations:cancel:own',  'Cancel own reservations'),
    ('reservations:cancel',      'Cancel any reservation'),
    ('insurance-types:manage',   'Create and edit insurance types'),
    ('rentals:manage',           'Register rental pickup and return'),
    -- payment-billing
    ('payments:create:own',      'Upload a payment receipt for own reservation'),
    ('payments:read',            'View all payments'),
    ('payments:review',          'Approve or reject payment receipts'),
    ('invoices:read:own',        'View and download own invoices'),
    ('invoices:read',            'View and download all invoices'),
    ('bank-accounts:manage',     'Register, activate and deactivate company bank accounts'),
    -- telemetry-gps
    ('tracking:read',            'View live location and route history of rentals'),
    -- iam
    ('users:read',               'List users'),
    ('users:update-status',      'Unblock or deactivate user accounts'),
    ('roles:grant',              'Change a user''s role');
