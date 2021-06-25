modem = peripheral.find("modem")
modem.open(1001)

-- Receive Request:
while true do
    local users
    if fs.exists("users.lua") then
        users = textutils.unserialise(fs.open("users.lua", "r").readAll())
    else
        users = {}
    end

    local event, _, senderChannel,
        replyChannel, request, _ = os.pullEvent("modem_message") -- Discarding modemSide, senderDistance
    print("received request:"..textutils.serialize(request))
    
    users[request.userID].balance = users[request.userID].balance - request.amount
    users[request.payeeID].balance = users[request.payeeID].balance + request.amount
    
    local usersf = fs.open("users.lua", "w")
    usersf.write(textutils.serialise(users))
    usersf.close()
    print(textutils.serialise(users))
end
