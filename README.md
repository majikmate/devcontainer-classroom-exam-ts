# Devcontainer Classroom TypeScript Exam

A standalone [Dev Container](https://containers.dev/) image for classroom
TypeScript and Deno exercises and exams.

Published image: `ghcr.io/majikmate/devcontainer-classroom-exam-ts`
(linux/amd64 and linux/arm64)

It provides a stripped-down Codespaces and Dev Containers environment with all
coding assistance disabled. The goal is a predictable setup for classroom
exercises and TypeScript exams, where students work without AI help,
autocomplete, or other editor guidance.

## Use it in an exam repository

Add `.devcontainer/devcontainer.json` to the exam (template) repository:

```jsonc
{
  "name": "Exam",
  "image": "ghcr.io/majikmate/devcontainer-classroom-exam-ts:2",
}
```

- `:2` receives all compatible updates (new Deno LTS versions, security
  updates). Pin a full version (for example `:2.0.3`) if an exam must not
  change during the exam period.
- `:1` is the old Debian 12 "bookworm" image and gets no more updates.

## What the image contains

- Debian 13 "trixie" (`buildpack-deps:trixie-curl`), user `dev`, zsh with Pure
  prompt, locales, aliases, Git configuration
- **Deno** — newest LTS release (feature
  `ghcr.io/majikmate/devcontainer-features/deno:1`)
- **No Node.js and no Go**, for fast build times

The exact versions of each release are listed in its
[release notes](https://github.com/majikmate/devcontainer-classroom-exam-ts/releases).

## VS Code configuration

- **Extensions:** Deno, Prettier, Markdown preview. The extensions for GitHub
  Pull Requests, GitHub Actions, Dev Containers and ESLint are removed.
- **Formatting:** Prettier formats files on save, with the standard Prettier
  style (2-space indentation). The Prettier extension brings its own Prettier,
  so Node.js is not needed. Deno is the runtime and language server, but not the
  formatter.
- **Tests:** the Deno test code lens and Test Explorer run tests with
  `--allow-all --check=all`.
- **AI features are turned off** with `chat.disableAIFeatures` (hides all AI
  and chat UI and disables the Copilot extension that is built into VS Code),
  plus additional settings for agents, inline suggestions and next edit
  suggestions.

  > Note for students: VS Code also turns off Copilot in your own (local) VS
  > Code after you have used this container. To use Copilot again, open your
  > user settings and set `chat.disableAIFeatures` to `false`.

- **Coding assistance is turned off:** no suggestion popup, no suggestions after
  trigger characters, no word-based suggestions, no inline suggestions, no
  parameter hints, no snippets, no light bulb.
- The welcome page and extension walkthroughs do not open; extension
  recommendations are off.
- The folders `.devcontainer`, `.github` and `.vscode` are hidden.
- The title bar has a light blue color, so an exam environment is easy to
  recognize.

## Automatic releases

The workflow [`.github/workflows/release.yml`](.github/workflows/release.yml)
uses the shared workflow of `devcontainer-base` (described in its
[README](https://github.com/majikmate/devcontainer-base#automatic-releases)).
Every hour it checks the inputs of the image: the `.devcontainer` folder, the
digests of `buildpack-deps:trixie-curl` and of the features, and the newest
Deno LTS version ([`.github/tool-versions.sh`](.github/tool-versions.sh)). When
an input changed, or the image is older than 7 days, it builds, tests and
releases a new version. Pull requests are only built and tested.

## Customization

Edit `.devcontainer/devcontainer.json` through a pull request. After the merge,
the new image is released automatically.
