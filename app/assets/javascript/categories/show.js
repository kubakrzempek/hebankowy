import {inject} from 'aurelia-framework';
import {CategoryService} from './category.service';

@inject(CategoryService)
export class CategoriesShow {
  category = {};

  constructor(categoryService) {
    this.categoryService = categoryService;
  }

  activate(params) {
    return this.categoryService.show(params.id)
      .then(response => response.json())
      .then(category => this.category = category);
  }
}
