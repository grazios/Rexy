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
    stylus: $src+"/client/stylesheets/**/*.*"
  outpath:
    stylus: $public+'/assets/stylesheets/'


# ブラウザーシンク起動
gulp.task "browser-sync", ["nodemon"],->
  browserSync.init null,{
    proxy: "http://localhost:3000"
    files: config.path.public
    port: 5000
  }

# サーバ起動
gulp.task "nodemon",(callback)->
  return $.nodemon({
    script: config.path.server
    }).on("start",()->
      $.gutil.log "hoge"
      )

# cssの生成
gulp.task 'stylus', ->
    gulp.src(config.path.stylus)
    .pipe $.stylus()
    .pipe gulp.dest(config.outpath.stylus)

gulp.task "default",[
  "stylus"
  "browser-sync"
],->
