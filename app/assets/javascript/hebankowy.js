import config from './auth-config';
import moment from 'moment';
import 'moment/locale/pl';

export function configure(aurelia) {
  moment.locale('pl');

  aurelia.use
    .standardConfiguration()
    .plugin('aurelia-auth', (baseConfig) => {
      baseConfig.configure(config);
    })
    .plugin('aurelia-animator-css');

  aurelia.start().then(a => a.setRoot());
}
