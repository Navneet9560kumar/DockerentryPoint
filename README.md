# FastAPI Async Task Queue Application

A production-ready FastAPI application with Docker containerization, PostgreSQL database, and Celery-based asynchronous task processing using Redis.

## Features

- **FastAPI Framework**: Modern, fast web framework for building APIs with Python
- **PostgreSQL Database**: Robust relational database with SQLAlchemy ORM
- **Redis Message Broker**: High-performance in-memory data store
- **Celery Worker**: Distributed task processing for async operations (email sending, etc.)
- **Docker & Docker Compose**: Complete containerization for easy deployment
- **Database Migrations**: Alembic for version control of database schema
- **Health Checks**: Built-in health check endpoints and service readiness probes
- **Hot Reload**: Development mode with auto-reload support

## Project Structure

```
projDoc/
├── main.py              # FastAPI application entry point
├── database.py          # Database configuration and SQLAlchemy setup
├── tasks.py             # Celery task definitions
├── requirements.txt     # Python dependencies
├── Dockerfile           # Container image definition
├── compose.yml          # Docker Compose service orchestration
├── entrypoint.sh        # Container startup script
├── tasks.py             # Async task definitions (Celery)
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

## Prerequisites

- Docker & Docker Compose (recommended)
- Python 3.11+ (for local development)
- PostgreSQL 15+ (if running locally)
- Redis 7+ (if running locally)

## Quick Start with Docker Compose

### 1. Clone and Navigate
```bash
cd projDoc
```

### 2. Create Environment Variables
Create a `.env` file in the project root:
```env
POSTGRES_HOST=db
POSTGRES_USER=admin
POSTGRES_PASSWORD=secret
POSTGRES_DB=mydatabase
DATABASE_URL=postgresql://admin:secret@db:5432/mydatabase
REDIS_URL=redis://redis:6379/0
REDIS_HOST=redis
RUN_MIGRATIONS=true
```

### 3. Start Services
```bash
docker-compose up -d
```

This will start:
- **PostgreSQL Database** on port 5432
- **Redis Broker** on port 6379
- **FastAPI Application** on http://localhost:8000
- **Celery Worker** for async tasks

### 4. Verify Services
```bash
docker-compose ps
```

## API Endpoints

### 1. Home Endpoint
```
GET /
```
Returns the API status.

**Response:**
```json
{
  "status": "FastAPI chal raha hai! 🚀"
}
```

### 2. Health Check
```
GET /health
```
Returns health status.

**Response:**
```json
{
  "status": "ok"
}
```

### 3. Send Email (Async Task)
```
POST /send-email?email=user@example.com
```
Queues an email sending task to Celery.

**Request:**
```bash
curl -X POST "http://localhost:8000/send-email?email=john@example.com"
```

**Response:**
```json
{
  "message": "john@example.com queue mein daal diya",
  "task_id": "abc123def456"
}
```

## Development Setup (Local)

### 1. Install Dependencies
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Configure Environment
Create a `.env` file with local database connection:
```env
DATABASE_URL=postgresql://admin:secret@localhost:5432/mydatabase
REDIS_URL=redis://localhost:6379/0
POSTGRES_HOST=localhost
POSTGRES_USER=admin
POSTGRES_PASSWORD=secret
POSTGRES_DB=mydatabase
REDIS_HOST=localhost
RUN_MIGRATIONS=true
```

### 3. Start Local Services
For PostgreSQL and Redis, either:
- Use Docker Compose (recommended)
- Install and run locally

### 4. Run FastAPI Server
```bash
uvicorn main:app --reload
```

### 5. Run Celery Worker (in separate terminal)
```bash
celery -A tasks worker --loglevel=info
```

## Database Management

### Run Migrations
Migrations run automatically when `RUN_MIGRATIONS=true` in the entrypoint.

### Manual Migration
```bash
alembic upgrade head
```

## Docker Commands

### View Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f api
docker-compose logs -f worker
docker-compose logs -f db
```

### Stop Services
```bash
docker-compose down
```

### Stop and Remove Data
```bash
docker-compose down -v
```

### Rebuild Images
```bash
docker-compose build --no-cache
```

## Technology Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| Python | 3.11 | Programming language |
| FastAPI | 0.111.0 | Web framework |
| SQLAlchemy | 2.0.30 | ORM library |
| Alembic | 1.13.1 | Database migrations |
| PostgreSQL | 15 | Relational database |
| Redis | 7 | Message broker |
| Celery | 5.4.0 | Task queue |
| Uvicorn | 0.29.0 | ASGI server |
| Pydantic | 2.7.1 | Data validation |

## Troubleshooting

### Services not starting?
Check logs:
```bash
docker-compose logs
```

### Database connection error?
Ensure `POSTGRES_HOST` and `REDIS_HOST` environment variables are set correctly.

### Celery tasks not executing?
1. Verify Redis is running: `redis-cli ping`
2. Check worker logs: `docker-compose logs worker`
3. Ensure `RUN_MIGRATIONS=false` for worker service

### Port conflicts?
If port 8000 is in use, modify `compose.yml`:
```yaml
ports:
  - "8001:8000"  # Map to different port
```

## File Descriptions

- **main.py**: FastAPI application with route handlers
- **database.py**: Database engine, session management, and SQLAlchemy base models
- **tasks.py**: Celery app configuration and async task definitions
- **requirements.txt**: All Python package dependencies
- **Dockerfile**: Multi-stage container image for the application
- **compose.yml**: Docker Compose configuration for all services
- **entrypoint.sh**: Startup script for service initialization and health checks
- **.env**: Environment variables (create this file, not in repo)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DATABASE_URL` | postgresql://admin:secret@db:5432/mydatabase | PostgreSQL connection string |
| `REDIS_URL` | redis://redis:6379/0 | Redis connection string |
| `POSTGRES_HOST` | db | PostgreSQL hostname |
| `POSTGRES_USER` | admin | PostgreSQL username |
| `POSTGRES_PASSWORD` | secret | PostgreSQL password |
| `POSTGRES_DB` | mydatabase | PostgreSQL database name |
| `REDIS_HOST` | redis | Redis hostname |
| `RUN_MIGRATIONS` | true | Run database migrations on startup |

## Contributing

1. Create a feature branch
2. Make your changes
3. Test with Docker Compose
4. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues and questions, please open an issue in the repository.

---

**Built with ❤️ using FastAPI, Docker, and Python**
