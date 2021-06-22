local protocol = "ratOSupdate"

function fetchVersion(serverID)
    local recieved = rednet.send(serverID, "getVersion")
    if recieved then
        local nSenderID, version, sProtocol = rednet.recieve(protocol, 10)
        return parseVersion(version)
    else
        return nil
    end
end

function getCurrentVersion()
    if fs.exists("/version") then
        local handler = fs.open("/version", "r")
        local version = handler.readLine()
        return parseVersion(version)
    else
        return nil
    end
end

-- https://stackoverflow.com/a/1647577/16071759
-- untested
function string:split(pat)
    pat = pat or "%s+"
    local st, g = 1, self:gmatch("()(" .. pat .. ")")
    local function getter(segs, seps, sep, cap1, ...)
        st = sep and seps + #sep
        return self:sub(segs, (seps or 0) - 1), cap1 or sep, ...
    end
    return function()
        if st then
            return getter(st, g())
        end
    end
end

function parseVersion(sVersion)
    local vNumbers = {}
    for i, s in sVersion.split(".") do
        table.insert(vNumbers, s)
    end
    return vNumbers
end

local function updateRequired(serverID)
    local currentVersion = getCurrentVersion()
    if currentVersion == nil then
        return true
    end

    local serverVersion = fetchVersion(serverID)
    if serverVersion == nil then
        return false
    end

    for i = 0, 2 do
        if currentVersion[i] < serverVersion[i] then
            return true
        end
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
    local serverID = rednet.lookup(protocol)
    local success = false
    if serverID ~= nil then
        if updateRequired(serverID) then
            local recieved = rednet.send("update")
            if recieved then
                -- Update here
                success = true
            end
        end
    end
    return success
end

rednet.run()

local modems = peripheral.find("modem")

for _, modem in pairs(modems) do
    rednet.open(modem)
end

term.write(update())