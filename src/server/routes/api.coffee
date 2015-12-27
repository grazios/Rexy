History = require("../models/History")



module.exports = (app, isLogined, connection) ->
  connection.config.queryFormat = (query, values) ->
    if !values
      return query
    query.replace /\:(\w+)/g, ((txt, key) ->
      if values.hasOwnProperty(key)
        return @escape(values[key])
      txt
    ).bind(this)

  app.get "/api/histories", (req, res) ->
    entity = new History(connection,res)
    try
      entity.get()
    catch error
      res.status(500).send error.message

  app.get "/api/history/:id", (req, res) ->
    entity = new History(connection,res)
    param =
      id: req.params.id
    try
      result = entity.get(param)
    catch error
      res.status(500).send error.message


  app.post "/api/history", (req, res) ->
    entity = new History(connection)

    try
      result = entity.create(
        "subject"  : req.body.subject
        "abstract" : req.body.abstract
      )
      res.send result
    catch error
      res.status(500).send error.message

  app.put "/api/history/:id",isLogined, (req, res) ->
    unless isOkHistoryParam req.body,res
      return

    param =
      "id" : req.params.id
      "subject"  : req.body.subject
      "abstract" : req.body.abstract

    result = connection.query "UPDATE histories SET ? WHERE id = 1",param,(err,results)->
      if err
        res.status(500).send "OMG :("
      else
        res.status(200).send JSON.stringify(results)
      return
