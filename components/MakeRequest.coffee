noflo = require 'noflo'

request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class MakeRequest extends Component
  constructor: ->
    @method = 'GET'

    @inPorts =
      in: new Port 'string'
      method: new Port 'string'
    @outPorts =
      out: new Port 'object'

    @inPorts.method.on 'connect', () =>
      @method = 'GET'

    @inPorts.method.on 'data', (@method) =>

    @inPorts.in.on 'data', (text) =>
      url = "http://tinysong.com/s/"+text+"?format=json&limit=10&key=a337b63c225442d8c370830785a4e92b"
      @outPorts.out.send request(@method, url)
      @method = 'GET'

    @inPorts.in.on 'disconnect', () =>
      @outPorts.out.disconnect()

exports.getComponent = -> new MakeRequest