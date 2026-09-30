-- The 3 fixed roles (00-governance/security-policy.md). Never add a role without changing that policy.
INSERT INTO iam.role (name, description) VALUES
    ('CLIENT',      'End user who reserves and pays for vehicles'),
    ('ADMIN',       'Business administrator: fleet, maintenance, reservations, rentals, payments and invoices'),
    ('SUPER_ADMIN', 'System administrator: everything ADMIN can do, plus user access and bank accounts');
