noflo = require 'noflo'

request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class Display extends Component
  constructor: ->

    @inPorts =
      in:     new Port 'string'

    @inPorts.in.on 'data', (data) =>
      obj = JSON.parse data.text
      console.log obj.length

exports.getComponent = -> new Display