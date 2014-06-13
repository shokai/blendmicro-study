BLEFirmata = require 'ble-firmata'

console.log device_name = process.argv[2] || "BlendMicro"

arduino = new BLEFirmata().connect(device_name)

stat = false

arduino.on 'connect', ->
  setInterval ->
    console.log stat
    arduino.digitalWrite 12, stat
    arduino.digitalWrite 13, stat
    stat = !stat
  , 500

