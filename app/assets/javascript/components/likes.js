import { bindable, inject } from 'aurelia-framework';
import { PostService } from '../posts/post.service';

@inject(PostService)
export class Likes {
  @bindable count = 0;
  @bindable postId = undefined;
  liked = false;

  constructor(postService){
    this.postService = postService;
  }

  attached(){
    this.liked = this.isLiked;
    if (this.liked) this.heart.classList.add("liked");
  }

  like(){
    if (this.liked) return
    this.store();
    this.postService.like(this.postId)
      .then(response => {
        if(response.ok) {
          return response.json();
        } else {
          var error = new Error(response.statusText)
          error.response = response;
          throw error;
        }
      })
  }

  get isLiked() {
    return this.likesFromStore.indexOf(this.postId) !== -1;
  }

  get likesFromStore() {
    return JSON.parse(localStorage.getItem("likes")) || []
  }

  uniquify(arrArg) {
    return arrArg.filter((elem, post, arr) => {
      return arr.indexOf(elem) === post;
    })
  }

  store() {
    this.liked = true;
    this.count += 1;
    this.heart.classList.add("liked");
    const currentLikes = this.likesFromStore;
    const newLikes = this.uniquify(currentLikes.concat(this.postId));
    localStorage.setItem("likes", JSON.stringify(newLikes));
  }
}
