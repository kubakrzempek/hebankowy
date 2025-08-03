import {bindable, inject} from 'aurelia-framework';
import {AuthService} from 'aurelia-auth';

@inject(AuthService)
export class Footer{
  _isAuthenticated = false;
  @bindable router = null;
  @bindable categories = [];

  constructor(auth){
    this.auth = auth;
  }

  get isAuthenticated(){
    return this.auth.isAuthenticated();
  }

  get logout(){
    this.auth.logout();
  }
}
