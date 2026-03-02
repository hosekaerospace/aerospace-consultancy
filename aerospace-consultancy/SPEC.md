# Aerospace Consultancy Website — Requirements Specification

## 1. Project Overview

**Project Name:** Aerospace Consultancy Website  
**Type:** Single-page responsive corporate website  
**Core Functionality:** Showcase aerospace consulting services, build credibility, generate leads  
**Target Users:** Aerospace companies, defense contractors, aircraft manufacturers, government agencies

---

## 2. UI/UX Specification

### Layout Structure

**Page Sections (in order):**
1. **Navigation Bar** — Fixed top, transparent → solid on scroll
2. **Hero Section** — Full viewport, background image/video, headline, CTA
3. **About Section** — Company introduction, values, team teaser
4. **Services Section** — Grid of 4-6 core services with icons
5. **Why Choose Us** — Trust indicators, certifications, stats
6. **Testimonials** — Client quotes with logos
7. **Contact Section** — Form + contact info + map
8. **Footer** — Links, social, copyright

**Responsive Breakpoints:**
- Mobile: < 768px (single column)
- Tablet: 768px - 1024px (2 columns)
- Desktop: > 1024px (full layout)

### Visual Design

**Color Palette:**
- Primary: `#0A1628` (Deep navy — trust, professionalism)
- Secondary: `#1E3A5F` (Medium blue)
- Accent: `#00B4D8` (Cyan — aerospace, sky, innovation)
- Highlight: `#F4A261` (Warm orange — CTAs, energy)
- Text: `#FFFFFF` (white on dark), `#1A1A2E` (dark on light)
- Background: `#0A1628` → `#162A4A` gradient

**Typography:**
- Headings: "Rajdhani" (technical, modern, aerospace feel)
- Body: "Source Sans Pro" (clean, readable)
- Sizes: H1: 56px, H2: 42px, H3: 28px, Body: 16px

**Spacing:**
- Section padding: 100px vertical
- Container max-width: 1200px
- Grid gap: 30px

**Visual Effects:**
- Subtle parallax on hero
- Hover lift on service cards (+8px Y, shadow increase)
- Fade-in animations on scroll
- Glowing accent borders on CTA buttons

### Components

**Navigation:**
- Logo (left)
- Links: Home, Services, About, Contact
- CTA button: "Get Consultation"
- Mobile: hamburger menu

**Hero:**
- Headline: "Expert Aerospace Consulting for Tomorrow's Industry"
- Subheadline: "Engineering excellence, regulatory compliance, and innovation solutions"
- CTA: "Request Consultation" (primary), "Our Services" (secondary)

**Service Cards:**
- Icon (SVG)
- Title
- Short description (2 lines)
- "Learn More" link
- Hover: border glow, slight lift

**Stats Bar:**
- 4 metrics: "15+ Years", "200+ Projects", "50+ Clients", "100% Compliance"
- Animated counters

**Contact Form:**
- Fields: Name, Email, Company, Message
- Validation: required + email format
- Submit button with loading state

---

## 3. Functionality Specification

### Core Features

1. **Responsive Design** — Works on all devices
2. **Smooth Scroll** — Anchor links scroll smoothly
3. **Mobile Navigation** — Hamburger menu with slide-in panel
4. **Form Handling** — Client-side validation, success message
5. **Scroll Animations** — Elements fade in as they enter viewport
6. **Counter Animation** — Stats count up on scroll into view

### User Interactions

- Click nav links → smooth scroll to section
- Hover service cards → lift + glow effect
- Click CTA → scroll to contact form
- Submit form → validation → success message
- Scroll → nav becomes solid, animations trigger

### Technical Requirements

- Single HTML file with embedded CSS and JS
- No external frameworks (vanilla HTML/CSS/JS)
- Google Fonts: Rajdhani, Source Sans Pro
- All images: unsplash placeholders or inline SVGs
- Form: client-side only (no backend)

---

## 4. Acceptance Criteria

- [ ] Page loads in under 3 seconds
- [ ] All sections visible and properly styled
- [ ] Navigation works (desktop + mobile)
- [ ] Mobile hamburger menu opens/closes
- [ ] Form validates required fields
- [ ] Form shows success message on submit
- [ ] Scroll animations trigger correctly
- [ ] Stats counter animates on scroll
- [ ] All links work
- [ ] No horizontal scroll on mobile
- [ ] Accessible (proper heading hierarchy, alt text)
