# Start script for Godot MCP Server
# This script starts the MCP server for this Godot project

$projectRoot = $PSScriptRoot
$mcpPath = Join-Path $projectRoot "godot-mcp"
$buildPath = Join-Path $mcpPath "build\index.js"

# Check if build exists
if (-not (Test-Path $buildPath)) {
    Write-Host "Error: MCP server not built. Please run .\setup-mcp.ps1 first" -ForegroundColor Red
    exit 1
}

# Load environment variables from .env file
$envFile = Join-Path $projectRoot ".env"
if (Test-Path $envFile) {
    Write-Host "Loading environment variables from .env..." -ForegroundColor Cyan
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            if ($value) {
                Set-Item -Path "env:$name" -Value $value
                Write-Host "  Set $name" -ForegroundColor Gray
            }
        }
    }
} else {
    Write-Host "Warning: .env file not found. Using default environment variables." -ForegroundColor Yellow
    Write-Host "Please create .env file from .env.example and set your GODOT_PATH" -ForegroundColor Yellow
}

# Set default DEBUG if not set
if (-not $env:DEBUG) {
    $env:DEBUG = "true"
}

# Check if GODOT_PATH is set
if (-not $env:GODOT_PATH) {
    Write-Host "Error: GODOT_PATH environment variable is not set." -ForegroundColor Red
    Write-Host "Please set GODOT_PATH in .env file or as an environment variable." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Starting Godot MCP Server..." -ForegroundColor Green
Write-Host "Project root: $projectRoot" -ForegroundColor Cyan
Write-Host "Godot path: $env:GODOT_PATH" -ForegroundColor Cyan
Write-Host ""

# Start the MCP server
node $buildPath
