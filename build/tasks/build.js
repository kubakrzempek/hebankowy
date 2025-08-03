var gulp = require("gulp");
var runSequence = require("run-sequence");
var changed = require("gulp-changed");
var plumber = require("gulp-plumber");
var to5 = require("gulp-babel");
var sourceMaps = require("gulp-sourcemaps");
var paths = require("../paths");
var compilerOptions = require("../babel-options");
var assign = Object.assign || require("object.assign");
var notify = require("gulp-notify");
var slim = require("gulp-slim");
var sass = require("gulp-sass");
var concat = require("gulp-concat");
var minifyCSS = require("gulp-minify-css");
var autoprefixer = require('gulp-autoprefixer');

gulp.task("build-system", function (){
  return gulp.src(paths.source)
    .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
    .pipe(changed(paths.output, { extension: ".js" }))
    .pipe(sourceMaps.init({ loadMaps: true }))
    .pipe(to5(assign({}, compilerOptions.system())))
    .pipe(gulp.dest(paths.output));
});

gulp.task("build-html", function(){
  return gulp.src(paths.slim)
    .pipe(changed(paths.output, { extension: ".html" }))
    .pipe(slim())
    .pipe(gulp.dest(paths.output));
});

gulp.task("build-css", function(){
  return gulp.src(paths.scss)
    // .pipe(changed(paths.output, { extension: ".scss" }))
    .pipe(sass().on("error", sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }))
    .pipe(minifyCSS())
    .pipe(concat("application.css"))
    .pipe(gulp.dest(paths.output))
});

gulp.task("build", function(callback){
  return runSequence(
    "clean",
    ["build-system", "build-html", "build-css"],
    callback
  );
});
