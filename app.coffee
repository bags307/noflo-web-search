express = require("express")
noflo = require("noflo")
jade = require("jade")

app = express()

app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.bodyParser()

app.get "/", (req, res) ->
  res.render "search", searchtext: ""

app.post "/", (req, res) ->
	search_string = req.body.search_string
	graph = noflo.graph.createGraph "search"
	graph.addNode "SC", "SearchController"
	graph.addNode "M", "MakeRequest"
	graph.addNode "S", "SendRequest"
	graph.addNode "D", "Display"
	graph.addEdge "SC", "response", "D", "response"
	graph.addEdge "SC", "search", "M", "in"
	graph.addEdge "M", "out", "S", "in"
	graph.addEdge "S", "out", "D", "in"
	graph.addInitial [search_string, res], "SC", "in"
	noflo.createNetwork graph

app.listen 3000
console.log "Listen on port 3000"