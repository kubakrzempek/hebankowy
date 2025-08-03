import { bindable } from 'aurelia-framework';
import moment from 'moment';

export class PostTile {
  @bindable post = {};

  formatDate(date) {
    return moment(date).format("D MMM 'YY");
  }

  get distance() {
    if (this.post.distance > 30) {
      return `${this.post.distance} km od Wrocławia`;
    }
    if (this.post.distance > 20) {
      return "okolice Wrocławia";
    }
    return "we Wrocławiu";
  }

  get category() {
    return this.post.categories[0];
  }
}
