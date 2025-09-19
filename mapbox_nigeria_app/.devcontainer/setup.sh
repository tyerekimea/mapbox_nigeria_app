#!/usr/bin/env bash
set -e

# Install dependencies
apt-get update
apt-get install -y curl unzip git xz-utils zip libglu1-mesa

# Install Flutter
git clone https://github.com/flutter/flutter.git /usr/local/flutter
echo 'export PATH="/usr/local/flutter/bin:$PATH"' >> /etc/bash.bashrc
export PATH="/usr/local/flutter/bin:$PATH"

# Pre-cache Flutter binaries
flutter doctor
flutter precache
