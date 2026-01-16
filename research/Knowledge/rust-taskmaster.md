# Rust TaskMaster Tools

This document summarizes the key features and usage instructions for the `rust-taskmaster` toolkit, which is designed to enhance Rust project development with TaskMaster AI.

## Overview

The `rust-taskmaster` repository provides a collection of reusable tools, configurations, and automation scripts to streamline the use of TaskMaster AI in Rust projects. It focuses on optimizing the development workflow, managing the Rust build cache, and providing a standardized project setup.

## Key Features

-   **Automated Rust Cache Management:** Integrates with `rskiller` to provide scheduled cleanup of the Rust build cache, helping to free up disk space.
-   **Automated Development Environment Setup:** Provides scripts to automate the configuration of the development environment and dependencies.
-   **TaskMaster Integration:** Offers a one-command setup for initializing TaskMaster in Rust projects, along with pre-configured settings for optimal development.
-   **Project Templates:** Includes a ready-to-use Rust project template with TaskMaster integration.

## Quick Start

The recommended way to use the `rust-taskmaster` toolkit is to add it as a git submodule to your project.

### 1. Add as Submodule
```bash
# Add the repository as a submodule
git submodule add https://github.com/jhfnetboy/rust-taskmaster.git tools/rust-taskmaster

# Initialize the submodule
git submodule update --init --recursive
```

### 2. Copy Tools (Optional)
```bash
# Copy the scripts and templates to your project
cp tools/rust-taskmaster/scripts/* scripts/
cp tools/rust-taskmaster/templates/* templates/
```

### 3. Setup Automation
```bash
# Set up automated cache cleaning
chmod +x scripts/setup-rust-automation.sh
./scripts/setup-rust-automation.sh
```

### 4. Initialize TaskMaster
```bash
# Install TaskMaster AI globally
npm install -g task-master-ai

# Initialize in your Rust project
task-master init
```

## Daily Usage

-   **`task-master list`**: See all tasks.
-   **`task-master next`**: Get the next task to work on.
-   **`task-master set-status --id=<id> --status=<status>`**: Update the status of a task.
-   **`task-master show <id>`**: Get the details of a task.

## Directory Structure

The `rust-taskmaster` repository has the following structure:

```
rust-taskmaster/
├── scripts/
│   ├── rust-clean.sh
│   ├── setup-rust-automation.sh
│   └── package-rust-template.sh
├── templates/
│   └── rust-project-template.md
├── docs/
│   ├── Rust-Cache-Management.md
│   ├── TaskMaster-Setup-Guide.md
│   └── Quick-Setup-Commands.md
└── README.md
```