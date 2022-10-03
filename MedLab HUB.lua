-- Prison Life https://www.roblox.com/games/155615604/Prison-Life-Cars-fixed
if game.PlaceId == 155615604 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab", "Midnight")
        -- Values
        local WP = workspace.Prison_ITEMS.giver
        local MP = workspace.Prison_ITEMS.single
        -- Values Core
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        local WeaponTable = {} -- Weapon Table
        for i,v in pairs(WP:GetChildren()) do
            if v~=WP then
                WeaponTable[#WeaponTable+1] = v.Name
            end
        end
        local MeleeTable = {} -- Melee&Item Table
        for i,v in pairs(MP:GetChildren()) do
            if v~=MP then
                MeleeTable[#MeleeTable+1] = v.Name
            end
        end
        local Teleports = { --add your teleports here
        CriminalHQ = CFrame.new(-976.7828979492188,109.32376861572266,2053.4306640625),
        PrisonCell = CFrame.new(960.1095581054688,114.78997039794922,2438.6220703125),
        PrisonCellHall = CFrame.new(915.9741821289062,99.98997497558594,2451.855224609375),
        Cafetaria = CFrame.new(942.5005493164062,99.98993682861328,2265.30224609375),
        Kitchen = CFrame.new(876.8281860351562,99.98993682861328,2220.580322265625),
        Yard = CFrame.new(802.7354736328125,98.1899185180664,2533.961669921875),
        YardTower = CFrame.new(823.5271606445312,130.03990173339844,2588.708740234375),
        Sewer = CFrame.new(918.08447265625,78.69676208496094,2115.6767578125),
        GuardsGarage = CFrame.new(614.3189086914062,98.20000457763672,2520.23583984375),
        PrisonEntrance = CFrame.new(723.17626953125,99.98998260498047,2258.4130859375),
        GuardsSpawn = CFrame.new(857.6189575195312,99.98998260498047,2312.746826171875),
        GuardsArmory = CFrame.new(838.1721801757812,99.98998260498047,2264.80517578125),
        GuardsSurveillance = CFrame.new(794.0276489257812,99.98998260498047,2328.0263671875),
        GuardsBreakRoom = CFrame.new(801.1937866210938,99.98998260498047,2272.273681640625)
        }
        local tpArray = {} --we are making this so we can use it later on the dropdown
        for i,v in next, Teleports do
        tpArray[#tpArray + 1] = i
        end

    -- Main
    local MainTab = Window:NewTab("Main")
    local MainSection = MainTab:NewSection("Main")  
        -- Bypass arrest
        MainSection:NewToggle("Bypass Arrest", "NO CD ARREST", function(state)
            if state then
                getgenv().BA = true
                local mouse = game.Players.LocalPlayer:GetMouse()
                local arrestEvent = game.Workspace.Remote.arrest
                mouse.Button1Down:connect(function()
                if getgenv().BA == true then
                local obj = mouse.Target
                local response = arrestEvent:InvokeServer(obj)
                end
                end)
            else
                getgenv().BA = false
            end
        end)
        -- Give Key Card
        MainSection:NewButton("Key Card", "Get Weapon", function()
            local OldPosition = nil
            if game.workspace.Prison_ITEMS.single:FindFirstChild("Key card") then
                game.workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single:FindFirstChild("Key card").ITEMPICKUP)
            else
                OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local NoCardFound = true
                while NoCardFound == true do
                    game.workspace.Remote.TeamEvent:FireServer("Bright blue")
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                    if game.workspace.Prison_ITEMS.single:FindFirstChild("Key card") then
                        NoCardFound = false
                        workspace.Remote.TeamEvent:FireServer("Bright orange")
                        workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
                        game.workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single:FindFirstChild("Key card").ITEMPICKUP)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPosition)
                    end
                wait()
                end
            end
        end)
        -- Weapon Giver
        local MainSection = MainTab:NewSection("Weapon")  
        local SelectedWeapon;
        local Weapondropdown = MainSection:NewDropdown("Weapon","Select Weapon", WeaponTable, function(value)
            SelectedWeapon = value
            print(value)
        end)
        MainSection:NewButton("Get", "Get Weapon", function()
            workspace.Remote.ItemHandler:InvokeServer(WP[SelectedWeapon].ITEMPICKUP)
        end)
        -- Melee&Item Giver
        MainSection:NewLabel("Melee & Item")
        local SelectedMelee;
        local Meleedropdown = MainSection:NewDropdown("Select","Select Melee or Item", MeleeTable, function(value)
            SelectedMelee = value
            print(value)
        end)
        MainSection:NewButton("Refresh", "Refreshes Dropdown", function()
            unpack(MeleeTable)
        end)
        MainSection:NewButton("Get", "Get Weapon", function()
            workspace.Remote.ItemHandler:InvokeServer(MP[SelectedMelee].ITEMPICKUP)
        end)
        -- Teleport
        MainSection:NewLabel("Teleport")
            -- Teleport to Coordinates
            MainSection:NewDropdown("Teleports", "Teleport to Coordinates", tpArray, function(SelectedLocation)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Teleports[SelectedLocation]
            end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)

    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
        --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
        end)
        --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
        end)
        --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end)
        --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
        end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- Drive Cars Down A Hill! https://www.roblox.com/games/9414511685/Drive-Cars-Down-A-Hill
