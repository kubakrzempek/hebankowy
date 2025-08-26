# Hebankowy.pl Static Site Migration - TODO List

## Overview
Convert the existing Ruby Sinatra + Aurelia SPA blog to a static Jekyll site hosted on GitHub Pages using an **iterative approach**:
1. **Foundation first** - build site structure, templates, styling
2. **Content migration** - convert all existing posts to static content
3. **Remove dynamic features** - eliminate commenting, user interactions, and API dependencies

## Why Jekyll for This Project
- **Native GitHub Pages support** - zero-config deployment
- **Simple templating** - perfect for static content display
- **Performance benefits** - faster loading, better SEO
- **Maintenance-free** - no server management or security updates needed
- **Cost effective** - free hosting on GitHub Pages

## TODO Progress Tracker

### 🚀 Phase 1: Foundation Setup (Days 1-2) ✅ COMPLETE
**Goal**: Live site with navigation and basic styling

#### 1.1 Jekyll Site Setup
- [x] Install Jekyll and dependencies (`gem install jekyll bundler`)
- [x] Create new Jekyll site: `jekyll new hebankowy-archive`
- [x] Initialize Git repository in the new project
- [x] Configure `_config.yml` with basic site settings

#### 1.2 Directory Structure Creation
- [x] Create `_layouts/` directory
- [x] Create `_includes/` directory
- [x] Create `_sass/base/` directory
- [x] Create `_sass/components/` directory
- [x] Create `pages/` directory
- [x] Create `assets/css/` directory
- [x] Create `assets/images/` directory

#### 1.3 Basic Templates
- [x] Create `_layouts/default.html` (main wrapper with nav/footer)
- [x] Create `_layouts/page.html` (for static pages like /o-nas)
- [x] Create `_layouts/post.html` (empty template for now)
- [x] Create `_includes/navigation.html` (top navigation)
- [x] Create `_includes/footer.html` (site footer)

#### 1.4 Styling Foundation
- [x] Migrate `_colors.scss` from existing codebase
- [x] Migrate `_typography.scss` from existing codebase
- [x] Migrate `_utils.scss` from existing codebase
- [x] Create `_navigation.scss` for nav styles
- [x] Create `_footer.scss` for footer styles
- [x] Create main `assets/css/main.scss` stylesheet

#### 1.5 About Page
- [x] Create `pages/o-nas.md` (convert from existing about page)
- [x] Add proper frontmatter and layout reference
- [x] Migrate content from current `/o-nas` page

#### 1.6 Assets
- [x] Copy logo.svg to `assets/images/`
- [x] Copy any essential images for foundation

#### 1.7 Foundation Deployment
- [x] Push foundation to GitHub repository
- [x] Enable GitHub Pages in repository settings
- [x] Test live site deployment
- [x] Verify navbar displays correctly
- [x] Verify footer displays correctly
- [x] Verify `/o-nas` page works
- [x] Confirm basic styling is applied

**✅ Foundation Complete When**: Live site with working navigation, footer, and about page

**✅ Foundation Complete When**: Live site with working navigation, footer, and about page

---

### 📝 Phase 2: Content Templates (Day 2-3)
**Goal**: Working post template and content download system

#### 2.1 Post Template Development
- [ ] Create complete `_layouts/post.html` with:
  - [ ] Post title and date display
  - [ ] Category links
  - [ ] Featured image support
  - [ ] Content area
  - [ ] Static comments display (read-only)
- [ ] Create `_includes/post-tile.html` for post listings
- [ ] Add post-specific SCSS styling
- [ ] **Remove all interactive elements** (like buttons, comment forms)

#### 2.2 Download Script Creation
- [ ] Create `download_post.rb` script
- [ ] Implement API connection to `/api/posts/{slug}`
- [ ] Add image downloading functionality
- [ ] Add markdown file generation with frontmatter
- [ ] Add error handling and validation
- [ ] Test script with sample post slug

#### 2.3 Content Testing
- [ ] Download one test post: `ruby download_post.rb <sample-slug>`
- [ ] Verify post displays correctly on site
- [ ] Check image links work properly
- [ ] Test responsive design on mobile
- [ ] Deploy test post and verify live site

**✅ Content Templates Complete When**: One test post displays perfectly on live site

---

### 🎨 Phase 3: Template Migration (Days 3-5)
**Goal**: Complete UI components migrated from Aurelia to Jekyll

