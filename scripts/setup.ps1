$ErrorActionPreference = "Stop"

# --- Install rustup if missing ---
if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
    Write-Host "Installing rustup with nightly toolchain"
    Invoke-WebRequest https://win.rustup.rs -OutFile rustup-init.exe

    .\rustup-init.exe -y --default-toolchain nightly
    
    Remove-Item rustup-init.exe
}

# --- Ensure cargo is in PATH ---
$env:PATH += ";$env:USERPROFILE\.cargo\bin"

# --- Setting up Rust ---

Write-Host "Setting Rust nightly as default toolchain"
rustup default nightly

Write-Host "Adding rustfmt component"
rustup component add rustfmt --toolchain nightly

Write-Host "Adding clippy component"
rustup component add clippy --toolchain nightly

Write-Host "Adding wasm32-unknown-unknown target"
rustup target add wasm32-unknown-unknown --toolchain nightly

Write-Host "Adding x86_64-pc-windows-msvc target"
rustup target add x86_64-pc-windows-msvc --toolchain nightly

# --- Installing trunk if missing ---
if (-not (Get-Command trunk -ErrorAction SilentlyContinue)) {
    Write-Host "Installing trunk"
    
    # Installs cargo-binstall
    Set-ExecutionPolicy Unrestricted -Scope Process; iex (iwr "https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.ps1").Content

    cargo binstall trunk -y
}

Write-Host "Finished."