elseif game.PlaceId == 9414511685 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab | Drive Cars Down A Hill!", "Midnight")
        -- Values
        _G.CFL      = true
        local VP    = game.ReplicatedStorage.CarViewmodels
        local GSRS  = game:GetService("ReplicatedStorage")
        -- Values Core
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        -- Functions
        function CFL() -- Cash Farm Loop
            while _G.CFL == true do
                GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-26.23527717590332,-2582.30029296875,26233.322265625)
                wait(4)
                GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20.11614990234375,512.099609375,181.80662536621094)
                wait(1)
            end
        end
        -- Tables
        local VehicleTable = {} -- Vehicle Table for Spawner
        for i,v in pairs(VP:GetChildren()) do
            if v~=VP then
                VehicleTable[#VehicleTable+1] = v.Name
            end
         end

    -- Main
    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        --TP END
        MainSection:NewButton("The End", "TP to The End", function()
            GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-26.23527717590332,-2582.30029296875,26233.322265625)
        end)
        --TP Spawn
        MainSection:NewButton("Spawn", "TP to Spawn", function()
            GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20.11614990234375,512.099609375,181.80662536621094)
        end)
         --TP Checkpoint 1
         MainSection:NewButton("Checkpoint 1", "TP to Checkpoint 1", function()
            GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-82.15776824951172,-2710.546630859375,15664.6669921875)
        end)
        --LOOP
        MainSection:NewToggle("Loop TP SPAWN", "FARM MONEY", function(value)
            _G.CFL = value
            CFL()
        end)
        --Server Destroyer
        MainSection:NewButton("Destroy Server", "Server Destroyer", function()
            local ShatterGlass = select(2, pcall(function()
                return GSRS.Remotes.ShatterGlass
                end))
                
                if typeof(ShatterGlass) == 'Instance' and ShatterGlass:IsA("RemoteEvent") then
                for _, v in pairs(workspace:GetDescendants()) do
                ShatterGlass:FireServer(v)
                end
                end
        end)
        -- Spawner
        MainSection:NewLabel("Spawner")
            local SelectedVehicle;
            local Vehicledropdown = MainSection:NewDropdown("Dropdown","Info", VehicleTable, function(value)
                    SelectedVehicle = value
                    print(value)
            end)
            MainSection:NewButton("Spawn", "Refreshes Dropdown", function()
                GSRS.SpawnCar:FireServer(0,SelectedVehicle)
            end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- Tower of Misery https://www.roblox.com/games/4954752502/Tower-of-Misery
elseif game.PlaceId == 4954752502 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab | Tower of Misery", "Midnight")
        -- Values
        local TPCF  = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
        -- Values Core
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
    
    -- Main
    local MainTab = Window:NewTab("Main")
    local MainSection = MainTab:NewSection("Main")
        -- Top
        MainSection:NewButton("Top", "TP to Top", function()
            TPCF = CFrame.new(-75.16317749023438,253.99986267089844,60.79096221923828)
        end)
        -- Bottom
        MainSection:NewButton("Bottom", "TP to Bottom", function()
            TPCF = CFrame.new(-22.09346580505371,-10.999865531921387,48.87485122680664)
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)

    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
        --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
        end)
        --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
        end)
        --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end)
        --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
        end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- SHADOVIS RPG
