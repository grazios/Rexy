module.exports = (app, connect) ->
  app.get "/history/:id", (req, res) ->
  	result =
      query: req.params.id
    res.send JSON.stringify(result)
    return

  app.post "/history/:id", (req, res) ->
    
