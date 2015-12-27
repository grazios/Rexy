class History
  _con = null
  contructor: (connection)->
    _con = connection

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
    result = connection.query "SELECT * FROM histories WHERE ?",query,(err,results)->
      if err
        throw new Error "OMG :("
      else
        if results.length == 0
          return null
        else
          return JSON.stringify(results)

  create:(param)->
    result = connection.query "INSERT INTO histories SET ?",param,(err,results)->
      if err
        throw new Error "OMG :("
      else
        return JSON.stringify(results)
      return

module.exports = History
