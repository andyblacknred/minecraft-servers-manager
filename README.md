# 🛠 HELPERS DIRECTORY — DO NOT RUN DIRECTLY

`src/scripts/helpers/` — this folder contains low-level helper scripts used by higher-level batch files (e.g., `start.bat`, `backup.bat`).

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
**Version:** 1.0
