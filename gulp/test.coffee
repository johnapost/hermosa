coffee = require 'gulp-coffee'
config = require './config.coffee'
gulp = require 'gulp'
karma = require('karma').Server
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'

errorAlert = (error) ->
  notify.onError(
    title: 'Coffee Error'
    message: 'Check your terminal!'
  )(error)
  console.log error.toString()
  this.emit 'end'

gulp.task 'test', (done) ->
  server = new karma configFile: "#{__dirname}/../karma.conf.js"
  server.start()

gulp.task 'e2e', (done) ->
  gulp.src 'e2e/**/*.coffee'
    .pipe plumber errorHandler: errorAlert
    .pipe coffee bare: true
    .pipe chmod 755
    .pipe gulp.dest 'dist/e2e'

module.exports = gulp
