"use strict"
gulp = require 'gulp'
browserSync = require "browser-sync"

$ = require("gulp-load-plugins")()

$public = "./public"
$src = "./src"

config =
  path:
    public: $public
    server: $src+"/server/app.coffee"


gulp.task "browser-sync", ["nodemon"],->
  browserSync.init null,{
    proxy: "http://localhost:3000"
    files: config.path.public
    port: 5000
  }

gulp.task "nodemon",(callback)->
  $.nodemon({
    script: config.path.server
    })


gulp.task "default",[
  "browser-sync"
],->
