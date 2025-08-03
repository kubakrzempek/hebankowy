import {inject} from "aurelia-framework";
import {HttpClient, json} from "aurelia-fetch-client";
import 'fetch';

@inject(HttpClient)
export class CommentService {
  baseUrl = '/api/comments'

  constructor(http) {
    this.http = http;
  }

  create(params) {
    return this.http.fetch(this.baseUrl, {
      method: "post",
      body: json(params),
    });
  }
}
