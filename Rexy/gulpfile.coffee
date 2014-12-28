"use strict"
gulp = require 'gulp'
gutil = require "gulp-util"
browserSync = require "browser-sync"
spritesmith = require 'gulp.spritesmith'

$ = require("gulp-load-plugins")()

$public = "./public"
$src = "./src"
$server = "./src/server"
$client = "./src/client"

config =
  path:
    public: $public
    server: $server+"/app.coffee"
    stylus: $client+"/stylesheets/**/*.styl"
    images: [$client + '/images/**/*.*', '!'+$client+'/**/*.ico' ,'!'+$client+'/images/**/*.svg']
  outpath:
    stylus: $public+'/assets/stylesheets/'


# ブラウザーシンク起動
gulp.task "browser-sync",->
  browserSync.init null,{
    proxy: "http://localhost:3000"
    files: $src
    port: 5000
  }

# サーバ起動
gulp.task "nodemon",(callback)->
  return $.nodemon({
    script: config.path.server
    })

# cssの生成
gulp.task 'stylus', ['sprite_stylus'], ->
    gulp.src(config.path.stylus)
    .pipe $.plumber({errorHandler: $.notify.onError("<%= error.message %>")})
    .pipe $.stylus()
    .pipe gulp.dest(config.outpath.stylus)

gulp.task 'sprite_stylus', ->
  spriteDataStylus = gulp.src config.path.images
    .pipe spritesmith({
      imgName: 'sprite.png'
      cssName: 'sprite.styl'
      cssFormat: 'stylus'
      imgPath: 'sprite.png'
      destCSS: config.path.stylesheets
      engine: 'gm'
    })
  spriteDataStylus.img.pipe(gulp.dest('public/stylesheets/'));
  spriteDataStylus.css.pipe(gulp.dest('public/stylesheets/'));


gulp.task "watch", ()->
  gulp.watch config.path.stylus,["stylus"]



gulp.task "default",[
  "stylus"
  "nodemon"
  "browser-sync"
  "watch"
],->
