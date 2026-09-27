# devcontainer-classroom-exam-ts: core + Deno, for TypeScript exams.
# No Node.js and no Go, for fast build times.
#
# The layer tool devcon of devcontainer-core installs every layer.
# Layers and their arguments: https://github.com/majikmate/devcontainer-core/blob/main/docs/layers.md
FROM ghcr.io/majikmate/devcontainer-core:1

# deno: Deno 2.x (the release workflow passes the newest version of the pinned
# line; at its end of life the build fails and names the supported line)
ARG DENO_PIN=2
ARG DENO_VERSION
RUN devcon install deno
