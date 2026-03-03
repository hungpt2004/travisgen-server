# TravisGen Server Makefile
# Tự động hóa các tác vụ phát triển và documentation

.PHONY: help install dev build start test docs docs-watch docs-open clean prisma-generate prisma-migrate

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

## help: Hiển thị các lệnh có sẵn
help:
	@echo "$(BLUE)TravisGen Server - Available Commands$(NC)"
	@echo ""
	@echo "$(GREEN)Development:$(NC)"
	@echo "  make install          - Cài đặt dependencies"
	@echo "  make dev              - Chạy server ở chế độ development"
	@echo "  make build            - Build production"
	@echo "  make start            - Chạy production server"
	@echo "  make test             - Chạy tests"
	@echo ""
	@echo "$(GREEN)Documentation:$(NC)"
	@echo "  make docs             - Generate API documentation từ Swagger"
	@echo "  make docs-watch       - Auto-generate docs khi có thay đổi"
	@echo "  make docs-open        - Mở docs trong browser/explorer"
	@echo "  make docs-server      - Start local docs server"
	@echo ""
	@echo "$(GREEN)Database:$(NC)"
	@echo "  make prisma-generate  - Generate Prisma client"
	@echo "  make prisma-migrate   - Run database migrations"
	@echo "  make prisma-studio    - Open Prisma Studio"
	@echo ""
	@echo "$(GREEN)Utilities:$(NC)"
	@echo "  make clean            - Xóa các file build và cache"
	@echo "  make format           - Format code với Prettier"
	@echo "  make lint             - Lint code với ESLint"
	@echo ""

## install: Cài đặt dependencies
install:
	@echo "$(BLUE)📦 Installing dependencies...$(NC)"
	npm install
	@echo "$(GREEN)✅ Dependencies installed successfully$(NC)"

## dev: Chạy development server
dev:
	@echo "$(BLUE)🚀 Starting development server...$(NC)"
	npm run start:dev

## build: Build project
build:
	@echo "$(BLUE)🔨 Building project...$(NC)"
	npm run build
	@echo "$(GREEN)✅ Build completed$(NC)"

## start: Chạy production server
start: build
	@echo "$(BLUE)🚀 Starting production server...$(NC)"
	npm run start:prod

## test: Chạy tests
test:
	@echo "$(BLUE)🧪 Running tests...$(NC)"
	npm test

## docs: Generate API documentation
docs:
	@echo "$(BLUE)📚 Generating API documentation...$(NC)"
	@echo "$(YELLOW)⚠️  Make sure the server is running on port 4000$(NC)"
	@node scripts/generate-api-docs.js
	@echo "$(GREEN)✅ Documentation generated successfully!$(NC)"
	@echo "$(BLUE)💡 Open the 'docs' folder in Obsidian to view$(NC)"

## docs-watch: Auto-generate docs khi phát hiện thay đổi
docs-watch:
	@echo "$(BLUE)👀 Watching for changes and auto-generating docs...$(NC)"
	@echo "$(YELLOW)⚠️  Make sure the server is running on port 4000$(NC)"
	@echo "$(GREEN)Press Ctrl+C to stop$(NC)"
	@while true; do \
		node scripts/generate-api-docs.js; \
		echo "$(GREEN)✅ Docs updated. Waiting 30 seconds...$(NC)"; \
		sleep 30; \
	done

## docs-open: Mở thư mục docs
docs-open:
	@echo "$(BLUE)📂 Opening docs folder...$(NC)"
	@if [ "$(OS)" = "Windows_NT" ]; then \
		explorer docs; \
	else \
		open docs 2>/dev/null || xdg-open docs 2>/dev/null || echo "Please open docs/ folder manually"; \
	fi

## docs-server: Start một server đơn giản để xem docs
docs-server:
	@echo "$(BLUE)🌐 Starting documentation server...$(NC)"
	@echo "$(GREEN)Documentation available at: http://localhost:8080$(NC)"
	@cd docs && python -m http.server 8080 2>/dev/null || npx http-server -p 8080

## prisma-generate: Generate Prisma client
prisma-generate:
	@echo "$(BLUE)🔧 Generating Prisma client...$(NC)"
	npx prisma generate
	@echo "$(GREEN)✅ Prisma client generated$(NC)"

## prisma-migrate: Run database migrations
prisma-migrate:
	@echo "$(BLUE)🗄️  Running database migrations...$(NC)"
	npx prisma migrate dev
	@echo "$(GREEN)✅ Migrations completed$(NC)"

## prisma-studio: Open Prisma Studio
prisma-studio:
	@echo "$(BLUE)🎨 Opening Prisma Studio...$(NC)"
	npx prisma studio

## format: Format code
format:
	@echo "$(BLUE)✨ Formatting code...$(NC)"
	npm run format
	@echo "$(GREEN)✅ Code formatted$(NC)"

## lint: Lint code
lint:
	@echo "$(BLUE)🔍 Linting code...$(NC)"
	npm run lint
	@echo "$(GREEN)✅ Linting completed$(NC)"

## clean: Xóa build artifacts và cache
clean:
	@echo "$(BLUE)🧹 Cleaning build artifacts...$(NC)"
	@rm -rf dist node_modules/.cache
	@echo "$(GREEN)✅ Cleaned successfully$(NC)"

## dev-with-docs: Chạy dev server và auto-generate docs
dev-with-docs:
	@echo "$(BLUE)🚀 Starting dev server with auto-doc generation...$(NC)"
	@echo "$(GREEN)Server will start, then docs will auto-generate every 30s$(NC)"
	@(make dev &); sleep 10; make docs-watch
