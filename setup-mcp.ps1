# Setup script for Godot MCP Server
# This script installs dependencies and builds the MCP server

Write-Host "Setting up Godot MCP Server..." -ForegroundColor Green

# Check if Node.js is installed
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Node.js is not installed. Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Navigate to godot-mcp directory
$mcpPath = Join-Path $PSScriptRoot "godot-mcp"
if (-not (Test-Path $mcpPath)) {
    Write-Host "Error: godot-mcp submodule not found. Please run 'git submodule update --init --recursive'" -ForegroundColor Red
    exit 1
}

Set-Location $mcpPath

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
npm install

# Build the project
Write-Host "Building MCP server..." -ForegroundColor Yellow
npm run build

Set-Location $PSScriptRoot

# Setup environment files
Write-Host ""
Write-Host "Setting up environment files..." -ForegroundColor Yellow

# Create .env file if it doesn't exist
$envFile = Join-Path $PSScriptRoot ".env"
$envExampleFile = Join-Path $PSScriptRoot ".env.example"
if (-not (Test-Path $envFile)) {
    if (Test-Path $envExampleFile) {
        Copy-Item $envExampleFile $envFile
        Write-Host "Created .env file from .env.example" -ForegroundColor Green
        Write-Host "Please edit .env and set your GODOT_PATH" -ForegroundColor Yellow
    }
}

# Create .vscode/mcp.json if it doesn't exist
$mcpJsonFile = Join-Path $PSScriptRoot ".vscode\mcp.json"
$mcpJsonExampleFile = Join-Path $PSScriptRoot ".vscode\mcp.json.example"
if (-not (Test-Path $mcpJsonFile)) {
    if (Test-Path $mcpJsonExampleFile) {
        Copy-Item $mcpJsonExampleFile $mcpJsonFile
        Write-Host "Created .vscode/mcp.json from mcp.json.example" -ForegroundColor Green
        Write-Host "Please edit .vscode/mcp.json and set your GODOT_PATH" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Setup completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Edit .env and set your GODOT_PATH" -ForegroundColor White
Write-Host "  2. Edit .vscode/mcp.json and set your GODOT_PATH" -ForegroundColor White
Write-Host "  3. Run .\start-mcp.ps1 to start the MCP server" -ForegroundColor White
