modem = peripheral.find("modem")
modem.open(1001)
 
-- Receive Request:
while true do
    local event, _, senderChannel,
        replyChannel, request, _ = os.pullEvent("modem_message") -- Discarding modemSide, senderDistance
    print("received request:"..textutils.serialize(request))
end