import {inject} from 'aurelia-framework';
import {HttpClient, json} from 'aurelia-fetch-client';
import { PostService } from './post.service';
import 'fetch';

@inject(HttpClient, PostService)
export class AdminPostsIndex {
  posts = [];
  baseUrl = '/api/posts';
  newPost = {
    content: `
      <h2>Dzisiaj jesteśmy w nowym miejscu</h2>
      <p>Kilka słów o okolicy</p>
      <p>I jeszcze kilka słów</p>
      <div class="image-almost-full">
        <picture>
          <source media="(min-width: 980px)" srcset="obrazek-desktop">
          <img srcset="obrazek-mobile" alt="alt text">
        </picture>
      </div>
      <h2>A tak wygląda standardowy obrazek</h2>
      <div class="gallery-row">
        <picture>
          <source media="(min-width: 980px)" srcset="obrazek-desktop">
          <img srcset="obrazek-mobile" alt="alt text">
        </picture>
      </div>
    `,
    slug: "",
  };

  constructor(http, postService){
    this.http = http;
    this.postService = postService;
  }

  activate(){
    return this.http.fetch(`${this.baseUrl}/all`)
      .then(response => response.json())
      .then(posts => this.posts = posts);
  }

  addNew(){
    this.addingNew = true;
  }

  createPost(){
    this.postService.create(this.newPost)
      .then(response => {
        if(response.ok) {
          this.newPost = {};
          return response.json()
        } else {
          var error = new Error(response.statusText)
          error.response = response;
          throw error
        }
      })
      .then(post => this.posts.push(post))
      .catch(err => {
        console.log("Problem with network connectivity!");
      });
  }
}
