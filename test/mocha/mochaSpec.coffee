expObj = require "../../src/server/app"
request = require("supertest")(expObj.app)

describe "SuperTestのテスト", ()->
  after ()->
    expObj.server.close()

  it "indexにアクセスできる",(done)->
    request
      .get "/"
      .expect 200,done
