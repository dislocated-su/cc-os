local function serve()
    -- assume rednet is already running
    local protocol = "ru"
    local hostname = "server"

    rednet.host(protocol, hostname)
    
    term.write("Serving protocol " .. protocol .. " at " .. hostname)
    while true do
        local nSenderID, message, sProtocol

        repeat
            nSenderID, message, sProtocol = rednet.receive(protocol)
        until message ~= ""

        if message == "getVersion" then
            rednet.send(nSenderID, getVersion(), protocol)
        elseif message == "update" then
            rednet.send(nSenderID, getUpdate(), protocol)
        else
            -- Log?
        end
    end
end

function getVersion()
    return "0.0.1"
end

function getUpdate()
    return "test"
end

return {serve = serve}