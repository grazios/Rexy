class History
  _con = null
  _res = null
  constructor: (connection,res)->
    _con = connection
    _res = res

  isOkHistoryParam = (param,res)->
    result = true
    unless param.subject?
      res.status(400).send "OMG :("
      result = false
    unless param.abstract?
      res.status(400).send "OMG :("
      result = false
    return result

  get:(query)->
    sql = ""
    unless query?
      sql ="SELECT * FROM histories"
    else
      sql ="SELECT * FROM histories"


    _con.query sql,query,(err,results)->
      if err
        throw new Error "OMG :("
      else
        if results.length == 0
          _res.status(404).send "OMG:("
        else
          _res.send JSON.stringify(results)

  create:(param)->
    result = _con.query "INSERT INTO histories SET ?",param,(err,results)->
      if err
        throw new Error "OMG :("
      else
        res.send JSON.stringify(results)

module.exports = History
