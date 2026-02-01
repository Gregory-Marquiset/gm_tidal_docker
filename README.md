> This project is a personal initiative focused on live coding music and reproducible environments.

# marquis_tidal_prod — Tidal Cycles in Docker (Emacs + SuperDirt)

`marquis_tidal_prod` provides a **portable, reproducible live coding environment** for **Tidal Cycles**, packaged with **SuperCollider/SuperDirt** and **Emacs + tidal-mode**, running inside **Docker** with host audio support via **PulseAudio**.

---

## 🌐 Project Overview

**Goal:** Run Tidal Cycles without painful local setup by encapsulating the full stack in Docker (Tidal + SuperDirt + editor tooling + audio bridge).

**Users:** Live coders, developers, musicians, and anyone who wants a reliable Tidal setup on Linux.

### Key Features

* Tidal Cycles REPL (ghci) for algorithmic composition
* SuperCollider + SuperDirt audio engine
* Emacs with `tidal-mode` for live coding workflow
* Host audio output through PulseAudio (also works with PipeWire-Pulse)
* Mounted working directory for `.tidal` files
* Reproducible and portable Docker-based setup

> Note: This project targets **Linux hosts** using PulseAudio (or PipeWire with PulseAudio compatibility).

### Architecture

**Containerized stack**

* Docker
* Tidal Cycles (Haskell / ghci)
* SuperCollider + SuperDirt
* Emacs (tidal-mode)
* PulseAudio bridge (host ↔ container)

---

<a id="quickstart-and-tests"></a>

## 🚀 Quickstart

### Prerequisites

* Linux host
* Docker installed and running
* Working sound device available at `/dev/snd`

### 1) Use the Makefile

From the project root:

```bash
make help
```

### 2) Build the image

```bash
make build
```

Build without cache:

```bash
make build-c
```

### 3) Run the container (interactive)

```bash
make run
```

This starts an interactive container with:

* audio device access (`--device /dev/snd`)
* realtime-friendly settings (`--cap-add=sys_nice`, `--ulimit rtprio`, `--ulimit memlock`)

### 4) One-shot commands

Build → run → clean:

```bash
make once
```

Same, without cache:

```bash
make once-c
```

### 5) Inspect and clean

Show images and containers:

```bash
make show
```

Remove container + image:

```bash
make clean
```

---

## 📑 Resources & AI Usage

### Documentation / References

* [https://tidalcycles.org](https://tidalcycles.org)
* [https://supercollider.github.io](https://supercollider.github.io)

### AI usage

I used AI tools to:

* help structure documentation and project layout
* validate Docker configuration and audio routing concepts
* clarify Tidal Cycles, SuperCollider, and Emacs integration patterns
* review explanations and ensure technical consistency

I did **not** blindly copy-paste AI-generated code.

---

> This is a personal project. No license is provided.
