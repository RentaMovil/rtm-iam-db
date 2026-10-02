-- URL de la foto de perfil (la imagen vive en Cloudinary; aquí solo se guarda el enlace)
ALTER TABLE iam.person
    ADD image_url VARCHAR(500) NULL;
