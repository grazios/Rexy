module.exports = (app, db) ->
  app.get "/", (req, res) ->
    res.render "home"
    return
  app.get "/test", (req, res) ->
    res.render "home2"
    return
