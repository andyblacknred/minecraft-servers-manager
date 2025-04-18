# 🎮 Minecraft Server Manager

A lightweight, script-based manager for running and maintaining your own Minecraft server.

It automates the process of preparing the environment, downloading the correct server version, generating configuration files, and creating backups — all through clean and modular batch scripts.

---

## ✅ Features

- Automatically downloads and caches `server.jar` for your selected version
- Generates and updates key configuration files (`server.properties`, etc.)
- Prepares the world folder structure on first launch
- Creates timestamped backups with version tracking
- Uses a central `config.ini` for easy customization

---

## 💻 Platform

- ✅ **Tested on:** Windows 11
- ❌ Not designed for WSL / Linux / macOS
- 📁 All logic is implemented via `.bat` scripts and Windows paths

---

## 🚀 Getting Started

1. **Download or clone** this repository.
2. **Edit `config.ini`** to define:
    - Minecraft version
    - World name
    - RAM allocation
    - Port, etc.
3. **Run `start.bat`**:
    - Downloads correct `server.jar` version (if missing)
    - Prepares build folder and configs
    - Launches the server
4. **Run `backup.bat`** anytime to create a snapshot of your world.
5. **Run `versions.bat`** to see a list of official Minecraft versions (including snapshots).

---

## ⚠ IMPORTANT

**Do NOT run these helper scripts directly.**  
They require `BASE_DIR` and other environment variables to be loaded first via `load-env.bat`.

### ✅ Instead, always use the main entry point scripts:

- `start.bat`
- `backup.bat`

These entry points handle environment setup and ensure correct execution context.

---

## ⚠ WARNING

**It is NOT recommended to edit `config.ini` after a world has been created** (i.e., once the folder `build/<WORLD_NAME>/` exists).

Changing world parameters such as:
- `WORLD_NAME`
- `VERSION`
- `PORT`

...may lead to unexpected behavior, corruption, or runtime errors.

> If you still choose to proceed — make sure you know what you're doing.

---

**Author:** andyblacknred  
**Version:** 1.0.1
