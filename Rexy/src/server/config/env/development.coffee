config = {}

config.express =
  scheme: 'http'
  host: 'localhost'
  port: 3000
  url: (path)->
    this.scheme + '://' + this.host + ':' + this.port + (path || '')
  tokenExpiresInMinutes: 60

config.mongodb =
  oauth:
    host: "localhost"
    port: 27017
    db: "oauth"
    username: "eduma"
    password: "eduma"

  session:
    host: "localhost"
    port: 27017
    db: "eduma_session"
    username: "eduma"
    password: "eduma"
    clear_interval: 60 * 60
    auto_reconnect: true

  model:
    host: "localhost"
    port: 27017
    db: "eduma"
    username: "eduma"
    password: "eduma"

module.exports = config
