#!/bin/bash

# Script to generate Tidal API client using SwagGen
# Usage: ./scripts/generate_tidal_api.sh

set -e  # Exit on error

# Configuration
TIDAL_OAS_URL="https://tidal-music.github.io/tidal-api-reference/tidal-api-oas.json"
TEMPLATE_DIR="SwagGen_Template"
OUTPUT_DIR="Sources/TidalAPI/Generated"
TEMP_SPEC_FILE="/tmp/tidal-api-oas.json"
TEMP_TEMPLATE_FILE="/tmp/tidal-template.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🎵 Generating Tidal API client...${NC}"

# Check if SwagGen is installed
if ! command -v swaggen &> /dev/null; then
    echo -e "${RED}❌ SwagGen is not installed. Please install it first:${NC}"
    echo "   brew install swaggen"
    echo "   or visit: https://github.com/yonaskolb/SwagGen"
    exit 1
fi

# Check if template directory exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo -e "${RED}❌ Template directory '$TEMPLATE_DIR' not found${NC}"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo -e "${YELLOW}📥 Downloading Tidal OpenAPI specification...${NC}"

# Download the OpenAPI spec
if curl -s -L "$TIDAL_OAS_URL" -o "$TEMP_SPEC_FILE"; then
    echo -e "${GREEN}✅ Downloaded OpenAPI specification${NC}"
else
    echo -e "${RED}❌ Failed to download OpenAPI specification from $TIDAL_OAS_URL${NC}"
    exit 1
fi

# Validate the downloaded file is valid JSON
if ! jq empty "$TEMP_SPEC_FILE" 2>/dev/null; then
    echo -e "${RED}❌ Downloaded file is not valid JSON${NC}"
    exit 1
fi

echo -e "${YELLOW}🔧 Generating Swift API client...${NC}"

# Generate the API client using SwagGen
if swaggen generate "$TEMP_SPEC_FILE" \
    --template "$TEMPLATE_DIR" \
    --destination "$OUTPUT_DIR" \
    --option name:Tidal.API.V2 \
    --option modelNamespace:TDO \
    --option enumUndecodedCase:true \
    --option mutableModels:true \
    --option safeOptionalDecoding:true \
    --option codableResponses:true; then
    
    echo -e "${GREEN}✅ Successfully generated Tidal API client${NC}"
    echo -e "${GREEN}📁 Output directory: $OUTPUT_DIR${NC}"
    
    # List generated files
    echo -e "${YELLOW}📋 Generated files:${NC}"
    find "$OUTPUT_DIR" -name "*.swift" | head -10
    
    # Count total files
    FILE_COUNT=$(find "$OUTPUT_DIR" -name "*.swift" | wc -l)
    echo -e "${GREEN}📊 Total Swift files generated: $FILE_COUNT${NC}"
    
    # Format generated Swift files
    echo -e "${YELLOW}🎨 Formatting generated Swift files...${NC}"
    
    if command -v swiftformat &> /dev/null; then
        if swiftformat "$OUTPUT_DIR" --quiet; then
            echo -e "${GREEN}✅ Successfully formatted Swift files${NC}"
        else
            echo -e "${YELLOW}⚠️  SwiftFormat completed with warnings${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  SwiftFormat not installed - skipping formatting${NC}"
        echo "   Install with: brew install swiftformat"
    fi
    
else
    echo -e "${RED}❌ Failed to generate API client${NC}"
    exit 1
fi

# Cleanup
rm -f "$TEMP_SPEC_FILE"

echo -e "${GREEN}🎉 Tidal API client generation complete!${NC}"
echo -e "${YELLOW}💡 Next steps:${NC}"
echo "   1. Review the generated files in $OUTPUT_DIR"
echo "   2. Integrate the generated client with your existing TidalAPI target"
echo "   3. Update Package.swift if needed"
echo "   4. Run swift build to verify everything compiles"