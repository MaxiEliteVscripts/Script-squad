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
    Name = "Button Example",
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
 