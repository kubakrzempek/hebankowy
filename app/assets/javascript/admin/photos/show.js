import {inject} from 'aurelia-framework';
import { PhotoService } from './photo.service'
import croppie from 'croppie';

@inject(PhotoService)
export class PhotosShow {
  photo = {};
  processedPhoto = {
    url: "",
  };
  croppie = undefined;
  resizeWidth = 0;

  constructor(photoService){
    this.photoService = photoService;
  }

  activate(params){
    return this.photoService.show(params.id)
      .then(response => response.json())
      .then(photo => this.photo = photo)
  }

  attached(){
    this.cropArea = document.querySelector("div#crop-area");
    this.initializeCroppie();
  }

  repaintCroppie(width = 640, height = 480){
    this.croppie.destroy();
    this.initializeCroppie(width, height);
  }

  initializeCroppie(width = 640, height = 480) {
    this.croppie = new Croppie(this.cropArea, {
      viewport: {
        width: width,
        height: height,
      },
      boundary: {
        width: width,
        height: height,
      },
      showZoomer: true,
    });

    this.croppie.bind({
      url: this.photo.url,
    })
  }

  generateLink(){
    let [ox, oy, wx, wy] = this.croppie.get().points;
    let params = {
      offset_x: ox,
      offset_y: oy,
      width_x: wx,
      width_y: wy,
      width: this.resizeWidth,
    };

    return this.photoService.process(this.photo.id, params)
      .then(response => response.json())
      .then(photo => {
        window.prompt("Wygenerowany link:", photo.url);
      });
  }
}
