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
        PlayerSection:NewButton("FLY", "Toggle M", function()
            local User = game:GetService("UserInputService")
            local player = game:GetService("Players").LocalPlayer
            local GuiService = game:GetService("StarterGui")
            local mouse = game.Players.LocalPlayer:GetMouse()

            local holdingWKey = false
            local holdingSKey = false
            local holdingAKey = false
            local holdingDKey = false
            local holdingSpaceKey = false
            local holdingControlKey = false

            Speed_1 = -1

            mouse.KeyDown:connect(function(key)
            if key == "-" then
                Speed_1 = Speed_1 + 0.2
                GuiService:SetCore("SendNotification", {Title = "Speed", Text = "Speed has gone down";})
            end
            end)

            mouse.KeyDown:connect(function(key)
            if key == "=" then
                Speed_1 = Speed_1 - 0.2
                GuiService:SetCore("SendNotification", {Title = "Speed", Text = "Speed has gone up";})
            end
            end)

            mouse.KeyDown:connect(function(key)
            if key == "m" then
                if startup  == true then
                    startup = false
                    GuiService:SetCore("SendNotification", {Title = "FLY", Text = "FLY is now disabled";})
                else
                    startup = true
                    GuiService:SetCore("SendNotification", {Title = "FLY", Text = "FLY is now enabled";})
                    
                    local brick = Instance.new("Part", workspace)
                    brick.Size = Vector3.new(3, 2, 3)
                    brick.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
                    brick.Transparency = 1
                    brick.Anchored = true
                    brick.Name = "Brick"
                    mouse.KeyDown:connect(function(key)
                        if key == "m" then
                            brick:remove()
                        end
                    end)
                    for i = 1, math.huge do
                        brick.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
                        wait(0)
                    end
                end
            end
            end)

            game:GetService('RunService').Stepped:connect(function()
            if startup then
                if WHeld == true then
                    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,Speed_1)

                end
            end
            end)

            game:GetService('RunService').Stepped:connect(function()
            if startup then
            if SHeld == true then
                    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-Speed_1)
            end
            end
            end)

            game:GetService('RunService').Stepped:connect(function()
            if startup then
            if AHeld == true then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(Speed_1,0,0)
            end
            end
            end)


            game:GetService('RunService').Stepped:connect(function()
            if startup then
            if DHeld == true then
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(-Speed_1,0,0)
            end
            end
            end)


            game:GetService('RunService').Stepped:connect(function()
            if startup then
            if SpaceHeld == true then
                player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-Speed_1,0)
            end
            end
            end)

            game:GetService('RunService').Stepped:connect(function()
            if startup then
                if ControlHeld == true then
                player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,Speed_1,0)
                end
            end

            end)

            User.InputBegan:Connect(function(inputObject)
            if(inputObject.KeyCode==Enum.KeyCode.W) then
                holdingWKey = true WHeld = true
            end
            
            if(inputObject.KeyCode==Enum.KeyCode.S) then
                holdingSKey = true SHeld = true
            end

            if(inputObject.KeyCode==Enum.KeyCode.A) then
                holdingAKey = true AHeld = true
            end

            if(inputObject.KeyCode==Enum.KeyCode.D) then
                holdingDKey = true DHeld = true
            end
            if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
                holdingControlKey = true ControlHeld = true
            end

            if(inputObject.KeyCode==Enum.KeyCode.Space) then
                holdingSpaceKey = true SpaceHeld= true
            end

            if(inputObject.KeyCode==Enum.KeyCode.W) then
                holdingUKey = true WHeld = true
            end
            end)

            User.InputEnded:Connect(function(inputObject)
            if(inputObject.KeyCode==Enum.KeyCode.W) then
                holdingWKey = false WHeld = false
            end

            if(inputObject.KeyCode==Enum.KeyCode.S) then
                holdingSKey = false SHeld = false    
            end

            if(inputObject.KeyCode==Enum.KeyCode.A) then
                holdingAKey = false AHeld = false    
            end

            if(inputObject.KeyCode==Enum.KeyCode.D) then
                holdingDKey = false DHeld = false    
            end

            if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
                holdingShiftKey = false ControlHeld = false    
            end

            if(inputObject.KeyCode==Enum.KeyCode.Space) then
                holdingSpaceKey = false SpaceHeld = false
            end
            end)
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
        ToolsSection:NewButton("Simple SPy 2", "SPY", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/SimpleSpy2.lua", true))()
         end)

    -- Credits
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")
end