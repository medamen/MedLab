-- Prison Life https://www.roblox.com/games/155615604/Prison-Life-Cars-fixed
if game.PlaceId == 155615604 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab", "Ocean")


    -- Main

    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")
        --Give Guns
        MainSection:NewDropdown("Guns", "Give Guns", {"M9", "Remington 870", "AK-47"}, function(SelectedGuns)
            if SelectedGuns == "M9" then
                local args = {
                    [1] = workspace.Prison_ITEMS.giver:FindFirstChild("M9").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))
            elseif SelectedGuns == "Remington 870" then
                local args = {
                    [1] = workspace.Prison_ITEMS.giver:FindFirstChild("Remington 870").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))
            elseif SelectedGuns == "AK-47" then
                local args = {
                    [1] = workspace.Prison_ITEMS.giver:FindFirstChild("AK-47").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))
            end
        end)
        -- Give Melee
        MainSection:NewDropdown("Melee", "Give Melee", {"Crude Knife", "Hammer"}, function(SelectedMelee)
            if SelectedMelee == "Crude Knife" then
                local args = {
                    [1] = workspace.Prison_ITEMS.single:FindFirstChild("Crude Knife").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))
            elseif SelectedMelee == "Hammer" then
                local args = {
                    [1] = workspace.Prison_ITEMS.single:FindFirstChild("Hammer").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))
            end
        end)
        -- Give Items
        MainSection:NewDropdown("Items", "Give Items", {"Key card"}, function(SelectedItems)
            if SelectedItems == "key card" then
                local args = {
                    [1] = workspace.Prison_ITEMS.single:FindFirstChild("Key card").ITEMPICKUP
                }
                
                workspace.Remote.ItemHandler:InvokeServer(unpack(args))                              
            end
        end)


    -- Player

    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end)
            -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end)
        -- ctrl+click TP
        PlayerSection:NewToggle("TP", "TP", function(state)
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
        PlayerSection:NewButton("Alt+Click Delete", "ButtonInfo", function()
            local Plr = game:GetService("Players").LocalPlayer
            local Mouse = Plr:GetMouse()

            Mouse.Button1Down:connect(function()
            if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
            if not Mouse.Target then return end
            Mouse.Target:Destroy()
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

-- Ninja Legends https://www.roblox.com/games/3956818381/Ninja-Legends
elseif game.PlaceId == 3956818381 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab", "Ocean")
    
    -- Main
    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main")

    --Player
    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")

    --Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")

    --Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")
else
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MedLab", "Ocean")

    -- Player

    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")
        -- Walk SPeed
        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v) -- 500 (MaxValue) | 0 (MinValue)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end)
        -- Jump Power
        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v) -- 500 (MaxValue) | 0 (MinValue)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end)

        --TP
        local PlayerSection = Player:NewSection("TP")
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
        -- MISC
        local PlayerSection = Player:NewSection("Misc")
        
        -- alt+click delete
        PlayerSection:NewButton("Alt+Click Delete", "Delete Wall On Click", function()
            local Plr = game:GetService("Players").LocalPlayer
            local Mouse = Plr:GetMouse()

            Mouse.Button1Down:connect(function()
            if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then return end
            if not Mouse.Target then return end
            Mouse.Target:Destroy()
            end)
        end)
        PlayerSection:NewButton("FLY", "Toggle M", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/Ngabret.lua", true))()
        end)
        -- ESP
        PlayerSection:NewToggle("ESP", "Toggle", function(state)
            if state then
                getgenv().Toggle = true
                local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
                ESP:Toggle(true)
            else
                getgenv().Toggle = false
                local ESP = nil
                ESP:Toggle(false)
            end
        end)

    -- Server
    local Server = Window:NewTab("Server")
    local ServerSection = Server:NewSection("Section Name")

    -- Rejoin
    ServerSection:NewButton("Rejoin", "Rejoin The Same Server", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
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
    

    -- Setting
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
        -- Toggle UI
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
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
         

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")
end
