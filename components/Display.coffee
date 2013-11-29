noflo = require 'noflo'

request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class Display extends Component
	constructor: ->
		@res = null
		@inPorts =
			in: new Port 'string'
			response: new Port 'object'

		@inPorts.response.on 'data', (r) =>
			@res = r

		@inPorts.in.on 'data', (data) =>
			obj = JSON.parse data.text
			if @res isnt null
				@res.render "result",
					searchtext: ""
					items: obj

exports.getComponent = -> new Display