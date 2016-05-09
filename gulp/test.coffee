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
  server = new karma(configFile: "#{__dirname}/../karma.conf.js", (done) ->
    done()
  )
  server.start()

module.exports = gulp
