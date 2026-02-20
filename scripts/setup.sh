#!/usr/bin/env bash
set -e

# --- Install rustup if missing ---
if ! command -v rustup >/dev/null 2>&1; then
    echo "Installing rustup with nightly toolchain"
    curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
fi

# --- Ensure cargo is in PATH for this session ---
export PATH="$HOME/.cargo/bin:$PATH"

# --- Setting up Rust ---

echo "Setting Rust nightly as default toolchain"
rustup default nightly

echo "Adding rustfmt component"
rustup component add rustfmt --toolchain nightly

echo "Adding clippy component"
rustup component add clippy --toolchain nightly

echo "Adding wasm32-unknown-unknown target"
rustup target add wasm32-unknown-unknown --toolchain nightly

# macOS uses apple-darwin host automatically
# Linux uses unknown-linux-gnu host automatically

# --- Installing trunk if missing ---
if ! command -v trunk >/dev/null 2>&1; then
    echo "Installing trunk"

    curl -L https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

    cargo binstall trunk -y
fi

echo "Finished."