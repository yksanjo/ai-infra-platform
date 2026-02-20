#!/bin/bash
###############################################################################
# AI Infrastructure Platform - Complete Build Loop
# Automates: Plan → Build → Extend → Factory → Push
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║         AI INFRASTRUCTURE PLATFORM - BUILD LOOP           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() { echo -e "${BLUE}▶ $1${NC}"; }
print_done() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${MAGENTA}★ $1${NC}"; }

# Phase 1: Create Core Packages
create_core_packages() {
    print_banner
    print_step "PHASE 1: Creating Core Packages..."
    echo ""
    
    PACKAGES=(
        "model-serving:Model serving and inference optimization"
        "data-pipelines:ETL and data processing pipelines for AI"
        "feature-store:Feature engineering and storage"
        "experiment-tracking:ML experiment tracking and logging"
        "model-registry:Model versioning and registry"
        "inference-api:Unified inference API layer"
        "gpu-orchestration:GPU resource management"
        "batch-processing:Batch inference and processing"
    )
    
    for pkg_info in "${PACKAGES[@]}"; do
        IFS=':' read -r pkg_name pkg_desc <<< "$pkg_info"
        pkg_dir="$PROJECT_ROOT/packages/$pkg_name"
        
        print_step "Creating: $pkg_name"
        mkdir -p "$pkg_dir"/{src,tests,examples,docs}
        
        # package.json
        cat > "$pkg_dir/package.json" << EOF
{
  "name": "@ai-infra/$pkg_name",
  "version": "1.0.0",
  "description": "$pkg_desc",
  "main": "src/index.js",
  "type": "module",
  "scripts": {
    "test": "jest",
    "start": "node src/index.js",
    "dev": "node --watch src/index.js"
  },
  "keywords": ["ai", "infrastructure", "$pkg_name", "ml"],
  "author": "Yoshi Kondo <yoshi@musicailab.com>",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/yksanjo/ai-infra-platform/tree/main/packages/$pkg_name"
  }
}
EOF
        
        # README
        cat > "$pkg_dir/README.md" << EOF
# $pkg_name

> $pkg_desc

## Installation

