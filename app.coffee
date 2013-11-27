express = require("express")
noflo = require("noflo")
jade = require("jade")

app = express()

app.set "views", __dirname + "/"
app.set "view engine", "jade"
app.use express.bodyParser()

graph = noflo.graph.createGraph "search"
graph.addNode "M", "MakeRequest"
graph.addNode "S", "SendRequest"
graph.addNode "D", "Display"
graph.addEdge "M", "out", "S", "in"
graph.addEdge "S", "out", "D", "in"

graph.addInitial "http://tinysong.com/s/Linkin Park?format=json&limit=3&key=a337b63c225442d8c370830785a4e92b", "M", "in"
noflo.createNetwork graph