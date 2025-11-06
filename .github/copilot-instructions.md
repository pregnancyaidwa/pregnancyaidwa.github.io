# Pregnancy Aid of Washington - AI Coding Assistant Instructions

## Project Overview
This is a static website for Pregnancy Aid of Washington, a non-profit organization serving pregnant women and families. The site uses **Server Side Includes (SSI)** with `.shtml` files and Bootstrap 3 for styling.

## Architecture & Structure

### SSI Component System
The site uses a modular include-based architecture:
- `_Head1.html` - Meta charset and viewport tags
- `_Head2.html` - CSS links, fonts, and IE compatibility
- `_TopNav.html` - Bootstrap navbar with Washington state logo
- `_Highlights.html` - 4-column service highlight buttons
- `_WeCare.html` - Mission statement and call-to-action sections
- `_zFooter-Nav.html` - Copyright, links, and footer navigation
- `_zFooter-zBootstrap.html` - jQuery and Bootstrap JS includes

### Page Structure Pattern
Every `.shtml` page follows this pattern:
```html
<!--#include file="_Head1.html" -->
<meta name="description" content="Page-specific description" />
<title>Page Title - Pregnancy Aid of Washington</title>
<!--#include file="_Head2.html" -->
<!--#include file="_TopNav.html" -->
<!-- Page content -->
<!--#include file="_Highlights.html" -->
<!--#include file="_WeCare.html" -->
<!--#include file="_zFooter-Nav.html" -->
<!--#include file="_zFooter-zBootstrap.html" -->
```

### Multi-Location Support
The `desmoines/` subdirectory demonstrates the pattern for location-specific pages:
- Uses `<!--#include virtual="../_includes.html" -->` for relative paths
- Contains location-specific images and content
- Maintains consistent styling and navigation

## Styling Conventions

### Custom CSS Classes (site.css)
- `.lobster-xl` (75px) and `.lobster-big` (38px) - Lobster Two font for headings
- `.section-heading` - Bold 20px headings with consistent spacing
- `.well-top` - Removes top margin for first elements in Bootstrap wells
- `.highlights` - Styling for the 4-column service buttons
- `.text-overlay-container` - For positioned image overlays

### Color Scheme
- Primary: Bootstrap success green (`text-success`, `btn-success`)
- Accent: `rgba(241, 196, 15, 0.53)` yellow for wells
- Navigation: `navbar-inverse` dark theme

### CSS Cache Busting
**Important**: When modifying `site.css`, update the version parameter in `_Head2.html`:
```html
<link rel="stylesheet" href="./css/site.css?version=7">
```
This forces mobile browsers (especially Android) to reload the CSS.

## Development Environment
- **Server**: Requires SSI-capable server (IIS, Apache with mod_include)
- **Frameworks**: Bootstrap 3.x, jQuery 1.12.4, Font Awesome icons

## Content Guidelines
- All assistance is "Free", "Confidential", and "Compassionate"
- Use heart icons (`fa-heart`) for feature lists
- Navigation should be accessible without appointments
- Include location-specific contact information and hours

## File Naming Conventions
- Main pages: `PageName.shtml` (capitalize first letter)
- Includes: `_ComponentName.html` (underscore prefix)
- Footer includes: `_zFooter-*.html` (loads last alphabetically)
- Images: descriptive names with alt text in accompanying `.txt` files

## Testing
- Test on mobile devices due to Bootstrap responsive design
- Verify SSI includes work on the target server
- Check CSS cache-busting when styles are modified
- Validate links between `.shtml` pages work correctly