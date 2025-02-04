local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎮MaxiElite MM2 Script🔫",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Script Squad Hub",
   LoadingSubtitle = "by MaxiElite",
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

   KeySystem = true, -- Set this to true to use our key system
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

local MainTab = Window:CreateTab("Visuals", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")



local Button = MainTab:CreateButton({
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
 
 local function toggleESP()
     if espEnabled then
         removeAllESP()
         espEnabled = false
         print("ESP Disabled")
     else
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
     end
 end
 
 -- Create the ESP Toggle Button
 local Button = MainTab:CreateButton({
     Name = "Toggle ESP",
     Callback = function()
         toggleESP()
     end
 }) -- Properly closed function
 
