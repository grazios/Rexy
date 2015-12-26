"use strict"
gulp = require 'gulp'
mocha = require "gulp-mocha"
gutil = require "gulp-util"
bower = require 'main-bower-files'
browserSync = require "browser-sync"
spritesmith = require 'gulp.spritesmith'
isRelease = gutil.env.release?
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
    coffee: $client+"/javascripts/**/*.coffee"
    spec: "test/mocha/**/*.coffee"
    jade: $client+"/views/**/*.jade"
    images: [$client + '/images/**/*.*', '!'+$client+'/**/*.ico' ,'!'+$client+'/images/**/*.svg']
  outpath:
    stylus: $public+'/assets/stylesheets/'
    coffee: $public+'/assets/javascripts/'
    bower: $public+'/assets/libs'


# ブラウザーシンク起動
gulp.task "browser-sync",->
  browserSync.init null,{
    proxy: "http://localhost:5100"
    port: 5250
  }
gulp.task "browser-sync-reload",->
  browserSync.reload()


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

# coffeeの生成
gulp.task 'coffee', ->
    gulp.src(config.path.coffee)
    .pipe $.plumber({errorHandler: $.notify.onError("<%= error %>")})
    .pipe $.coffee()
    .pipe gulp.dest(config.outpath.coffee)

#bowerコンポーネンツあたり
gulp.task 'bower', ->
  gulp.src(bower())
    .pipe $.if isRelease, $.uglify({preserveComments:'some'})
    .pipe $.flatten()
    .pipe (gulp.dest config.outpath.bower)

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

#test
gulp.task "mocha", ->
  gulp.src [config.path.spec],{ read:false }
    .pipe mocha {
      reporter: "spec"
    }

gulp.task "watch-mocha", ()->
  gulp.watch [
    config.path.coffee
    config.path.spec
  ],["mocha"]



gulp.task "watch", ()->
  gulp.watch config.path.stylus,["stylus","browser-sync-reload"]
  gulp.watch config.path.coffee,["coffee","browser-sync-reload"]
  gulp.watch config.path.jade,["browser-sync-reload"]


gulp.task "test",[
  "mocha"
  "watch-mocha"
],->

gulp.task "default",[
  "bower"
  "nodemon"
  "browser-sync"
  "stylus"
  "coffee"
  "watch"
],->
