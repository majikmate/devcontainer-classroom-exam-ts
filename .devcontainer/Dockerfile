# SPDX-License-Identifier: MIT
# © 2026 Hannes Stauss (scalarion@nimblescape.com)
# Licensed under the MIT License. See LICENSE in the repository root for details.

# devcontainer-classroom-exam-ts: core + Node.js, the command ts and Deno, for
# TypeScript exams. No Go, for fast build times.
#
# The layer tool devcon of devcontainer-core installs every layer.
# Layers and their arguments: https://github.com/majikmate/devcontainer-core/blob/main/docs/layers.md
FROM ghcr.io/majikmate/devcontainer-core:1

# build-tools: make, gcc, g++, python3 for native npm modules (node-gyp);
# the layer node needs it
RUN devcon install build-tools

# node: nvm, Node.js 26.x, npm
ENV NVM_DIR=/usr/local/share/nvm \
    NVM_SYMLINK_CURRENT=true \
    PATH=/usr/local/share/nvm/current/bin:$PATH
ARG NVM_VERSION
ARG NODE_VERSION
RUN devcon install node

# ts: the command ts of nimblescape TypeScript (npm package
# @nimblescape/typescript) with Tab completion, and the VS Code extension
# nimblescape TypeScript, which gives ts the TypeScript of VS Code (no
# network needed)
ARG NIMBLESCAPE_TYPESCRIPT_VERSION
RUN devcon install ts

# deno: Deno 2.x LTS (the feature decides the version; the release workflow
# passes it; at the end of life of the line the build fails)
ARG DENO_VERSION
RUN devcon install deno