\`\`\`bash
npm install @ai-infra/$pkg_name
\`\`\`

## Usage

\`\`\`javascript
import { Service } from '@ai-infra/$pkg_name';

const service = new Service();
await service.init();
\`\`\`

## License

MIT
EOF
        
        # Source file
        cat > "$pkg_dir/src/index.js" << EOF
/**
 * $pkg_name
 * $pkg_desc
 */

export class Service {
  constructor(options = {}) {
    this.name = '$pkg_name';
    this.options = options;
    this.initialized = false;
  }

  async init() {
    this.initialized = true;
    return { status: 'initialized', service: this.name };
  }

  async execute(task, data) {
    if (!this.initialized) {
      await this.init();
    }
    return {
      success: true,
      service: this.name,
      task,
      data,
      timestamp: Date.now(),
    };
  }

  async health() {
    return {
      service: this.name,
      status: this.initialized ? 'healthy' : 'uninitialized',
      uptime: process.uptime(),
    };
  }
}

export default Service;
EOF
        
        print_done "$pkg_name created"
    done
    
    echo ""
    print_info "Core packages created: ${#PACKAGES[@]}"
}

# Phase 2: Create Advanced Features
create_advanced_features() {
    print_banner
    print_step "PHASE 2: Creating Advanced Features..."
    echo ""
    
    FEATURES=(
        "auto-scaling:Automatic scaling for ML workloads"
        "model-monitoring:Model performance monitoring and alerts"
        "drift-detection:Data and model drift detection"
        "a-b-testing:A/B testing framework for models"
        "pipeline-orchestration:ML pipeline orchestration"
        "model-compression:Model optimization and compression"
        "distributed-training:Distributed training coordination"
        "hyperparameter-tuning:Automated hyperparameter optimization"
    )
    
    for feat_info in "${FEATURES[@]}"; do
        IFS=':' read -r feat_name feat_desc <<< "$feat_info"
        feat_dir="$PROJECT_ROOT/features/$feat_name"
        
        print_step "Creating: $feat_name"
        mkdir -p "$feat_dir"/{src,tests,examples}
        
        cat > "$feat_dir/package.json" << EOF
{
  "name": "@ai-infra/$feat_name",
  "version": "1.0.0",
  "description": "$feat_desc",
  "main": "src/index.js",
  "type": "module",
  "scripts": {
    "test": "jest",
    "start": "node src/index.js"
  },
  "keywords": ["ai", "infrastructure", "$feat_name"],
  "author": "Yoshi Kondo <yoshi@musicailab.com>",
  "license": "MIT"
}
EOF
        
        cat > "$feat_dir/README.md" << EOF
# $feat_name

> $feat_desc

## Usage

\`\`\`javascript
import { $feat_name } from '@ai-infra/$feat_name';

const service = new $feat_name();
await service.run();
\`\`\`
EOF
        
        # Convert kebab-case to PascalCase for class name
        class_name=$(echo "$feat_name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | sed 's/ //g')
        
        cat > "$feat_dir/src/index.js" << EOF
/**
 * $feat_name
 * $feat_desc
 */

export class $class_name {
  constructor(options = {}) {
    this.name = '$feat_name';
    this.options = options;
    this.running = false;
  }

  async start() {
    this.running = true;
    return { status: 'started', feature: this.name };
  }

  async stop() {
    this.running = false;
    return { status: 'stopped', feature: this.name };
  }

  async run(config) {
    if (!this.running) {
      await this.start();
    }
    return {
      success: true,
      feature: this.name,
      config,
      result: 'completed',
    };
  }

  getStatus() {
    return {
      name: this.name,
      running: this.running,
      options: this.options,
    };
  }
}

export default $class_name;
EOF
        
        print_done "$feat_name created"
    done
    
    echo ""
    print_info "Advanced features created: ${#FEATURES[@]}"
}

# Phase 3: Create Factory Generator
create_factory() {
    print_banner
    print_step "PHASE 3: Creating Factory Generator..."
    echo ""
    
    factory_dir="$PROJECT_ROOT/factory"
    mkdir -p "$factory_dir"/templates
    
    # Vertical domains for AI infra
    VERTICALS=(
        "computer-vision:CV models and image processing"
        "nlp:NLP and language models"
        "recommendation:Recommendation systems"
        "forecasting:Time series forecasting"
        "anomaly-detection:Anomaly detection systems"
        "reinforcement-learning:RL training and deployment"
        "speech-audio:Speech and audio processing"
        "multimodal:Multimodal AI systems"
    )
    
    cat > "$factory_dir/generate.sh" << 'GENEOF'
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
GENEOF
    
    chmod +x "$factory_dir/generate.sh"
    
    # Generate all verticals
    print_step "Generating verticals..."
    for v_info in "${VERTICALS[@]}"; do
        IFS=':' read -r v_name v_desc <<< "$v_info"
        "$factory_dir/generate.sh" "$v_name" "$v_desc"
    done
    
    print_info "Factory created with ${#VERTICALS[@]} verticals"
}

# Phase 4: Create Root Config
create_root_config() {
    print_banner
    print_step "PHASE 4: Creating Root Configuration..."
    echo ""
    
    # Root package.json
    cat > "$PROJECT_ROOT/package.json" << EOF
{
  "name": "ai-infra-platform",
  "version": "1.0.0",
  "description": "Complete AI Infrastructure Platform",
  "private": true,
  "workspaces": [
    "packages/*",
    "features/*",
    "verticals/*/*"
  ],
  "scripts": {
    "test": "npm run test --workspaces --if-present",
    "build": "npm run build --workspaces --if-present",
    "dev": "npm run dev --workspaces --if-present",
    "lint": "eslint . --ext .js"
  },
  "keywords": ["ai", "infrastructure", "ml", "mlops"],
  "author": "Yoshi Kondo <yoshi@musicailab.com>",
  "license": "MIT"
}
EOF
    
    # Root README
    cat > "$PROJECT_ROOT/README.md" << EOF
# AI Infrastructure Platform

> Complete infrastructure for AI/ML systems

## 📦 Packages

### Core (8)
$(ls -1 packages/ | sed 's/^/- /')

### Advanced Features (8)
$(ls -1 features/ | sed 's/^/- /')

### Verticals
$(ls -1 verticals/ | sed 's/^/- /')

## 🚀 Quick Start

\`\`\`bash
npm install
npm run dev
\`\`\`

## 🏭 Factory

\`\`\`bash
cd factory
./generate.sh <vertical> <description>
\`\`\`

## License

MIT
EOF
    
    # .gitignore
    cat > "$PROJECT_ROOT/.gitignore" << EOF
node_modules/
dist/
*.log
.env
.DS_Store
coverage/
EOF
    
    print_done "Root configuration created"
}

# Phase 5: Initialize Git
init_git() {
    print_banner
    print_step "PHASE 5: Initializing Git..."
    echo ""
    
    cd "$PROJECT_ROOT"
    git init -q
    git branch -m main
    git config user.name "Yoshi Kondo"
    git config user.email "yoshi@musicailab.com"
    
    print_done "Git initialized"
}

# Main execution
main() {
    print_banner
    echo ""
    print_info "Starting complete build loop..."
    echo ""
    
    create_core_packages
    echo ""
    
    create_advanced_features
    echo ""
    
    create_factory
    echo ""
    
    create_root_config
    echo ""
    
    init_git
    echo ""
    
    print_banner
    print_done "BUILD LOOP COMPLETE!"
    echo ""
    echo "📊 Summary:"
    echo "   Core packages: 8"
    echo "   Advanced features: 8"
    echo "   Verticals: 8 × 5 = 40 packages"
    echo "   Total: 56 packages"
    echo ""
    echo "📁 Location: $PROJECT_ROOT"
    echo ""
}

main "$@"
