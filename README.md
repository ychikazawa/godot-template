# Godot Template with MCP Server

This is a Godot project template with integrated Model Context Protocol (MCP) server support.

## Features

- Pre-configured Godot project structure
- Integrated [godot-mcp](https://github.com/Coding-Solo/godot-mcp) as a git submodule
- Easy setup and startup scripts for the MCP server
- Ready to use with GitHub Copilot in VS Code

## Requirements

- [Godot Engine](https://godotengine.org/download) installed on your system
- [Node.js](https://nodejs.org/) (for running the MCP server)
- [VS Code](https://code.visualstudio.com/) with [GitHub Copilot](https://github.com/features/copilot) extension

## Quick Start

### 1. Clone this repository

```bash
git clone <your-repo-url>
cd godot-template
```

### 2. Initialize git submodules

```bash
git submodule update --init --recursive
```

### 3. Setup the MCP server

```powershell
.\setup-mcp.ps1
```

This script will:
- Install all required dependencies
- Build the MCP server
- Create `.env` and `.vscode/mcp.json` from example files

### 4. Configure environment variables

Edit the `.env` file and set your Godot path:

```env
GODOT_PATH=C:\Path\To\Your\Godot.exe
DEBUG=true
```

Also edit `.vscode/mcp.json` and set your Godot path in the `env` section:

```json
{
  "servers": {
    "godot-mcp": {
      "type": "stdio",
      "command": "node",
      "args": [
        "${workspaceFolder}/godot-mcp/build/index.js"
      ],
      "env": {
        "DEBUG": "true",
        "GODOT_PATH": "C:\\Path\\To\\Your\\Godot.exe"
      }
    }
  },
  "inputs": []
}
```

### 5. Start developing with GitHub Copilot!

Open this project in VS Code with GitHub Copilot enabled, and you can use prompts like:
- "Launch the Godot editor for this project"
- "Run my Godot project and show me any errors"
- "Create a new scene with a Player node"
- "Add a Sprite2D node to my player scene"

The MCP server is automatically started when GitHub Copilot needs to interact with Godot.

## Manual MCP Server Start (Optional)

If you want to manually start the MCP server:

```powershell
.\start-mcp.ps1
```

## Project Structure

```
godot-template/
├── godot-mcp/           # MCP server submodule
├── .godot/              # Godot engine files (gitignored)
├── icon.svg             # Project icon
├── project.godot        # Godot project file
├── setup-mcp.ps1        # Setup script for MCP server
├── start-mcp.ps1        # Start script for MCP server
└── README.md            # This file
```

## MCP Server Features

The integrated godot-mcp server provides:
- Launch Godot Editor
- Run Godot Projects in debug mode
- Capture Debug Output
- Control Execution
- Get Godot Version
- List Godot Projects
- Project Analysis
- Scene Management
- UID Management (for Godot 4.4+)

For more details, see [godot-mcp README](godot-mcp/README.md)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
