module.exports = {
  "bundles": {
    "dist/app-build": {
      "includes": [
        "[./dist/**/*.js]",
        "./dist/**/*.html!text",
        "./dist/**/*.css!text",
        "aurelia-animator-css",
        "github:paulvanbladel/aurelia-auth",
        "aurelia-bootstrapper",
        "aurelia-fetch-client",
        "aurelia-framework",
        "aurelia-history-browser",
        "aurelia-loader-default",
        "aurelia-logging-console",
        "aurelia-pal-browser",
        "aurelia-polyfills",
        "aurelia-router",
        "aurelia-templating-binding",
        "aurelia-templating-resources",
        "aurelia-templating-router",
        "moment",
        "croppie",
        "fetch"
      ],
      "options": {
        "inject": true,
        "minify": true,
        "depCache": false,
        "rev": true,
      }
    },
  }
};
