// this file provides a list of unbundled files that
// need to be included when exporting the application
// for production.
module.exports = {
  'list': [
    'config.js',
    "jspm_packages/github/systemjs/**",
    "jspm_packages/github/paulvanbladel/**",
    "jspm_packages/npm/moment@2.17.0/moment.js",
    "jspm_packages/npm/moment@2.17.0/locale/pl.js",
    "jspm_packages/npm/croppie@2.3.0/croppie.min.js",
    'jspm_packages/system.js',
    'jspm_packages/system.js.map',
    'jspm_packages/system-polyfills.js',
    'jspm_packages/system-csp-production.js',
  ],
  // this section lists any jspm packages that have
  // unbundled resources that need to be exported.
  // these files are in versioned folders and thus
  // must be 'normalized' by jspm to get the proper
  // path.
  'normalize': [
    [
      // include font-awesome.css and its fonts files
      'font-awesome', [
        '/css/font-awesome.min.css',
        '/fonts/*'
      ]
    ]
  ]
};
