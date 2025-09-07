---
layout: default
title: "Hebankowy.pl - Blog dla miłośników psów we Wrocławiu"
---

{% include featured-post.html %}

<h1 class="articles-header home-rest-tag mobile">Pozostałe wpisy</h1>

<p class="home-mobile-dropdown mobile" onclick="toggleFilters()">
  <span id="selectedCategoryName">wszystkie</span>
  <span>▼</span>
</p>

<ul class="tabs mod-collapsed">
  <li class="tabs-item mod-selected" data-category-id="0" onclick="clearFilter()">wszystkie</li>
  {% assign categories = "miasta,parki,zamki,pola,woda,góry,lasy" | split: "," %}
  {% for category in categories %}
    <li class="tabs-item" onclick="filterPosts('{{ category }}')" data-category-id="{{ category }}">
      <img class="tabs-item-image" src="{{ '/assets/images/' | append: category | append: '.svg' | relative_url }}" alt="{{ category }}">
      {{ category }}
    </li>
  {% endfor %}
</ul>

<div class="articles">
  {% for post in site.posts offset: 1 %}
    {% include post-tile.html %}
  {% endfor %}
</div>

<script>
function toggleFilters() {
  const tabs = document.querySelector('.tabs');
  tabs.classList.toggle('mod-collapsed');
}

function clearFilter() {
  const allPosts = document.querySelectorAll('.articles-item');
  const tabItems = document.querySelectorAll('.tabs-item');

  // Reset selected state
  tabItems.forEach(item => item.classList.remove('mod-selected'));
  document.querySelector('[data-category-id="0"]').classList.add('mod-selected');

  // Show all posts
  allPosts.forEach(post => post.style.display = 'block');

  // Update dropdown text
  document.getElementById('selectedCategoryName').textContent = 'wszystkie';
}

function filterPosts(categoryName) {
  const allPosts = document.querySelectorAll('.articles-item');
  const tabItems = document.querySelectorAll('.tabs-item');

  // Reset selected state
  tabItems.forEach(item => item.classList.remove('mod-selected'));
  document.querySelector(`[data-category-id="${categoryName}"]`).classList.add('mod-selected');

  // Filter posts by category
  allPosts.forEach(post => {
    const categoryLabel = post.querySelector('.content-category-label');
    if (categoryLabel && categoryLabel.textContent.trim() === categoryName) {
      post.style.display = 'block';
    } else {
      post.style.display = 'none';
    }
  });

  // Update dropdown text
  document.getElementById('selectedCategoryName').textContent = categoryName;

  // Collapse mobile dropdown
  document.querySelector('.tabs').classList.add('mod-collapsed');
}
</script>
