describe "State", ->
  beforeEach ->
    @data = JSON.parse(__html__["tests/fixtures/web_state.json"])
  it "read json data", ->
    State.read(@data.nodes, @data.edges)
