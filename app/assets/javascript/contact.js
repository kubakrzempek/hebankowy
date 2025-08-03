import { inject } from 'aurelia-framework';
import { HttpClient, json } from 'aurelia-fetch-client';
import 'fetch';

@inject(HttpClient)
export class Contact{

  contactForm = {};
  isSuccessful = false;

  constructor(http){
    this.http = http;
  }

  sendEmail(){
    return this.http.fetch('/api/contact', {
      method: 'post',
      body: json(this.contactForm),
    })
    .then(response => {
      if(response.ok) {
        this.contactForm = {};
        alert("Dziękujemy, odpowiemy niebawem!")
        return this.isSuccessful = true;
      } else {
        return this.isSuccessful = false;
      }
    })
  }
}