elseif game.PlaceId == 9585537847 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | SHADOVIS RPG", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        getgenv().TAD = true
        -- Function
        function TAD() -- Cash Farm Loop
            while getgenv().TAD == true do
                GSP.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9637.5048828125,2253.259765625,10144.80859375) 
            end
        end

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        MainSection:NewToggle("TP", "Toggle", function()
            if getgenv().TAD == true then
                game.Players.LocalPlayer.CharacterAdded:connect(function()
                    getgenv().TAD = value
                    TAD()
                    end)
            else
                getgenv().TAD = false
            end
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- 🔪 Survive the Killer!
elseif game.PlaceId == 4580204640 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | 🔪 Survive the Killer!", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        getgenv().IT = true
        getgenv().ED = true
        
    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        MainSection:NewButton("Item", "Toggle", function()
            if getgenv().IT == true then
                -- TRASH
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Type = "Model",
                    Color = ColorDynamic,
                    IsEnabled = "Item"
                })
                -- RAINBOW 150
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "treasure_chest",
                    Type = "Model",
                    Color = Color3.fromRGB(248, 249, 250),
                    IsEnabled = "Rainbow"
                })
                -- GOLDEN 30
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "gold_bars",
                    Type = "Model",
                    Color = Color3.fromRGB(255, 221, 67),
                    IsEnabled = "Golden"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "pendant",
                    Type = "Model",
                    Color = Color3.fromRGB(255, 221, 67),
                    IsEnabled = "Golden"
                })
                -- PINK 15
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "golden_pocket_watch",
                    Type = "Model",
                    Color = Color3.fromRGB(255, 0, 255),
                    IsEnabled = "Pink"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "golden_compass",
                    Type = "Model",
                    Color = Color3.fromRGB(255, 0, 255),
                    IsEnabled = "Pink"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "apocalypse_helmet",
                    Type = "Model",
                    Color = Color3.fromRGB(255, 0, 255),
                    IsEnabled = "Pink"
                })
                -- RED 6
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "smartphone",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "smartwatch",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "laptop",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "trophy",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "binoculars",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "welding_goggles",
                    Type = "Model",
                    Color = Color3.fromRGB(234, 13, 1),
                    IsEnabled = "Red"
                })
                -- BLUE 3
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "car_engine",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "rusty_cleaver",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "pickaxe",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "busted_boombox",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "rusty_pipe",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "old_slycer",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "tire",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap.Loot, {
                    Name = "gen_1",
                    Type = "Model",
                    Color = Color3.fromRGB(166, 227, 224),
                    IsEnabled = "Blue"
                })
                ESP.Rainbow     = true
                ESP.Golden      = true
                ESP.Pink        = true
                ESP.Red         = true
                ESP.Blue        = true
                ESP.Item        = true
                ESP.Boxes       = false
                getgenv().IT    = false
            else
                ESP.Rainbow     = false
                ESP.Golden      = false
                ESP.Pink        = false
                ESP.Red         = false
                ESP.Blue        = false
                ESP.Item        = false
                getgenv().IT    = true
            end
        end)
        -- DOOR
        MainSection:NewButton("DOOR", "Toggle", function()
            if getgenv().ED == true then
                ESP:AddObjectListener(game:GetService("Workspace").CurrentMap, {
                    Name = "ExitDoor",
                    Type = "Model",
                    Color = Color3.fromRGB(248, 249, 250),
                    IsEnabled = "ED"
                })
                ESP.ED = true
                getgenv().ED = false
            else
                ESP.ED = false
                getgenv().ED = true
            end
        end)
    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- All of Us Are Dead
