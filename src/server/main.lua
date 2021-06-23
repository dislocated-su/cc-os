local updater = require("updater")

local modem = peripheral.find("modem")
rednet.open(peripheral.getName(modem))

updater.serve()