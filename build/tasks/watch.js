var gulp = require("gulp");
var paths = require("../paths");

function reportChange(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
}

gulp.task("watch", function(){
  gulp.watch(paths.source, ["build-system"]).on("change", reportChange);
  gulp.watch(paths.slim, ["build-html"]).on("change", reportChange);
  gulp.watch(paths.css, ["build-css"]).on("change", reportChange);
});