elseif game.PlaceId == 9759729519 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | All of Us Are Dead", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local Zombie = game:GetService("Workspace").Enemies
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        getgenv().Zombie = true

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        MainSection:NewButton("Zombie ESP", "Toggle", function()
            if getgenv().Zombie == true then 
                ESP:AddObjectListener(game:GetService("Workspace").Enemies, {
                    Color =  Color3.new(1,1,0),
                    Type = "Model",
                    PrimaryPart = function(obj)
                        local hrp = obj:FindFirstChildWhichIsA("BasePart")
                        while not hrp do
                            wait()
                            hrp = obj:FindFirstChildWhichIsA("BasePart")
                        end
                        return hrp
                    end,
                    Validator = function(obj)
                        return not game.Players:GetPlayerFromCharacter(obj)
                    end,
                    CustomName = function(obj)
                        return obj:FindFirstChild("Zombie") and obj.Zombie.Value or obj.Name
                    end,
                    IsEnabled = "NPCs",
                    })
                    ESP.NPCs = true
                    ESP.Boxes = false
                    getgenv().Zombie = false
                else
                    ESP.NPCs = false
                    getgenv().Zombie = true
            end
        end)
        MainSection:NewButton("INF AMMO", "Toggle", function()
            local old
            local path = game.Players.LocalPlayer.Backpack
            old = hookmetamethod(path, "__index", function(instances,property)
                if tostring(instances) == "CurrentAmmo" and property == "Value" then
                    return math.huge
                end
                if tostring(instances) == "ShotCooldown" and property == "Value" then
                    return 0.
                end
                if tostring(instances) == "GravityFactor" and property == "Value" then
                    return 0.
                end
                if tostring(instances) == "RecoilMax" and property == "Value" then
                    return 0.
                end
                if tostring(instances) == "RecoilMin" and property == "Value" then
                    return 0.
                end
                if tostring(instances) == "MaxSpread" and property == "Value" then
                    return 0.
                end
                if tostring(instances) == "GravityFactor" and property == "Value" then
                    return 0.
                end
                return old(instances,property)
                end)
                    end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits") 

-- CLICKER SIMULATOR --
-- 🔥100X CLICKS🔥 Clicker Madness!😈
elseif game.PlaceId == 5490351219 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | 🔥100X CLICKS🔥 Clicker Madness!😈", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local ClickMod = require(game:GetService("Players").LocalPlayer.PlayerScripts.Aero.Controllers.UI.Click)
        local GamepassMod = require(game:GetService("ReplicatedStorage").Aero.Shared.Gamepasses)
        -- Function
        function AutoTap() -- auto tap
            spawn(function()
                while getgenv().autotap == true do
                    ClickMod:Click() -- Click Script Module
                    wait()
                end
            end)
        end
        function UnlockGamepasses() -- unlock gamepass
            GamepassMod.HasPassOtherwisePrompt = function() return true end
        end

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        -- Auto Tap
        MainSection:NewToggle("CLICK", "Toggle", function(bool)
            getgenv().autotap = bool
            if bool then
                AutoTap();
            end
        end)
        -- Unlock Gamepasses
        MainSection:NewButton("Gamepass", "Auto Rebirth, Triple Hatch", function()
            UnlockGamepasses();
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- TYCOON --
-- Apartment Tycoon [UPD 3!]
elseif game.PlaceId == 9284097280 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | Apartment Tycoon [UPD 3!]", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local Loc   = game:GetService("Workspace"):FindFirstChild(PP.UserId .. "Tycoon").GeneratedFloor1.MoneyATM.Part

        -- Function
        function ACM() -- Auto Collect Money
            while getgenv().ACM == true do
                PP.PlayerGui:FindFirstChild("EffectsScreenGui").Enabled = false -- disable collected money screen effect
                firetouchinterest(PP3, Loc, 0)
                wait(1)
                PP.PlayerGui:FindFirstChild("EffectsScreenGui").Enabled = true -- disable collected money screen effect
                firetouchinterest(PP3, Loc, 1)
            end
        end

    -- Main
    local Main          = Window:NewTab("Main")
    local MainSection   = Main:NewSection("Main")
        -- Auto Collect
        MainSection:NewToggle("Auto Collect Money", "", function(value)
            getgenv().ACM = value
            ACM()
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- Millionaire Empire Tycoon
elseif game.PlaceId == 6677985923 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | Millionaire Empire Tycoon", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local Loc   = game:GetService("Workspace").Tycoons[PP.Team.Name].StarterParts.Collector.Givers.Giver
        -- Function
        function ACM() -- Auto Collect Money
            while getgenv().ACM == true do
                firetouchinterest(PP3, Loc, 0)
                wait(1)
                firetouchinterest(PP3, Loc, 1)
            end
        end

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        MainSection:NewToggle("Auto Collect Money", "", function(value)
            getgenv().ACM = value
            ACM()
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- Money Tycoon!
elseif game.PlaceId == 9898710720 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | Money Tycoon!", "Midnight")
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")
        local Loc   = game:GetService("Workspace").Tycoons[PP.Team.Name].StarterParts.Collector.CollectPart
        -- Function
        function ACM() -- Auto Collect Money
            while getgenv().ACM == true do
                firetouchinterest(PP3, Loc, 0)
                wait(1)
                firetouchinterest(PP3, Loc, 1)
            end
        end

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        MainSection:NewToggle("Auto Collect Money", "", function(value)
            getgenv().ACM = value
            ACM()
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

-- 🛒🧒 Retail Tycoon 2
elseif game.PlaceId == 5865858426 then
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab | 🛒🧒 Retail Tycoon 2", "Midnight")
        -- Bypass GUI Detection
        local CoreGui = game.CoreGui
        local ContentProvider = game.ContentProvider
        local RobloxGuis = {"RobloxGui", "TeleportGui", "RobloxPromptGui", "RobloxLoadingGui", "PlayerList", "RobloxNetworkPauseNotification", "PurchasePrompt", "HeadsetDisconnectedDialog", "ThemeProvider", "DevConsoleMaster"}
        local function FilterTable(tbl)
            local context = syn_context_get()
            syn_context_set(7)
            local new = {}
            for i,v in ipairs(tbl) do --roblox iterates the array part
                if typeof(v) ~= "Instance" then
                    table.insert(new, v)
                else
                    if v == CoreGui or v == game then
                        --insert only the default roblox guis
                        for i,v in pairs(RobloxGuis) do
                            local gui = CoreGui:FindFirstChild(v)
                            if gui then
                                table.insert(new, gui)
                            end
                        end
                        if v == game then
                            for i,v in pairs(game:GetChildren()) do
                                if v ~= CoreGui then
                                    table.insert(new, v)
                                end
                            end
                        end
                    else
                        if not CoreGui:IsAncestorOf(v) then
                            table.insert(new, v)
                        else
                            --don't insert it if it's a descendant of a different gui than default roblox guis
                            for j,k in pairs(RobloxGuis) do
                                local gui = CoreGui:FindFirstChild(k)
                                if gui then
                                    if v == gui or gui:IsAncestorOf(v) then
                                        table.insert(new, v)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
            syn_context_set(context)
            return new
        end

        local old
        old = hookfunc(ContentProvider.PreloadAsync, function(self, tbl, cb)
            if self ~= ContentProvider or type(tbl) ~= "table" or type(cb) ~= "function" then --note: callback can be nil but in that case it's useless anyways
                return old(self, tbl, cb)
            end

            --check for any errors that I might've missed (such as table being {[2] = "something"} which causes "Unable to cast to Array")
            local err
            task.spawn(function() --TIL pcalling a C yield function inside a C yield function is a bad idea ("cannot resume non-suspended coroutine")
                local s,e = pcall(old, self, tbl)
                if not s and e then
                    err = e
                end
            end)
        
            if err then
                return old(self, tbl) --don't pass the callback, just in case
            end

            tbl = FilterTable(tbl)
            return old(self, tbl, cb)
        end)

        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if self == ContentProvider and (method == "PreloadAsync" or method == "preloadAsync") then
                local args = {...}
                if type(args[1]) ~= "table" or type(args[2]) ~= "function" then
                    return old(self, ...)
                end

                local err
                task.spawn(function()
                    setnamecallmethod(method) --different thread, different namecall method
                    local s,e = pcall(old, self, args[1])
                    if not s and e then
                        err = e
                    end
                end)

                if err then
                    return old(self, args[1])
                end

                args[1] = FilterTable(args[1])
                setnamecallmethod(method)
                return old(self, args[1], args[2])
            end
            return old(self, ...)
        end)
        
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")

    -- Main
    local Main        = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        -- Auto Load Unload Truck
        MainSection:NewButton("Instant Delivery", "", function()
            local Client = game:GetService("Players").LocalPlayer
            local GetPlot = function() return getrenv()._G.Plot end
            local GetLoadingDock = function()
            local Plot = tostring(GetPlot())
            local DockNum = string.gsub(Plot, "Plot_", "")
            return game:GetService("Workspace").Map.Landmarks["Loading Dock"]["LoadingDock_" .. DockNum].LoadingSpot
            end
            local GetVehicle; GetVehicle = function()
                for _, v in next, workspace.PlayerVehicles:GetChildren() do
                    if v.Name:match(Client.Name) then
                        return v
                    end
                end
                game:GetService("ReplicatedStorage").Remotes.SpawnVehicle:InvokeServer(1, Client.Character.HumanoidRootPart.CFrame * CFrame.new(10, 5, 0))
                task.wait()
                return GetVehicle()
            end
            local LoadCar = function()
                local Vehicle = GetVehicle()
                Vehicle:SetPrimaryPartCFrame(GetLoadingDock().CFrame)
                Client.Character:SetPrimaryPartCFrame(Vehicle.PrimaryPart.CFrame * CFrame.new(5, 0, 0))
                task.wait(.5)
                game:GetService("ReplicatedStorage").Remotes.LoadVehicle:InvokeServer()
            end
            local UnloadCar = function()
                for i, v in next, GetPlot():GetDescendants() do
                    if v.Name:lower():match("door") then
                        if v:FindFirstChild("Handle") and v:FindFirstChild("Base") then
                            local Vehicle = GetVehicle()
                            Vehicle:SetPrimaryPartCFrame(CFrame.new(v.Base.Position + Vector3.new(10, 6, 10)))
                            Client.Character:SetPrimaryPartCFrame(Vehicle.PrimaryPart.CFrame * CFrame.new(5, 0, 0))
                            task.wait(.5)
                            game:GetService("ReplicatedStorage").Remotes.UnloadVehicle:InvokeServer()
                        end
                    end
                end
            end
            local GetBoughtStuff = function()
                LoadCar()
                task.wait()
                UnloadCar()
            end
            GetBoughtStuff()
        end)
        MainSection:NewButton("Auto Purchase & Restock", "", function()
            getgenv().settings = {
                ['AutoRestock'] = {
                    ['Enabled'] = true,
                    ['Delay'] = 5, -- seconds 
                }
            }
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Sellables = ReplicatedStorage.Sellables
            local Remotes = ReplicatedStorage.Remotes
            local BuyStorage = Remotes.BuyStorage
            local StockShelfFunction = Remotes.StockShelfFunction
            local function getPlot()
                for index, value in next, getgc(true) do 
                    if type(value) == "table" and rawget(value, "Plot") then 
                        return value.Plot
                    end
                end
            end
            local Plot = getPlot()
            local function TypeToBuy(Item) 
                for index, value in next, Sellables:GetChildren() do 
                    if value:FindFirstChild(Item,true) then 
                        return value.Name 
                    end
                end
            end
            local function BuyAllItems()
                for Index, Value in next, Plot.Objects:GetChildren() do
                    for Index, Value in next, Value:GetChildren() do 
                        if Value:FindFirstChild("Sellables") then 
                            local AmountToBuy = #Value.Sellables.Items:GetChildren() - Value.SellableAmount.Value 
                            if AmountToBuy > 0 then 
                                BuyStorage:InvokeServer(TypeToBuy(Value.Sellable.Value),AmountToBuy,true)
                                wait(.1)
                                StockShelfFunction:InvokeServer(Value, Value.Sellable.Value)
                            end
                        end
                    end
                end
            end
            while settings['AutoRestock'].Enabled do 
                BuyAllItems()
                wait(settings['AutoRestock'].Delay)
            end
        end)
        MainSection:NewButton("Anti AFK", "", function()
            for Index, Value in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
                Value:Disable()
                end
        end)

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")

else -- MedLab Hub CORE
    local Library   = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window    = Library.CreateLib("MedLab", "Midnight")
        -- Bypass GUI Detection
        local CoreGui = game.CoreGui
        local ContentProvider = game.ContentProvider
        local RobloxGuis = {"RobloxGui", "TeleportGui", "RobloxPromptGui", "RobloxLoadingGui", "PlayerList", "RobloxNetworkPauseNotification", "PurchasePrompt", "HeadsetDisconnectedDialog", "ThemeProvider", "DevConsoleMaster"}
        local function FilterTable(tbl)
            local context = syn_context_get()
            syn_context_set(7)
            local new = {}
            for i,v in ipairs(tbl) do --roblox iterates the array part
                if typeof(v) ~= "Instance" then
                    table.insert(new, v)
                else
                    if v == CoreGui or v == game then
                        --insert only the default roblox guis
                        for i,v in pairs(RobloxGuis) do
                            local gui = CoreGui:FindFirstChild(v)
                            if gui then
                                table.insert(new, gui)
                            end
                        end

                        if v == game then
                            for i,v in pairs(game:GetChildren()) do
                                if v ~= CoreGui then
                                    table.insert(new, v)
                                end
                            end
                        end
                    else
                        if not CoreGui:IsAncestorOf(v) then
                            table.insert(new, v)
                        else
                            --don't insert it if it's a descendant of a different gui than default roblox guis
                            for j,k in pairs(RobloxGuis) do
                                local gui = CoreGui:FindFirstChild(k)
                                if gui then
                                    if v == gui or gui:IsAncestorOf(v) then
                                        table.insert(new, v)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
            syn_context_set(context)
            return new
        end

        local old
        old = hookfunc(ContentProvider.PreloadAsync, function(self, tbl, cb)
            if self ~= ContentProvider or type(tbl) ~= "table" or type(cb) ~= "function" then --note: callback can be nil but in that case it's useless anyways
                return old(self, tbl, cb)
            end

            --check for any errors that I might've missed (such as table being {[2] = "something"} which causes "Unable to cast to Array")
            local err
            task.spawn(function() --TIL pcalling a C yield function inside a C yield function is a bad idea ("cannot resume non-suspended coroutine")
                local s,e = pcall(old, self, tbl)
                if not s and e then
                    err = e
                end
            end)
        
            if err then
                return old(self, tbl) --don't pass the callback, just in case
            end

            tbl = FilterTable(tbl)
            return old(self, tbl, cb)
        end)

        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if self == ContentProvider and (method == "PreloadAsync" or method == "preloadAsync") then
                local args = {...}
                if type(args[1]) ~= "table" or type(args[2]) ~= "function" then
                    return old(self, ...)
                end

                local err
                task.spawn(function()
                    setnamecallmethod(method) --different thread, different namecall method
                    local s,e = pcall(old, self, args[1])
                    if not s and e then
                        err = e
                    end
                end)

                if err then
                    return old(self, args[1])
                end

                args[1] = FilterTable(args[1])
                setnamecallmethod(method)
                return old(self, args[1], args[2])
            end
            return old(self, ...)
        end)
        
        -- Values
        local PP    = game.Players.LocalPlayer
        local PP2   = PP.Character.Humanoid
        local PP3   = PP.Character.HumanoidRootPart
        local WS    = game.Workspace
        local GSTS  = game:GetService("TeleportService")
        local GSP   = game:GetService("Players")

    -- Player
    local Player        = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Kiriot ESP Lib
        local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
        ESP:Toggle(true)
        -- Toggler
        PlayerSection:NewButton("ESP", "Toggle", function()
            if getgenv().ET == true then
                getgenv().ET = false
                ESP:Toggle(true)
            else
                getgenv().ET = true
                ESP:Toggle(false)
            end
        end)
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            PP2.JumpPower = v
        end)
        -- Reset
        PlayerSection:NewButton("Reset", "Force Reset", function()
            PP2.Health = 0
        end)
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        -- ctrl+click TP
        PlayerSection:NewToggle("ctrl+click TP", "TP", function(state)
            if state then
                getgenv().Enabled = true
                local speed = 10000
                local bodyvelocityenabled = true
                local UIS = game:GetService("UserInputService")
                local Plr = game.Players.LocalPlayer
                local Mouse = Plr:GetMouse()
                function To(position)
                local Chr = Plr.Character
                if Chr ~= nil then
                local ts = game:GetService("TweenService")
                local char = game.Players.LocalPlayer.Character
                local hm = char.HumanoidRootPart
                local dist = (hm.Position - Mouse.Hit.p).magnitude
                local tweenspeed = dist/tonumber(speed)
                local ti = TweenInfo.new(tonumber(tweenspeed), Enum.EasingStyle.Linear)
                local tp = {CFrame = CFrame.new(position)}
                ts:Create(hm, ti, tp):Play()
                if bodyvelocityenabled == true then
                local bv = Instance.new("BodyVelocity")
                bv.Parent = hm
                bv.MaxForce = Vector3.new(100000,100000,100000)
                bv.Velocity = Vector3.new(0,0,0)
                wait(tonumber(tweenspeed))
                bv:Destroy()
                end
                end
                end
                UIS.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Enabled then
                To(Mouse.Hit.p)
                end
                end)
            else
                getgenv().Enabled = false
            end
        end)
        -- alt+click delete
        PlayerSection:NewToggle("Alt Click Delete", "Delete Wall", function(state)
            if state then
                getgenv().ACD = true
                local Plr = game:GetService("Players").LocalPlayer
                local Mouse = Plr:GetMouse()
                Mouse.Button1Down:connect(function()
                if getgenv().ACD == true then
                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
                if not Mouse.Target then return end
                Mouse.Target:Destroy()
                end
                end)
            else
                getgenv().ACD = false
            end
        end)
        -- FLY
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        
    -- Teleport
    local Teleport          = Window:NewTab("Teleport")
    local TeleportSection   = Teleport:NewSection("Teleport")
        -- Tables
        local PlayerTable = {} -- Player Table for TP
        for i,v in pairs(GSP:GetPlayers()) do
            if v~=PP then
                PlayerTable[#PlayerTable+1] = v.Name
            end
        end
        -- Player Dropdown
        local SelectedPlayer;
        local Playerdropdown = TeleportSection:NewDropdown("Player","Info",PlayerTable, function(value)
                SelectedPlayer = value;
                print(value)
            end)
            TeleportSection:NewButton("Refresh", "Refreshes Dropdown", function()
                unpack(PlayerTable)
            end)
            TeleportSection:NewButton("Teleport", "ButtonInfo", function()
                PP3.CFrame = WS:FindFirstChild(SelectedPlayer).HumanoidRootPart.CFrame
            end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Server")
        -- Rejoin
        ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
            GSTS:Teleport(game.PlaceId, GSP.LocalPlayer)
        end)
        -- Rejoin Smallest Server
        ServerSection:NewButton("Rejoin Smallest Server", "Rejoin The Smallest Server", function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
            end
            local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
            until Server
            TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
        end)
        -- Change Server
        ServerSection:NewButton("Change Server", "Change to the Different Server", function()
            local HTTPS = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local SERVERS = HTTPS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            local f = false
            for _,v in pairs(SERVERS.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    f = true
                end
            end
            if not f then print("No different server found!") end
        end)
    
    -- Tools
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
         --Simple Spy 2
        ToolsSection:NewButton("Simple Spy 2", "Remote Spy", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)
         --Turtle Spy
        ToolsSection:NewButton("Turtle Spy", "Remote Spy", function()
            loadstring(game:HttpGet("https://pastebin.com/raw/BDhSQqUU", true))()
         end)
         --Infinite Yield
        ToolsSection:NewButton("Inf Yield", "CMDS", function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
         end)
         --Print Object Names
        ToolsSection:NewButton("Print Object Names", "Tool", function()
            local tool = Instance.new("Tool")
            tool.Name = "Print Clicked Object Name"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = game.Players.LocalPlayer.Backpack
            tool.Equipped:Connect(function(mouse)
            mouse.Button1Down:connect(function()
            if mouse.Target and mouse.Target.Parent then
            print(mouse.Target.Name.." | "..mouse.Target:GetFullName())
            end
            end)
            end)
         end)

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")
end
