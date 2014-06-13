noble = require 'noble'
_     = require 'lodash'

noble.on 'discover', (peripheral) ->
  console.log peripheral.advertisement.localName
  # console.log peripheral

noble.startScanning()
