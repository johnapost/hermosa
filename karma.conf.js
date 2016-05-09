module.exports = function(config) {
  config.set({
    basePath: '',

    frameworks: ['jasmine'],

    files: [
      'node_modules/faker/build/build/faker.min.js',
      'node_modules/jquery/dist/jquery.min.js',
      'node_modules/velocity-animate/velocity.min.js',
      'node_modules/velocity-animate/velocity.ui.min.js',
      'src/**/*.coffee',
      'tests/**/*.coffee'
    ],

    exclude: [
    ],

    preprocessors: {
      '**/*.coffee': 'coffee',
      'src/**/*.coffee': 'coverage'
    },

    client: {
      captureConsole: true
    },

    reporters: ['progress', 'growl', 'coverage'],
    coverageReporter: {
      dir: 'coverage',
      type: 'lcov'
    },

    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Firefox'],
    singleRun: false
  });
};
