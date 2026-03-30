# EBP06-2026-I

Proyecto de Fabrica Escuela orientado a la gestion de finanzas personales.

## Descripcion

Este proyecto forma parte de la estrategia Fabrica Escuela, donde estudiantes trabajan en equipo bajo Scrum para desarrollar una plataforma web de finanzas personales.

El objetivo es permitir a usuarios registrar, organizar y analizar su informacion financiera para tomar decisiones mas informadas.

## Contexto del problema

Muchas personas tienen dificultades para entender sus habitos financieros, lo que afecta ahorro y planificacion.

La plataforma busca resolver esto permitiendo:
- Visualizar ingresos y gastos con claridad.
- Entender patrones de consumo.
- Tomar decisiones financieras mas conscientes.

## Funcionalidades objetivo

- Registrar ingresos y gastos personales.
- Clasificar transacciones por categorias.
- Gestionar presupuestos mensuales.
- Calcular balances financieros.
- Generar reportes de habitos de consumo.
- Proveer recomendaciones basicas de salud financiera.

## 🛠️ Stack tecnológico y Herramientas

### Frontend
- **React:** Biblioteca para interfaces de usuario.
- **Vite:** Herramienta de desarrollo ultrarrápida.
- **TypeScript:** Tipado estático preventivo para mayor robustez en el código.
- **Tailwind CSS v4:** Motor de estilos mediante clases utilitarias, integrado de forma nativa e incluyendo la paleta de colores institucional del proyecto.

### Backend
- **Spring Boot:** Framework base para desarrollo ágil en Java.
- **Spring Data JPA / Hibernate:** Gestión de base de datos mediante Object-Relational Mapping (ORM).
- **PostgreSQL:** Motor de base de datos relacional.

### Arquitectura Monorepo y Entorno
- **Turborepo (`turbo`):** Orquestador de tareas que ejecuta procesos en paralelo (ej. arrancar frontend y backend juntos) y cachea compilaciones para ahorrar tiempo.
- **pnpm workspaces:** Gestor de dependencias altamente optimizado, ideal para conectar distintas aplicaciones en el mismo repositorio sin duplicar paquetes.
- **Docker Compose:** Virtualización de infraestructura local para levantar el ecosistema completo con un par de comandos.

### CI/CD
- **GitHub Actions:** Pipeline de integración continua dedicado a ejecutar pruebas automáticas.
- **Despliegues:** El frontend se despliega a Vercel desde GitHub Actions cuando la rama pasa tests: `develop` va a `preview` y `main` va a `production`; el backend usa Railway Watch con `Wait for CI`.
- **Secrets necesarios en GitHub Actions:** `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`.
- **Documentación:** Ver [docs/guides/ci-cd.md](docs/guides/ci-cd.md) para detalles de configuración y flujos.

### Agentes IA / Automatización
- **Propósito:** Reglas, políticas y *skills* para agentes de IA que ayudan en tareas repetitivas (generación de PRs, plantillas de código, refactors guiados).
- **Dónde leer:** Revisa `AGENTS.md` y el registro de skills en `.agents/skills/registry.md`.
- **Reglas rápidas:** Nunca subir secretos; leer la skill correspondiente (`design-patterns-frontend` o `design-patterns-backend`) antes de generar cambios en esa área; mantener cambios pequeños y añadir/actualizar tests si se modifica comportamiento.
- **Alcance:** Los agentes IA solo generan y sugieren cambios; no realizan despliegues ni manejan credenciales.

## Como trabajamos con IA y Figma Make

- **Gobernanza IA:** Toda ejecucion asistida por agentes debe seguir [`AGENTS.md`](AGENTS.md).
- **Skills locales:** El inventario operativo vive en [`.agents/skills/registry.md`](.agents/skills/registry.md).
- **Handoff UI:** Para tickets de interfaz originados en Figma Make, usar [`docs/guides/figma-make-handoff.md`](docs/guides/figma-make-handoff.md) y la skill `.agents/skills/figma-make-handoff/SKILL.md`.
- **Regla de oro:** Figma Make define la intencion visual; la implementacion final debe cumplir patrones de arquitectura, pruebas y calidad del repositorio.

## Estructura del repositorio

.
|- apps/
|  |- frontend/
|  \- backend/
|- packages/
|- infra/
|- docs/
|  |- architecture/
|  \- guides/
|- .agents/
|  \- skills/
|- .github/workflows/
|- dev-start.sh
\- docker-compose.yml

## Desarrollo local

1. Copia .env.example a .env.
2. Ejecuta:

```bash
./dev-start.sh
```

URLs por defecto:
- Frontend: http://localhost:3000
- Backend health: http://localhost:8080/api/health
- PostgreSQL: localhost:5432

Para detener todo:

```bash
./dev-stop.sh
```

## 💻 Comandos de Terminal (Scripts del Monorepo)

Gracias a la combinación de **pnpm workspaces** y **Turborepo**, puedes controlar todo el proyecto desde la raíz. Aquí tienes los comandos por consola más útiles para el día a día:

### Generales (Afectan a todo el proyecto)
- `pnpm dev` Levanta **simultáneamente** el frontend y backend.
- `pnpm build` Compila todo el monorepo (usando la caché de Turborepo para mayor velocidad).
- `pnpm lint` Revisa reglas de sintaxis y buenas prácticas en todo el código.
- `pnpm test` Ejecuta las pruebas automatizadas globales.

### Específicos (Solo Frontend o Backend)
Útiles si solo quieres trabajar en una de las partes:
- `pnpm dev:frontend` Levanta **únicamente** la app de React/Vite. Podrías hacerlo también con `pnpm --filter frontend dev`.
- `pnpm dev:backend` Levanta **únicamente** el servidor de Spring Boot. Podrías hacerlo también con `pnpm --filter backend dev`.
- Para añadir un paquete solo a frontend: `pnpm --filter frontend add <paquete>`

### Infraestructura y Base de Datos (Docker)
- `pnpm db:up` Levanta el contenedor local de PostgreSQL en segundo plano.
- `pnpm db:down` Detiene y destruye el contenedor de PostgreSQL.
- `pnpm db:logs` Muestra los registros de la base de datos en tiempo real.

## Flujo de ramas

- develop: rama de integracion y despliegue de entorno dev.
- main: rama estable, sin despliegue productivo automatico por ahora.
- feature/*: trabajo de funcionalidades.

## CI/CD

- GitHub Actions: ejecuta `pnpm test` en pull requests y pushes a `develop` y `main`.
- Frontend: despliegue a Vercel desde GitHub Actions despues de un push exitoso, usando `preview` para `develop` y `production` para `main`.
- Backend: Railway Watch con `Wait for CI`.
- Main: despliega frontend a produccion solo si `Tests` pasa.

Mas detalle en docs/guides/ci-cd.md.

## Metodologia de trabajo

Se usa Scrum con:
- Product Backlog en Issues.
- Planificacion por sprints.
- Seguimiento continuo.
- Entregas incrementales.

## Contribucion

1. Crear rama desde develop.
2. Implementar cambio.
3. Crear commits atomicos con Conventional Commits en espanol:
  - Formato: tipo(alcance): descripcion
  - Tipos recomendados: feat, fix, docs, test, refactor, chore
  - Regla: un cambio logico por commit, sin mezclar intenciones
4. Crear Pull Request hacia develop.
5. Esperar revision y CI en verde.

## Notas

- No subir secretos ni credenciales.
- Priorizar configuracion por variables de entorno.
- Mantener cambios acotados y consistentes con patrones del proyecto.
