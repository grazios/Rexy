module.exports = (app, db) ->
  app.get "/", (req, res) ->
    res.render "home"
    return
  app.get "/history", (req, res) ->
    res.render "history"
    return
  app.get "/create_history", (req, res) ->
    res.render "create_history"
    return
