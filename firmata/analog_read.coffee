BLEFirmata = require 'ble-firmata'

console.log device_name = process.argv[2] || "BlendMicro"

arduino = new BLEFirmata().connect(device_name)

stat = false

arduino.on 'connect', ->
  setInterval ->
    console.log arduino.analogRead 0
  , 500

