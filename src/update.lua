local protocol = "ratOSupdate"


local function fetchVersion()
    serverID = rednet.lookup(protocol)
    if serverID ~= nil then
        local recieved = rednet.send(serverID, "getVersion")
        if recieved then
            local nSenderID, version, sProtocol = rednet.recieve(protocol, 10)
            return version;
        else
            return nil
        end
    else
        return nil
    end
end