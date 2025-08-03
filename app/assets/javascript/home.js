import {inject} from 'aurelia-framework';
import {PostService} from './posts/post.service';
import {CategoryService} from './categories/category.service';

@inject(PostService, CategoryService, Element)
export class Home{
  posts = [];
  featuredPost = {};
  // TODO: Find a way to pass them from app.js
  categories = []
  filteredPosts = [];
  selectedCategoryName = "";

  constructor(postService, categoryService, element) {
    this.postService = postService;
    this.categoryService = categoryService;
    this.element = element;
  }

  activate() {
    let posts = this.postService.index()
      .then(response => response.json())
      .then(posts => this.posts = this.filteredPosts = posts);
    let featuredPost =  this.postService.newest()
      .then(response => response.json())
      .then(post => this.featuredPost = post);
    let categories = this.categoryService.index()
      .then(response => response.json())
      .then(categories => this.categories = categories)

    return Promise.all([posts, featuredPost, categories]);
  }

  attached() {
    this.tabs = Array.from(this.element.querySelectorAll(".tabs-item"));
    this.selectedCategoryName = this.element.querySelector(".tabs-item.mod-selected").innerText;
    this.filtersNode = this.element.querySelector(".tabs")
  }

  filterPosts(categoryId) {
    this.filteredPosts = this.posts.filter(post => {
      return post.categories.map(category => category.id).includes(categoryId);
    })
    this.collapseFilters();
    this.removeSelection();
    this.markSelectedTab(categoryId);
  }

  clearFilter() {
    this.filteredPosts = this.posts;
    this.collapseFilters();
    this.removeSelection();
    this.markSelectedTab(0)
  }

  removeSelection() {
    return this.tabs.forEach(tab => {
      tab.classList.remove("mod-selected");
    });
  }

  markSelectedTab(id) {
    let selectedNode = this.tabs.find(tab => {
      return tab.getAttribute("data-category-id") == id.toString();
    })
    selectedNode.classList.add("mod-selected");
    this.selectedCategoryName = selectedNode.innerText;
  }

  collapseFilters() {
    this.filtersNode.classList.add("mod-collapsed");
  }

  revealFilters() {
    this.filtersNode.classList.remove("mod-collapsed");
  }

  get isFilterCollapsed() {
    return this.filtersNode.classList.contains("mod-collapsed");
  }

  toggleFilters() {
    if (this.isFilterCollapsed) {
      this.revealFilters();
    } else {
      this.collapseFilters();
    }
  }
}
