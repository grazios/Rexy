config = {}

config.base =
  domain: "http://rexy.info:5100/"

config.express =
  scheme: 'http'
  host: 'localhost'
  port: 5100
  url: (path)->
    this.scheme + '://' + this.host + ':' + this.port + (path || '')
  tokenExpiresInMinutes: 60
  session:
    secretkey: "hogefuga"

config.mysql =
  host: "localhost"
  user: "rexy"
  password: "relaunch"
  db_name: "rexy_db"

config.passport =
  facebook:
    clientID: "796627250450158"
    clientSecret: "5228bdffa3c7091037ba498e51cb8123"
    callbackURL: config.base.domain + "auth/facebook/callback"
  twitter:
    clientID: "ihXQGck6YtxgdFRf90jyOSPI1"
    clientSecret: "Oa0v8Bkisdw5OlgGpt4lU4WDlwTqaHMBVmKbqavEg914F2V1Ad"
    callbackURL: config.base.domain + "auth/twitter/callback"




module.exports = config
