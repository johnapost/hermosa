gulp = require 'gulp'
newer = require 'gulp-newer'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
config = require './config.coffee'

gulp.task 'vendor', ->
  gulp.src [
    'node_modules/jquery/dist/jquery.min.js'
    'node_modules/velocity-animate/velocity.min.js'
    'node_modules/velocity-animate/velocity.ui.min.js'
  ]
  .pipe newer "#{config.path}/scripts/vendor.min.js"
  .pipe uglify()
  .pipe concat 'vendor.min.js'
  .pipe gulp.dest "#{config.path}/scripts"

module.exports = gulp
