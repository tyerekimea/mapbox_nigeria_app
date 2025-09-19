#!/usr/bin/env bash
set -e

echo "🔧 Installing Flutter dependencies..."

# Install system packages
sudo apt-get update
sudo apt-get install -y \
  ninja-build \
  cmake \
  pkg-config \
  libgtk-3-dev \
  liblzma-dev \
  unzip \
  xz-utils \
  curl \
  git \
  openjdk-17-jdk

# Flutter & Dart paths
if ! grep -q "/usr/local/flutter/bin" /etc/bash.bashrc; then
  echo 'export PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$PATH"' | sudo tee -a /etc/bash.bashrc
fi

# Android SDK path (placeholder, you’ll update once installed)
if ! grep -q "ANDROID_HOME" /etc/bash.bashrc; then
  echo 'export ANDROID_HOME=/usr/local/android-sdk' | sudo tee -a /etc/bash.bashrc
  echo 'export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"' | sudo tee -a /etc/bash.bashrc
fi

# Chrome path (optional, for Flutter Web)
if ! grep -q "CHROME_EXECUTABLE" /etc/bash.bashrc; then
  echo 'export CHROME_EXECUTABLE=/usr/bin/google-chrome' | sudo tee -a /etc/bash.bashrc
fi

# Apply environment changes to current session
source /etc/bash.bashrc || true

# Precache Flutter SDK (downloads required artifacts)
echo "📦 Running flutter precache..."
flutter precache

# Run flutter doctor to verify setup
echo "🩺 Running flutter doctor..."
flutter doctor -v || true

echo "✅ setup.sh finished! Restart your terminal or run 'source /etc/bash.bashrc' to apply."
