# N8N Docker Setup with FFmpeg, Typhoon OCR, and Ollama

Complete Docker setup for N8N workflow automation platform with integrated FFmpeg, Typhoon OCR, and Ollama LLM capabilities.

## Features

- **N8N Workflow Automation** - Visual workflow builder and automation platform
- **FFmpeg Integration** - Complete video/audio processing capabilities
- **Typhoon OCR** - Thai language optimized OCR text recognition
- **Ollama LLM** - Run large language models locally
- **Font Support** - Custom font integration with automatic cache generation
- **Persistent Storage** - Data persistence across container restarts
- **Flexible Volume Mounting** - Easy integration with external directories

## Tech Stack

- **Containerization**: Docker, Docker Compose
- **Workflow Automation**: n8n
- **LLM Engine**: Ollama
- **Media Processing**: FFmpeg
- **OCR Engine**: Typhoon OCR (running on Python)
- **PDF Utilities**: Poppler
- **Base Image**: n8nio/n8n (Alpine Linux)

## Prerequisites

- Docker
- Docker Compose

## Project Structure

```
project-directory/
├── Dockerfile
├── docker-compose.yml
├── fonts/                 # Place your custom fonts here
│   ├── font1.ttf
│   └── font2.otf
├── data/                  # Persistent data directory for n8n
├── doc/                   # Document storage directory for n8n
└── ollama_data/           # Persistent storage for Ollama models
```

## Installation & Setup

### 1. Clone or Download Files

Download the `Dockerfile` and `docker-compose.yml` to your project directory.

### 2. Prepare Font Directory (Optional)

If you need custom fonts for text processing:

```bash
mkdir fonts
# Copy your .ttf or .otf font files to the fonts/ directory
```
Link font Kanit form Google Fonts: https://fonts.google.com/specimen/Kanit

### 3. Create Required Directories

```bash
mkdir -p data doc
```

### 4. Build and Start Services

```bash
docker-compose up -d --build
```

## Configuration

### N8N Environment Variables

See `docker-compose.yml` for variables like `N8N_BASIC_AUTH_USER`, `N8N_BASIC_AUTH_PASSWORD`, etc.

- `OLLAMA_BASE_URL=http://ollama:11434`: This new variable is added to the n8n service to ensure it can communicate with the Ollama service.

### Volume Mounts

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `n8n_data` (Docker volume) | `/home/node/.n8n` | N8N configuration and workflows |
| `ollama_data` (Docker volume) | `/root/.ollama` | Ollama models and data |
| `C:/AI/ComfyUI/output` | `/comfy-output` | ComfyUI output integration |
| `./data` | `/data` | General data storage |
| `./doc` | `/doc` | Document processing |

## Access

- **N8N**: http://localhost:5678
- **Ollama API**: http://localhost:11434

## Installed Components

- **N8N Latest**
- **FFmpeg**
- **Typhoon OCR**
- **Ollama**
- **Python 3, Poppler Utils, Font Config**

## Common Operations

### Start/Stop Services
```bash
# Start in detached mode
docker-compose up -d

# Stop services
docker-compose down
```

### View Logs
```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f n8n
docker-compose logs -f ollama
```

### Pulling an Ollama Model

To use a model with Ollama, you first need to pull it. You can do this by running a command inside the running `ollama` container.

1. Find the container name (it's `ollama` by default in the `docker-compose.yml`).
2. Execute the pull command. For example, to pull the `llama3` model:

```bash
docker exec -it ollama ollama pull llama3
```

### Using Ollama in N8N

With the `OLLAMA_BASE_URL` configured, you can now use the Ollama node in your n8n workflows. Point it to the model you have pulled (e.g., `llama3`). The n8n container will communicate with the `ollama` container over the internal Docker network.

## Security Notes

- Change default n8n credentials before production use.
- The Ollama API is unauthenticated and exposed on your local machine. Ensure it is not accessible from untrusted networks.

![Alt text](https://drive.google.com/thumbnail?id=1SelLWikl15lvFumIfws0hyaJWnyhpZWk&sz=w1200)
