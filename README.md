# DockerTaskApp

A containerized Flask web application with PostgreSQL, created to demonstrate Docker best practices including multi-stage builds, non-root execution, health checks, Docker Compose, and persistent database storage.

## Project Overview

DockerTaskApp is a simple Flask web application running in a Docker container alongside a PostgreSQL database.

The project demonstrates:

- Multi-stage Docker build
- Small production image
- Non-root container execution
- Docker Compose
- PostgreSQL integration
- Container health checks
- Persistent PostgreSQL volume
- Build and runtime evidence

## Technologies Used

- Python 3.12
- Flask
- Gunicorn
- PostgreSQL 16
- Docker
- Docker Compose
- Alpine Linux

## Project Structure

```text
DockerTaskApp/
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── evidence/
│   ├── build-log.txt
│   ├── container-health.txt
│   ├── image-size.txt
│   ├── non-root.txt
│   └── persistence.txt
│
├── .dockerignore
├── Dockerfile
├── docker-compose.yml
└── README.md
Dockerfile Features

The Dockerfile uses a two-stage build:

Builder stage
Installs Python dependencies.
Production stage
Uses Python Alpine.
Copies only the required dependencies and application.
Runs the application as a non-root user.

The application container runs as:

appuser
Image Size

The final Docker image was optimized to:

83.9 MB

This is below the required 150 MB limit.

Running the Application

Start the application and PostgreSQL database using:

docker compose up -d

Check container status:

docker compose ps

Both services should show a healthy status.

Application Endpoints
Home
http://localhost:5000/

Returns the application status.

Health Check
http://localhost:5000/health

Returns:

{
  "status": "healthy"
}
Information
http://localhost:5000/info

Returns application information.

Health Checks

The project includes health checks for both services.

Web Container

The web container checks:

http://localhost:5000/health
PostgreSQL Container

PostgreSQL uses:

pg_isready

to verify database availability.

PostgreSQL Persistence

PostgreSQL data is stored using a Docker named volume:

volumes:
  postgres_data:

The volume is mounted to:

/var/lib/postgresql/data

Persistence was verified by:

Creating data in PostgreSQL.
Restarting the PostgreSQL container.
Querying the data again.
Confirming that the data remained available.

Example:

Docker volume persistence works!
Non-Root Security

The application container does not run as root.

The Dockerfile creates:

appuser

and switches to that user using:

USER appuser

This was verified using Docker inspection.

Evidence

The evidence/ directory contains proof of the Docker implementation:

Evidence File	Purpose
build-log.txt	Docker image build output
image-size.txt	Final Docker image size
container-health.txt	Web and PostgreSQL health status
non-root.txt	Verification of non-root execution
persistence.txt	PostgreSQL persistence verification
Useful Commands

Build the image:

docker build -t dockertaskapp:1.0 .

Start services:

docker compose up -d

Check services:

docker compose ps

View logs:

docker compose logs

Stop services:

docker compose down

Do not use docker compose down -v when you want to preserve PostgreSQL data because removing the volume will delete the persisted database data.

Conclusion

DockerTaskApp demonstrates a lightweight and secure containerized Flask application with PostgreSQL. The implementation includes a multi-stage Docker build, an image below 150 MB, non-root execution, health checks, Docker Compose orchestration, and verified PostgreSQL volume persistence.