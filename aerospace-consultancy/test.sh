#!/bin/bash
# Website Test Suite - Based on AI Architecture
# Tests: HTML validation, link checking, structure verification

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_FILE="$REPO_DIR/index.html"
BASE_URL="https://hosekaerospace.github.io/aerospace-consultancy"

echo "=========================================="
echo "🧪 Website Test Suite"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0

# Test 1: HTML file exists
echo "Test 1: HTML file exists..."
if [ -f "$HTML_FILE" ]; then
    echo -e "${GREEN}✓ PASSED${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAILED: index.html not found${NC}"
    ((FAILED++))
fi
echo ""

# Test 2: HTML has DOCTYPE
echo "Test 2: HTML has DOCTYPE..."
if grep -q "<!DOCTYPE html>" "$HTML_FILE"; then
    echo -e "${GREEN}✓ PASSED${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAILED: Missing DOCTYPE${NC}"
    ((FAILED++))
fi
echo ""

# Test 3: Has required sections
echo "Test 3: Required sections present..."
REQUIRED_SECTIONS=("hero" "services" "about" "contact")
for section in "${REQUIRED_SECTIONS[@]}"; do
    if grep -q "id=\"$section\"" "$HTML_FILE"; then
        echo -e "  ${GREEN}✓${NC} Section: $section"
    else
        echo -e "  ${RED}✗${NC} Missing: $section"
        ((FAILED++))
    fi
done
echo ""

# Test 4: Required content present
echo "Test 4: Required content..."
CONTENT_CHECKS=("Hošek Aerospace Consulting" "UAV Systems Design" "Command & Control" "vlastimil.hosek@gmail.com")
for content in "${CONTENT_CHECKS[@]}"; do
    if grep -q "$content" "$HTML_FILE"; then
        echo -e "  ${GREEN}✓${NC} Found: $content"
    else
        echo -e "  ${RED}✗${NC} Missing: $content"
        ((FAILED++))
    fi
done
echo ""

# Test 5: CSS variables defined
echo "Test 5: Brand colors (CSS variables)..."
COLOR_CHECKS=("#143f68" "#e8a838" "#2d8bc7")
for color in "${COLOR_CHECKS[@]}"; do
    if grep -q "$color" "$HTML_FILE"; then
        echo -e "  ${GREEN}✓${NC} Found color: $color"
    else
        echo -e "  ${RED}✗${NC} Missing color: $color"
        ((FAILED++))
    fi
done
echo ""

# Test 6: JavaScript functions present
echo "Test 6: JavaScript functionality..."
JS_CHECKS=("IntersectionObserver" "addEventListener" "form")
for js in "${JS_CHECKS[@]}"; do
    if grep -q "$js" "$HTML_FILE"; then
        echo -e "  ${GREEN}✓${NC} Found: $js"
    else
        echo -e "  ${RED}✗${NC} Missing: $js"
        ((FAILED++))
    fi
done
echo ""

# Test 7: Mobile responsive (viewport meta)
echo "Test 7: Mobile responsiveness..."
if grep -q 'name="viewport"' "$HTML_FILE"; then
    echo -e "${GREEN}✓ PASSED${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAILED: No viewport meta tag${NC}"
    ((FAILED++))
fi
echo ""

# Test 8: External resources accessibility (if online)
echo "Test 8: External resources..."
if curl -s -o /dev/null -w "%{http_code}" "https://fonts.googleapis.com" | grep -q "200\|301\|302"; then
    echo -e "  ${GREEN}✓${NC} Google Fonts: accessible"
else
    echo -e "  ${YELLOW}⚠${NC} Google Fonts: may not be accessible"
fi
echo ""

# Summary
echo "=========================================="
echo "📊 Test Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed${NC}"
    exit 1
fi
