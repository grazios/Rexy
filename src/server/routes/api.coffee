isOkHistoryParam = (param,res)->
  result = true
  unless param.subject?
    res.status(400).send "OMG :("
    result = false
  unless param.abstract?
    res.status(400).send "OMG :("
    result = false

  return result

module.exports = (app, isLogined, connection) ->
  connection.config.queryFormat = (query, values) ->
    if !values
      return query
    query.replace /\:(\w+)/g, ((txt, key) ->
      if values.hasOwnProperty(key)
        return @escape(values[key])
      txt
    ).bind(this)

  app.get "/api/history/:id", (req, res) ->
    param =
      "id": req.params.id

    result = connection.query "SELECT * FROM histories WHERE ?",param,(err,results)->
      if err
        res.status(500).send "OMG :("
      else
        if results.length == 0
          res.status(404).send "OMG :("
        else
          res.status(200).send JSON.stringify(results[0])
      return

  app.post "/api/history",isLogined, (req, res) ->
    unless isOkHistoryParam req.body,res
      return

    param =
      "subject"  : req.body.subject
      "abstract" : req.body.abstract

    result = connection.query "INSERT INTO histories SET ?",param,(err,results)->
      if err
        res.status(500).send "OMG :("
      else
        res.status(200).send JSON.stringify(results)
      return

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
