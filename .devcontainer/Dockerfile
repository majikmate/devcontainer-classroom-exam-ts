# devcontainer-classroom-exam-ts: core + Deno, for TypeScript exams.
# No Node.js and no Go, for fast build times.
#
# The layer tool devcon of devcontainer-core installs every layer.
# Layers and their arguments: https://github.com/majikmate/devcontainer-core/blob/main/docs/layers.md
FROM ghcr.io/majikmate/devcontainer-core:1

# deno: Deno 2.x LTS (the feature decides the version; the release workflow
# passes it; at the end of life of the line the build fails)
ARG DENO_VERSION
RUN devcon install deno
