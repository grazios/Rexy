module.exports = (app, db) ->
  app.get "/api/doc/:id", (req, res) ->
  	result =
      query: req.params.id
    res.send JSON.stringify(result)
    return
  
