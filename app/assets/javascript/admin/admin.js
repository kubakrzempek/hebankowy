export class Admin {
  configureRouter(config, router){
    config.map([
      {
        route: "",
        name: "dashboard",
        moduleId: "./dashboard",
        title: "Dashboard",
        nav: true,
      }, {
        route: "photos",
        name: "photos",
        moduleId: "./photos/index",
        title: "Zdjęcia",
        nav: true,
      }, {
        route: "photos/:id",
        name: "showPhoto",
        moduleId: "./photos/show",
        title: "Edytuj zdjęcie",
      }, {
        route: "posts",
        name: "posts",
        moduleId: "./posts/index",
        title: "Posty",
        nav: true,
      }, {
        route: "posts/:id",
        name: "editPost",
        moduleId: "./posts/edit",
        title: "Edytuj wpis",
      },
    ]);

    this.router = router;
  }
}
