modem = peripheral.find("modem")
modem.open(1002)
 
local request = {
    type = "test",
    compID = os.getComputerID(),
    reqID = os.getComputerID().."-"..os.day().."-".. os.time()
} 
modem.transmit(1001, 1002, request)