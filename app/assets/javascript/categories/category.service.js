import {inject} from 'aurelia-framework';
import {HttpClient} from 'aurelia-fetch-client';
import 'fetch';

@inject(HttpClient)
export class CategoryService {
  baseUrl = '/api/categories';

  constructor(http) {
    this.http = http;
  }

  index() {
    return this.http.fetch(this.baseUrl);
  }

  show(id) {
    return this.http.fetch(`${this.baseUrl}/${id}`);
  }
}
