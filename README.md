# devcontainer-classroom-exam-ts

The image for classroom TypeScript and Deno exercises and exams. AI features
and all coding assistance are turned off, so students work without AI help,
autocomplete or other editor guidance.

**Image:** `ghcr.io/majikmate/devcontainer-classroom-exam-ts:2` · linux/amd64,
linux/arm64 ·
[release notes](https://github.com/majikmate/devcontainer-classroom-exam-ts/releases)

## Dependencies

```text
                                               Nightly Content
devcontainer-features                                  Go library of layers, compiled into devcon
  ▼
devcontainer-core:1                            22:17   Debian 13, devcon, user dev, zsh, SSH server
├── devcontainer-base:2                        23:17   + go, build-tools, node, deno, prettier
│   ├── devcontainer-dev:2                     23:57   + github-cli
│   ├── devcontainer-classroom-web:2           00:07   + html-validate, classroom settings, AI off
│   └── devcontainer-classroom-web-advanced:2  00:17   + playwright-deps, html-validate, AI on
└── devcontainer-classroom-exam-ts:2           23:47   + deno, AI and coding assistance off
```

This repository: **devcontainer-classroom-exam-ts**. Nightly checks in UTC.
Repositories: [core](https://github.com/majikmate/devcontainer-core) ·
[features](https://github.com/majikmate/devcontainer-features) ·
[base](https://github.com/majikmate/devcontainer-base) ·
[dev](https://github.com/majikmate/devcontainer-dev) ·
[classroom-web](https://github.com/majikmate/devcontainer-classroom-web) ·
[classroom-web-advanced](https://github.com/majikmate/devcontainer-classroom-web-advanced) ·
[classroom-exam-ts](https://github.com/majikmate/devcontainer-classroom-exam-ts)

## Use

Add `.devcontainer/devcontainer.json` to the exam (template) repository:

```jsonc
{
  "name": "Exam",
  "image": "ghcr.io/majikmate/devcontainer-classroom-exam-ts:2",
}
```

- `:2` receives all compatible updates (new Deno 2.x versions, security
  updates).
- A full version (for example `:2.0.6`) stays available for at least 90 days.
  Use it when the image must not change during an exam period.

## Content

| Layer | Content | Version |
| ----- | ------- | ------- |
| (devcontainer-core) | Debian 13, user `dev`, zsh, locales, git settings, aliases, Pure prompt, SSH server on port 2222 | see [core](https://github.com/majikmate/devcontainer-core#content); Debian release: [`debianPin`](https://github.com/majikmate/devcontainer-core/blob/main/pkg/layers/os.go#L31-L34) |
| `deno` | Deno | Deno 2.x LTS, the release of `deno upgrade lts` ([`denoPin`, `denoChannel`](https://github.com/majikmate/devcontainer-features/blob/main/deno/deno.go#L36-L39)) |

- **No Node.js and no Go**, for fast build times. The release workflow checks
  that the commands `node` and `go` do not exist.
- **Version:** the feature `deno` decides the line (2) and the channel (lts),
  not the Dockerfile ([rules](https://github.com/majikmate/devcontainer-features#versions)).
  When Deno publishes a new major release, the nightly check and the build
  fail.

## VS Code

- **Extensions:** Deno, Prettier, Markdown preview. GitHub Pull Requests,
  GitHub Actions, Dev Containers and ESLint are removed.
- **Formatting:** Prettier formats on save with the standard Prettier style
  and 2 spaces. The Prettier extension brings its own Prettier, so Node.js is
  not needed. Deno is the runtime and language server, not the formatter.
- **Tests:** the Deno test code lens and the Test Explorer run tests with
  `--allow-all --check=all`.
- **AI features are turned off** (`chat.disableAIFeatures`, plus the settings
  for agents, inline suggestions and next edit suggestions).

  > Note for students: VS Code also turns off Copilot in your own (local) VS
  > Code after you have used this container. To use Copilot again, set
  > `chat.disableAIFeatures` to `false` in your user settings.

- **Coding assistance is turned off:** no suggestion popup, no suggestions
  after trigger characters, no word-based suggestions, no inline suggestions,
  no parameter hints, no snippets, no light bulb.
- The welcome page and walkthroughs do not open; extension recommendations are
  off. The folders `.devcontainer`, `.github` and `.vscode` are hidden. The
  title bar is light blue, so an exam environment is easy to recognize.

## Releases

- **Nightly check at 23:47 UTC** (01:47 CEST). A new version is released when an input
  changes: `.devcontainer`, `README.md`, the digest of `devcontainer-core:1`, or the
  Deno version. Pending Debian updates and an age above
  7 days also lead to a new version.
- **Manual:** **Actions → Release → Run workflow**. The option `upstream` (on
  by default) first updates core; `force` releases without a change.
- **Pull requests** build and test both architectures and publish nothing.
- **Kept versions:** the newest release and the tags `2`, `2.x` and `latest`.
  Older releases and workflow runs are deleted after 90 days. **Actions →
  Prune** lists or deletes them at once; the scope `all-but-newest` keeps
  only the newest release and the newest run of each workflow.

Rules: [Releases](https://github.com/majikmate/devcontainer-core#releases).

## Change the image

Change `.devcontainer/` or `README.md` through a pull request and consider the
effect on the students. After the merge, the new image is released
automatically (GitHub shows the README of the newest image on the package
page).

---

© 2026 Hannes Stauss (scalarion@nimblescape.com) · [MIT License](LICENSE).
