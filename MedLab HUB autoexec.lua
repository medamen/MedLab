local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MedLab", "Ocean")


    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Player")

        PlayerSection:NewSlider("Walk Speed", "Change the walkspeed", 250, 16, function(v)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end)

        PlayerSection:NewSlider("Jump Power", "Change the jump power", 250, 50, function(v)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end)


        local PlayerSection = Player:NewSection("TP")

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
        
        local PlayerSection = Player:NewSection("Misc")
        
        
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
    
    
    local Setting = Window:NewTab("Setting")
    local SettingSection = Setting:NewSection("Setting")
     
        SettingSection:NewKeybind("Toggle UI", "KeybindInfo", Enum.KeyCode.RightControl, function()
            Library:ToggleUI()
        end)
        
    
    local Tools = Window:NewTab("Tools")
    local ToolsSection = Tools:NewSection("Tools")
    
        ToolsSection:NewButton("Simple Spy 2", "SPY", function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/medamen/MedLab/main/JamesBond2.lua", true))()
         end)

   
    local Credits = Window:NewTab("Credits")
    local CreditsSection = Credits:NewSection("Credits")
end