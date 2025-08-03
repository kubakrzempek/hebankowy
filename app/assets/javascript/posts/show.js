import {inject} from 'aurelia-framework';
import {PostService} from './post.service';

@inject(PostService)
export class PostsShow{
  post = {};

  constructor(postService){
    this.postService = postService;
  }

  activate(params, routeConfig){
    return this.postService.show(params.slug)
      .then(response => response.json())
      .then(post => {
        this.post = post;
        routeConfig.navModel.setTitle(post.seo.title);
        document.querySelector('meta[property="og:url"]').setAttribute('content', window.location.href);
        document.querySelector('meta[property="og:title"]').setAttribute('content', this.post.seo.title + ' | hebankowy.pl Blog');
        document.querySelector('meta[property="og:description"]').setAttribute('content', this.post.seo.description);
        document.querySelector('meta[property="og:image"]').setAttribute('content', this.post.seo.image);
        document.querySelector('meta[name="description"]').setAttribute('content', this.post.seo.description);
      })
  }

  attached() {
    document.querySelector("img.preloader").style.display = "none";
    const postMap = document.querySelector('.post-map');
    postMap.addEventListener('click', function(){
      this.querySelector('iframe').style['pointerEvents'] = 'auto';
    }, false)
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
}
