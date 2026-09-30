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
  05_views/                         CREATE VIEW
  10_indexes/                       CREATE INDEX
02_dml/                           DML
  00_inserts/                       datos de referencia (roles, permisos)
  01_updates/                       backfills y correcciones de datos
  02_deletes/                       eliminación de datos
03_dcl/                           DCL
  00_roles/                         usuario de BD del servicio
  01_grants/                        permisos sobre el schema iam
04_tcl/                           TCL
  02_release_tags/                  tags de versión (tagDatabase)
05_rollbacks/                     espejo de 01_ddl … 03_dcl: un .rollback.sql por cada .sql
```

Todas estas carpetas existen aunque estén vacías: una carpeta sin changesets tiene
`databaseChangeLog: []` en su `changelog.yaml` (y `.gitkeep` en su espejo de `05_rollbacks`).
Los huecos en la numeración son a propósito — el porqué de cada carpeta que no existe está en
`rtm-docs/06-data/migration-strategy.md`.

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
# edita la contraseña de sa en los dos archivos (deben coincidir)
# y pon en liquibase.properties una contraseña para iam_app (parameter.iamAppPassword)

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

## Usuario de base de datos del servicio (`03_dcl`)

Las migraciones corren con `sa`. El servicio `rtm-iam` **nunca** usa `sa`: se conecta con
`iam_app`, que solo puede leer y escribir datos del schema `iam` (sin DDL, sin acceso a otros
schemas ni a `dbo`). Su contraseña **no está en el repo**: sale de `parameter.iamAppPassword` en
`liquibase.properties` (git-ignored). Si falta, el changeset falla a propósito.

> Al usar parámetros, el plugin de Maven imprime un `NoSuchFieldException: The field
> 'parameter.iamAppPassword' could not be found...` con stack trace. Es inofensivo: el plugin
> intenta leerlo como opción propia y después lo usa correctamente como parámetro. Lo que importa
> es el `BUILD SUCCESS` final.

## Primer SUPER_ADMIN de cada entorno (paso manual, una sola vez)

Solo un `SUPER_ADMIN` puede dar roles, y el registro público (`POST /register`) siempre crea
`CLIENT`. En una base nueva nadie puede llegar a `SUPER_ADMIN`, así que el primero se crea a mano:

1. La persona que será administradora se registra normalmente en `rtm-iam` (`POST /register`).
2. Alguien con acceso `sa` a la base ejecuta, **una sola vez por entorno**:

```sql
UPDATE iam.[user]
SET role_id = (SELECT role_id FROM iam.role WHERE name = 'SUPER_ADMIN')
WHERE username = '<su_username>';
```

3. Esa persona cierra sesión y vuelve a entrar: el token nuevo ya trae el rol `SUPER_ADMIN` y sus
   25 permisos. Desde ahí, los demás roles se dan con `PATCH /users/{id}/role`.

No se automatiza con un changeset a propósito: así no hay contraseñas de administrador ni hashes
en el repositorio.

## Ramas

`feat/`, `fix/`, `chore/` → PR a `develop` (Squash and Merge). Ver
`rtm-docs/00-governance/git-conventions.md`.
