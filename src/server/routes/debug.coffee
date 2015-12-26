module.exports = (app, mongoose) ->
  app.get "/debug", (req, res) ->
    res.render "debug"
    return
