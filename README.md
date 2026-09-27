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

- `:2` receives all compatible updates (new Deno 2.x versions, security
  updates). Pin a full version (for example `:2.0.3`) if an exam must not
  change during the exam period. A full version stays available for at
  least 90 days after its release (see
  [Kept package versions](#kept-package-versions)).
- The former `:1` images (Debian 12 "bookworm") are deleted.

## What the image contains

The image is [devcontainer-core](https://github.com/majikmate/devcontainer-core)
plus one layer ([`.devcontainer/Dockerfile`](.devcontainer/Dockerfile)):

- **Core:** Debian 13 "trixie", user `dev`, zsh with Pure prompt, locales,
  aliases, Git configuration, SSH server on port 2222 (keys of your GitHub
  account only, see
  [SSH access](https://github.com/majikmate/devcontainer-core#ssh-access))
- **Layer `deno`:** Deno, newest 2.x release (`ARG DENO_PIN=2` in the
  Dockerfile). When Deno publishes a new major release, the Deno 2 line ends:
  the nightly check and the build fail with a message, and the pin must be
  changed (see
  [Pinned release lines](https://github.com/majikmate/devcontainer-features#pinned-release-lines))
- **No Node.js and no Go**, for fast build times. The release workflow checks
  that the commands `node` and `go` do not exist.

The exact versions of each release are listed in its
[release notes](https://github.com/majikmate/devcontainer-classroom-exam-ts/releases).

## VS Code configuration

The settings come from devcontainer-core (terminal zsh, theme, Markdown
preview, Git), from the layer `deno` (Deno extension and test arguments) and
from [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) (all
exam settings below). The release workflow writes them into the image label.

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
uses the shared workflow of `devcontainer-core` (described in its
[README](https://github.com/majikmate/devcontainer-core#releases)).
Every night at 01:27 UTC, two hours after devcontainer-core (23:17 UTC), it
checks the inputs of the image: the `.devcontainer` folder, the digest of
`ghcr.io/majikmate/devcontainer-core:1`, and the newest Deno version of the
pinned line (`DENO_PIN`).
When an input changed, or the image is older than 7 days, it builds, tests and
releases a new version. Pull requests are only built and tested.

To check at once, open **Actions → Release → Run workflow** and keep the default
options. With the option `upstream` (on by default), the run first starts the
Release workflow of devcontainer-core and waits for it, so a new core image is
included. Then it runs the same check as the nightly run. The option `force`
releases a new version without a change.

### Kept package versions

After every release run, the outdated versions of the image package are
deleted (rules: [Releases](https://github.com/majikmate/devcontainer-core#releases)):

- releases older than 90 days; the newest release and the tags `2`, `2.x` and
  `latest` are always kept,
- versions of older major lines and untagged versions that no image uses.

A full version (for example `:2.0.3`) stays available for at least 90 days
after its release. The manual workflow **Actions → Prune → Run workflow** lists
(`report`) or deletes (`apply`) the outdated versions at once; the scope
`all-but-newest` deletes every release except the newest.

## Customization

Edit `.devcontainer/devcontainer.json` through a pull request. After the merge,
the new image is released automatically.
