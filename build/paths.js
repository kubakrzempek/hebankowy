var appRoot = "app/assets/";
var outputRoot = "dist/";
var exportSrvRoot = "public/assets/";

module.exports = {
  root: appRoot,
  source: appRoot + '/javascript/**/*.js',
  slim: appRoot + '/javascript/**/*.slim',
  scss: appRoot + '**/*.scss',
  images: appRoot + 'images/**/*',
  output: outputRoot,
  exportSrv: exportSrvRoot,
}
