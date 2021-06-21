function installPrograms()
    local list
    if fs.exists("programlist") then
        -- load programlist from file
    else
        list = {
            udo = {link = "cUwVrENR", path = "bin"},
            button = {link = "x71BzgKb", path = "api_dir"},
            calc = {link = "5v4aar72", path = "bin"},
            play2048 = {link = "RHhdEZ52", path = "bin"}
        }
    end
    -- Install every program
    for name, cfg in pairs(list) do
        shell.run(
            "pastebin", 
            "get", 
            cfg.link, 
            cfg.path .. "/" .. name
        )
    end
end

function setup()
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
Press [E] to enter ratOs]]
    )

    -- repeat until E is pressed
    local event, key
    repeat
        event, key = os.pullEvent("key")
    until key == keys.e
    shell.run("clear")
end

-- Normal start
function boot()
    -- Welcome MOTD
    print("Welcome to RatCo Micro")
    print("Current installed programs:")
    -- Loop through every file in bin (k as counter, v as full file path)
    for k, v in pairs(fs.find("/bin/*")) do
        -- Everything in bin gets a system-wide alias
        shell.setAlias(fs.getName(v), "/" .. v)
        print(k .. ".", fs.getName(v))
    end

    if fs.exists("autorun") then
        shell.run("background", "autorun")
    end
end

if not fs.exists("/bin") then
    setup()
end

boot()
