import {bindable} from 'aurelia-framework';
import moment from 'moment';

export class Banner {
  @bindable header = 'Gdzie dziś weźmiesz swojego psa?';
  @bindable photo = '/assets/images/banner.jpg';
  @bindable mobilePhoto = '/assets/images/banner.jpg';
  @bindable icon;
  @bindable date;
  @bindable likes;
  @bindable comments;
  @bindable distance;

  formatDate(date) {
    return moment(date).format("D MMMM 'YY");
  }
}
