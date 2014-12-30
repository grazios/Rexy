describe "rexy start test",()->
  rexyApp = null
  beforeEach ->
    rexyApp = angular.module("rexyApp")

  it "rexyApp defined",->
    expect(rexyApp).not.to.be.null

  it "what rexy?",()->
    expect(rexy()).to.equal("it's funtastic history server")
