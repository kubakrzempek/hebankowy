import { bindable } from 'aurelia-framework';
import moment from 'moment';

export class PostTile {
  @bindable post = {};

  formatDate(date) {
    return moment(date).format("DD.MM.'YY");
  }

  get distance() {
    switch (true) {
      case (this.post.distance > 30): return `${this.post.distance} km od Wrocławia`;
      case (this.post.distance > 20): return "okolice Wrocławia";
      default: return "we Wrocławiu";
    }
  }

  get category() {
    return this.post.categories[0]
  }
}
