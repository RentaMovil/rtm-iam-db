DELETE rp
FROM iam.role_permission rp
JOIN iam.role r ON r.role_id = rp.role_id
WHERE r.name IN ('CLIENT', 'ADMIN', 'SUPER_ADMIN');
