import {inject} from 'aurelia-framework';
import { HttpClient, json } from 'aurelia-fetch-client';
import 'fetch';

@inject(HttpClient)
export class PhotoService {
  baseUrl = '/api/photos';

  constructor(http){
    this.http = http;
  }

  index() {
    return this.http.fetch(this.baseUrl);
  }

  show(id) {
    return this.http.fetch(`${this.baseUrl}/${id}`);
  }

  process(id, params){
    let esc = encodeURIComponent;
    let query = Object.keys(params)
      .map(k => esc(k) + '=' + esc(params[k]))
      .join('&');
    return this.http.fetch(`${this.baseUrl}/${id}/process?${query}`);
  }
}
