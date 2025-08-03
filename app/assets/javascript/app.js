import {inject} from 'aurelia-framework';
import {Router} from 'aurelia-router';
import AppRouterConfig from 'app.router.config';
import {FetchConfig} from 'aurelia-auth';
import {CategoryService} from './categories/category.service';

@inject(Router, FetchConfig, AppRouterConfig, CategoryService, Element)
export class App {
  categories = [];
  mobileMenuActivated = false;

  constructor(router, fetchConfig, appRouterConfig, categoryService, element){
    this.router = router;
    this.appRouterConfig = appRouterConfig;
    this.fetchConfig = fetchConfig;
    this.categoryService = categoryService;
    this.element = element;
  }

  activate(){
    this.appRouterConfig.configure();
    this.fetchConfig.configure();
    this.mobileMenuActivated = false;
    return this.categoryService.index()
      .then(response => response.json())
      .then(categories => this.categories = categories);
  }

  attached() {
    this.mobileMenuNode = this.element.querySelector('nav-bar');
  }

  toggleMobileMenu() {
    this.mobileMenuActivated = !this.mobileMenuActivated;
    if (this.mobileMenuActivated) {
      this.mobileMenuNode.classList.add('visible')
    } else {
      this.mobileMenuNode.classList.remove('visible')
    }
  }
}
