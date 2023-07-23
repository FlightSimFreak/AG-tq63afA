local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local current_tween
local noclip_tween

local camera = workspace.CurrentCamera

local function onCharacterAdded(character)
    -- This function will be called whenever the player's character is added or changed
    Character = character
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

local function onCharacterRemoved()
    -- This function will be called whenever the player's character is removed (e.g., on death)
    Character = nil
end

task.spawn(function()
    while task.wait() do
        if noclip_tween then
            Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end
end)

LocalPlayer.CharacterRemoving:Connect(onCharacterRemoved)
-- Main Menu
if game.PlaceId == 5956785391 then
    local Window = Rayfield:CreateWindow({
        Name = "Faceless Premium Hub | Main Menu",
        LoadingTitle = "Premium Hub",
        LoadingSubtitle = "by Faceless",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "Big Hub"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "Faceless Premium Hub",
            Subtitle = "Key System",
            Note = "No method of obtaining the key is provided",
            FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
            SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
            GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = {"https://raw.githubusercontent.com/FlightSimFreak/AG-tq63afA/main/Script"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
        }
        })

        --[Home/Main Section]
        local Home = Window:CreateTab("🏠 Home") -- Title, Image
        local Main = Home:CreateSection("Main")

        local isDailySpinActive = false -- Flag to track if the auto daily spin is active
        local dailySpinLoop = nil
        
        local function autoDailySpin()
            while isDailySpinActive do
                ReplicatedStorage:WaitForChild("spins_thing_remote"):InvokeServer()
                task.wait(.1)
            end
        end
        
        local function stopDailySpinLoop()
            if dailySpinLoop then
                isDailySpinActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                dailySpinLoop = nil
            end
        end
        
        local function startDailySpinLoop()
            if not dailySpinLoop then
                isDailySpinActive = true -- Set the flag to true to start the loop
                dailySpinLoop = task.spawn(autoDailySpin) -- Start the auto daily spin loop
            end 
        end
        
        local startDailySpin = Home:CreateToggle({
            Name = "Auto Daily Spin",
            CurrentValue = false,
            Flag = "StartAutoDailySpin",
            Callback = function(Value)
                if Value then
                    startDailySpinLoop() -- Start the auto daily spin loop
                else
                    stopDailySpinLoop() -- Stop the auto daily spin loop
                end
            end,
        })

        local SupremeClanspinSection = Home:CreateSection("Supreme Clan Spin")

        local spinForUzui = Home:CreateButton({
            Name = "Auto Spin For Uzui",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Uzui" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)

                end
            end,
        }) 
        local spinForKamado = Home:CreateButton({
            Name = "Auto Spin For Kamado",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Kamado" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)

                end
            end,
        }) 
        local spinForAgatsuma = Home:CreateButton({
            Name = "Auto Spin For Agatsuma",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Agatsuma" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)

                end
            end,
        }) 
        local spinForRengoku = Home:CreateButton({
            Name = "Auto Spin For Rengoku",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Rengoku" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)
                    
                end
            end,
        })

        local MythicalClanSpin = Home:CreateSection("Mythical Clan Spin")

        local spinForTokito = Home:CreateButton({
            Name = "Auto Spin For Tokito",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Tokito" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)
                    
                end
            end,
        })
        local spinForHashibira = Home:CreateButton({
            Name = "Auto Spin For Hashibira",
            Callback = function()
                while ReplicatedStorage.Player_Data[LocalPlayer.Name].Clan.Value ~= "Hashibira" do
                    local args = {
                        [1] = "check_can_spin"
                    }
    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                    task.wait(.1)
                    
                end
            end,
        })
        
          -- [GUI SETTINGS]
          local Settings = Window:CreateTab("Settings")
          local SettingsSection = Settings:CreateSection("Settings")
          
          local DestroyGuiButton = Settings:CreateButton({
              Name = "Destroy GUI",
              Callback = function()
                  -- The function that takes place when the button is pressed
                  Rayfield:Destroy()
              end,
          })
        
        end
        -- [Map 2]
                if tostring(game.PlaceId):sub(1, 4) == "1388" then

                    local skill_module = require(game:GetService("ReplicatedStorage").Modules.Server["Skills_Modules_Handler"])

                    hookfunction(skill_module.Kick, function()
                        return nil
                    end);
                    
                    local anti_cheat1 = LocalPlayer.PlayerScripts["Small_Scripts"]["Client_Global_utility"]
                    local anti_cheat2 = LocalPlayer.PlayerScripts["Small_Scripts"]["client_global_delete_script"]
                    
                    hookfunction(anti_cheat1.GetPropertyChangedSignal, function()
                        return
                    end)
                    
                    hookfunction(anti_cheat2.GetPropertyChangedSignal, function()
                        return
                    end)
                    
                    anti_cheat1.Disabled = true
                    anti_cheat2.Disabled = true
                    
                    local Namecall
                    Namecall = hookmetamethod(game, '__namecall', function(self, ...)
                        local Args = {...}
                        local method = getnamecallmethod()
                        
                        if method == 'FireServer' and string.find(self.Name, 'mod') then 
                            return 
                        end
                        
                        if method == 'InvokeServer' and self.Name == 'reporthackerasdasd' then 
                            return 
                        end
                        
                        if method == 'FireServer' and self.Name == 'To_Server_commends' then 
                            return
                        end
                        
                        if method:lower() == 'kick' then 
                            return 
                        end
                        
                        return Namecall(self, ...)
                    end)

                    _G.Options ={
                        TweenSpeed = 120,
                        infstam = false,
                        infbreath = false,
                    }
                    
                    local hook
                    hook = hookmetamethod(game, "__namecall", function(self, ...)
                       args = {...}
                    
                       if getnamecallmethod() == "FireServer" and #args == 2 and type(args[1]) == "boolean" then
                           return task.wait(9e9)
                       end
                    
                       return hook(self, ...)
                    end)

                    local Window = Rayfield:CreateWindow({
                        Name = "Faceless Premium Hub | Project Slayers",
                        LoadingTitle = "Premium Hub",
                        LoadingSubtitle = "by Faceless",
                        ConfigurationSaving = {
                            Enabled = false,
                            FolderName = nil, -- Create a custom folder for your hub/game
                            FileName = "Big Hub"
                        },
                        Discord = {
                            Enabled = false,
                            Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
                            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
                        },
                        KeySystem = true, -- Set this to true to use our key system
                        KeySettings = {
                            Title = "Faceless Premium Hub",
                            Subtitle = "Key System",
                            Note = "No method of obtaining the key is provided",
                            FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
                            SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
                            GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
                            Key = {"https://raw.githubusercontent.com/FlightSimFreak/AG-tq63afA/main/Script"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
                        }
                        })
            
                     --[Home/Main Section]
        local Home = Window:CreateTab("🏠 Home") -- Title, Image
        local Main = Home:CreateSection("Main")
        
        local AuraMethod = {
            ["Combat"] = function()
                -- Code for KillAura with Combat method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Combat" then
                                repeat
                                    local args = {
                                        [1] = "fist_combat",
                                        [2] = LocalPlayer,
                                        [3] = workspace:WaitForChild(LocalPlayer.Name),
                                        [4] = Character.HumanoidRootPart,
                                        [5] = Character.Humanoid,
                                        [6] = 919,
                                        [7] = "ground_slash"
                                    }
                                    
                                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                                    
                                    task.wait(1.5)
                                    
                                until not getgenv().KillAura or not getgenv().Method == "Combat"
                            end
                        end
                    end)
                end)
            end,
            ["Sword"] = function()
                -- Code for KillAura with Sword method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Sword" then
                                repeat task.wait(3)
                                   
                            until not getgenv().KillAura or not getgenv().Method == "Sword"
                        end
                    end
                end)
                end)
        
            end,
            ["Fans"] = function()
                -- Code for KillAura with Fans method goes here
            end,
            ["Scythe"] = function()
                -- Code for KillAura with Scythe method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Scythe" then
                                repeat
        
                                local args = {
                                [1] = "Scythe_Combat_Slash",
                                [2] = LocalPlayer,
                                [3] = workspace:WaitForChild(LocalPlayer.Name),
                                [4] = Character.HumanoidRootPart,
                                [5] = Character.Humanoid,
                                [6] = 919,
                                [7] = "ground_slash"
                            }
                            
                           ReplicatedStorage:WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
        
                                    task.wait(1.5)
                                    
                                until not getgenv().KillAura or not getgenv().Method == "Scythe"
                            end
                        end
                    end)
                end)
            end,
        }
        
        local methodNames = {} -- Create an empty table to store the method names
        
        for auraMethod, _ in pairs(AuraMethod) do
            table.insert(methodNames, auraMethod) -- Add each method name to the methodNames table
        end
        
        local selectedMethod = "Combat" -- Default method is "Combat"
        
        local KillAuraMethod = Home:CreateDropdown({
            Name = "Kill Aura Method",
            Options = methodNames,
            CurrentOption = {selectedMethod}, -- Set the initial value to the default method
            MultipleOptions = false,
            Flag = "KillAuraMethod",
            Callback = function(Option)
                -- The function that takes place when the selected option is changed
                -- The variable (Option) is a table of strings for the current selected options
                selectedMethod = Option[1] -- Update the selectedMethod with the new option
                getgenv().Method = selectedMethod -- Update getgenv().Method with the new option
            end,
        })
        
        -- Function to toggle KillAura
        local function toggleKillAura()
            if getgenv().KillAura and type(AuraMethod[getgenv().Method]) == "function" then
                task.spawn(AuraMethod[getgenv().Method]) -- Start the corresponding KillAura method
            end
        end
        
        local selectBosses = {
            "Akeza",
            "Douma",
            "Tengen",
            "Rengoku",
            "Renpeke",
            "Enme",
            "Inosuke",
            "Muichiro Tokito",
            "Swampy",
            "Slasher",
            "Sound Trainee",
            "Snow Trainee"
        }
        
        local selectedBoss = "None"
        
        local selectBossDropdown = Home:CreateDropdown({
            Name = "Select Boss",
            Options = selectBosses,
            CurrentOption = {selectedBoss}, -- Set the initial value to the default method
            MultipleOptions = false,
            Flag = "selectBoss",
            Callback = function(Option)
                -- The function that takes place when the selected option is changed
                -- The variable (Option) is a table of strings for the current selected options
                selectedBoss = Option[1] -- Update the selectedBoss with the new option
            end,
        })
        
        local startFarmButton = Home:CreateToggle({
            Name = "Kill Aura",
            CurrentValue = false,
            Flag = "StartFarmButton", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                -- The function that takes place when the toggle is pressed
                -- The variable (Value) is a boolean on whether the toggle is true or false
        
                if Value then
                    -- Start the farm
                    if selectedMethod ~= getgenv().Method then  
                        getgenv().Method = selectedMethod -- Update getgenv().Method with the new option if it's different
                        print("Using " .. selectedMethod .. " kill aura")
                    end
        
                    print("Farm started")
                    print("Using " .. selectedMethod .. " kill aura")
                    getgenv().KillAura = true
                    toggleKillAura()
                else
                    -- Stop the farm
                    print("Farm stopped")
                    getgenv().KillAura = false
                end
            end,
        })
        
        -- [GKA]
        local gkaTab = Window:CreateTab("GKA")
        local gkaSection = gkaTab:CreateSection("Main Global Kill Aura")
        
        local isArrowGKAActive = false -- Flag to track if Arrow Global Kill Aura is active
        local arrowGKALoop = nil
        
        local function activateArrowGKA()
            while isArrowGKAActive do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = LocalPlayer,
                    [3] = "arrow_knock_back",
                    [4] = 5
                }
                
               ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))

                task.wait(1)
            end
        end
        
        local function stopArrowGKALoop()
            if arrowGKALoop then
                isArrowGKAActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                arrowGKALoop = nil
            end
        end
        
        local function startArrowGKALoop()
            if not arrowGKALoop then
                isArrowGKAActive = true -- Set the flag to true to start the loop
                arrowGKALoop = task.spawn(activateArrowGKA) -- Start the Arrow Global Kill Aura loop
            end
        end
        
        local arrowGKA = gkaTab:CreateToggle({
            Name = "Arrow Global Kill Aura [Requires Arrow BDA]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startArrowGKALoop() -- Start the Arrow Global Kill Aura loop
                else
                    stopArrowGKALoop() -- Stop the Arrow Global Kill Aura loop
                end
            end
        })
        
        
        -- [Miscellaneous]
        local miscellaneousTab = Window:CreateTab("Miscellaneous")
        local LocalPlayerMainSection = miscellaneousTab:CreateSection("Main Settings")
        
        local Label = miscellaneousTab:CreateLabel("Clan Must Start With A Capital Letter")
        local Input = miscellaneousTab:CreateInput({
        Name = "Change Clan",
        PlaceholderText = "Type Clan Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
        -- The function that takes place when the input is changed
        -- The variable (Text) is a string for the value in the text box
            local data = ReplicatedStorage.Player_Data[LocalPlayer.Name]
            data.Clan.Value = (Text)
        end,
        })
        local KillPlayerButton = miscellaneousTab:CreateButton({
            Name = "Kill Character",
            Callback = function()
                -- The function that takes place when the button is pressed
                    Character.Humanoid.Health = 0
            end,
        })
        
        local LocalPlayerBuffs = miscellaneousTab:CreateSection("Character Buffs & God Modes")
        
        local isBuffActive = false -- Flag to track if the buff is currently active
        local warDrumsBuffLoop = nil
        
        local function activateWarDrumsBuff()
            while isBuffActive do
                local args = {
                    [1] = true
                }
                ReplicatedStorage.Remotes.war_Drums_remote:FireServer(unpack(args))
                task.wait(20) -- Delay for 20 seconds before the next call
            end
        end
        
        local function stopWarDrumsBuffLoop()
            if warDrumsBuffLoop then
                isBuffActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.war_Drums_remote:FireServer(unpack(args))
                warDrumsBuffLoop = nil
            end
        end
        
        local function startWarDrumsBuffLoop()
            if not warDrumsBuffLoop then
                isBuffActive = true -- Set the flag to true to start the loop
                warDrumsBuffLoop = task.spawn(activateWarDrumsBuff) -- Start the buff activation loop
            end 
        end
        
        local warDrumsBuffToggle = miscellaneousTab:CreateToggle({
            Name = "Speed & Damage Buff [All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startWarDrumsBuffLoop() -- Start the buff loop
                else
                    stopWarDrumsBuffLoop() -- Stop the buff loop
                end
            end
        })
        
        local isFuriosityEnabled = false -- Flag to track if the buff is currently active
        local furiosityBuffLoop = nil
        
        local function activateFuriosityBuff()
            while isFuriosityEnabled do
                local args = {
                    [1] = true
                }
                ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
                task.wait(22) -- Delay for 18 seconds before the next call
            end
        end
        
        local function stopFuriosityBuffLoop()
            if furiosityBuffLoop then
                isFuriosityEnabled = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
                furiosityBuffLoop = nil
            end
        end
        
        local function startFuriosityBuffLoop()
            if not furiosityBuffLoop then
                isFuriosityEnabled = true -- Set the flag to true to start the loop
                furiosityBuffLoop = task.spawn(activateFuriosityBuff) -- Start the buff activation loop
            end 
        end
        
        local furiosityToggle = miscellaneousTab:CreateToggle({
            Name = "Furiosity [More Damage / All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startFuriosityBuffLoop() -- Start the buff loop
                else
                    stopFuriosityBuffLoop() -- Stop the buff loop
                end
            end
        })

        local spacialAwareness = miscellaneousTab:CreateToggle({
            Name = "Spacial Awareness",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    local args = {
                        [1] = true
                    }
                    
                   ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("spacial_awareness_remote"):FireServer(unpack(args))
                    
                else
                    local args = {
                        [1] = false
                    }
                    
                 ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("spacial_awareness_remote"):FireServer(unpack(args))
                    
                end
            end
        })

        local semiGodModeToggle = miscellaneousTab:CreateToggle({
            Name = "Semi God Mode [All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    local args = {
                        [1] = true
                    }
                    
                   ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("regeneration_breathing_remote"):FireServer(unpack(args))
                    
                else
                    local args = {
                        [1] = false
                    }
                    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("regeneration_breathing_remote"):FireServer(unpack(args))
                    
                end
            end
        })

        local miscellaneousTabBDASPINS = miscellaneousTab:CreateSection("Information")

        local getBreathingInfo = miscellaneousTab:CreateButton({
            Name = "Breathing Progress",
            Callback = function ()
                local breathingProgress = ReplicatedStorage.Player_Data[LocalPlayer.Name].BreathingProgress["1"].Value
                local neededBreathingProgress = ReplicatedStorage.Player_Data[LocalPlayer.Name].BreathingProgress["2"].Value
                game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Breathing Progress: " .. breathingProgress .. "/" .. neededBreathingProgress; Duration = 10; })
            end
        })

        local getDemonInfo = miscellaneousTab:CreateButton({
            Name = "Demon Progress",
            Callback = function ()
                local demonProgress = ReplicatedStorage.Player_Data[LocalPlayer.Name].DemonProgress["1"].Value
                local neededDemonProgress = ReplicatedStorage.Player_Data[LocalPlayer.Name].DemonProgress["2"].Value
                game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Demon Progress: " .. demonProgress .. "/" .. neededDemonProgress; Duration = 10; })
            end
        })
        
        -- [Scythe GodMode]
        local isUniversalGodModeActive = false -- Flag to track if Universal God Mode is active
        local universalGodModeLoop = nil
        
        local function activateUniversalGodMode()
            while isUniversalGodModeActive do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = LocalPlayer,
                    [3] = "scythe_asteroid_reap",
                    [4] = 1
                }
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                task.wait(.5)
            end
        end
        
        local function stopUniversalGodModeLoop()
            if universalGodModeLoop then
                isUniversalGodModeActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                universalGodModeLoop = nil
            end
        end
        
        local function startUniversalGodModeLoop()
            if not universalGodModeLoop then
                isUniversalGodModeActive = true -- Set the flag to true to start the loop
                universalGodModeLoop = task.spawn(activateUniversalGodMode) -- Start the Universal God Mode loop
            end
        end
        
        local universalGodMode = miscellaneousTab:CreateToggle({
            Name = "Universal God Mode [Requires Scythe Equipped/ 28+ Mas.]",
            CurrentValue = false,
            Callback = function(Value)
                if Value then
                    startUniversalGodModeLoop() -- Start the Universal God Mode loop
                else
                    stopUniversalGodModeLoop() -- Stop the Universal God Mode loop
                end
            end
        })
        
        local infBreathingToggle = miscellaneousTab:CreateToggle({
            Name = "INF Breathing",
            CurrentValue = false,
            Callback = function (Value)
                _G.Options.infbreath = (Value)
            end
        })
        
        spawn(function()
            while task.wait() do
                if _G.Options.infbreath then
                    getrenv()._G:Breath(-100)
                else
                    _G.Options.infbreath = false
                end
            end
        end)
        
        local infStamToggle = miscellaneousTab:CreateToggle({
            Name = "INF Stamina",
            CurrentValue = false,
            Callback = function (Value)
                _G.Options.infstam = (Value)
            end
        })
        
        spawn(function()
            while task.wait() do
                if _G.Options.infstam then
                    getrenv()._G:Stamina(-100)
                else
                    _G.Options.infstam = false
                end
            end
        end)

   -- [ESP]
   local ESP = Window:CreateTab("ESP")
   local ESPSection = ESP:CreateSection("ESP Settings")
   
   -- Tables to store ESP labels and drawing objects
   local ESPLabels = {}
   local DrawingPool = {}
   
   -- Helper function to create or reuse a drawing object
   local function getDrawingObject()
       local drawingObject = next(DrawingPool) or Drawing.new("Text")
       DrawingPool[drawingObject] = nil
       drawingObject.Visible = false
       drawingObject.Center = true
       drawingObject.Outline = true
       drawingObject.Font = 2
       drawingObject.Color = Color3.fromRGB(255, 255, 255)
       drawingObject.Size = 13
       return drawingObject
   end
   
   -- Helper function to return a drawing object to the pool for reuse
   local function returnDrawingObject(drawingObject)
       drawingObject.Visible = false
       DrawingPool[drawingObject] = true
   end
   
   -- Helper function to update the ESP labels for a player
   local function updatePlayerESP(player, labelData)
       local playerESP, playerInfo = labelData.ESP, labelData.Info
       if player == LocalPlayer then
           -- Hide ESP labels for the local player
           playerESP.Visible, playerInfo.Visible = false, false
       else
           local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
           if humanoidRootPart then
               -- Convert 3D position to 2D screen position
               local position, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position)
               local powerValue = ReplicatedStorage.Player_Data[player.Name].Power.Value
               local artValue = ReplicatedStorage.Player_Data[player.Name].Demon_Art.Value
               local healthValue = workspace[player.Name].Humanoid.Health

                local playerRace = ReplicatedStorage.Player_Data[player.Name].Race.Value
               -- Calculate distance between LocalPlayer and the target player
               local distance = (Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
   
               -- Update the ESP label with player information and distance
               playerESP.Position, playerESP.Visible, playerESP.Text = Vector2.new(position.X, position.Y), onScreen, "Username: " .. player.Name
               playerInfo.Visible, playerInfo.Text = onScreen, "Health: " .. math.floor(healthValue)
               playerInfo.Position = Vector2.new(position.X, position.Y + 15)  -- Adjust the position for distance
               playerInfo.Text = playerInfo.Text .. string.format("\nDistance: %.2f studs", distance)
               playerInfo.Text = playerInfo.Text .. ((playerRace == 1 or playerRace == 2) and "\nBreathing: " .. powerValue or "")
               playerInfo.Text = playerInfo.Text .. (playerRace == 3 and "\nBlood Demon Art: " .. artValue or "")
           else
               -- Hide ESP labels if the player's character is not available
               playerESP.Visible, playerInfo.Visible = false, false
           end
       end
   end
   
   -- Create ESP labels and start updating them for a new player
   local function createESP(player)
       local playerESP, playerInfo = getDrawingObject(), getDrawingObject()
       local HeartBeat = RunService.Heartbeat:Connect(function()
           updatePlayerESP(player, ESPLabels[player])
       end)
   
       -- Store the ESP label data for the player
       ESPLabels[player] = {
           ESP = playerESP,
           Info = playerInfo,
           HeartBeat = HeartBeat
       }
   end
   
   -- Update all ESP labels for all players
   local function updateESPLabels()
       for player, labelData in pairs(ESPLabels) do
           updatePlayerESP(player, labelData)
       end
   end
   
   -- Remove ESP labels and stop updating them for a player leaving the game
   local function removeESP(player)
       local labelData = ESPLabels[player]
       if labelData then
           local playerESP, playerInfo = labelData.ESP, labelData.Info
           playerESP.Visible, playerInfo.Visible = false, false
           returnDrawingObject(playerESP)
           returnDrawingObject(playerInfo)
           labelData.HeartBeat:Disconnect()
           ESPLabels[player] = nil
       end
   end

   Players.PlayerRemoving:Connect(removeESP)
   
   local Toggle = ESP:CreateToggle({
    Name = "Toggle ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            -- Enable ESP
            for _, player in ipairs(Players:GetPlayers()) do
                createESP(player)
            end
            ESP.HeartbeatConnection = RunService.Heartbeat:Connect(updateESPLabels)

            -- Connect createESP to PlayerAdded when ESP is enabled
            ESP.PlayerAddedConnection = Players.PlayerAdded:Connect(createESP)
        else
            -- Disable ESP
            for player, _ in pairs(ESPLabels) do
                removeESP(player)
            end
            ESPLabels = {}
            if ESP.HeartbeatConnection then
                ESP.HeartbeatConnection:Disconnect()
                ESP.HeartbeatConnection = nil
            end

            -- Disconnect createESP from PlayerAdded when ESP is disabled
            if ESP.PlayerAddedConnection then
                ESP.PlayerAddedConnection:Disconnect()
                ESP.PlayerAddedConnection = nil
            end
        end
    end,
})

        -- [Teleport Section]
        local Teleport = Window:CreateTab("Teleport")
        local TeleportSection = Teleport:CreateSection("Teleport")

        function TeleportTween(dist, AdditionalCFrame)
            if Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("Humanoid") then
                if AdditionalCFrame then
                    local tweenInfo = TweenInfo.new((Character:WaitForChild("HumanoidRootPart").Position - dist.Position).magnitude / _G.Options.TweenSpeed, Enum.EasingStyle.Linear)
                    current_tween = TweenService:Create(Character:WaitForChild("HumanoidRootPart"), tweenInfo, {CFrame = dist * AdditionalCFrame})
                else
                    local tweenInfo = TweenInfo.new((Character:WaitForChild("HumanoidRootPart").Position - dist.Position).magnitude / _G.Options.TweenSpeed, Enum.EasingStyle.Linear)
                    current_tween = TweenService:Create(Character:WaitForChild("HumanoidRootPart"), tweenInfo, {CFrame = dist})
                end
     
                current_tween:Play()
                noclip_tween = true
                current_tween.Completed:Wait()
                current_tween = nil
                noclip_tween = false
            end
        end
        
        local teleportOptions = {
            ["Nomay Village"] = function()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22675.3963009,
                    [3] = "Nomay Village"
                }
        
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
            end,
        
            ["Cave 1"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22808.3569176,
                    [3] = "Cave 1"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Frozen Lake"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22909.3037934,
                    [3] = "Frozen Lake"
                }
                
              ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Village 2"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22936.3472706,
                    [3] = "Village 2"
                }
                
              ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Mist Trainer Location"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23791.931781699997,
                    [3] = "Mist trainer location"
                }
                
                ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Wop's Trainings Grounds"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22972.2790373,
                    [3] = "Wop's training grounds"
                }
                
                ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Beast Cave"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22497.1703685,
                    [3] = "Beast Cave"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Wop City"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23213.6518868,
                    [3] = "Wop City"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Mugen Train Station"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23243.3612639,
                    [3] = "Mugen Train Station"
                }
                
                ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Akeza Cave"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23278.7101263,
                    [3] = "Akeza Cave"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Cave 2"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 22869.9446229,
                    [3] = "Cave 2"
                }
                
                ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Sound Cave"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23309.3081049,
                    [3] = "Sound Cave"
                }
                
                ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Snowy Place"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23341.4434868,
                    [3] = "Snowy Place"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        
            ["Devourers Jaw"] = function ()
                local args = {
                    [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                    [2] = 23371.9606183,
                    [3] = "Devourers Jaw"
                }
                
               ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                
            end,
        }
        
        local selectedPlace = "Nomay Village"
        
        local placeNames = {} -- Create an empty table to store the place names
        
        for placeName, _ in pairs(teleportOptions) do
        table.insert(placeNames, placeName) -- Add each place name to the placeNames table
        end
        
        local TeleportPlace = Teleport:CreateDropdown({
         Name = "Select Place",
            Options = placeNames,
            CurrentOption = {"Nomay Village"},
            MultipleOptions = false,
            Flag = "TeleportPlaceDropDown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
            -- The function that takes place when the selected option is changed
            -- The variable (Option) is a table of strings for the current selected options
            selectedPlace = Option[1]
            end,
        })
        
        
        local TeleportButton = Teleport:CreateButton({
            Name = "Teleport",
            Callback = function()
                if not Character then
                    return
                end
        
                local teleportFunction = teleportOptions[selectedPlace]
                if teleportFunction then
                    teleportFunction() -- Execute the selected teleport function
                end
            end,
        })

        -- [NPC Teleport]
        local TeleportNPC = Teleport:CreateSection("Teleport NPC")

        local muzanTeleport = Teleport:CreateButton({
            Name = "Teleport to Muzan",
            Callback = function()
                local muzanSpawnPos = workspace.Muzan.SpawnPos.Value
                if muzanSpawnPos then
                    TeleportTween(CFrame.new(muzanSpawnPos))
                else
                    return
                end
            end
        })
        
        
        local doctorTeleport = Teleport:CreateButton({
            Name = "Teleport to Doctor Higoshima",
            Callback = function ()
                TeleportTween(CFrame.new(525.875, 321.917603, -2304.84766, -0.655203104, 0, 0.755452693, 0, 1, 0, -0.755452693, 0, -0.655203104))
            end
        })
        
        -- [GUI SETTINGS]
        local Settings = Window:CreateTab("Settings")
        local SettingsSection = Settings:CreateSection("Settings")
        
        local DestroyGuiButton = Settings:CreateButton({
            Name = "Destroy GUI",
            Callback = function()
                -- The function that takes place when the button is pressed
                Rayfield:Destroy()
            end,
        })
        
        local FOV = Settings:CreateSlider({
            Name = "Field Of View",
            Range = {40, 120},
            Increment = 10,
            Suffix = "FOV",
            CurrentValue = 70,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
            -- The function that takes place when the slider changes
            -- The variable (Value) is a number which correlates to the value the slider is currently at
            workspace.Camera.FieldOfView = (Value)
            end,
        })
