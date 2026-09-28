# rtm-iam-db

Migraciones Liquibase de las tablas del servicio **IAM** de RentaMovil.

- **Base de datos:** `rentamovil` (SQL Server), **compartida** por todos los servicios.
- **Schema propio:** `iam` — toda tabla de este repo se crea como `iam.<tabla>`. Ninguna tabla va en `dbo`.
- **Tablas:** `person`, `user`, `role`, `permission`, `role_permission`, `verification_code`, `session`.
- **Historial Liquibase propio:** `dbo.DATABASECHANGELOG_IAM` / `dbo.DATABASECHANGELOGLOCK_IAM`.
- **Orden entre repos:** `rtm-iam-db` corre **primero** — otros servicios tienen FKs hacia `iam.[user]` / `iam.person`.

Convenciones completas (estructura, nombres, orden, rollback): `rtm-docs/06-data/migration-strategy.md`.

## Estructura

```
changelog/changelog-master.yaml   ← punto de entrada: incluye 01_ddl → 02_dml → 03_dcl → 04_tcl
01_ddl/                           DDL
  01_schemas/                       CREATE SCHEMA iam
  03_tables/                        CREATE TABLE, sin FKs
  04_alter/                         FKs y demás ALTER
  10_indexes/                       CREATE INDEX
02_dml/00_inserts/                DML: datos de referencia (roles, permisos)
03_dcl/00_roles, 01_grants/       DCL: usuario de BD del servicio y sus permisos
04_tcl/02_release_tags/           Tags de versión (tagDatabase)
05_rollbacks/                     Espejo de 01_ddl/02_dml: un .rollback.sql por cada .sql
```

Cada carpeta hoja tiene:
- `NNN_descripcion.sql` — el SQL real (dialecto SQL Server).
- `changelog.yaml` — un `changeSet` por `.sql`, con su `rollback` apuntando a `05_rollbacks/`.

## Requisitos

- Java 17+
- Maven 3.9+
- Docker Desktop

## Uso local

```bash
# 1. Configuración local (una sola vez)
cp .env.example .env
cp liquibase.properties.example liquibase.properties
# edita la contraseña en los dos archivos (deben coincidir)

# 2. Levantar SQL Server y crear la base rentamovil
docker compose up -d

# 3. Ver qué changesets faltan
mvn liquibase:status

# 4. Ver el SQL sin ejecutarlo
mvn liquibase:updateSQL

# 5. Aplicar
mvn liquibase:update
```

Otros comandos:

```bash
mvn liquibase:rollback -Dliquibase.rollbackCount=1   # deshace el último changeset
docker compose down                                  # detiene SQL Server (los datos quedan)
docker compose down -v                               # detiene y BORRA los datos
```

## Ramas

`feat/`, `fix/`, `chore/` → PR a `develop` (Squash and Merge). Ver
`rtm-docs/00-governance/git-conventions.md`.
