#!/bin/bash
# ===========================================
# REVIEW AGENT - Quality & Compliance Check
# Based on AI Architecture: Evaluator-Optimizer
# ===========================================

# Don't exit on error - continue testing
# set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_FILE="$REPO_DIR/index.html"
SPEC_FILE="$REPO_DIR/SPEC.md"

echo "=============================================="
echo "🔍 REVIEW AGENT - Quality & Compliance"
echo "=============================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0
WARNINGS=0

log_pass() { echo -e "${GREEN}✓ PASS${NC}: $1"; ((PASSED++)); }
log_fail() { echo -e "${RED}✗ FAIL${NC}: $1"; ((FAILED++)); }
log_warn() { echo -e "${YELLOW}⚠ WARN${NC}: $1"; ((WARNINGS++)); }
log_info() { echo -e "${BLUE}ℹ INFO${NC}: $1"; }

# -----------------------------------------
# SECTION 1: Content Quality
# -----------------------------------------
echo "📄 Content Quality..."

# Company name
if grep -q "Hošek Aerospace Consulting" "$HTML_FILE"; then
    log_pass "Company name present"
else
    log_fail "Company name missing"
fi

# Founder info
if grep -q "Vlastimil" "$HTML_FILE"; then
    log_pass "Founder name present"
else
    log_warn "Founder name not found"
fi

# Contact info
if grep -q "vlastimil.hosek@gmail.com" "$HTML_FILE"; then
    log_pass "Email contact present"
else
    log_fail "Email contact missing"
fi

# Phone number
if grep -q "+41" "$HTML_FILE"; then
    log_pass "Phone number present"
else
    log_warn "Phone number not found"
fi

# Location
if grep -q "Switzerland" "$HTML_FILE"; then
    log_pass "Location present"
else
    log_warn "Location not found"
fi
echo ""

# -----------------------------------------
# SECTION 2: Experience Timeline
# -----------------------------------------
echo "📜 Experience Timeline..."

COMPANIES=(
    "SwissDrones"
    "Lilium"
    "Honeywell"
    "Drone Masters"
)

for company in "${COMPANIES[@]}"; do
    if grep -q "$company" "$HTML_FILE"; then
        log_pass "Experience: $company"
    else
        log_warn "Missing: $company"
    fi
done
echo ""

# -----------------------------------------
# SECTION 3: Visual Design Compliance
# -----------------------------------------
echo "🎨 Visual Design..."

# Hero section has gradient
if grep -q "gradient" "$HTML_FILE"; then
    log_pass "Hero gradient background"
else
    log_fail "Hero gradient missing"
fi

# CTA buttons present
if grep -q "btn-primary" "$HTML_FILE" && grep -q "btn-secondary" "$HTML_FILE"; then
    log_pass "CTA buttons present"
else
    log_fail "CTA buttons missing"
fi

# Hover effects
if grep -q ":hover" "$HTML_FILE"; then
    log_pass "Hover effects defined"
else
    log_warn "No hover effects found"
fi

# Animations
if grep -q "fade-in" "$HTML_FILE"; then
    log_pass "Scroll animations present"
else
    log_warn "No scroll animations"
fi

# Service cards styling
if grep -q "service-card" "$HTML_FILE"; then
    log_pass "Service cards styled"
else
    log_fail "Service cards missing"
fi

# Stats/counters
if grep -q "stat-number" "$HTML_FILE"; then
    log_pass "Stats/counters present"
else
    log_warn "Stats counters not found"
fi
echo ""

# -----------------------------------------
# SECTION 4: Accessibility (from SPEC)
# -----------------------------------------
echo "♿ Accessibility..."

# Heading hierarchy
H1_COUNT=$(grep -c "<h1" "$HTML_FILE" || echo "0")
H2_COUNT=$(grep -c "<h2" "$HTML_FILE" || echo "0")

if [ "$H1_COUNT" -ge 1 ]; then
    log_pass "H1 headings present ($H1_COUNT)"
else
    log_fail "No H1 headings"
fi

if [ "$H2_COUNT" -ge 2 ]; then
    log_pass "H2 headings present ($H2_COUNT)"
else
    log_fail "Not enough H2 headings"
fi

# Alt text for images
if grep -q 'alt="' "$HTML_FILE"; then
    log_pass "Alt attributes present"
else
    log_warn "No alt attributes found"
fi

# Semantic HTML
if grep -q "<nav" "$HTML_FILE" && grep -q "<footer" "$HTML_FILE"; then
    log_pass "Semantic HTML tags"
else
    log_warn "Missing semantic tags"
fi
echo ""

# -----------------------------------------
# SECTION 5: Mobile Responsiveness
# -----------------------------------------
echo "📱 Mobile Responsiveness..."

# Responsive breakpoints
if grep -q "@media" "$HTML_FILE"; then
    log_pass "Media queries present"