end
-- [End Of Map 2]










--[Map 1]
if game.PlaceId == 6152116144 then

    local skill_module = require(game:GetService("ReplicatedStorage").Modules.Server["Skills_Modules_Handler"])

    hookfunction(skill_module.Kick, function()
        return nil
    end);
    
    local anti_cheat1 = LocalPlayer.PlayerScripts["Small_Scripts"]["Client_Global_utility"]
    local anti_cheat2 = LocalPlayer.PlayerScripts["Small_Scripts"]["client_global_delete_script"]
    
    hookfunction(anti_cheat1.GetPropertyChangedSignal, function()
        return
    end)
    
    hookfunction(anti_cheat2.GetPropertyChangedSignal, function()
        return
    end)
    
    anti_cheat1.Disabled = true
    anti_cheat2.Disabled = true
    
    local Namecall
    Namecall = hookmetamethod(game, '__namecall', function(self, ...)
        local Args = {...}
        local method = getnamecallmethod()
        
        if method == 'FireServer' and string.find(self.Name, 'mod') then 
            return 
        end
        
        if method == 'InvokeServer' and self.Name == 'reporthackerasdasd' then 
            return 
        end
        
        if method == 'FireServer' and self.Name == 'To_Server_commends' then 
            return
        end
        
        if method:lower() == 'kick' then 
            return 
        end
        
        return Namecall(self, ...)
    end)
    
    local hook
    hook = hookmetamethod(game, "__namecall", function(self, ...)
       args = {...}
    
       if getnamecallmethod() == "FireServer" and #args == 2 and type(args[1]) == "boolean" then
           return task.wait(9e9)
       end
    
       return hook(self, ...)
    end)

    local Window = Rayfield:CreateWindow({
        Name = "Faceless Premium Hub | Project Slayers",
        LoadingTitle = "Premium Hub",
        LoadingSubtitle = "by Faceless",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "Big Hub"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "Faceless Premium Hub",
            Subtitle = "Key System",
            Note = "No method of obtaining the key is provided",
            FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
            SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
            GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = {"https://raw.githubusercontent.com/FlightSimFreak/AG-tq63afA/main/Script"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
        }
        })

        
        --[Home/Main Section]
        local Home = Window:CreateTab("🏠 Home") -- Title, Image
        local Main = Home:CreateSection("Main")

        
        local AuraMethod = {
            ["Combat"] = function()
                -- Code for KillAura with Combat method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Combat" then
                                repeat
                                    local args = {
                                        [1] = "fist_combat",
                                        [2] = LocalPlayer,
                                        [3] = workspace:WaitForChild(LocalPlayer.Name),
                                        [4] = Character.HumanoidRootPart,
                                        [5] = Character.Humanoid,
                                        [6] = 919,
                                        [7] = "ground_slash"
                                    }
                                    
                                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                                    
                                    task.wait(1.5)
                                    
                                until not getgenv().KillAura or not getgenv().Method == "Combat"
                            end
                        end
                    end)
                end)
            end,
            ["Sword"] = function()
                -- Code for KillAura with Sword method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Sword" then
                                repeat task.wait(3)
                                   
                            until not getgenv().KillAura or not getgenv().Method == "Sword"
                        end
                    end
                end)
                end)
        
            end,
            ["Fans"] = function()
                -- Code for KillAura with Fans method goes here
            end,
            ["Scythe"] = function()
                -- Code for KillAura with Scythe method goes here
                task.spawn(function()
                    pcall(function()
                        while task.wait() do
                            if getgenv().KillAura == true and getgenv().Method == "Scythe" then
                                repeat
        
                                local args = {
                                [1] = "Scythe_Combat_Slash",
                                [2] = LocalPlayer,
                                [3] = workspace:WaitForChild(LocalPlayer.Name),
                                [4] = Character.HumanoidRootPart,
                                [5] = Character.Humanoid,
                                [6] = 919,
                                [7] = "ground_slash"
                            }
                            
                           ReplicatedStorage:WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
        
                                    task.wait(1.5)
                                    
                                until not getgenv().KillAura or not getgenv().Method == "Scythe"
                            end
                        end
                    end)
                end)
            end,
        }
        
        local methodNames = {} -- Create an empty table to store the method names
        
        for auraMethod, _ in pairs(AuraMethod) do
            table.insert(methodNames, auraMethod) -- Add each method name to the methodNames table
        end
        
        local selectedMethod = "Combat" -- Default method is "Combat"
        
        local KillAuraMethod = Home:CreateDropdown({
            Name = "Kill Aura Method",
            Options = methodNames,
            CurrentOption = {selectedMethod}, -- Set the initial value to the default method
            MultipleOptions = false,
            Flag = "KillAuraMethod",
            Callback = function(Option)
                -- The function that takes place when the selected option is changed
                -- The variable (Option) is a table of strings for the current selected options
                selectedMethod = Option[1] -- Update the selectedMethod with the new option
                getgenv().Method = selectedMethod -- Update getgenv().Method with the new option
            end,
        })
        
        -- Function to toggle KillAura
        local function toggleKillAura()
            if getgenv().KillAura and type(AuraMethod[getgenv().Method]) == "function" then
                task.spawn(AuraMethod[getgenv().Method]) -- Start the corresponding KillAura method
            end
        end
        
        local selectBosses = {
            "Sabito",
            "Giyu",
            "Nezuko",
            "Sanemi",
            "Zoku",
            "Zanegutsu Kuuchie",
            "Shiron",
            "Yahaba",
            "Susamaru",
            "Slasher"
        }
        
        local selectedBoss = "None"
        
        local selectBossDropdown = Home:CreateDropdown({
            Name = "Select Boss",
            Options = selectBosses,
            CurrentOption = {selectedBoss}, -- Set the initial value to the default method
            MultipleOptions = false,
            Flag = "selectBoss",
            Callback = function(Option)
                -- The function that takes place when the selected option is changed
                -- The variable (Option) is a table of strings for the current selected options
                selectedBoss = Option[1] -- Update the selectedBoss with the new option
            end,
        })
        
        local startFarmButton = Home:CreateToggle({
            Name = "Kill Aura",
            CurrentValue = false,
            Flag = "StartFarmButton", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                -- The function that takes place when the toggle is pressed
                -- The variable (Value) is a boolean on whether the toggle is true or false
        
                if Value then
                    -- Start the farm
                    if selectedMethod ~= getgenv().Method then  
                        getgenv().Method = selectedMethod -- Update getgenv().Method with the new option if it's different
                        print("Using " .. selectedMethod .. " kill aura")
                    end
        
                    print("Farm started")
                    print("Using " .. selectedMethod .. " kill aura")
                    getgenv().KillAura = true
                    toggleKillAura()
                else
                    -- Stop the farm
                    print("Farm stopped")
                    getgenv().KillAura = false
                end
            end,
        })
        
        -- [GKA]
        local gkaTab = Window:CreateTab("GKA")
        local gkaSection = gkaTab:CreateSection("Main Global Kill Aura")
        
        local isArrowGKAActive = false -- Flag to track if Arrow Global Kill Aura is active
        local arrowGKALoop = nil
        
        local function activateArrowGKA()
            while isArrowGKAActive do
                local args = {
                    [1] = "arrow_knock_back_damage",
                    [2] = workspace:WaitForChild(LocalPlayer.Name),
                    [3] = CFrame.new(3470.03003, 670.609985, -1883.43396, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                    [4] = workspace:WaitForChild("Mobs"):WaitForChild("Village_1_quest_bandits"):WaitForChild("BanditBoss"):WaitForChild("Nomay Bandit Boss"),
                    [5] = math.huge,
                    [6] = math.huge
                }
                
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                task.wait(1)
            end
        end
        
        local function stopArrowGKALoop()
            if arrowGKALoop then
                isArrowGKAActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                arrowGKALoop = nil
            end
        end
        
        local function startArrowGKALoop()
            if not arrowGKALoop then
                isArrowGKAActive = true -- Set the flag to true to start the loop
                arrowGKALoop = task.spawn(activateArrowGKA) -- Start the Arrow Global Kill Aura loop
            end
        end
        
        local arrowGKA = gkaTab:CreateToggle({
            Name = "Arrow Global Kill Aura [Requires Arrow BDA]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startArrowGKALoop() -- Start the Arrow Global Kill Aura loop
                else
                    stopArrowGKALoop() -- Stop the Arrow Global Kill Aura loop
                end
            end
        })
        
        
        -- [Miscellaneous]
        local miscellaneousTab = Window:CreateTab("Miscellaneous")
        local LocalPlayerMainSection = miscellaneousTab:CreateSection("Main Settings")
        
        local Label = miscellaneousTab:CreateLabel("Clan Must Start With A Captial Letter")
        local Input = miscellaneousTab:CreateInput({
        Name = "Change Clan",
        PlaceholderText = "Type Clan Name",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
        -- The function that takes place when the input is changed
        -- The variable (Text) is a string for the value in the text box
            local data = ReplicatedStorage.Player_Data[LocalPlayer.Name]
            data.Clan.Value = Text
        end,
        })
        local KillPlayerButton = miscellaneousTab:CreateButton({
            Name = "Kill Character",
            Callback = function()
                -- The function that takes place when the button is pressed
                    Character.Humanoid.Health = 0
            end,
        })
        
        local LocalPlayerBuffs = miscellaneousTab:CreateSection("Character Buffs & God Modes")
        
        local isBuffActive = false -- Flag to track if the buff is currently active
        local warDrumsBuffLoop = nil
        
        local function activateWarDrumsBuff()
            while isBuffActive do
                local args = {
                    [1] = true
                }
                ReplicatedStorage.Remotes.war_Drums_remote:FireServer(unpack(args))
                task.wait(20) -- Delay for 20 seconds before the next call
            end
        end
        
        local function stopWarDrumsBuffLoop()
            if warDrumsBuffLoop then
                isBuffActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.war_Drums_remote:FireServer(unpack(args))
                warDrumsBuffLoop = nil
            end
        end
        
        local function startWarDrumsBuffLoop()
            if not warDrumsBuffLoop then
                isBuffActive = true -- Set the flag to true to start the loop
                warDrumsBuffLoop = task.spawn(activateWarDrumsBuff) -- Start the buff activation loop
            end 
        end
        
        local warDrumsBuffToggle = miscellaneousTab:CreateToggle({
            Name = "Speed & Damage Buff [All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startWarDrumsBuffLoop() -- Start the buff loop
                else
                    stopWarDrumsBuffLoop() -- Stop the buff loop
                end
            end
        })
        
        local isFuriosityEnabled = false -- Flag to track if the buff is currently active
        local furiosityBuffLoop = nil
        
        local function activateFuriosityBuff()
            while isFuriosityEnabled do
                local args = {
                    [1] = true
                }
                ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
                task.wait(22) -- Delay for 18 seconds before the next call
            end
        end
        
        local function stopFuriosityBuffLoop()
            if furiosityBuffLoop then
                isFuriosityEnabled = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
                furiosityBuffLoop = nil
            end
        end
        
        local function startFuriosityBuffLoop()
            if not furiosityBuffLoop then
                isFuriosityEnabled = true -- Set the flag to true to start the loop
                furiosityBuffLoop = task.spawn(activateFuriosityBuff) -- Start the buff activation loop
            end 
        end
        
        local furiosityToggle = miscellaneousTab:CreateToggle({
            Name = "Furiosity [More Damage / All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    startFuriosityBuffLoop() -- Start the buff loop
                else
                    stopFuriosityBuffLoop() -- Stop the buff loop
                end
            end
        })

        local semiGodModeToggle = miscellaneousTab:CreateToggle({
            Name = "Semi God Mode [All Races]",
            CurrentValue = false,
            Callback = function (Value)
                if Value then
                    local args = {
                        [1] = true
                    }
                    
                   ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("regeneration_breathing_remote"):FireServer(unpack(args))
                    
                else
                    local args = {
                        [1] = false
                    }
                    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("regeneration_breathing_remote"):FireServer(unpack(args))
                    
                end
            end
        })
        
        local isUniversalGodModeActive = false -- Flag to track if Universal God Mode is active
        local universalGodModeLoop = nil
        
        local function activateUniversalGodMode()
            while isUniversalGodModeActive do
                local args = {
                    [1] = "skil_ting_asd",
                    [2] = LocalPlayer,
                    [3] = "scythe_asteroid_reap",
                    [4] = 1
                }
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S"):FireServer(unpack(args))
                task.wait(.5)
            end
        end
        
        local function stopUniversalGodModeLoop()
            if universalGodModeLoop then
                isUniversalGodModeActive = false -- Stop the loop by setting the flag to false
                task.wait() -- Yield the current thread so the loop can finish
                universalGodModeLoop = nil
            end
        end
        
        local function startUniversalGodModeLoop()
            if not universalGodModeLoop then
                isUniversalGodModeActive = true -- Set the flag to true to start the loop
                universalGodModeLoop = task.spawn(activateUniversalGodMode) -- Start the Universal God Mode loop
            end
        end
        
        local universalGodMode = miscellaneousTab:CreateToggle({
            Name = "Universal God Mode [Requires Scythe Equipped/ 30+ Mas.]",
            CurrentValue = false,
            Callback = function(Value)
                if Value then
                    startUniversalGodModeLoop() -- Start the Universal God Mode loop
                else
                    stopUniversalGodModeLoop() -- Stop the Universal God Mode loop
                end
            end
        })
        
        local infBreathingToggle = miscellaneousTab:CreateToggle({
            Name = "INF Breathing",
            CurrentValue = false,
            Callback = function (Value)
                _G.Options.infbreath = (Value)
            end
        })
        
        spawn(function()
            while task.wait() do
                if _G.Options.infbreath then
                    getrenv()._G:Breath(-100)
                else
                    _G.Options.infbreath = false
                end
            end
        end)
        
        local infStamToggle = miscellaneousTab:CreateToggle({
            Name = "INF Stamina",
            CurrentValue = false,
            Callback = function (Value)
                _G.Options.infstam = (Value)
            end
        })
        
        spawn(function()
            while task.wait() do
                if _G.Options.infstam then
                    getrenv()._G:Stamina(-100)
                else
                    _G.Options.infstam = false
                end
            end
        end)
        
        local miscellaneousTabBDASPINS = miscellaneousTab:CreateSection("Others")

        local isAutoBDASpinActive = false
        local autoBDASpinLoop = nil
        local chosenBDA = nil
        
        local bdas = {
            "Ice",
            "Reaper",
            "Shockwave",
            "Arrow",
            "Swamp",
            "Dream",
            "Blood",
            "Tamari",
            -- Add more BDAs if needed
        }
        
        local bdaNames = {}
        
        -- Use ipairs instead of pairs for ordered insertion
        for _, bdaName in ipairs(bdas) do
            table.insert(bdaNames, bdaName)
        end
        
        local Dropdown = miscellaneousTab:CreateDropdown({
            Name = "Select Blood Demon Art",
            Options = bdaNames,
            CurrentOption = "None",
            MultipleOptions = false,
            Flag = "Dropdown1",
            Callback = function(option)
                chosenBDA = option
            end,
        })
        
        local autoBDASpinToggle -- Define the toggle variable globally
        
        local function startAutoBDASpinLoop()
            if not autoBDASpinLoop and chosenBDA then  -- Added an extra condition to check if chosenBDA is not nil
                isAutoBDASpinActive = true

                autoBDASpinLoop = task.spawn(function()
                    while isAutoBDASpinActive do
                        local currentBDA = ReplicatedStorage.Player_Data[LocalPlayer.Name].Demon_Art.Value
                        if currentBDA == chosenBDA then
                            isAutoBDASpinActive = false
                            autoBDASpinToggle:Set(false) -- Turn off the toggle when the desired BDA is obtained
                            break
                        end
        
                        local args = {
                            [1] = "check_can_spin_demon_art"
                        }
        
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                        task.wait(1.5) -- You can adjust the delay time if needed
                    end
                    autoBDASpinLoop = nil  -- Set autoBDASpinLoop to nil after the loop ends
                end)
            end
        end
        
        
        local function stopAutoBDASpinLoop()
            if autoBDASpinLoop then
                isAutoBDASpinActive = false
                task.wait()
                autoBDASpinLoop = nil
            end
        end
        
        autoBDASpinToggle = miscellaneousTab:CreateToggle({
            Name = "Auto Blood Demon Art Spin",
            CurrentValue = false,
            Flag = "StartAutoBDASpin",
            Callback = function(value)
                if value then
                    startAutoBDASpinLoop()
                else
                    stopAutoBDASpinLoop()
                end
            end,
        })             
        
      -- [ESP]
      local ESP = Window:CreateTab("ESP")
      local ESPSection = ESP:CreateSection("ESP Settings")
      
      -- Tables to store ESP labels and drawing objects
      local ESPLabels = {}
      local DrawingPool = {}
      
      -- Helper function to create or reuse a drawing object
      local function getDrawingObject()
          local drawingObject = next(DrawingPool) or Drawing.new("Text")
          DrawingPool[drawingObject] = nil
          drawingObject.Visible = false
          drawingObject.Center = true
          drawingObject.Outline = true
          drawingObject.Font = 2
          drawingObject.Color = Color3.fromRGB(255, 255, 255)
          drawingObject.Size = 13
          return drawingObject
      end
      
      -- Helper function to return a drawing object to the pool for reuse
      local function returnDrawingObject(drawingObject)
          drawingObject.Visible = false
          DrawingPool[drawingObject] = true
      end
      
      -- Helper function to update the ESP labels for a player
      local function updatePlayerESP(player, labelData)
          local playerESP, playerInfo = labelData.ESP, labelData.Info
          if player == LocalPlayer then
              -- Hide ESP labels for the local player
              playerESP.Visible, playerInfo.Visible = false, false
          else
              local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
              if humanoidRootPart then
                  -- Convert 3D position to 2D screen position
                  local position, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position)
                  local powerValue = ReplicatedStorage.Player_Data[player.Name].Power.Value
                  local artValue = ReplicatedStorage.Player_Data[player.Name].Demon_Art.Value
                  local healthValue = workspace[player.Name].Humanoid.Health
   
                   local playerRace = ReplicatedStorage.Player_Data[player.Name].Race.Value
                  -- Calculate distance between LocalPlayer and the target player
                  local distance = (Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
      
                  -- Update the ESP label with player information and distance
                  playerESP.Position, playerESP.Visible, playerESP.Text = Vector2.new(position.X, position.Y), onScreen, "Username: " .. player.Name
                  playerInfo.Visible, playerInfo.Text = onScreen, "Health: " .. math.floor(healthValue)
                  playerInfo.Position = Vector2.new(position.X, position.Y + 15)  -- Adjust the position for distance
                  playerInfo.Text = playerInfo.Text .. string.format("\nDistance: %.2f studs", distance)
                  playerInfo.Text = playerInfo.Text .. ((playerRace == 1 or playerRace == 2) and "\nBreathing: " .. powerValue or "")
                  playerInfo.Text = playerInfo.Text .. (playerRace == 3 and "\nBlood Demon Art: " .. artValue or "")
              else
                  -- Hide ESP labels if the player's character is not available
                  playerESP.Visible, playerInfo.Visible = false, false
              end
          end
      end
      
      -- Create ESP labels and start updating them for a new player
      local function createESP(player)
          local playerESP, playerInfo = getDrawingObject(), getDrawingObject()
          local HeartBeat = RunService.Heartbeat:Connect(function()
              updatePlayerESP(player, ESPLabels[player])
          end)
      
          -- Store the ESP label data for the player
          ESPLabels[player] = {
              ESP = playerESP,
              Info = playerInfo,
              HeartBeat = HeartBeat
          }
      end
      
      -- Update all ESP labels for all players
      local function updateESPLabels()
          for player, labelData in pairs(ESPLabels) do
              updatePlayerESP(player, labelData)
          end
      end
      
      -- Remove ESP labels and stop updating them for a player leaving the game
      local function removeESP(player)
          local labelData = ESPLabels[player]
          if labelData then
              local playerESP, playerInfo = labelData.ESP, labelData.Info
              playerESP.Visible, playerInfo.Visible = false, false
              returnDrawingObject(playerESP)
              returnDrawingObject(playerInfo)
              labelData.HeartBeat:Disconnect()
              ESPLabels[player] = nil
          end
      end
      
      -- Connect events for player joining and leaving
      Players.PlayerRemoving:Connect(removeESP)
      
      local Toggle = ESP:CreateToggle({
       Name = "Toggle ESP",
       CurrentValue = false,
       Callback = function(Value)
           if Value then
               -- Enable ESP
               for _, player in ipairs(Players:GetPlayers()) do
                   createESP(player)
               end
               ESP.HeartbeatConnection = RunService.Heartbeat:Connect(updateESPLabels)
   
               -- Connect createESP to PlayerAdded when ESP is enabled
               ESP.PlayerAddedConnection = Players.PlayerAdded:Connect(createESP)
           else
               -- Disable ESP
               for player, _ in pairs(ESPLabels) do
                   removeESP(player)
               end
               ESPLabels = {}
               if ESP.HeartbeatConnection then
                   ESP.HeartbeatConnection:Disconnect()
                   ESP.HeartbeatConnection = nil
               end
   
               -- Disconnect createESP from PlayerAdded when ESP is disabled
               if ESP.PlayerAddedConnection then
                   ESP.PlayerAddedConnection:Disconnect()
                   ESP.PlayerAddedConnection = nil
               end
           end
       end,
   })
        
        -- [Teleport Section]
        local Teleport = Window:CreateTab("Teleport")
        local TeleportSection = Teleport:CreateSection("Teleport")


    -- [GUI SETTINGS]
    local Settings = Window:CreateTab("Settings")
    local SettingsSection = Settings:CreateSection("Settings")
    
    local DestroyGuiButton = Settings:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            -- The function that takes place when the button is pressed
            Rayfield:Destroy()
        end,
    })
    
    local FOV = Settings:CreateSlider({
        Name = "Field Of View",
        Range = {40, 120},
        Increment = 10,
        Suffix = "FOV",
        CurrentValue = 70,
        Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
        -- The function that takes place when the slider changes
        -- The variable (Value) is a number which correlates to the value the slider is currently at
        workspace.Camera.FieldOfView = (Value)
        end,
    })
end
