
local gameID = game.GameId
local NameGame = nil

if gameID == 286090429 then
    NameGame = "🎮Arensal ScriptHub🔫"
else
    NameGame = "🎮Unknow ScriptHub🔫"
end

if GameId == 14202073004 then
    NameGame = "🎮Unnamed-Shooter ScriptHub🔫"
end

if gameID == 155615604 then 
    NameGame = "🎮Unnamed-Shooter ScriptHub🔫"
end


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = NameGame,
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Script Squad Hub",
   LoadingSubtitle = "by IDK",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "MaxiElitesrp"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "https://discord.gg/3uVw4fuR", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "MaxiElite",
      Subtitle = "Key System",
      Note = "join our discord for key links", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/Y7YbDKJ2"}
   }
})

Rayfield:Notify({
    Title = "Script Squad",
    Content = "Thanks for using us!",
    Duration = 6.5,
    Image = "rewind",
 })

local VisualsTab = Window:CreateTab("Visuals", nil) -- Title, Image
local VisualsSection = VisualsTab:CreateSection("Main")

local CombatTab = Window:CreateTab("Combat", nil) -- Title, Image
local CombatSection = CombatTab:CreateSection("Combat")

local MovementTab = Window:CreateTab("Movement", nil) -- Title, Image
local MovementSection = MovementTab:CreateSection("Movement")




local Button = MovementTab:CreateButton({
    Name = "Inf Jump",
    Callback = function()
       -- The function that runs when the button is pressed
       _G.infinjump = not _G.infinjump

       if _G.infinJumpStarted == nil then
           --Ensures this only runs once to save resources
           _G.infinJumpStarted = true
           
           --Notifies readiness
           game.StarterGui:SetCore("SendNotification", {Title="WeAreDevs.net"; Text="The WeAreDevs Infinite Jump exploit is ready!"; Duration=5;})
       
           --The actual infinite jump
           local plr = game:GetService('Players').LocalPlayer
           local m = plr:GetMouse()
           m.KeyDown:connect(function(k)
               if _G.infinjump then
                   if k:byte() == 32 then
                   humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                   humanoid:ChangeState('Jumping')
                   wait()
                   humanoid:ChangeState('Seated')
                   end
               end
           end)
       end
    end -- This properly closes the function
 }) -- This properly closes the CreateButton function
 
 
 local espEnabled = false
 local espParts = {} -- Stores ESP parts for cleanup
 
 local function createESP(target)
     if not target:FindFirstChild("ESPBox") then
         local box = Instance.new("BoxHandleAdornment")
         box.Name = "ESPBox"
         box.Adornee = target
         box.Size = Vector3.new(4, 6, 4) -- Adjusted to fit humanoids
         box.Color3 = Color3.fromRGB(0, 255, 0)
         box.AlwaysOnTop = true
         box.ZIndex = 10
         box.Transparency = 0.5
         box.Parent = target -- Properly attached
 
         espParts[target] = box -- Store for removal
     end
 end
 
 local function removeAllESP()
     for _, esp in pairs(espParts) do
         if esp then
             esp:Destroy()
         end
     end
     espParts = {} -- Clear stored ESP parts
 end
 
 local function toggleESP(Value)
     if Value then
         -- Enable ESP
         for _, player in pairs(game.Players:GetPlayers()) do
             if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                 createESP(player.Character.HumanoidRootPart)
             end
         end
 
         game.Players.PlayerAdded:Connect(function(player)
             player.CharacterAdded:Connect(function(character)
                 local root = character:WaitForChild("HumanoidRootPart")
                 if espEnabled then
                     createESP(root)
                 end
             end)
         end)
 
         espEnabled = true
         print("ESP Enabled")
     else
         -- Disable ESP
         removeAllESP()
         espEnabled = false
         print("ESP Disabled")
     end
 end
 
 -- Create the ESP Toggle using the Toggle button style
 local Toggle = VisualsTab:CreateToggle({
     Name = "Toggle ESP",
     CurrentValue = false, -- Default to disabled
     Flag = "ESP_Toggle", -- Unique flag identifier for the configuration
     Callback = function(Value)
         toggleESP(Value) -- Pass the toggle value to the function
     end
 })
 
 local aimBotEnabled = false

 local Toggle = CombatTab:CreateToggle({
     Name = "Aim Bot",
     CurrentValue = false,
     Flag = "ToggleAimBot", -- Unique flag for this toggle
     Callback = function(Value)
         aimBotEnabled = Value
         
         local function aimAt(target)
             if target and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                 local cam = game.Workspace.CurrentCamera
                 local targetPos = target.Position
                 cam.CFrame = CFrame.new(cam.CFrame.Position, targetPos)
             end
         end
 
         local function findTarget()
             local nearestPlayer = nil
             local shortestDistance = math.huge
 
             for _, player in pairs(game.Players:GetPlayers()) do
                 if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                     local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                     if distance < shortestDistance then
                         shortestDistance = distance
                         nearestPlayer = player
                     end
                 end
             end
             return nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") or nil
         end
 
         local function aimBotLoop()
             while aimBotEnabled do
                 local target = findTarget()
                 if target then aimAt(target) end
                 wait(0.1) -- Adjust aim speed
             end
         end
 
         if aimBotEnabled then
             spawn(aimBotLoop)
         end
     end,
 })
 
 -- Keybind to toggle Aim Bot
 local Keybind = CombatTab:CreateKeybind({
     Name = "Aim Bot Keybind",
     CurrentKeybind = "P", -- Default keybind (you can change it)
     HoldToInteract = false,
     Flag = "AimBotKeybind", -- Unique flag
     Callback = function()
         aimBotEnabled = not aimBotEnabled
         Toggle.Callback(aimBotEnabled) -- Manually trigger the toggle's callback
     end,
 })
 
 local Slider = MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

