env = (process.env.NODE_ENV or "development")
config = require("./config/env/" + env)

express = require("express")
errorHandler = require("errorhandler")
bodyParser = require("body-parser")
methodOverride = require("method-override")
mysql = require("mysql")
passport = require "passport"
cookieParser = require "cookie-parser"
session = require "express-session"
###
 Connecting to MySQL
###
mysql_connect = (mysql, config)->
  connection = mysql.createPool {
    host: config.mysql.host
    user: config.mysql.user
    password: config.mysql.password
    database: config.mysql.db_name
  }
  return connection

express_init_basic = (app)->
  app.set "views", __dirname + "/../client/views"
  app.set "view engine", "jade"
  app.use errorHandler()
  app.use bodyParser.urlencoded({limit: '32mb', extended: true})
  app.use bodyParser.json({limit: '32mb'})
  app.use methodOverride()

  app.use cookieParser()
  app.use session(
    secret: config.express.session.secretkey
    resave: false
    saveUninitialized: false
    cookie:
      maxAge: 60*60*1000
    )

  #expressのsessionミドルウェアを有効にしてsecretを設定
  app.use passport.initialize()
  #passportの初期化
  app.use passport.session()
  #passportでのログイン状態を保持するpassport sessionミドルウェアを有効にする


  #app.use staticAsset __dirname + "/../public/"
  app.use express.static __dirname + "/../../public/"

express_init_routes = (app, db)->
  require("./locals")(app, db)
  require("./routes/home")(app, db)
  require("./routes/historyAPI")(app, db)
  require("./routes/debug")(app, db)


###
  passport settings
###
passport_init = (app, connect)->
  require("./passport/strategy")(app, connect, passport, config)
  passport.serializeUser (user, done)->
    done(null, user)

  passport.deserializeUser (obj, done)->
    done(null, obj)

  app.get('/auth/facebook',(req,res,next)->
      req.session.redirect = req.query.ref
      next()
    )
  app.get('/auth/facebook',passport.authenticate('facebook', { scope: [ 'email' ] }))


  app.get('/auth/facebook/callback',
    passport.authenticate('facebook',{scope: ['email'],"failureRedirect": '/fail'}),
    (req, res)->
      res.redirect(req.session.redirect)
  )

  app.get('/auth/twitter',(req,res,next)->
      req.session.redirect = req.query.ref
      next()
    )
  app.get('/auth/twitter',passport.authenticate('twitter'))


  app.get('/auth/twitter/callback',
    passport.authenticate('twitter',{"failureRedirect": '/fail'}),
    (req, res)->
      res.redirect(req.session.redirect)
  )

  app.get "/logout",(req,res)->
    req.logout()
    req.session.destroy()
    req.logout()
    result =
      success: !req.isAuthenticated()
    res.send JSON.stringify(result)
    return


###
  Exit Initialize Methods
###
connect = mysql_connect(mysql, config)
app = express()
express_init_basic(app)
passport_init(app, connect)
express_init_routes(app, connect)

server = app.listen config.express.port

expObj =
  app: app
  server: server
module.exports = expObj
