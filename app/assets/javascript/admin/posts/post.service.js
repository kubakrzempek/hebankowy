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

  show(id) {
    return this.http.fetch(`${this.baseUrl}/${id}`);
  }

  update(id, params) {
    return this.http.fetch(`${this.baseUrl}/${id}`, {
      method: 'put',
      body: json({ post: params }),
    })
  }

  create(params) {
    return this.http.fetch(this.baseUrl, {
      method: 'post',
      body: json(params),
    })
  }
}
