# Hebankowy.pl Static Archive Migration Plan

## Overview
Convert the existing Ruby Sinatra + Aurelia blog to a static Jekyll archive hosted on GitHub Pages using an **iterative approach**:
1. **Foundation first** - build site structure, templates, styling
2. **Content second** - incrementally add posts one by one

## Why Jekyll for This Project
- **Native GitHub Pages support** - zero-config deployment
- **Simple templating** - perfect for iterative development
- **Stable and mature** - ideal for historical archives
- **Immediate feedback** - see changes live with each commit

## Iterative Migration Strategy

### Phase 1: Foundation (2-3 days)
*Build core site structure and templates first*

#### 1.1 Jekyll Site Setup
```bash
# Create new Jekyll site
jekyll new hebankowy-archive
cd hebankowy-archive
```

#### 1.2 Basic Structure
```
_layouts/
├── default.html      # Main wrapper with nav/footer
├── page.html         # For static pages like /o-nas
└── post.html         # Post template (empty for now)

_includes/
├── navigation.html   # Top navigation
└── footer.html       # Site footer

_sass/
├── base/
│   ├── _colors.scss     # Migrated from existing
│   ├── _typography.scss # Migrated from existing  
│   └── _utils.scss      # Migrated from existing
└── components/
    ├── _navigation.scss # Migrated nav-bar styles
    └── _footer.scss     # Migrated footer styles

pages/
└── o-nas.md          # About page

assets/
├── css/
│   └── main.scss     # Main stylesheet
└── images/
    └── logo.svg      # Site logo
```

#### 1.3 Deploy Foundation
- Push to GitHub repository
- Enable GitHub Pages
- Verify navbar, footer, /o-nas page work
- **Goal**: Live site with navigation and styling

### Phase 2: Content Integration (ongoing)
*Add posts incrementally, one by one*

#### 2.1 Create Post Template
```html
<!-- _layouts/post.html -->
---
layout: default
---
<article class="post">
  <header>
    <h1>{{ page.title }}</h1>
    <time>{{ page.date | date: "%d %B %Y" }}</time>
  </header>
  <div class="content">
    {{ content }}
  </div>
</article>
```

#### 2.2 Single Post Download Script
```ruby
# download_post.rb <post-slug>
# Downloads single post from API and creates markdown file
require 'net/http'
require 'json'

def download_post(slug)
  # Fetch from /api/posts/#{slug}
  # Download associated images
  # Create _posts/YYYY-MM-DD-slug.md with frontmatter
end
```

#### 2.3 Iterative Process
1. **Test with one post** - verify template works
2. **Add posts gradually** - `ruby download_post.rb hiking-sudety`
3. **Deploy frequently** - see changes live immediately
4. **Refine as needed** - adjust templates based on real content

## Implementation Steps

### Step 1: Foundation Setup (Day 1)
1. **Create Jekyll site structure**
2. **Build navigation template** (convert from existing Aurelia nav-bar)
3. **Build footer template** (convert from existing footer)
4. **Create /o-nas page** (convert from existing about-us)
5. **Migrate SCSS files** (from app/assets/stylesheets/)
6. **Deploy to GitHub Pages**

### Step 2: Content Templates (Day 2)  
1. **Create post layout template**
2. **Test with sample post**
3. **Create download script for individual posts**

### Step 3: Incremental Content (Ongoing)
1. **Download posts one by one**: `ruby download_post.rb <slug>`
2. **Commit and deploy frequently**
3. **Refine templates as needed**

## Jekyll Configuration
```yaml
# _config.yml
title: "Hebankowy.pl"
description: "Blog dla miłośników psów we Wrocławiu"
baseurl: ""
url: "https://USERNAME.github.io"

markdown: kramdown
highlighter: rouge
plugins:
  - jekyll-sitemap
  - jekyll-seo-tag

collections:
  categories:
    output: true
    permalink: /categories/:name/

defaults:
  - scope:
      path: ""
      type: "posts"
    values:
      layout: "post"
  - scope:
      path: ""
      type: "categories"
    values:
      layout: "category"
```

### Phase 3: Template Migration (2-3 days)

#### 3.1 Convert Aurelia Components

**Navigation Component** (`_includes/navigation.html`):
```html
<nav class="navbar">
  <div class="container">
    <a href="/" class="logo">
      <img src="/assets/images/logo.svg" alt="Hebankowy.pl">
    </a>
    <ul class="nav-links">
      {% for category in site.data.categories %}
        <li><a href="/categories/{{ category.slug }}/">{{ category.name }}</a></li>
      {% endfor %}
    </ul>
  </div>
</nav>
```

**Post Tile Component** (`_includes/post-tile.html`):
```html
<article class="post-tile">
  <a href="{{ post.url }}">
    {% if post.featured_image %}
      <img src="{{ post.featured_image }}" alt="{{ post.title }}">
    {% endif %}
    <h3>{{ post.title }}</h3>
    <p>{{ post.excerpt | strip_html | truncate: 150 }}</p>
    <time>{{ post.date | date: "%d.%m.%Y" }}</time>
  </a>
</article>
```

