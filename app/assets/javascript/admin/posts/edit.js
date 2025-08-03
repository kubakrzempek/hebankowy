import { inject } from 'aurelia-framework';
import { PostService } from './post.service';

@inject(PostService)
export class PostsEdit {
  post = {
    seo: {},
  };
  preview = false;

  constructor(postService) {
    this.postService = postService;
  }

  activate(params) {
    return this.postService.show(params.id)
      .then(response => response.json())
      .then(post => this.post = post)
  }

  togglePreview() {
    this.preview = !this.preview;
    if (!this.preview) return;
    let images = Array.from(this.previewNode.querySelectorAll("img.desktop"));
    images.forEach(image => {
      image.addEventListener("click", function(){
        let oldAltText = image.getAttribute("alt");
        let newAltText = prompt("Alt Text", oldAltText);
        image.setAttribute("alt", newAltText);
        let mobileImage = image.nextElementSibling;
        if (mobileImage) {
          mobileImage.setAttribute("alt", newAltText);
        }
      });
    });
  }

  savePost() {
    const params = {
      title: this.post.title,
      slug: this.post.slug,
      content: this.post.content,
      teaser: this.post.teaser,
      hints: this.post.hints,
      location: this.post.location,
      distance: this.post.distance,
      banner_photo_url: this.post.banner_photo_url,
      cover_photo_url: this.post.cover_photo_url,
      mobile_cover_photo_url: this.post.mobile_cover_photo_url,
      featured_photo_url: this.post.featured_photo_url,
      route: this.post.route,
      seo: {
        title: this.post.seo.title,
        description: this.post.seo.description,
        image: this.post.seo.image,
      }
    }
    this.saving = true;
    this.postService.update(this.post.id, params)
      .then(response => {
        if(response.ok) {
          this.saving = false;
          return response.json()
        } else {
          var error = new Error(response.statusText)
          error.response = response;
          throw error
        }
      })
      .then(post => this.post = post)
  }
}
