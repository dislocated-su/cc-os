local protocol = "ratOSupdate"

function fetchVersion(serverID)
    local recieved = rednet.send(serverID, "getVersion")
    if recieved then
        local nSenderID, version, sProtocol = rednet.recieve(protocol, 10)
        return version
    else
        return nil
    end
end

function getCurrentVersion()
    if fs.exists("/version") then
        local handler = fs.open("/version", "r")
        local version = handler.readLine()
        return version
    else
        return nil
    end
end

-- https://stackoverflow.com/a/1647577/16071759
-- untested
function string:split(pat)
    pat = pat or '%s+'
    local st, g = 1, self:gmatch("()("..pat..")")
    local function getter(segs, seps, sep, cap1, ...)
      st = sep and seps + #sep
      return self:sub(segs, (seps or 0) - 1), cap1 or sep, ...
    end
    return function() if st then return getter(st, g()) end end
  end

function parseVersion(sVersion)
    local vNumbers = {}
    for i, s in vNumbers.split(".") do
        -- stub, untested if this iteration works
    end
end

function getUpdate(serverID)
    local recieved = rednet.send(serverID, "update")
    if recieved then
        local nSenderID, code, sProtocol = rednet.recieve(protocol, 15)
        return code
    else
        return nil
    end
end

local function update()
    serverID = rednet.lookup(protocol)
    if serverID ~= nil then
        local currentVersion = getCurrentVersion()
        if currentVersion == nil then
            -- if version is lower 
            -- local updateCode = getUpdate()
            -- and so on
        end
    end
    
end
