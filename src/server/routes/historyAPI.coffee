module.exports = (app, connect) ->
  app.get "/api/history/:id", (req, res) ->
  	result =
      query: req.params.id
    return res.json JSON.stringify(result)

  app.post "/history/:id", (req, res) ->
