import {inject} from 'aurelia-framework';
import { HttpClient, json } from 'aurelia-fetch-client';
import 'fetch';

@inject(HttpClient)
export class PostService {
  baseUrl = '/api/posts';

  constructor(http){
    this.http = http;
  }

  index() {
    return this.http.fetch(this.baseUrl);
  }

  show(slug) {
    return this.http.fetch(`${this.baseUrl}/${slug}`);
  }

  newest() {
    return this.http.fetch(`${this.baseUrl}/newest`);
  }

  like(id) {
    return this.http.fetch(`${this.baseUrl}/${id}/like`, {
      method: 'post',
      body: json({}),
    })
  }
}