local Slider = MovementTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200}, -- Adjust the range as needed
    Increment = 10,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "SliderJumpPower", -- Unique flag for this slider
    Callback = function(Value)
        -- The function that takes place when the slider changes
        -- The variable (Value) is a number which correlates to the value the slider is currently at
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

local RunService = game:GetService("RunService") -- Used to update No Clip continuously
local NoClipEnabled = false

local Toggle = MovementTab:CreateToggle({
    Name = "No Clip",
    Flag = "ToggleNoClip",
    CurrentValue = false,
    Callback = function(State)
        NoClipEnabled = State
    end,
})

RunService.Stepped:Connect(function()
    if NoClipEnabled then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local mainRemotes = game.ReplicatedStorage
local meleeRemote = mainRemotes["meleeEvent"]
local mouse = game.Players.LocalPlayer:GetMouse()
local punchingEnabled = false -- Toggle state
local cooldown = false

-- Create Toggle for Rayfield UI
local Toggle = CombatTab:CreateToggle({
    Name = "OnePunch",
    Flag = "ToggleMelee",
    CurrentValue = false,
    Callback = function(state)
        punchingEnabled = state
    end,
})

-- Function to execute punch
local function punch()
    if not punchingEnabled or cooldown then return end
    cooldown = true

    local character = game.Players.LocalPlayer.Character
    local part = Instance.new("Part", character)
    part.Transparency = 1
    part.Size = Vector3.new(5, 2, 3)
    part.CanCollide = false

    local weld = Instance.new("Weld", part)
    weld.Part0 = character.Torso
    weld.Part1 = part
    weld.C1 = CFrame.new(0, 0, 2)

    part.Touched:Connect(function(hit)
        local plr = game.Players:FindFirstChild(hit.Parent.Name)
        if plr and plr.Name ~= game.Players.LocalPlayer.Name then
            part:Destroy()
            for i = 1, 100 do
                meleeRemote:FireServer(plr)
            end
        end
    end)

    wait(1) -- Cooldown time
    cooldown = false
    part:Destroy()
end

-- Detect key press (F) to punch
mouse.KeyDown:Connect(function(key)
    if key:lower() == "f" then
        punch()
    end
end)




-- Your toggle creation code
-- Your toggle creation code

-- Jump Power slider creation code
