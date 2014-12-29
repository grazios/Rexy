module.exports = (app, mongoose) ->
  app.get "/", (req, res) ->
    res.render "home"
    return
