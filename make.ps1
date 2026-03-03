# TravisGen Server - Build & Docs Scripts
# PowerShell script for Windows

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function Write-ColorOutput($ForegroundColor, $Message) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    Write-Output $Message
    $host.UI.RawUI.ForegroundColor = $fc
}

function Show-Help {
    Write-ColorOutput Blue "========================================="
    Write-ColorOutput Blue "TravisGen Server - Available Commands"
    Write-ColorOutput Blue "========================================="
    Write-Output ""
    Write-ColorOutput Green "Development:"
    Write-Output "  .\make.ps1 install          - Install dependencies"
    Write-Output "  .\make.ps1 dev              - Start development server"
    Write-Output "  .\make.ps1 build            - Build production"
    Write-Output "  .\make.ps1 start            - Start production server"
    Write-Output "  .\make.ps1 test             - Run tests"
    Write-Output ""
    Write-ColorOutput Green "Documentation:"
    Write-Output "  .\make.ps1 docs             - Generate API documentation from Swagger"
    Write-Output "  .\make.ps1 docs-watch       - Auto-generate docs on changes"
    Write-Output "  .\make.ps1 docs-open        - Open docs folder"
    Write-Output "  .\make.ps1 docs-server      - Start local docs server"
    Write-Output ""
    Write-ColorOutput Green "Database:"
    Write-Output "  .\make.ps1 prisma-generate  - Generate Prisma client"
    Write-Output "  .\make.ps1 prisma-migrate   - Run database migrations"
    Write-Output "  .\make.ps1 prisma-studio    - Open Prisma Studio"
    Write-Output ""
    Write-ColorOutput Green "Utilities:"
    Write-Output "  .\make.ps1 clean            - Clean build artifacts and cache"
    Write-Output "  .\make.ps1 format           - Format code with Prettier"
    Write-Output "  .\make.ps1 lint             - Lint code with ESLint"
    Write-Output ""
}

function Install-Dependencies {
    Write-ColorOutput Blue "Installing dependencies..."
    npm install
    Write-ColorOutput Green "Dependencies installed successfully"
}

function Start-Dev {
    Write-ColorOutput Blue "Starting development server..."
    npm run start:dev
}

function Build-Project {
    Write-ColorOutput Blue "Building project..."
    npm run build
    Write-ColorOutput Green "Build completed"
}

function Start-Prod {
    Build-Project
    Write-ColorOutput Blue "Starting production server..."
    npm run start:prod
}

function Run-Tests {
    Write-ColorOutput Blue "Running tests..."
    npm test
}

function Generate-Docs {
    Write-ColorOutput Blue "Generating API documentation..."
    Write-ColorOutput Yellow "Make sure the server is running on port 4000"
    node scripts/generate-api-docs.js
    if ($LASTEXITCODE -eq 0) {
        Write-ColorOutput Green "Documentation generated successfully!"
        Write-ColorOutput Blue "Open the docs folder in Obsidian to view"
    }
}

function Watch-Docs {
    Write-ColorOutput Blue "Watching for changes and auto-generating docs..."
    Write-ColorOutput Yellow "Make sure the server is running on port 4000"
    Write-ColorOutput Green "Press Ctrl+C to stop"
    while ($true) {
        node scripts/generate-api-docs.js
        Write-ColorOutput Green "Docs updated. Waiting 30 seconds..."
        Start-Sleep -Seconds 30
    }
}

function Open-Docs {
    Write-ColorOutput Blue "Opening docs folder..."
    if (Test-Path "docs") {
        Start-Process "docs"
    } else {
        Write-ColorOutput Red "Docs folder not found. Run docs command first."
    }
}

function Start-DocsServer {
    Write-ColorOutput Blue "Starting documentation server..."
    Write-ColorOutput Green "Documentation available at: http://localhost:8080"
    Set-Location docs
    npx http-server -p 8080
}

function Generate-Prisma {
    Write-ColorOutput Blue "Generating Prisma client..."
    npx prisma generate
    Write-ColorOutput Green "Prisma client generated"
}

function Migrate-Prisma {
    Write-ColorOutput Blue "Running database migrations..."
    npx prisma migrate dev
    Write-ColorOutput Green "Migrations completed"
}

function Open-PrismaStudio {
    Write-ColorOutput Blue "Opening Prisma Studio..."
    npx prisma studio
}

function Format-Code {
    Write-ColorOutput Blue "Formatting code..."
    npm run format
    Write-ColorOutput Green "Code formatted"
}

function Lint-Code {
    Write-ColorOutput Blue "Linting code..."
    npm run lint
    Write-ColorOutput Green "Linting completed"
}

function Clean-Build {
    Write-ColorOutput Blue "Cleaning build artifacts..."
    if (Test-Path "dist") { Remove-Item -Recurse -Force dist }
    if (Test-Path "node_modules/.cache") { Remove-Item -Recurse -Force node_modules/.cache }
    Write-ColorOutput Green "Cleaned successfully"
}

# Command router
switch ($Command) {
    "help" { Show-Help }
    "install" { Install-Dependencies }
    "dev" { Start-Dev }
    "build" { Build-Project }
    "start" { Start-Prod }
    "test" { Run-Tests }
    "docs" { Generate-Docs }
    "docs-watch" { Watch-Docs }
    "docs-open" { Open-Docs }
    "docs-server" { Start-DocsServer }
    "prisma-generate" { Generate-Prisma }
    "prisma-migrate" { Migrate-Prisma }
    "prisma-studio" { Open-PrismaStudio }
    "format" { Format-Code }
    "lint" { Lint-Code }
    "clean" { Clean-Build }
    default {
        Write-ColorOutput Red "Unknown command: $Command"
        Write-Output ""
        Show-Help
    }
}