else
    log_fail "No media queries"
fi

# Mobile menu
if grep -q "hamburger" "$HTML_FILE" && grep -q "mobile" "$HTML_FILE"; then
    log_pass "Mobile menu implementation"
else
    log_warn "Mobile menu may need work"
fi

# Viewport
if grep -q 'content="width=device-width' "$HTML_FILE"; then
    log_pass "Viewport configured for mobile"
else
    log_fail "Viewport not mobile-optimized"
fi
echo ""

# -----------------------------------------
# SECTION 6: Form Functionality
# -----------------------------------------
echo "📧 Form Functionality..."

# Form validation
if grep -q "emailRegex" "$HTML_FILE" || grep -q "type=\"email\"" "$HTML_FILE"; then
    log_pass "Email validation"
else
    log_warn "Email validation unclear"
fi

# Required fields
if grep -q 'required' "$HTML_FILE"; then
    log_pass "Required field validation"
else
    log_warn "No required attributes"
fi

# Success feedback
if grep -q "formSuccess" "$HTML_FILE" || grep -q "success" "$HTML_FILE"; then
    log_pass "Success message"
else
    log_fail "No success message"
fi

# Form submit handling
if grep -q "preventDefault" "$HTML_FILE"; then
    log_pass "Form submit handling"
else
    log_warn "Form submit may reload page"
fi
echo ""

# -----------------------------------------
# SECTION 7: Code Quality
# -----------------------------------------
echo "💻 Code Quality..."

# Inline CSS vs external (preference: inline for single file)
STYLE_COUNT=$(grep -c "<style>" "$HTML_FILE" || echo "0")
if [ "$STYLE_COUNT" -ge 1 ]; then
    log_pass "CSS embedded (good for single file)"
else
    log_warn "No embedded CSS"
fi

# JavaScript inline
SCRIPT_COUNT=$(grep -c "<script>" "$HTML_FILE" || echo "0")
if [ "$SCRIPT_COUNT" -ge 1 ]; then
    log_pass "JavaScript embedded"
else
    log_warn "No embedded JavaScript"
fi

# No external frameworks (from SPEC)
if ! grep -q "bootstrap" "$HTML_FILE" && ! grep -q "jquery" "$HTML_FILE"; then
    log_pass "No external frameworks (vanilla)"
else
    log_warn "External frameworks detected"
fi

# External fonts only
if grep -q "fonts.googleapis.com" "$HTML_FILE"; then
    log_pass "Google Fonts (allowed)"
else
    log_warn "No Google Fonts"
fi
echo ""

# -----------------------------------------
# SECTION 8: Performance Considerations
# -----------------------------------------
echo "⚡ Performance..."

# Inline SVGs (no external image requests)
if grep -q "<svg" "$HTML_FILE"; then
    log_pass "Inline SVGs (fast loading)"
else
    log_warn "No inline SVGs"
fi

# No large images referenced
if grep -q "\.jpg" "$HTML_FILE" || grep -q "\.png" "$HTML_FILE"; then
    log_warn "Image files may slow loading"
else
    log_pass "No heavy images"
fi

# Minified consideration
FILE_SIZE=$(stat -c%s "$HTML_FILE" 2>/dev/null || stat -f%z "$HTML_FILE")
SIZE_KB=$((FILE_SIZE / 1024))
if [ "$SIZE_KB" -lt 100 ]; then
    log_pass "File size reasonable (${SIZE_KB}KB)"
else
    log_warn "File size large (${SIZE_KB}KB)"
fi
echo ""

# -----------------------------------------
# SECTION 9: SPEC Acceptance Criteria
# -----------------------------------------
echo "✅ Acceptance Criteria Check..."

ACCEPTANCE=(
    "All sections visible:hero,services,about,contact"
    "Navigation works:nav-links"
    "Mobile hamburger:hamburger"
    "Form validation:required,email"
    "Scroll animations:fade-in"
    "Counter animation:counter"
)

for item in "${ACCEPTANCE[@]}"; do
    KEY="${item%%:*}"
    VALUE="${item##*:}"
    if grep -q "$VALUE" "$HTML_FILE"; then
        log_pass "Acceptance: $KEY"
    else
        log_fail "Acceptance: $KEY"
    fi
done
echo ""

# -----------------------------------------
# SUMMARY
# -----------------------------------------
echo "=============================================="
echo "📊 REVIEW AGENT SUMMARY"
echo "=============================================="
echo -e "Passed:   ${GREEN}$PASSED${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"
echo -e "Failed:   ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}🎉 PERFECT - All checks passed!${NC}"
    else
        echo -e "${GREEN}✅ GOOD - All tests passed (with warnings)${NC}"
    fi
    exit 0
else
    echo -e "${RED}❌ NEEDS IMPROVEMENT - $FAILED issue(s)${NC}"
    exit 1
fi
