modem = peripheral.find("modem")
modem.open(1002)

local request = {
    action = "send",
    userID = "test1",
    payeeID = "test2",
    amount = 100,
    compID = os.getComputerID(),
    reqID = os.getComputerID().."-"..os.day().."-".. os.time()
} 
modem.transmit(1001, 1002, request)
