noble = require 'noble'
_     = require 'lodash'

UUIDs =
  service: "713d0000-503e-4c75-ba94-3148f18d941e".replace(/\-/g, '')
  tx:      "713d0003-503e-4c75-ba94-3148f18d941e".replace(/\-/g, '')
  rx:      "713d0002-503e-4c75-ba94-3148f18d941e".replace(/\-/g, '')

noble.on 'discover', (peripheral) ->
  if peripheral.advertisement.localName is "BlendMicro"
    console.log "device found"

    peripheral.connect ->
      console.log 'connect!!'

      setInterval ->
        peripheral.updateRssi (err, rssi) ->
          console.log "rssi: #{rssi}"
      , 1000

      peripheral.discoverServices [], (err, services) ->
        service = _.find services, (service) -> service.uuid is UUIDs.service
        service.discoverCharacteristics [], (err, chars) ->

          tx = _.find chars, (char) -> char.uuid is UUIDs.tx
          rx = _.find chars, (char) -> char.uuid is UUIDs.rx

          rx.on 'read', (data) ->
            console.log data?.toString()
          rx.notify true, (err) ->
            console.error err

          setInterval ->
            msg = _.sample ['かずすけ', 'ざんまい', 'かずどん', 'まるたか']
            tx.write new Buffer msg, 'utf-8'
          , 1000

          on_exit = ->
            peripheral.disconnect ->
              process.exit 0

          process.on 'SIGINT', on_exit
          process.on 'SIGHUP', on_exit

noble.startScanning()
