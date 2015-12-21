Package.describe({
  name: 'crapthings:boot',
  version: '0.0.1',
  summary: '',
  git: '',
  documentation: 'README.md'
});

Package.onUse(function(api) {

  api.versionsFrom('1.0');

  api.use([
    'mongo',
    'random',
    'templating',
    'accounts-password',

    'coffeescript',
    'stevezhu:lodash',

    'aldeed:collection2@2.7.0',
    'aldeed:autoform@5.8.1',

    'iron:router',
    'mquandalle:jade',
    'mquandalle:stylus',
    'zimme:active-route'
  ]);

  api.add_files([
    'client/normalize.css',
    'client/screen.styl'
  ], 'client');

  api.add_files([
    'client/template.jade',
    'client/template.coffee',
    'client/debugger.jade',
    'client/debugger.coffee'

  ], 'client');

  api.add_files('lib/boot.coffee');

  api.export('Boot');

});
