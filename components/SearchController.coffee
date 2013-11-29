noflo = require 'noflo'
request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class SearchController extends Component
	constructor: ->

		@inPorts =
			in: new Port

		@outPorts =
			search: new Port 'string'
			response: new Port 'object'

		@inPorts.in.on 'data', (data) =>
			@outPorts.search.send data[0]
			@outPorts.response.send data[1]
###
		@inPorts.in.on 'disconnect', ()=>
			@outPorts.response.disconnect()
###
exports.getComponent = -> new SearchController