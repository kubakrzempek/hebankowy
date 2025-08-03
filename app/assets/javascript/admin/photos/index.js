import {inject} from 'aurelia-framework';
import {HttpClient, json} from 'aurelia-fetch-client';
import 'fetch';

@inject(HttpClient)
export class AdminPhotos {
  photos = [];
  newPhoto = {};
  baseUrl = '/api/photos';

  constructor(http){
    this.http = http;
  }

  activate(){
    return this.http.fetch(this.baseUrl)
      .then(response => response.json())
      .then(photos => this.photos = photos);
  }

  createPhoto(){
    var data = new FormData();
    data.append('image', this.newPhoto.image[0]);
    data.append('title', this.newPhoto.title);

    this.http.fetch(this.baseUrl, {
        method: 'post',
        body: data,
      })
    .then(response => {
      if(response.ok) {
        this.newPhoto = {};
        return response.json()
      } else {
        var error = new Error(response.statusText);
        error.response = response;
        throw error;
      }
    })
    .then(photo => this.photos.unshift(photo))
    .catch(err => {
      console.log("Problem with network connectivity!");
    });
  }

  removePhoto(photoId){
    this.http.fetch(`${this.baseUrl}/${photoId}`, {
      method: 'delete',
      body: json({id: photoId}),
    })
    .then(response => {
      if(response.ok) {
        return response.json()
      } else {
        var error = new Error(response.statusText);
        error.response = response;
        throw error;
      }
    })
    .then(photo => {
      var index = this.photos.map(function(el){
        return el.id;
      }).indexOf(photo.id);
      this.photos.splice(index, 1);
    })
    .catch(err => {
      console.log("Problem with network connectivity!");
    });
  }
}
