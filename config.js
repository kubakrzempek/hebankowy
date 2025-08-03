System.config({
  baseURL: "assets/",
  defaultJSExtensions: true,
  transpiler: "–latest",
  babelOptions: {
    "optional": [
      "runtime",
      "optimisation.modules.system"
    ]
  },
  paths: {
    "*": "dist/*",
    "github:*": "jspm_packages/github/*",
    "npm:*": "jspm_packages/npm/*"
  },
  map: {
    "aurelia-animator-css": "npm:aurelia-animator-css@1.0.4",
    "aurelia-auth": "github:paulvanbladel/aurelia-auth@3.0.5",
    "aurelia-bootstrapper": "npm:aurelia-bootstrapper@1.0.1",
    "aurelia-fetch-client": "npm:aurelia-fetch-client@1.8.2",
    "aurelia-framework": "npm:aurelia-framework@1.3.1",
    "aurelia-history-browser": "npm:aurelia-history-browser@1.3.2",
    "aurelia-loader-default": "npm:aurelia-loader-default@1.2.1",
    "aurelia-logging-console": "npm:aurelia-logging-console@1.1.1",
    "aurelia-pal-browser": "npm:aurelia-pal-browser@1.8.1",
    "aurelia-polyfills": "npm:aurelia-polyfills@1.3.4",
    "aurelia-router": "npm:aurelia-router@1.7.1",
    "aurelia-templating-binding": "npm:aurelia-templating-binding@1.5.3",
    "aurelia-templating-resources": "npm:aurelia-templating-resources@1.10.0",
    "aurelia-templating-router": "npm:aurelia-templating-router@1.4.0",
    "babel": "npm:babel-core@5.8.38",
    "babel-runtime": "npm:babel-runtime@5.8.38",
    "core-js": "npm:core-js@1.2.7",
    "croppie": "npm:croppie@2.3.0",
    "fetch": "github:github/fetch@1.1.1",
    "font-awesome": "npm:font-awesome@4.7.0",
    "moment": "npm:moment@2.17.0",
    "text": "github:systemjs/plugin-text@0.0.3",
    "–latest": "npm:babel-core@5.8.38",
    "–latest-runtime": "npm:babel-runtime@5.8.38",
    "github:jspm/nodelibs-assert@0.1.0": {
      "assert": "npm:assert@1.5.0"
    },
    "github:jspm/nodelibs-buffer@0.1.1": {
      "buffer": "npm:buffer@5.2.1"
    },
    "github:jspm/nodelibs-path@0.1.0": {
      "path-browserify": "npm:path-browserify@0.0.0"
    },
    "github:jspm/nodelibs-process@0.1.2": {
      "process": "npm:process@0.11.10"
    },
    "github:jspm/nodelibs-util@0.1.0": {
      "util": "npm:util@0.10.3"
    },
    "github:jspm/nodelibs-vm@0.1.0": {
      "vm-browserify": "npm:vm-browserify@0.0.4"
    },
    "github:paulvanbladel/aurelia-auth@3.0.5": {
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-event-aggregator": "npm:aurelia-event-aggregator@1.0.3",
      "aurelia-fetch-client": "npm:aurelia-fetch-client@1.8.2",
      "aurelia-router": "npm:aurelia-router@1.7.1"
    },
    "npm:assert@1.5.0": {
      "assert": "github:jspm/nodelibs-assert@0.1.0",
      "buffer": "github:jspm/nodelibs-buffer@0.1.1",
      "object-assign": "npm:object-assign@4.1.1",
      "process": "github:jspm/nodelibs-process@0.1.2",
      "util": "npm:util@0.10.3"
    },
    "npm:aurelia-animator-css@1.0.4": {
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-templating": "npm:aurelia-templating@1.10.2"
    },
    "npm:aurelia-binding@2.3.1": {
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-task-queue": "npm:aurelia-task-queue@1.3.3"
    },
    "npm:aurelia-bootstrapper@1.0.1": {
      "aurelia-event-aggregator": "npm:aurelia-event-aggregator@1.0.3",
      "aurelia-framework": "npm:aurelia-framework@1.3.1",
      "aurelia-history": "npm:aurelia-history@1.2.1",
      "aurelia-history-browser": "npm:aurelia-history-browser@1.3.2",
      "aurelia-loader-default": "npm:aurelia-loader-default@1.2.1",
      "aurelia-logging-console": "npm:aurelia-logging-console@1.1.1",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-pal-browser": "npm:aurelia-pal-browser@1.8.1",
      "aurelia-polyfills": "npm:aurelia-polyfills@1.3.4",
      "aurelia-router": "npm:aurelia-router@1.7.1",
      "aurelia-templating": "npm:aurelia-templating@1.10.2",
      "aurelia-templating-binding": "npm:aurelia-templating-binding@1.5.3",
      "aurelia-templating-resources": "npm:aurelia-templating-resources@1.10.0",
      "aurelia-templating-router": "npm:aurelia-templating-router@1.4.0"
    },
    "npm:aurelia-dependency-injection@1.4.2": {
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-event-aggregator@1.0.3": {
      "aurelia-logging": "npm:aurelia-logging@1.5.2"
    },
    "npm:aurelia-fetch-client@1.8.2": {
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-framework@1.3.1": {
      "aurelia-binding": "npm:aurelia-binding@2.3.1",
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-loader": "npm:aurelia-loader@1.0.2",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-path": "npm:aurelia-path@1.1.3",
      "aurelia-task-queue": "npm:aurelia-task-queue@1.3.3",
      "aurelia-templating": "npm:aurelia-templating@1.10.2"
    },
    "npm:aurelia-history-browser@1.3.2": {
      "aurelia-history": "npm:aurelia-history@1.2.1",
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-loader-default@1.2.1": {
      "aurelia-loader": "npm:aurelia-loader@1.0.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-loader@1.0.2": {
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-path": "npm:aurelia-path@1.1.3"
    },
    "npm:aurelia-logging-console@1.1.1": {
      "aurelia-logging": "npm:aurelia-logging@1.5.2"
    },
    "npm:aurelia-metadata@1.0.6": {
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-pal-browser@1.8.1": {
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-polyfills@1.3.4": {
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-route-recognizer@1.3.2": {
      "aurelia-path": "npm:aurelia-path@1.1.3"
    },
    "npm:aurelia-router@1.7.1": {
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-event-aggregator": "npm:aurelia-event-aggregator@1.0.3",
      "aurelia-history": "npm:aurelia-history@1.2.1",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-path": "npm:aurelia-path@1.1.3",
      "aurelia-route-recognizer": "npm:aurelia-route-recognizer@1.3.2"
    },
    "npm:aurelia-task-queue@1.3.3": {
      "aurelia-pal": "npm:aurelia-pal@1.8.2"
    },
    "npm:aurelia-templating-binding@1.5.3": {
      "aurelia-binding": "npm:aurelia-binding@2.3.1",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-templating": "npm:aurelia-templating@1.10.2"
    },
    "npm:aurelia-templating-resources@1.10.0": {
      "aurelia-binding": "npm:aurelia-binding@2.3.1",
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-loader": "npm:aurelia-loader@1.0.2",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-path": "npm:aurelia-path@1.1.3",
      "aurelia-task-queue": "npm:aurelia-task-queue@1.3.3",
      "aurelia-templating": "npm:aurelia-templating@1.10.2"
    },
    "npm:aurelia-templating-router@1.4.0": {
      "aurelia-binding": "npm:aurelia-binding@2.3.1",
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-path": "npm:aurelia-path@1.1.3",
      "aurelia-router": "npm:aurelia-router@1.7.1",
      "aurelia-templating": "npm:aurelia-templating@1.10.2"
    },
    "npm:aurelia-templating@1.10.2": {
      "aurelia-binding": "npm:aurelia-binding@2.3.1",
      "aurelia-dependency-injection": "npm:aurelia-dependency-injection@1.4.2",
      "aurelia-loader": "npm:aurelia-loader@1.0.2",
      "aurelia-logging": "npm:aurelia-logging@1.5.2",
      "aurelia-metadata": "npm:aurelia-metadata@1.0.6",
      "aurelia-pal": "npm:aurelia-pal@1.8.2",
      "aurelia-path": "npm:aurelia-path@1.1.3",
      "aurelia-task-queue": "npm:aurelia-task-queue@1.3.3"
    },
    "npm:babel-runtime@5.8.38": {
      "process": "github:jspm/nodelibs-process@0.1.2"
    },
    "npm:buffer@5.2.1": {
      "base64-js": "npm:base64-js@1.3.0",
      "ieee754": "npm:ieee754@1.1.13"
    },
    "npm:core-js@1.2.7": {
      "fs": "github:jspm/nodelibs-fs@0.1.2",
      "path": "github:jspm/nodelibs-path@0.1.0",
      "process": "github:jspm/nodelibs-process@0.1.2",
      "systemjs-json": "github:systemjs/plugin-json@0.1.2"
    },
    "npm:font-awesome@4.7.0": {
      "css": "github:systemjs/plugin-css@0.1.37"
    },
    "npm:inherits@2.0.1": {
      "util": "github:jspm/nodelibs-util@0.1.0"
    },
    "npm:path-browserify@0.0.0": {
      "process": "github:jspm/nodelibs-process@0.1.2"
    },
    "npm:process@0.11.10": {
      "assert": "github:jspm/nodelibs-assert@0.1.0",
      "fs": "github:jspm/nodelibs-fs@0.1.2",
      "vm": "github:jspm/nodelibs-vm@0.1.0"
    },
    "npm:util@0.10.3": {
      "inherits": "npm:inherits@2.0.1",
      "process": "github:jspm/nodelibs-process@0.1.2"
    },
    "npm:vm-browserify@0.0.4": {
      "indexof": "npm:indexof@0.0.1"
    }
  },
  bundles: {
    "app-build-77da1b11fa.js": [
      "about-us.html!github:systemjs/plugin-text@0.0.3.js",
      "about-us.js",
      "admin/admin.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/admin.js",
      "admin/dashboard.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/dashboard.js",
      "admin/photos/index.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/photos/index.js",
      "admin/photos/photo.service.js",
      "admin/photos/show.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/photos/show.js",
      "admin/posts/edit.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/posts/edit.js",
      "admin/posts/index.html!github:systemjs/plugin-text@0.0.3.js",
      "admin/posts/index.js",
      "admin/posts/post.service.js",
      "app.html!github:systemjs/plugin-text@0.0.3.js",
      "app.js",
      "app.router.config.js",
      "application.css!github:systemjs/plugin-text@0.0.3.js",
      "auth-config.js",
      "categories/category.service.js",
      "categories/show.html!github:systemjs/plugin-text@0.0.3.js",
      "categories/show.js",
      "comments/comment.service.js",
      "comments/index.html!github:systemjs/plugin-text@0.0.3.js",
      "comments/index.js",
      "components/likes.html!github:systemjs/plugin-text@0.0.3.js",
      "components/likes.js",
      "components/post-tile.html!github:systemjs/plugin-text@0.0.3.js",
      "components/post-tile.js",
      "contact.html!github:systemjs/plugin-text@0.0.3.js",
      "contact.js",
      "custom-elements/banner/banner.html!github:systemjs/plugin-text@0.0.3.js",
      "custom-elements/banner/banner.js",
      "custom-elements/featured-post/featured-post.html!github:systemjs/plugin-text@0.0.3.js",
      "custom-elements/nav-bar/nav-bar.html!github:systemjs/plugin-text@0.0.3.js",
      "custom-elements/nav-bar/nav-bar.js",
      "custom-elements/post-tile/post-tile.html!github:systemjs/plugin-text@0.0.3.js",
      "custom-elements/post-tile/post-tile.js",
      "footer.html!github:systemjs/plugin-text@0.0.3.js",
      "footer.js",
      "github:github/fetch@1.1.1.js",
      "github:github/fetch@1.1.1/fetch.js",
      "github:paulvanbladel/aurelia-auth@3.0.5.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/aurelia-auth.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/auth-fetch-config.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/auth-filter.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/auth-service.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/auth-utilities.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/authentication.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/authorize-step.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/base-config.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/oAuth1.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/oAuth2.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/popup.js",
      "github:paulvanbladel/aurelia-auth@3.0.5/storage.js",
      "hebankowy.js",
      "home.html!github:systemjs/plugin-text@0.0.3.js",
      "home.js",
      "login.html!github:systemjs/plugin-text@0.0.3.js",
      "login.js",
      "npm:aurelia-animator-css@1.0.4.js",
      "npm:aurelia-animator-css@1.0.4/aurelia-animator-css.js",
      "npm:aurelia-binding@2.3.1.js",
      "npm:aurelia-binding@2.3.1/aurelia-binding.js",
      "npm:aurelia-bootstrapper@1.0.1.js",
      "npm:aurelia-bootstrapper@1.0.1/aurelia-bootstrapper.js",
      "npm:aurelia-dependency-injection@1.4.2.js",
      "npm:aurelia-dependency-injection@1.4.2/aurelia-dependency-injection.js",
      "npm:aurelia-event-aggregator@1.0.3.js",
      "npm:aurelia-event-aggregator@1.0.3/aurelia-event-aggregator.js",
      "npm:aurelia-fetch-client@1.8.2.js",
      "npm:aurelia-fetch-client@1.8.2/aurelia-fetch-client.js",
      "npm:aurelia-framework@1.3.1.js",
      "npm:aurelia-framework@1.3.1/aurelia-framework.js",
      "npm:aurelia-history-browser@1.3.2.js",
      "npm:aurelia-history-browser@1.3.2/aurelia-history-browser.js",
      "npm:aurelia-history@1.2.1.js",
      "npm:aurelia-history@1.2.1/aurelia-history.js",
      "npm:aurelia-loader-default@1.2.1.js",
      "npm:aurelia-loader-default@1.2.1/aurelia-loader-default.js",
      "npm:aurelia-loader@1.0.2.js",
      "npm:aurelia-loader@1.0.2/aurelia-loader.js",
      "npm:aurelia-logging-console@1.1.1.js",
      "npm:aurelia-logging-console@1.1.1/aurelia-logging-console.js",
      "npm:aurelia-logging@1.5.2.js",
      "npm:aurelia-logging@1.5.2/aurelia-logging.js",
      "npm:aurelia-metadata@1.0.6.js",
      "npm:aurelia-metadata@1.0.6/aurelia-metadata.js",
      "npm:aurelia-pal-browser@1.8.1.js",
      "npm:aurelia-pal-browser@1.8.1/aurelia-pal-browser.js",
      "npm:aurelia-pal@1.8.2.js",
      "npm:aurelia-pal@1.8.2/aurelia-pal.js",
      "npm:aurelia-path@1.1.3.js",
      "npm:aurelia-path@1.1.3/aurelia-path.js",
      "npm:aurelia-polyfills@1.3.4.js",
      "npm:aurelia-polyfills@1.3.4/aurelia-polyfills.js",
      "npm:aurelia-route-recognizer@1.3.2.js",
      "npm:aurelia-route-recognizer@1.3.2/aurelia-route-recognizer.js",
      "npm:aurelia-router@1.7.1.js",
      "npm:aurelia-router@1.7.1/aurelia-router.js",
      "npm:aurelia-task-queue@1.3.3.js",
      "npm:aurelia-task-queue@1.3.3/aurelia-task-queue.js",
      "npm:aurelia-templating-binding@1.5.3.js",
      "npm:aurelia-templating-binding@1.5.3/aurelia-templating-binding.js",
      "npm:aurelia-templating-resources@1.10.0.js",
      "npm:aurelia-templating-resources@1.10.0/aurelia-templating-resources.js",
      "npm:aurelia-templating-router@1.4.0.js",
      "npm:aurelia-templating-router@1.4.0/aurelia-templating-router.js",
      "npm:aurelia-templating@1.10.2.js",
      "npm:aurelia-templating@1.10.2/aurelia-templating.js",
      "npm:croppie@2.3.0.js",
      "npm:croppie@2.3.0/croppie.js",
      "npm:moment@2.17.0.js",
      "npm:moment@2.17.0/moment.js",
      "posts/post.service.js",
      "posts/show.html!github:systemjs/plugin-text@0.0.3.js",
      "posts/show.js"
    ]
  }
});