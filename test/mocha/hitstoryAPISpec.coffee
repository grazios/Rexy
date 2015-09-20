expObj = require "../../src/server/app"
request = require("supertest")(expObj.app)

describe "HistoryAPIテスト", ()->
  after ()->
    expObj.server.close()

  describe "GET: /api/history/1", ()->
    it "記事番号1の記事情報を取得",(done)->
      request
        .get "/api/history/1"
        .expect 200,done
    it "形式がJSONである",(done)->
      request
        .get "/api/history/1"
        .expect "Content-Type",/json/,done