#### 3.1 Navigation Component Enhancement
- [ ] Convert Aurelia nav-bar component to Jekyll
- [ ] Implement dynamic category links using `site.data.categories`
- [ ] Add responsive mobile navigation
- [ ] Style navigation to match original design
- [ ] Test navigation on all screen sizes

#### 3.2 Post Components
- [ ] Enhance post-tile component with:
  - [ ] Featured image handling
  - [ ] Excerpt truncation
  - [ ] Date formatting
  - [ ] Category badges
- [ ] Create post listing templates for homepage
- [ ] Add pagination support if needed

#### 3.3 SCSS Migration
- [ ] Migrate all base styles from `app/assets/stylesheets/`
- [ ] Convert component styles:
  - [ ] Post tile styles
  - [ ] Post content styles
  - [ ] Category page styles
  - [ ] Navigation styles
  - [ ] Footer styles
- [ ] **Remove all dynamic/interactive styles** (likes, comment forms, buttons, API loading states)
- [ ] **Remove JavaScript dependencies** and dynamic behaviors
- [ ] Optimize for static content display only
- [ ] Test responsive breakpoints

#### 3.4 Category System
- [ ] Create `_data/categories.yml` file
- [ ] Create `_layouts/category.html` layout
- [ ] Create category archive pages
- [ ] Test category navigation and pages

**✅ Template Migration Complete When**: All UI components work and match original design

---

### 📊 Phase 4: Content Migration (Days 5-6)
**Goal**: All existing content migrated to static format

#### 4.1 Export Script Enhancement
- [ ] Create bulk export script for all existing posts
- [ ] Add batch processing for multiple posts
- [ ] Implement image organization by year/month
- [ ] Add progress tracking and logging
- [ ] Add validation for exported content

#### 4.2 Data Processing
- [ ] Export all published posts from current site/API
- [ ] Download and organize all images
- [ ] Convert existing comments to static display-only data
- [ ] Generate category data file
- [ ] Create tag index if needed
- [ ] **Remove all user-generated content submission features**

#### 4.3 Content Organization
- [ ] Organize posts by date in `_posts/` directory
- [ ] Create proper frontmatter for all posts:
  - [ ] Title, date, categories, tags
  - [ ] Featured images, excerpts
  - [ ] Custom fields (distance, route, location)
  - [ ] Static comments data (display only)
- [ ] Organize images in logical directory structure
- [ ] Create category pages for all categories
- [ ] **Ensure no forms or interactive elements remain**

#### 4.4 Static Conversion Verification
- [ ] Run bulk export script
- [ ] Verify all posts have proper frontmatter
- [ ] Check all images downloaded correctly
- [ ] Test random sample of posts on local site
- [ ] Validate all internal links work
- [ ] **Confirm no dynamic features remain**

**✅ Content Migration Complete When**: All existing posts accessible locally as static content with no interactive features

---

### 🧪 Phase 5: Testing & Validation (Day 6-7)
**Goal**: Thoroughly tested site ready for production

#### 5.1 Content Validation
- [ ] Test all posts display correctly
- [ ] Verify all images load properly
- [ ] Check all internal links work
- [ ] Validate category pages show correct posts
- [ ] Test post navigation (prev/next)

#### 5.2 Technical Testing
- [ ] Validate HTML markup
- [ ] Test CSS styling across browsers
- [ ] Check responsive design on multiple devices
- [ ] Test site performance and loading times
- [ ] Validate SEO meta tags

#### 5.3 User Experience Testing
- [ ] Test navigation flow
- [ ] **Verify no interactive elements are present** (no comment forms, like buttons, etc.)
- [ ] Check accessibility features
- [ ] Test on slow connections
- [ ] Validate mobile experience
- [ ] **Confirm site works without JavaScript**

#### 5.4 Pre-Launch Checks
- [ ] Test local build: `bundle exec jekyll serve`
- [ ] Fix any broken links or missing images
- [ ] Optimize large images if needed
- [ ] Test GitHub Pages build locally
- [ ] Create final backup of original site

**✅ Testing Complete When**: All content displays perfectly and site performs well

---

### 🚀 Phase 6: Production Deployment (Day 7-8)
**Goal**: Live production site with custom domain

