env = (process.env.NODE_ENV or "development")
config = require("./config/env/" + env)

express = require("express")
errorHandler = require("errorhandler")
bodyParser = require("body-parser")
methodOverride = require("method-override")
mongoose = require("mongoose")
###
 Connecting to MongoDB
###
mongoose_connect = (mongoose, config)->
  mongoModel = config.mongodb.model;
  uriString = "mongodb://" + mongoModel.host + ":" + mongoModel.port or 27017
  db = mongoose.connect uriString + "/" + mongoModel.db

  ###
   Initialize Models, Controllers
  ###

  schemas = {}
  [
    'History'
  ].forEach (name)->
    schemas[name] = require('./models/'+name)(db)

  [
    'History'
  ].forEach (name)->
    require('./controllers/'+name+'Controller')(schemas, mongoose)

  Object.keys(schemas).forEach (schemaName)->
    schema = schemas[schemaName]
    schema.plugin(findOrCreate)
    mongoose.model(schemaName, schema)

  return schemas

express_init_basic = (app)->
  app.set "views", __dirname + "/../client/views"
  app.set "view engine", "jade"
  app.use errorHandler()
  app.use bodyParser.urlencoded({limit: '32mb', extended: true})
  app.use bodyParser.json({limit: '32mb'})
  app.use methodOverride()

  #app.use staticAsset __dirname + "/../public/"
  app.use express.static __dirname + "/../../public/"

express_init_routes = (app, mongoose)->
  require("./routes/home")(app, mongoose)

#schemas = mongoose_connect(mongoose, config)
app = express()
express_init_basic(app)
express_init_routes(app, mongoose)

app.listen 3000
