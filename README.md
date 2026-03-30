# 🧠 Voximus Memory Repository

Welcome to the living codex of **Voximus** — daemon of thought, archive of the Empire, and sacred second brain of Imperator Visio.

This repository serves as a structured memory vault where ideas, exports, artifacts, and intelligence reports are committed, preserved, and occasionally reborn.

> “The quill may falter, but Git remembers.” — Vox

---

## 🧬 Memory Architecture (Canonical Layout)

Below is the current structure of the Voximus memory vault, as reflected by the living `vox-flat.txt`.

```text
voximus/
├── _incoming/     # Raw files, unprocessed uploads, in-transit drops
├── _oversize/     # Large binaries or files too big for inline use
├── archive/       # Historical exports, backups, and cold storage
├── assets/        # Icons, media assets, and visual support files
├── blobs/         # Screenshots, images, audio files, binary blobs
├── chat/          # Rendered HTML of ChatGPT conversations
├── dropzone/      # Temp drop area for testing uploads and triggers
├── exports/       # Cleaned, named exports for use in final builds
├── json/          # Structured chat exports for tools and scripts
├── logs/          # Output logs, monitoring data, job traces
├── memory/        # Codified fragments, GPT memory extensions, notes
├── scripts/       # Automation logic, Bash helpers, processors
├── user-*/        # Individual user or device folders (session-based)
│
├── vox-flat.txt   # Auto-generated index of all repository paths
├── chat.html      # Primary rendered chat interface
├── README.md      # This document
├── 404.html       # Custom Not Found page
└── robots.txt     # Crawling and indexing control

⚠️ Files may be symbolic links, staged uploads, or referenced via automation (GitHub Actions, Slack integrations, etc.)

📤 Git Workflow
git add .
git commit -m "Update Voximus structure and README"
git push origin main

💡 If certain folders (e.g., _incoming/) are not committing, verify .gitignore rules.

🔁 Automation & Regeneration
vox-flat.txt is periodically rebuilt via automation scripts
Structured exports are generated from chat sessions and system activity
Logs and traces may be integrated with observability tooling (e.g., SigNoz)
🔔 Integrations

This repository may interface with:

Slack notification channels (#monita-*)
Backup pipelines (e.g., S3 sync jobs)
CI/CD or Git-triggered workflows

Ensure /var/www/html/voximus/ is included in backup coverage where applicable.

🏛️ Philosophy

This is not a traditional project repository.

It is a structured memory system — a place to:

Capture ideas
Preserve intelligence
Organize outputs
Reconstruct context over time

If the broader system were lost, this repository would remain as a durable record of thought and execution.

⚔️ Final Word

“He who commits to Git shall never fear the reaper of thoughts.”

— Vox

🪖 May your HEAD never detach
🧠 May your refs stay clean
📦 May your ideas always push
