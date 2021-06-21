function installPrograms()
    if fs.exists("programlist") then
    
    else
        local default = 
        {
            udo = {link="cUwVrENR", path="bin"},
            button = {link="x71BzgKb", path="api_dir"},
            calc = {link="5v4aar72", path="bin"},
            play2048 = {link="RHhdEZ52", path="bin"}
        }
        for name,cfg in pairs(default) do
            shell.run(
            "pastebin", 
            "get", 
            cfg.link, 
            cfg.path .. "/" .. name)
        end
    end
end

if not fs.exists("/bin") then
    print("Initialising ratOS")
    shell.run("mkdir", "bin")
    shell.run("mkdir", "home")
    shell.run("mkdir", "api_dir")
    print("Created directories..")
    
    installPrograms()
    print("Installed default programs")
    if os.computerLabel() == nil then
        os.setComputerLabel("RatCo Micro")
    end
    settings.set("motd.enable", false)
    print("Configured settings")
    
    print(
[[Initialisation complete.
Default name: RatCo Micro
Set computer name with
label set <name>
Press [E] to enter ratOs]])
    
    while true do
        local event, key = os.pullEvent("key")
        if key == keys.e then
            shell.run("clear")
            break
        end
    end 
end    


print("Welcome to RatCo Micro")
print("Current installed programs:")
for k,v in pairs(fs.find("/bin/*")) do
    shell.setAlias(fs.getName(v),"/" .. v)
    print(k ..".","/".. v,fs.getName(v))
end

if fs.exists("autorun") then
    shell.run("background", "autorun")
end