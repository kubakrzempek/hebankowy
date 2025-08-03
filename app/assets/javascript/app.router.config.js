import {AuthorizeStep} from 'aurelia-auth';
import {inject} from 'aurelia-framework';
import {Router} from 'aurelia-router';

@inject(Router)
export default class{
  constructor(router){
    this.router = router;
  }

  configure(){
    var appRouterConfig = function(config){
      config.title = "hebankowy.pl";
      config.options.pushState = true;
      config.addPipelineStep('authorize', AuthorizeStep);
      config.addPipelineStep('postcomplete', PostCompleteStep);

      config.map([
        { route: "", name: "home", moduleId: "./home", title: "home" },
        { route: "o-nas", name: "o nas", moduleId: "./about-us", nav: true, title: "O nas" },
        { route: "kontakt", name: "kontakt", moduleId: "./contact", nav: true, title: "Kontakt" },
        { route: "login", name: "login", moduleId: "./login", title: "Log in" },
        { route: "kategorie/:id", name: "showCategory", moduleId: "./categories/show" },
        { route: "admin", name: "admin", moduleId: "./admin/admin", title: "admin", nav: true, auth: true },
        { route: ":slug", name: "showPost", moduleId: "./posts/show" },
      ]);
    };

    this.router.configure(appRouterConfig);
  }
}

class PostCompleteStep {
  run(routingContext, next) {
      window.scrollTo(0,0);
      return next();
  }
}
