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
  <li class="tabs-item mod-selected" data-category-id="0">wszystkie</li>
  {% assign categories = "miasta,parki,zamki,pola,woda,góry,lasy" | split: "," %}
  {% assign category_urls = "miasta,parki,zamki,pola,woda,gory,lasy" | split: "," %}
  {% for category in categories %}
    {% assign category_url = category_urls[forloop.index0] %}
    <li class="tabs-item" data-category-id="{{ category }}">
      <a href="{{ '/' | append: category_url | append: '/' | relative_url }}" style="color: inherit; text-decoration: none; display: flex; align-items: center; gap: 0.5em;">
        <img class="tabs-item-image" src="{{ '/assets/images/' | append: category | append: '.svg' | relative_url }}" alt="{{ category }}">
        {{ category }}
      </a>
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
</script>
