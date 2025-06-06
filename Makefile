# Project management commands for CTO Digital Twin
.PHONY: install run test lint clean build deploy start-qdrant start-qdrant-cloud

# Environment variables
PYTHON=python3
PIP=$(PYTHON) -m pip
PYTEST=$(PYTHON) -m pytest
BACKEND_DIR=backend
FRONTEND_DIR=frontend
CURRENT_DIR=$(shell pwd)

# Qdrant configuration (can be overridden via environment)
QDRANT_HOST ?= localhost
QDRANT_PORT ?= 6333
QDRANT_CLOUD_URL ?= 
QDRANT_API_KEY ?= 

# Install all dependencies
install: install-backend install-frontend

install-backend:
	cd $(BACKEND_DIR) && \
	$(PIP) install -r requirements.txt

install-frontend:
	cd $(FRONTEND_DIR) && \
	npm install

# Run the application
run: run-backend run-frontend

run-backend:
	cd $(BACKEND_DIR) && \
	uvicorn main:app --reload --host 0.0.0.0 --port 8000

run-frontend:
	cd $(FRONTEND_DIR) && \
	npm run dev

# Testing
test: test-backend test-frontend

test-backend:
	cd $(BACKEND_DIR) && \
	$(PYTEST) tests/

test-frontend:
	cd $(FRONTEND_DIR) && \
	npm run test

# Linting
lint: lint-backend lint-frontend

lint-backend:
	cd $(BACKEND_DIR) && \
	flake8 . && \
	black . --check && \
	isort . --check-only

lint-frontend:
	cd $(FRONTEND_DIR) && \
	npm run lint

# Clean build artifacts
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name "node_modules" -exec rm -rf {} +
	find . -type d -name "dist" -exec rm -rf {} +
	find . -type d -name "build" -exec rm -rf {} +

# Build for production
build: build-backend build-frontend

build-backend:
	cd $(BACKEND_DIR) && \
	$(PYTHON) -m build

build-frontend:
	cd $(FRONTEND_DIR) && \
	npm run build

# Deploy (customize based on your deployment strategy)
deploy: build
	@echo "Deploying application..."
	# Add your deployment commands here

# Initialize knowledge base
init-knowledge:
	cd $(BACKEND_DIR) && \
	$(PYTHON) scripts/init_knowledge_base.py

# Run evaluation harness
evaluate:
	cd $(BACKEND_DIR) && \
	$(PYTHON) scripts/run_evaluation.py

# Helper to setup development environment
setup-dev: install
	pre-commit install
	@echo "Development environment setup complete"

# Helper to update all dependencies
update-deps:
	cd $(BACKEND_DIR) && $(PIP) install --upgrade -r requirements.txt
	cd $(FRONTEND_DIR) && npm update

# Start Qdrant vector store (Docker-based)
start-qdrant:
	@if command -v docker >/dev/null 2>&1; then \
		if ! docker info > /dev/null 2>&1; then \
			echo "Docker daemon is not running. Please start Docker daemon first."; \
			echo "Contact your organization's IT support for the correct way to start Docker."; \
			exit 1; \
		fi; \
		mkdir -p "$(CURRENT_DIR)/qdrant_storage" && \
		docker run -d --name qdrant \
			-p $(QDRANT_PORT):6333 \
			-v "$(CURRENT_DIR)/qdrant_storage":/qdrant/storage \
			qdrant/qdrant:latest; \
	else \
		echo "Docker is not available. Please use make start-qdrant-cloud instead."; \
		exit 1; \
	fi

# Configure Qdrant Cloud connection
start-qdrant-cloud:
	@if [ -z "$(QDRANT_CLOUD_URL)" ] || [ -z "$(QDRANT_API_KEY)" ]; then \
		echo "Please set QDRANT_CLOUD_URL and QDRANT_API_KEY environment variables."; \
		echo "You can get these from your Qdrant Cloud dashboard."; \
		exit 1; \
	fi
	@echo "Using Qdrant Cloud configuration:"
	@echo "URL: $(QDRANT_CLOUD_URL)"
	@echo "API Key: ****$(shell echo $(QDRANT_API_KEY) | tail -c 4)"

# Default target
all: install build test 