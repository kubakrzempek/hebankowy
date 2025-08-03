import {AuthService} from 'aurelia-auth';
import {inject} from 'aurelia-framework';

@inject(AuthService)
export class Login{

  email = '';
  password = '';

  constructor(auth){
    this.auth = auth;
  };

  login(){
    console.log(this.auth);
    return this.auth.login(this.email, this.password)
      .then(response => {
        console.log("logged in " + response);
      })
      .catch(err => {
        console.log(err);
      });
  };
}
