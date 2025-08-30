---
layout: default
title: "Hebankowy.pl - Blog dla miłośników psów we Wrocławiu"
---

<section class="hero">
  <h1>Hebankowy.pl</h1>
  <p>Blog dla miłośników psów we Wrocławiu - archiwum</p>
</section>

<section class="posts">
  <h2>Najnowsze wpisy</h2>
  <div class="posts-grid">
    {% for post in site.posts limit: 9 %}
      {% include post-tile.html %}
    {% endfor %}
  </div>

  <div class="view-all">
    <a href="/archive/" class="btn">Zobacz wszystkie wpisy</a>
  </div>
</section>