**Post Layout** (`_layouts/post.html`):
```html
---
layout: default
---
<article class="post">
  <header>
    <h1>{{ page.title }}</h1>
    <time>{{ page.date | date: "%d %B %Y" }}</time>
    {% if page.categories %}
      <div class="categories">
        {% for category in page.categories %}
          <a href="/categories/{{ category | slugify }}/">{{ category }}</a>
        {% endfor %}
      </div>
    {% endif %}
  </header>

  {% if page.featured_image %}
    <img src="{{ page.featured_image }}" alt="{{ page.title }}" class="featured-image">
  {% endif %}

  <div class="content">
    {{ content }}
  </div>

  {% if page.comments %}
    <section class="comments-archive">
      <h3>Komentarze (archiwalne)</h3>
      {% for comment in page.comments %}
        <div class="comment">
          <strong>{{ comment.author }}</strong>
          <time>{{ comment.date }}</time>
          <p>{{ comment.content }}</p>
        </div>
      {% endfor %}
    </section>
  {% endif %}
</article>
```

#### 3.2 SCSS Migration

**Convert existing stylesheets** from `app/assets/stylesheets/` to Jekyll's `_sass/` directory:
- Keep existing color scheme and typography
- Adapt responsive breakpoints
- Remove dynamic/interactive styles (likes, comment forms)
- Optimize for static content display

### Phase 4: Content Processing (1-2 days)

#### 4.1 Post Format
```markdown
---
layout: post
title: "Hiking in Sudety Mountains with Dogs"
date: 2019-05-15
categories: [góry]
tags: [hiking, sudety, weekend]
featured_image: /assets/images/posts/2019/sudety-cover.jpg
excerpt: "Perfect weekend trip to Sudety mountains with our four-legged friends..."
slug: hiking-sudety-mountains
distance: 12.5
route: "Szklarska Poręba - Śnieżka - Karpacz"
location: "Karkonosze National Park"
likes: 45
comments:
  - author: "Anna K."
    date: 2019-05-16
    content: "Świetne zdjęcia! Muszę tam pojechać z moim psem."
  - author: "Tomek"
    date: 2019-05-17
    content: "Polecam też szlak na Śnieżkę przez Czarny Kocioł."
---

Weekend in Sudety mountains was absolutely amazing. We decided to take our dogs...

![Mountain view]({{ "/assets/images/posts/2019/sudety-mountain-view.jpg" | relative_url }})

The trail from Szklarska Poręba to Śnieżka is perfect for dogs...
```

#### 4.2 Category Pages
```markdown
---
layout: category
title: "Góry"
category: góry
icon: /assets/images/categories/gory.svg
description: "Wyprawy górskie z psami"
---

Lista wszystkich wpisów z kategorii górskiej.
```

### Phase 5: Deployment (1 day)

#### 5.1 GitHub Repository Setup
```bash
# Create new repository: hebankowy-archive
# Enable GitHub Pages in repository settings
# Point custom domain hebankowy.pl to GitHub Pages
```

#### 5.2 DNS Configuration
```
CNAME record: hebankowy.pl -> USERNAME.github.io
```

#### 5.3 Automated Deployment
GitHub Pages automatically builds and deploys Jekyll sites on every push to the main branch.

## Technical Implementation Steps

### Step 1: Export Script
Create Ruby script to:
1. Fetch all posts from `/api/posts`
2. Download all images from `/uploads/` directory
3. Convert API JSON to Jekyll markdown with frontmatter
4. Organize files in Jekyll structure

### Step 2: Template Creation
1. Set up basic Jekyll site structure
2. Create layout templates (default, post, category)
3. Convert Aurelia components to Jekyll includes
4. Migrate SCSS stylesheets

### Step 3: Content Migration
1. Run export script
2. Process images (organize, optimize if needed)
3. Generate category pages
4. Create navigation data file

### Step 4: Testing & Deployment
1. Test locally with `bundle exec jekyll serve`
2. Verify all internal links work
3. Check responsive design
4. Deploy to GitHub Pages

## Migration Checklist

### Pre-Migration
- [ ] Backup current database
- [ ] Download all uploaded images
- [ ] Document current URL structure
- [ ] Set up Jekyll development environment

### Content Export
- [ ] Export all published posts
- [ ] Export categories and tags
- [ ] Download and organize images
- [ ] Convert comments to static data

### Template Development
- [ ] Create base layout template
- [ ] Build navigation component
- [ ] Design post layout
- [ ] Create category archive pages
- [ ] Convert and optimize SCSS

### Testing
- [ ] Verify all posts display correctly
- [ ] Test navigation and internal links
- [ ] Check responsive design on mobile
- [ ] Validate HTML and CSS
- [ ] Test performance and loading times

### Deployment
- [ ] Set up GitHub repository
- [ ] Configure GitHub Pages
- [ ] Update DNS records
- [ ] Set up custom domain
- [ ] Monitor for broken links

## Expected Timeline
- **Day 1-2**: Data export and Jekyll setup
- **Day 3-5**: Template migration and styling
- **Day 6-7**: Content processing and testing
- **Day 8**: Deployment and DNS setup

**Total: ~8 days** for complete migration

## Risks & Mitigation
- **Image size limits**: Use image optimization tools if needed
- **URL structure changes**: Set up redirects in Jekyll
- **Missing content**: Thorough testing of export script
- **DNS propagation**: Plan deployment timing carefully

## Success Criteria
✅ All historical posts accessible and properly formatted  
✅ Images display correctly and load efficiently  
✅ Navigation works and categories are browsable  
✅ Site loads quickly on GitHub Pages  
✅ Custom domain (hebankowy.pl) works correctly  
✅ Responsive design works on all devices  
✅ SEO meta tags and sitemaps generated automatically