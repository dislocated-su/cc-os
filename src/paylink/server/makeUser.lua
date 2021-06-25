local args = {...}
 
if #args ~= 1 then
    print("Error. Usage: makeUser [username]")
else
    local users
    if fs.exists("users.lua") then
        users = textutils.unserialise(fs.open("users.lua", "r").readAll())
    else
        users = {}
    end
    print(textutils.serialise(users))
    users[args[1]] = "ee"
    local usersf = fs.open("users.lua", "w")
    usersf.write(textutils.serialise(users))
    usersf.close()
    print(textutils.serialise(users))
end