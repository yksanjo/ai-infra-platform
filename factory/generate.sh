#!/bin/bash
# Factory: Generate vertical-specific packages

VERTICAL=$1
DESC=$2

if [[ -z "$VERTICAL" ]]; then
    echo "Usage: $0 <vertical> <description>"
    exit 1
fi

FACTORY_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$FACTORY_ROOT/../verticals/$VERTICAL"

echo "Generating vertical: $VERTICAL"

mkdir -p "$OUTPUT_DIR"/{src,tests,examples}

# Create vertical packages
PACKAGES=("api" "sdk" "models" "pipelines" "connectors")

for pkg in "${PACKAGES[@]}"; do
    pkg_name="$VERTICAL-$pkg"
    pkg_dir="$OUTPUT_DIR/$pkg_name"
    mkdir -p "$pkg_dir"/{src,tests}
    
    cat > "$pkg_dir/package.json" << EOF
{
  "name": "@ai-infra/$pkg_name",
  "version": "1.0.0",
  "description": "$pkg for $VERTICAL - $DESC",
  "main": "src/index.js",
  "type": "module",
  "author": "Yoshi Kondo",
  "license": "MIT"
}
EOF
    
    cat > "$pkg_dir/src/index.js" << EOF
export class Service {
  constructor() {
    this.name = '$pkg_name';
    this.vertical = '$VERTICAL';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
EOF
    
    echo "  ✓ Created: $pkg_name"
done

echo "Vertical $VERTICAL generated with ${#PACKAGES[@]} packages"