#### 6.1 GitHub Repository Setup
- [ ] Create new GitHub repository: `hebankowy-archive`
- [ ] Push complete Jekyll site to repository
- [ ] Configure repository settings for GitHub Pages
- [ ] Enable GitHub Pages on main branch
- [ ] Test GitHub Pages deployment

#### 6.2 Domain Configuration
- [ ] Configure DNS records for custom domain
- [ ] Add CNAME record: `hebankowy.pl -> username.github.io`
- [ ] Add custom domain in GitHub Pages settings
- [ ] Test custom domain access
- [ ] Verify HTTPS certificate

#### 6.3 Production Monitoring
- [ ] Monitor for broken links using tools
- [ ] Check site performance on live domain
- [ ] Verify all redirects work properly
- [ ] Test from different geographic locations
- [ ] Monitor DNS propagation

#### 6.4 Launch Verification
- [ ] Test all major user journeys
- [ ] Verify SEO meta tags are working
- [ ] Check sitemap.xml generation
- [ ] Test social media sharing
- [ ] Validate Google Analytics (if used)

**✅ Deployment Complete When**: Live site accessible at hebankowy.pl with all content working

---

## 📋 Pre-Migration Preparation Checklist

### Environment Setup
- [ ] Install Ruby and Jekyll locally
- [ ] Set up development environment
- [ ] Test Jekyll installation with sample site
- [ ] Install necessary gems and dependencies

### Data Backup & Documentation
- [ ] Backup current database completely
- [ ] Document current URL structure
- [ ] Create inventory of all uploaded images
- [ ] Document current site functionality
- [ ] Export current site analytics data

### Access & Credentials
- [ ] Ensure access to current site API
- [ ] Verify GitHub account and permissions
- [ ] Check domain registrar access
- [ ] Document any third-party integrations

---

## 🎯 Success Criteria

### Technical Requirements
- ✅ All existing posts accessible and properly formatted as static content
- ✅ Images display correctly and load efficiently
- ✅ Navigation works and categories are browsable
- ✅ Site loads quickly on GitHub Pages
- ✅ Custom domain (hebankowy.pl) works correctly
- ✅ Responsive design works on all devices
- ✅ SEO meta tags and sitemaps generated automatically
- ✅ **No dynamic features or user interactions remain**

### Content Requirements
- ✅ All posts maintain original formatting and content
- ✅ Existing comments preserved as static display-only content
- ✅ Categories and tags properly organized
- ✅ Images optimized and properly linked
- ✅ About page content migrated accurately
- ✅ **No forms, comment submission, or user-generated content features**

### Performance Requirements
- ✅ Page load times under 3 seconds
- ✅ Mobile-friendly design
- ✅ SEO optimization maintained or improved
- ✅ Accessibility standards met
- ✅ **Works without JavaScript dependencies**

---

## ⚠️ Risk Mitigation

### Potential Issues & Solutions
- **Image size limits**: Use image optimization tools if needed
- **URL structure changes**: Set up redirects in Jekyll or document changes
- **Missing content**: Thorough testing of export script before bulk migration
- **DNS propagation delays**: Plan deployment timing carefully
- **Build failures**: Test GitHub Pages build process extensively
- **Dynamic feature removal**: Ensure all interactive elements are properly removed without breaking layout

### Rollback Plan
- [ ] Keep original site running during migration
- [ ] Document rollback procedures
- [ ] Have DNS change reversal plan ready
- [ ] Maintain backup of all original data

---

## 📅 Estimated Timeline

**Total Duration**: 7-8 days

- **Days 1-2**: Foundation Setup (Jekyll site, basic templates, initial deployment)
- **Day 2-3**: Content Templates (post layouts, scripts for conversion, testing)
- **Days 3-5**: Template Migration (UI components, styling, removing dynamic features)
- **Days 5-6**: Content Migration (all existing posts, images, static conversion)
- **Day 6-7**: Testing & Validation (comprehensive testing, static-only verification)
- **Day 7-8**: Production Deployment (domain setup, final launch, monitoring)

---

## 💡 Notes

- **Static-First Approach**: Remove all dynamic features and dependencies
- **Content Preservation**: Maintain all existing content but make it read-only
- **Performance Focus**: Optimize for fast static site performance
- **No User Interactions**: Eliminate commenting, forms, and any user-generated content features
- **Maintenance-Free**: Final site should require no ongoing server maintenance
- **Documentation**: Keep detailed notes of removed features and any content changes
