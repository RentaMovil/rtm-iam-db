# rtm-iam-db

Migraciones Liquibase de las tablas del servicio **IAM** de RentaMovil.

- Base de datos: **`rentamovil`** (SQL Server), **compartida** por todos los servicios. Este repo
  solo gestiona las tablas de IAM: `person`, `user`, `role`, `permission`, `role_permission`,
  `verification_code`, `session`.
- Historial propio: `DATABASECHANGELOG_IAM` / `DATABASECHANGELOGLOCK_IAM`, para no chocar con las
  migraciones de los otros servicios (`rtm-*-db`) en la misma base.
- Orden: **`rtm-iam-db` se ejecuta antes que los demás `-db`**, porque otras tablas referencian a
  `user` / `person`.
- Reglas de migración: `rtm-docs/06-data/migration-strategy.md` (forward-only, 2 fases para cambios
  incompatibles, seeds aparte).

## Requisitos

- Java 17+
- Maven 3.9+
- Docker Desktop

## Estructura

```
src/main/resources/db/changelog/
├── db.changelog-master.yml   ← incluye changes/ y luego seed/
├── changes/                  ← cambios estructurales: 001-create-....xml, 002-...
└── seed/                     ← datos de referencia: S001-seed-roles.xml, ...
```

## Uso local

```bash
# 1. Configuración local (una sola vez)
cp .env.example .env
cp liquibase.properties.example liquibase.properties

# 2. Levantar SQL Server y crear la base rentamovil
docker compose up -d

# 3. Ver qué migraciones faltan por aplicar
mvn liquibase:status

# 4. Aplicar migraciones
mvn liquibase:update
```

Otros comandos útiles:

```bash
mvn liquibase:updateSQL       # muestra el SQL que se ejecutaría, sin aplicarlo
mvn liquibase:rollbackCount -Dliquibase.rollbackCount=1
docker compose down           # detiene SQL Server (los datos quedan en el volumen)
docker compose down -v        # detiene y BORRA los datos
```

## Ramas

`feat/`, `fix/`, `chore/` → PR a `develop` (Squash and Merge). Ver
`rtm-docs/00-governance/git-conventions.md`.
