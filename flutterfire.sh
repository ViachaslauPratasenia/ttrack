#!/bin/bash
# Wrapper script to run flutterfire with Dart from FVM
FVM_FLUTTER_VERSION=$(fvm list | grep "active" | awk '{print $1}' | head -1)
FVM_BIN="/Users/vpratasenia/fvm/versions/${FVM_FLUTTER_VERSION}/bin"

if [ ! -d "$FVM_BIN" ]; then
    echo "Error: FVM bin directory not found at $FVM_BIN"
    exit 1
fi

# Add FVM Dart to PATH and run flutterfire directly
export PATH="$FVM_BIN:$PATH"
exec ~/.pub-cache/bin/flutterfire "$@"

