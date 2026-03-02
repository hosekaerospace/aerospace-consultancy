#!/bin/bash
# ===========================================
# TEST AGENT - Validates against SPEC.md
# Based on AI Architecture: Parallelization
# ===========================================

# Don't exit on error - continue testing
# set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_FILE="$REPO_DIR/index.html"
SPEC_FILE="$REPO_DIR/SPEC.md"

echo "=============================================="
echo "🧪 TEST AGENT - Technical Validation"
echo "=============================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0

log_pass() { echo -e "${GREEN}✓ PASS${NC}: $1"; ((PASSED++)); }
log_fail() { echo -e "${RED}✗ FAIL${NC}: $1"; ((FAILED++)); }
log_info() { echo -e "${YELLOW}ℹ INFO${NC}: $1"; }

# -----------------------------------------
# SECTION 1: File Structure
# -----------------------------------------
echo "📁 File Structure..."
if [ -f "$HTML_FILE" ]; then
    log_pass "index.html exists"
    SIZE=$(stat -f%z "$HTML_FILE" 2>/dev/null || stat -c%s "$HTML_FILE")
    log_info "File size: $SIZE bytes"
else
    log_fail "index.html not found"
    exit 1
fi
echo ""

# -----------------------------------------
# SECTION 2: HTML Validation
# -----------------------------------------
echo "📝 HTML Validation..."

# DOCTYPE
grep -q "<!DOCTYPE html>" "$HTML_FILE" && log_pass "DOCTYPE present" || log_fail "Missing DOCTYPE"

# HTML lang
grep -q 'lang="en"' "$HTML_FILE" && log_pass "HTML lang attribute" || log_fail "Missing lang attribute"

# Viewport
grep -q 'name="viewport"' "$HTML_FILE" && log_pass "Viewport meta tag" || log_fail "Missing viewport"

# Title
grep -q "<title>" "$HTML_FILE" && log_pass "Title tag" || log_fail "Missing title"
echo ""

# -----------------------------------------
# SECTION 3: Required Sections (from SPEC)
# -----------------------------------------
echo "🏗️ Required Sections..."

REQUIRED_SECTIONS=(
    "hero"
    "services"
    "about"
    "contact"
    "experience"
)

for section in "${REQUIRED_SECTIONS[@]}"; do
    if grep -q "id=\"$section\"" "$HTML_FILE"; then
        log_pass "Section: $section"
    else
        log_fail "Missing section: $section"
    fi
done
echo ""

# -----------------------------------------
# SECTION 4: Brand Colors (from SPEC)
# -----------------------------------------
echo "🎨 Brand Colors..."

COLORS=(
    "#143f68:Primary navy"
    "#e8a838:Gold highlight"
    "#2d8bc7:Accent blue"
)

for color_pair in "${COLORS[@]}"; do
    COLOR="${color_pair%%:*}"
    NAME="${color_pair##*:}"
    if grep -q "$COLOR" "$HTML_FILE"; then
        log_pass "Color $NAME ($COLOR)"
    else
        log_fail "Missing color $NAME ($COLOR)"
    fi
done
echo ""

# -----------------------------------------
# SECTION 5: Required Services (from SPEC)
# -----------------------------------------
echo "🛠️ Required Services..."

SERVICES=(
    "UAV Systems Design"
    "Command & Control"
    "System Architecture"
    "Flight Test Engineering"
    "RF & Communications"
    "Regulatory Compliance"
)

for service in "${SERVICES[@]}"; do
    if grep -q "$service" "$HTML_FILE"; then
        log_pass "Service: $service"
    else
        log_fail "Missing service: $service"
    fi
done
echo ""

# -----------------------------------------
# SECTION 6: Contact Form (from SPEC)
# -----------------------------------------
echo "📧 Contact Form..."

FORM_FIELDS=(
    "name"
    "email"
    "message"
)

for field in "${FORM_FIELDS[@]}"; do
    if grep -q "id=\"$field\"" "$HTML_FILE"; then
        log_pass "Form field: $field"
    else
        log_fail "Missing form field: $field"
    fi
done

# Form validation
if grep -q "required" "$HTML_FILE"; then
    log_pass "Form has required validation"
else
    log_fail "Missing form validation"
fi

# Success message
if grep -q "form-success" "$HTML_FILE"; then
    log_pass "Success message element"
else
    log_fail "Missing success message"
fi
echo ""

# -----------------------------------------
# SECTION 7: JavaScript Functionality
# -----------------------------------------
echo "⚡ JavaScript Functionality..."

JS_FEATURES=(
    "IntersectionObserver:Scroll animations"
    "addEventListener:Event listeners"
    "counter:Counter animation"
    "form:Form handling"
    "hamburger:Mobile menu"
)

for feature_pair in "${JS_FEATURES[@]}"; do
    FEATURE="${feature_pair%%:*}"
    NAME="${feature_pair##*:}"
    if grep -q "$FEATURE" "$HTML_FILE"; then
        log_pass "JS feature: $NAME"
    else
        log_fail "Missing JS: $NAME"
    fi
done
echo ""

# -----------------------------------------
# SECTION 8: Navigation (from SPEC)
# -----------------------------------------
echo "🧭 Navigation..."

NAV_ITEMS=(
    "Home"
    "Services"
    "About"
    "Contact"
)

for item in "${NAV_ITEMS[@]}"; do
    if grep -q "href=\"#$item\"" "$HTML_FILE" || grep -q "href=\"#${item,,}\"" "$HTML_FILE"; then
        log_pass "Nav item: $item"
    else
        log_fail "Missing nav: $item"
    fi
done

# Hamburger menu
if grep -q "hamburger" "$HTML_FILE"; then
    log_pass "Hamburger menu"
else
    log_fail "Missing hamburger menu"
fi
echo ""

# -----------------------------------------
# SECTION 9: Typography (from SPEC)
# -----------------------------------------
echo "🔤 Typography..."

if grep -q "Montserrat" "$HTML_FILE"; then
    log_pass "Montserrat font (headings)"
else
    log_fail "Missing Montserrat font"
fi

if grep -q "Source Sans" "$HTML_FILE"; then
    log_pass "Source Sans font (body)"
else
    log_fail "Missing Source Sans font"
fi
echo ""

# -----------------------------------------
# SUMMARY
# -----------------------------------------
echo "=============================================="
echo "📊 TEST AGENT SUMMARY"
echo "=============================================="
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 ALL TESTS PASSED${NC}"
    exit 0
else
    echo -e "${RED}❌ $FAILED TEST(S) FAILED${NC}"
    exit 1
fi
