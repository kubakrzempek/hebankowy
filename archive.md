---
layout: default
title: "Archiwum wpisów"
permalink: /archive/
---

<div class="page">
  <header>
    <h1 class="main-header">Archiwum wszystkich wpisów</h1>
    <p>Przeglądaj wszystkie wpisy z bloga Hebankowy.pl</p>
  </header>

  <div class="posts-grid">
    {% for post in site.posts %}
      {% include post-tile.html %}
    {% endfor %}
  </div>

  {% if site.posts.size == 0 %}
    <p>Brak wpisów do wyświetlenia.</p>
  {% endif %}
</div>
