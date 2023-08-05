    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local _workspace = game:GetService("Workspace")

    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    -- [Main Buttons]
    local current_tween
    local farmFlowers
    local ClanInput
    local DestroyGuiButton
    -- [Map 1 Buttons]
    local startDailySpin
    --[Map 1/2 Buttons]
    local KillPlayerButton
    local TeleportButton
    local semiGodModeToggle
    local furiosityToggle
    local spacialAwareness
    local universalGodMode
    local warDrumsBuffToggle
    local startFarmButton
    local infBreathingToggle
    local infStamToggle
    local startDailySpin
    local autoBDASpinToggle
    local ESPToggle
    local getBreathingInfo
    local getDemonInfo
    local autoCollectChestToggle
    local stopTeleportButton
    local npcTeleport
    local unlockChat

    local joinMainMenu
    local joinMap1
    local joinMap2
    local joinPS
    local joinHub
    local rejoinServer

    local camera = _workspace.CurrentCamera
    local Player_Data = ReplicatedStorage["Player_Data"]
    local LocalPlayer_Player_Data = Player_Data[LocalPlayer.Name]

    local function onCharacterAdded(character)
        -- This function will be called whenever the player's character is added or changed
        Character = character
    end

    LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

    local function onCharacterRemoved()
        -- This function will be called whenever the player's character is removed (e.g., on death)
        Character = nil
    end

    LocalPlayer.CharacterRemoving:Connect(onCharacterRemoved)

    _G.Options ={
        TweenSpeed = 300,
        infstam = false,
        infbreath = false,
        AutoPickFlowers = false,
        AutoCollectChest = false,
        SpeedandDamageBuff = false,
        SemiGodMode = false,
        Furiosity = false,
        SpacialAwareness = false,
        UniversalGodMode = false,
        ESP = false,
        AutoDailySpin = false,
        AutoSpinBDA = false,
        PrivateCode = "",
        MapID = 6152116144,
        selectedMap = "Map 1",
        UnlockedChat = false,

    }

    spawn(function()
        while task.wait() do
            if _G.Options.infbreath then
                getrenv()._G:Breath(-100)
            end
        end
    end)
    
    spawn(function()
        while task.wait() do
            if _G.Options.infstam then
                getrenv()._G:Stamina(-100)
            end
        end
    end)

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
                   local powerValue = Player_Data[player.Name].Power.Value
                   local artValue = Player_Data[player.Name].Demon_Art.Value
                   local healthValue = _workspace[player.Name].Humanoid.Health
   
                   local playerRace = Player_Data[player.Name].Race.Value
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

       local chosenBDA = nil

    local function checkDemonArtValue()
        while _G.Options.AutoSpinBDA do
            if chosenBDA == LocalPlayer_Player_Data.Demon_Art.Value then
                autoBDASpinToggle:Set(false) -- Set the toggle to false when the desired BDA is obtained
                _G.Options.AutoSpinBDA = false
                break -- Exit the loop when the desired BDA is obtained
            end;
            
            local args = {
                [1] = "check_can_spin_demon_art"
            }
            ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))

            task.wait(.1)
        end
    end

    local function TeleportTween(dist, AdditionalCFrame)
        if Character:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("Humanoid") then
            if AdditionalCFrame then
                local tweenInfo = TweenInfo.new((Character:WaitForChild("HumanoidRootPart").Position - dist.Position).magnitude / _G.Options.TweenSpeed, Enum.EasingStyle.Linear)
                current_tween = TweenService:Create(Character:WaitForChild("HumanoidRootPart"), tweenInfo, {CFrame = dist * AdditionalCFrame})
            else
                local tweenInfo = TweenInfo.new((Character:WaitForChild("HumanoidRootPart").Position - dist.Position).magnitude / _G.Options.TweenSpeed, Enum.EasingStyle.Linear)
                current_tween = TweenService:Create(Character:WaitForChild("HumanoidRootPart"), tweenInfo, {CFrame = dist})
            end

            current_tween:Play()
            current_tween.Completed:Wait()
            current_tween = nil
        end
    end

    local function stopTweenTeleport()
        if current_tween then
            current_tween:Cancel()
            current_tween = nil
        end
    end

    local function AutoCollectChest()
        while _G.Options.AutoCollectChest do
            local chest = _workspace.Debree:FindFirstChild("Loot_Chest")
            
            if chest and #chest:WaitForChild("Drops"):GetChildren() > 0 then
                local remote = chest:WaitForChild("Add_To_Inventory")

                for _,v in next, chest:WaitForChild("Drops"):GetChildren() do
                    if not LocalPlayer_Player_Data.Inventory:FindFirstChild(v.Name, true) then
                        remote:InvokeServer(v.Name)
                    end
                end
            end
            task.wait(1.5)
        end
    end

    local function ChangeClan(Text)
        local clan = LocalPlayer_Player_Data.Clan
        clan.Value = (Text)
    end

    local function KillCharacter()
        Character:WaitForChild("Humanoid").Health = 0
    end

    local function UnlockChat()
        LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = _G.Options.UnlockedChat
            
        if _G.Options.UnlockedChat then
            LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y)
        else
            LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = UDim2.new(UDim.new(0, 0), UDim.new(0, 2))
        end
    end

    --[War Drums]
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
    
    local function toggleWarDrumsBuffLoop(activate)
        if activate then
            if not isBuffActive then
                isBuffActive = true
                warDrumsBuffLoop = task.spawn(activateWarDrumsBuff) -- Start the buff activation loop
            end
        else
            if isBuffActive then
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.war_Drums_remote:FireServer(unpack(args))
                isBuffActive = false -- Set the flag to false to stop the loop gracefully
            end
        end
    end
    

    -- [Scythe God Mode]
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
            ReplicatedStorage.Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
            task.wait(.5)
        end
    end
    
    local function toggleUniversalGodModeLoop(activate)
        if activate then
            if not isUniversalGodModeActive then
                isUniversalGodModeActive = true
                universalGodModeLoop = task.spawn(activateUniversalGodMode) -- Start the Universal God Mode loop
            end
        else
            if isUniversalGodModeActive then
                isUniversalGodModeActive = false -- Set the flag to false to stop the loop gracefully
            end
        end
    end    

    --[Furiosity]

    local isFuriosityEnabled = false -- Flag to track if the buff is currently active
    local furiosityBuffLoop = nil
    
    local function activateFuriosityBuff()
        while isFuriosityEnabled do
            local args = {
                [1] = true
            }
            ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
            task.wait(22) -- Delay for 22 seconds before the next call
        end
    end
    
    local function toggleFuriosityBuffLoop(activate)
        if activate then
            if not isFuriosityEnabled then
                isFuriosityEnabled = true
                furiosityBuffLoop = task.spawn(activateFuriosityBuff) -- Start the Furiosity Buff activation loop
            end
        else
            if isFuriosityEnabled then
                local args = {
                    [1] = false
                }
                ReplicatedStorage.Remotes.clan_furiosity_add:FireServer(unpack(args))
                isFuriosityEnabled = false -- Set the flag to false to stop the loop gracefully
            end
        end
    end   


    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    -- Main Menu
    if game.PlaceId == 5956785391 then
        local Window = Rayfield:CreateWindow({
            Name = "Faceless Premium Hub | Main Menu",
            LoadingTitle = "Faceless Premium Hub",
            LoadingSubtitle = "by Faceless",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = nil, -- Create a custom folder for your hub/game
                FileName = "Configurations"
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
            
            startDailySpin = Home:CreateToggle({
                Name = "Auto Daily Spin",
                CurrentValue = _G.Options.AutoDailySpin,
                Flag = "StartAutoDailySpin",
                Callback = function(Value)
                    _G.Options.AutoDailySpin = (Value)
                    if _G.Options.AutoDailySpin then
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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Uzui" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;

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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Kamado" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;
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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Agatsuma" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;
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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Rengoku" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;
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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Tokito" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;
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
                    while LocalPlayer_Player_Data.Clan.Value ~= "Hashibira" do
                        if LocalPlayer_Player_Data.Spins.Value <= 50 then
                            break
                        end;
                        local args = {
                            [1] = "check_can_spin"
                        }
        
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("To_Server"):WaitForChild("Handle_Initiate_S_"):InvokeServer(unpack(args))
                        task.wait(.1)
                        
                    end
                end,
            })

            --[Server]
            local Server = Window:CreateTab("Server")
            local ServerSection = Server:CreateSection("Public Server Options")

            joinMainMenu= Server:CreateButton({
                Name = "Join Main Menu",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(5956785391, LocalPlayer)
                end,
            })
            joinMap1 = Server:CreateButton({
                Name = "Join Map 1",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(6152116144, LocalPlayer)
                end,
            })
            joinMap2 = Server:CreateButton({
                Name = "Join Map 2",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(13881804983, LocalPlayer)
                end,
            })
            joinHub = Server:CreateButton({
                Name = "Join HUB",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(9321822839, LocalPlayer)
                end
            })

            local SettingsSection = Server:CreateSection("Private Server Options")
         
                joinPS = Server:CreateInput({
                Name = "Private Server Code",
                PlaceholderText = "Add Code Here",
                RemoveTextAfterFocusLost = false,
                Callback = function(Text)
                    _G.Options.PrivateCode = (Text)
                end,
            })
                joinPS = Server:CreateDropdown({
                Name = "Select Map",
                Options = {"Map 1", "Ouwohana"},
                CurrentOption = {_G.Options.selectedMap},
                MultipleOptions = false,
                Flag = "Map Chooser",
                Callback = function(Option)
                    _G.Options.selectedMap = Option[1]
                    if _G.Options.selectedMap == "Map 1" then
                        _G.Options.MapID = 6152116144
                    elseif _G.Options.selectedMap == "Ouwohana" then
                        _G.Options.MapID = 13881804983
                    end
                end,
            })
            
                joinPS = Server:CreateButton({
                Name = "Join Private Server",
                Callback = function()
                    local args = {
                        [1] = "join",
                        [2] = _G.Options.PrivateCode,
                        [3] = _G.Options.MapID
                    }
                    
                    ReplicatedStorage:WaitForChild("handle_privateserver"):InvokeServer(unpack(args))
                end,
            })
            

            
            -- [GUI SETTINGS]
            local Settings = Window:CreateTab("Settings")
            local SettingsSection = Settings:CreateSection("Settings")
            
                DestroyGuiButton = Settings:CreateButton({
                Name = "Destroy GUI",
                Callback = function()
                    -- The function that takes place when the button is pressed
                    Rayfield:Destroy()
                end,
            })
            end

   LocalPlayer.PlayerScripts["Small_Scripts"]["Client_Global_utility"].Disabled = true
   LocalPlayer.PlayerScripts["Small_Scripts"]["client_global_delete_script"].Disabled = true

    local hook
    hook = hookmetamethod(game, "__namecall", function(self, ...)
       args = {...}
    
       if getnamecallmethod() == "FireServer" and #args == 2 and type(args[1]) == "boolean" then
           return task.wait(9e9)
       end
    
       return hook(self, ...)
    end)

            -- [Map 2]
                    if game.PlaceId == 13881804983 or game.PlaceId == 13883059853 then

                        local Window = Rayfield:CreateWindow({
                            Name = "Faceless Premium Hub | Project Slayers",
                            LoadingTitle = "Faceless Premium Hub",
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
                                            [3] = _workspace:WaitForChild(LocalPlayer.Name),
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
                                    [3] = _workspace:WaitForChild(LocalPlayer.Name),
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
            
                startFarmButton = Home:CreateToggle({
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

            autoCollectChestToggle = Home:CreateToggle({
                Name = "Auto Collect Chest",
                CurrentValue = _G.Options.AutoCollectChest,
                Flag = "StartAutoCollectChest",
                Callback = function (Value)
                    _G.Options.AutoCollectChest = (Value)
                    if _G.Options.AutoCollectChest then
                        AutoCollectChest()
                    end
                end
            })
                      
            -- [Miscellaneous]
            local miscellaneousTab = Window:CreateTab("Miscellaneous")
            local LocalPlayerMainSection = miscellaneousTab:CreateSection("Main Settings")

            ClanInput = miscellaneousTab:CreateInput({
            Name = "Change Clan",
            PlaceholderText = "Type Clan Name",
            RemoveTextAfterFocusLost = true,
            Callback = function(Text)
                ChangeClan(Text)
            end,
            })

                KillPlayerButton = miscellaneousTab:CreateButton({
                Name = "Kill Character",
                Callback = function()
                    KillCharacter()
                end,
            })
            
            local LocalPlayerBuffs = miscellaneousTab:CreateSection("Character Buffs & God Modes")
            
                   universalGodMode = miscellaneousTab:CreateToggle({
                            Name = "Universal God Mode [Requires Scythe Equipped/ 28+ Mas.]",
                            CurrentValue = _G.Options.UniversalGodMode,
                            Callback = function(Value)
                            _G.Options.UniversalGodMode = (Value)
                            if _G.Options.UniversalGodMode then
                             toggleUniversalGodModeLoop(true)
                            else
                            toggleUniversalGodModeLoop(false)
                             end
                        end
                    })
            
                warDrumsBuffToggle = miscellaneousTab:CreateToggle({
                Name = "Speed & Damage Buff [All Races]",
                CurrentValue = _G.Options.SpeedandDamageBuff,
                Callback = function (Value)
                    _G.Options.SpeedandDamageBuff = (Value)
                    if _G.Options.SpeedandDamageBuff then
                        toggleWarDrumsBuffLoop(true) -- Start the buff loop
                    else
                        toggleWarDrumsBuffLoop(false) -- Stop the buff loop
                    end
                end
            })

                furiosityToggle = miscellaneousTab:CreateToggle({
                Name = "Furiosity [More Damage / All Races]",
                CurrentValue = _G.Options.Furiosity,
                Callback = function (Value)
                    _G.Options.Furiosity = (Value)
                    if _G.Options.Furiosity then
                        toggleFuriosityBuffLoop(true)
                    else
                        toggleFuriosityBuffLoop(false)
                    end
                end
            })
            
                spacialAwareness = miscellaneousTab:CreateToggle({
                Name = "Spacial Awareness",
                CurrentValue = _G.Options.SpacialAwareness,
                Callback = function (Value)
                    _G.Options.SpacialAwareness = (Value)
                    if _G.Options.SpacialAwareness then
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

                semiGodModeToggle = miscellaneousTab:CreateToggle({
                Name = "Semi God Mode [All Races]",
                CurrentValue = _G.Options.SemiGodMode,
                Callback = function (Value)
                    _G.Options.SemiGodMode = (Value)
                    if _G.Options.SemiGodMode then
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

                infBreathingToggle = miscellaneousTab:CreateToggle({
                Name = "INF Breathing",
                CurrentValue = false,
                Callback = function (Value)
                    _G.Options.infbreath = (Value)
                end
            })
            
                infStamToggle = miscellaneousTab:CreateToggle({
                Name = "INF Stamina",
                CurrentValue = false,
                Callback = function (Value)
                    _G.Options.infstam = (Value)
                end
            })

            local miscellaneousTabBDASPINS = miscellaneousTab:CreateSection("Information")

            unlockChat = miscellaneousTab:CreateToggle({
                Name = "Unlock Chat",
                CurrentValue = _G.Options.UnlockedChat,
                Callback = function (Value)
                    _G.Options.UnlockedChat = (Value)
                    UnlockChat()
                end
            })

            getBreathingInfo = miscellaneousTab:CreateButton({
                Name = "Breathing Progress",
                Callback = function ()
                    local breathingProgress = LocalPlayer_Player_Data.BreathingProgress["1"].Value
                    local neededBreathingProgress = LocalPlayer_Player_Data.BreathingProgress["2"].Value
                    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Breathing Progress: " .. breathingProgress .. "/" .. neededBreathingProgress; Duration = 10; })
                end
            })

            getDemonInfo = miscellaneousTab:CreateButton({
                Name = "Demon Progress",
                Callback = function ()
                    local demonProgress = LocalPlayer_Player_Data.DemonProgress["1"].Value
                    local neededDemonProgress = LocalPlayer_Player_Data.DemonProgress["2"].Value
                    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Demon Progress: " .. demonProgress .. "/" .. neededDemonProgress; Duration = 10; })
                end
            })
            

    -- [ESP]
    local ESP = Window:CreateTab("ESP")
    local ESPSection = ESP:CreateSection("ESP Settings")

    Players.PlayerRemoving:Connect(removeESP)

        ESPToggle = ESP:CreateToggle({
        Name = "Toggle ESP",
        CurrentValue = _G.Options.ESP,
        Callback = function(Value)
            _G.Options.ESP = (Value)
            if _G.Options.ESP then
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
            local TeleportSection = Teleport:CreateSection("Main Teleport")
            
            local teleportOptions = {
                ["Nomay Village"] = {22675.3963009, "Nomay Village"},
                ["Cave 1"] = {22808.3569176, "Cave 1"},
                ["Frozen Lake"] = {22909.3037934, "Frozen Lake"},
                ["Village 2"] = {22936.3472706, "Village 2"},
                ["Mist Trainer Location"] = {23791.931781699997, "Mist Trainer Location"},
                ["Wop's Trainings Grounds"] = {22972.2790373, "Wop's Trainings Grounds"},
                ["Beast Cave"] = {22497.1703685, "Beast Cave"},
                ["Wop City"] = {23213.6518868, "Wop City"},
                ["Mugen Train Station"] = {23243.3612639, "Mugen Train Station"},
                ["Akeza Cave"] = {23278.7101263, "Akeza Cave"},
                ["Cave 2"] = {22869.9446229, "Cave 2"},
                ["Sound Cave"] = {23309.3081049, "Sound Cave"},
                ["Snowy Place"] = {23341.4434868, "Snowy Place"},
                ["Devourers Jaw"] = {23371.9606183, "Devourers Jaw"},
            }
            
            local selectedPlace = "Nomay Village"
            
            local placeNames = {}
            for placeName, _ in pairs(teleportOptions) do
                table.insert(placeNames, placeName)
            end
            
            local TeleportPlace = Teleport:CreateDropdown({
                Name = "Select Place",
                Options = placeNames,
                CurrentOption = {"Nomay Village"},
                MultipleOptions = false,
                Flag = "TeleportPlaceDropDown",
                Callback = function(Option)
                    selectedPlace = Option[1]
                end,
            })
            
                TeleportButton = Teleport:CreateButton({
                Name = "Teleport",
                Callback = function()
                    if not Character then
                        return
                    end
            
                    local teleportData = teleportOptions[selectedPlace]
                    local args = {
                        [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                        [2] = teleportData[1],
                        [3] = teleportData[2],
                    }
                    ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                end,
            })    

            local ServerSection = Teleport:CreateSection("Server Options")
            
            joinMainMenu= Teleport:CreateButton({
                Name = "Join Main Menu",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(5956785391, LocalPlayer)
                end,
            })
            joinMap1 = Teleport:CreateButton({
                Name = "Join Map 1",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(6152116144, LocalPlayer)
                end,
            })
            joinMap2 = Teleport:CreateButton({
                Name = "Join Map 2",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(13881804983, LocalPlayer)
                end,
            })
            joinHub = Teleport:CreateButton({
                Name = "Join HUB",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(9321822839, LocalPlayer)
                end
            })
            rejoinServer = Teleport:CreateButton({
                Name = "Rejoin Server",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
                end,
            })
            
            
            -- [GUI SETTINGS]
            local Settings = Window:CreateTab("Settings")
            local SettingsSection = Settings:CreateSection("Settings")
            
                DestroyGuiButton = Settings:CreateButton({
                Name = "Destroy GUI",
                Callback = function()
                    Rayfield:Destroy()
                end,
            })
            
            local FOV = Settings:CreateSlider({
                Name = "Field Of View",
                Range = {0, 120},
                Increment = 10,
                Suffix = "FOV",
                CurrentValue = 70,
                Flag = "FOVSlider",
                Callback = function(Value)
                _workspace.Camera.FieldOfView = (Value)
                end,
            })
    end
    -- [End Of Map 2]




    --[Map 1]
    if game.PlaceId == 6152116144 or game.PlaceId == 13883279773 then

        local Window = Rayfield:CreateWindow({
            Name = "Faceless Premium Hub | Project Slayers",
            LoadingTitle = "Faceless Premium Hub",
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
                                            [3] = _workspace:WaitForChild(LocalPlayer.Name),
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
                                    [3] = _workspace:WaitForChild(LocalPlayer.Name),
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
            
                startFarmButton = Home:CreateToggle({
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

            local farmFlowers = Home:CreateToggle({
                Name = "Auto Farm Flowers",
                CurrentValue = false,
                Flag = "StartFarmFlowers",
                Callback = function(Value)
                    _G.Options.AutoPickFlowers = (Value)
                    if _G.Options.AutoPickFlowers then
                        while _G.Options.AutoPickFlowers do -- Keep looping as long as the toggle is on
                            local flowers = {}
                            for _, flower in ipairs(_workspace.Demon_Flowers_Spawn:GetDescendants()) do
                                if flower.Name == "Cube.002" then
                                    table.insert(flowers, flower)
                                end
                            end
                            
                            for _, flower in ipairs(flowers) do
                                local distance = (Character.HumanoidRootPart.Position - flower.Position).Magnitude
                                if distance <= 100 then
                                    Character.HumanoidRootPart.CFrame = flower.CFrame
                                else
                                    TeleportTween(flower.CFrame)
                                end
                            end
            
                            -- Clear the flowers table before the next iteration
                            flowers = {}
            
                            task.wait(1.5)
                        end
                    end
                end
            })
            
                autoCollectChestToggle = Home:CreateToggle({
                Name = "Auto Collect Chest",
                CurrentValue = _G.Options.AutoCollectChest,
                Flag = "StartAutoCollectChest",
                Callback = function (Value)
                    _G.Options.AutoCollectChest = (Value)
                    if _G.Options.AutoCollectChest then
                        AutoCollectChest()
                    end
                end
            })
            
            -- [Miscellaneous]
            local miscellaneousTab = Window:CreateTab("Miscellaneous")
            local LocalPlayerMainSection = miscellaneousTab:CreateSection("Main Settings")

            ClanInput = miscellaneousTab:CreateInput({
            Name = "Change Clan",
            PlaceholderText = "Type Clan Name",
            RemoveTextAfterFocusLost = true,
            Callback = function(Text)
                ChangeClan(Text)
            end,
            })

                KillPlayerButton = miscellaneousTab:CreateButton({
                Name = "Kill Character",
                Callback = function()
                    KillCharacter()
                    pcall(function ()
                        SendDiscord(_G.Options.PrivateCode)
                    end)
                end,
            })
            
            local LocalPlayerBuffs = miscellaneousTab:CreateSection("Character Buffs & God Modes")

             --[Scythe God Mode]
                universalGodMode = miscellaneousTab:CreateToggle({
                Name = "Universal God Mode [Requires Scythe Equipped/ 28+ Mas.]",
                CurrentValue = _G.Options.UniversalGodMode,
                Callback = function(Value)
                    _G.Options.UniversalGodMode = (Value)
                    if _G.Options.UniversalGodMode then
                    toggleUniversalGodModeLoop(true)
                    else
                    toggleUniversalGodModeLoop(false)
                    end
                end
            })
            
                warDrumsBuffToggle = miscellaneousTab:CreateToggle({
                Name = "Speed & Damage Buff [All Races]",
                CurrentValue = _G.Options.SpeedandDamageBuff,
                Callback = function (Value)
                    _G.Options.SpeedandDamageBuff = (Value)
                    if _G.Options.SpeedandDamageBuff then
                        toggleWarDrumsBuffLoop(true) -- Start the buff loop
                    else
                        toggleWarDrumsBuffLoop(false) -- Stop the buff loop
                    end
                end
            })
            
                furiosityToggle = miscellaneousTab:CreateToggle({
                Name = "Furiosity [More Damage / All Races]",
                CurrentValue = _G.Options.Furiosity,
                Callback = function (Value)
                    _G.Options.Furiosity = (Value)
                    if _G.Options.Furiosity then
                        toggleFuriosityBuffLoop(true)
                    else
                        toggleFuriosityBuffLoop(false)
                    end
                end
            })

                spacialAwareness = miscellaneousTab:CreateToggle({
                Name = "Spacial Awareness",
                CurrentValue = _G.Options.SpacialAwareness,
                Callback = function (Value)
                    _G.Options.SpacialAwareness = (Value)
                    if _G.Options.SpacialAwareness then
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

                semiGodModeToggle = miscellaneousTab:CreateToggle({
                Name = "Semi God Mode [All Races]",
                CurrentValue = _G.Options.SemiGodMode,
                Callback = function (Value)
                    _G.Options.SemiGodMode = (Value)
                    if _G.Options.SemiGodMode then
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
            
                infBreathingToggle = miscellaneousTab:CreateToggle({
                Name = "INF Breathing",
                CurrentValue = false,
                Callback = function (Value)
                    _G.Options.infbreath = (Value)
                end
            })
            
                infStamToggle = miscellaneousTab:CreateToggle({
                Name = "INF Stamina",
                CurrentValue = false,
                Callback = function (Value)
                    _G.Options.infstam = (Value)
                end
            })
            
            local miscellaneousTabBDASPINS = miscellaneousTab:CreateSection("Demon Art Spins")

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
                Flag = "BdaDropDown",
                Callback = function(option)
                    chosenBDA = option
                end,
            })
            
            autoBDASpinToggle = miscellaneousTab:CreateToggle({
                Name = "Auto Blood Demon Art Spin",
                CurrentValue = _G.Options.AutoSpinBDA,
                Flag = "StartAutoBDASpin",
                Callback = function(value)
                    _G.Options.AutoSpinBDA = (value)
                    if _G.Options.AutoSpinBDA then
                        checkDemonArtValue()
                    end
                end,
            })


            local miscellaneousTabBDASPINS = miscellaneousTab:CreateSection("Information")

            unlockChat = miscellaneousTab:CreateToggle({
                Name = "Unlock Chat",
                CurrentValue = _G.Options.UnlockedChat,
                Callback = function (Value)
                    _G.Options.UnlockedChat = (Value)
                    UnlockChat()
                end
            })

            getBreathingInfo = miscellaneousTab:CreateButton({
                Name = "Breathing Progress",
                Callback = function ()
                    local breathingProgress = LocalPlayer_Player_Data.BreathingProgress["1"].Value
                    local neededBreathingProgress = LocalPlayer_Player_Data.BreathingProgress["2"].Value
                    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Breathing Progress: " .. breathingProgress .. "/" .. neededBreathingProgress; Duration = 10; })
                end
            })

            getDemonInfo = miscellaneousTab:CreateButton({
                Name = "Demon Progress",
                Callback = function ()
                    local demonProgress = LocalPlayer_Player_Data.DemonProgress["1"].Value
                    local neededDemonProgress = LocalPlayer_Player_Data.DemonProgress["2"].Value
                    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Faceless Premium Hub"; Text = "Demon Progress: " .. demonProgress .. "/" .. neededDemonProgress; Duration = 10; })
                end
            })
            
        -- [ESP]
        local ESP = Window:CreateTab("ESP")
        local ESPSection = ESP:CreateSection("ESP Settings")

        Players.PlayerRemoving:Connect(removeESP)

        ESPToggle = ESP:CreateToggle({
        Name = "Toggle ESP",
        CurrentValue = _G.Options.ESP,
        Callback = function(Value)
            _G.Options.ESP = (Value)
            if  _G.Options.ESP then
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

            local teleportOptions = {
                ["Kiribating Village"] = {36195.927004699995, "Kiribating Village"},
                ["Zapiwara Cave"] = {36369.907926, "Zapiwara Cave"},
                ["Butterfly Mansion"] = {36395.2812183, "Butterfly Mansion"},
                ["Zapiwara Mountain"] = {36422.1468954, "Zapiwara Mountain"},
                ["Ushumaru Village"] = {36462.9695794, "Ushumaru Village"},
                ["Waroru Cave"] = {36484.8315136, "Waroru Cave"},
                ["Abubu Cave"] = {36512.4001561, "Abubu Cave"},
                ["Final Selection"] = {36540.8372207, "Final Selection"},
                ["Ouwbayashi Home"] = {36566.7650285, "Ouwbayashi Home"},
                ["Wind Trainer"] = {36592.2484425, "Wind Trainer"},
                ["Dangerous Woods"] = {36621.7353394, "Dangerous Woods"},
                ["Slasher Demon"] = {36654.390417999995, "Slasher Demon"},
                ["Dungeon"] = {36673.498631099996, "Dungeon"},
            }
            
            local selectedPlace = "Kiribating Village"
            
            local placeNames = {}
            for placeName, _ in pairs(teleportOptions) do
                table.insert(placeNames, placeName)
            end
            
            local TeleportPlace = Teleport:CreateDropdown({
                Name = "Select Place",
                Options = placeNames,
                CurrentOption = {"Kiribating Village"},
                MultipleOptions = false,
                Flag = "TeleportPlaceDropDown",
                Callback = function(Option)
                    selectedPlace = Option[1]
                end,
            })
            
                TeleportButton = Teleport:CreateButton({
                Name = "Teleport",
                Callback = function()
                    if not Character then
                        return
                    end
            
                    local teleportData = teleportOptions[selectedPlace]
                    local args = {
                        [1] = "Players.Kekkai_Sensen11.PlayerGui.Npc_Dialogue.Guis.ScreenGui.LocalScript",
                        [2] = teleportData[1],
                        [3] = teleportData[2],
                    }
                    ReplicatedStorage:WaitForChild("teleport_player_to_location_for_map_tang"):InvokeServer(unpack(args))
                end,
            })

            stopTeleportButton = Teleport:CreateButton({
                Name = "Stop Teleporting [Tween Teleport Only]",
                Callback = function ()
                    stopTweenTeleport()
                end
            })

            local TeleportNPC = Teleport:CreateSection("Other Teleport")
            local TesterPlace = Teleport:CreateButton({
                Name = "Teleport to Tester Place",
                Callback = function ()
                    TeleportTween(CFrame.new(180.705414, 3.07499981, 166.806946, 0.997751355, 1.47003384e-12, -0.0670237914, -1.63727896e-12, 1, -2.44037993e-12, 0.0670237914, 2.544629e-12, 0.997751355))
                end
            })

            -- [NPC Teleport]
            local TeleportNPC = Teleport:CreateSection("Teleport NPC")

            local muzanTeleport = Teleport:CreateButton({
                Name = "Teleport to Muzan",
                Callback = function()
                    if not _workspace:FindFirstChild("Muzan") then
                        return
                    end
            
                    TeleportTween(CFrame.new(_workspace.Muzan.SpawnPos.Value))
                end
            })
            
            
            local doctorTeleport = Teleport:CreateButton({
                Name = "Teleport to Doctor Higoshima",
                Callback = function ()
                    TeleportTween(CFrame.new(525.875, 321.917603, -2304.84766, -0.655203104, 0, 0.755452693, 0, 1, 0, -0.755452693, 0, -0.655203104))
                end
            })

            local ServerSection = Teleport:CreateSection("Server Options")
            
            joinMainMenu= Teleport:CreateButton({
                Name = "Join Main Menu",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(5956785391, LocalPlayer)
                end,
            })
            joinMap1 = Teleport:CreateButton({
                Name = "Join Map 1",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(6152116144, LocalPlayer)
                end,
            })
            joinMap2 = Teleport:CreateButton({
                Name = "Join Map 2",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(13881804983, LocalPlayer)
                end,
            })
            joinHub = Teleport:CreateButton({
                Name = "Join HUB",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(9321822839, LocalPlayer)
                end
            })
            rejoinServer = Teleport:CreateButton({
                Name = "Rejoin Server",
                Callback = function ()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
                end,
            })

        -- [GUI SETTINGS]
        local Settings = Window:CreateTab("Settings")
        local SettingsSection = Settings:CreateSection("Settings")
        
            DestroyGuiButton = Settings:CreateButton({
            Name = "Destroy GUI",
            Callback = function()
                -- The function that takes place when the button is pressed
                Rayfield:Destroy()
            end,
        })
        
        local FOV = Settings:CreateSlider({
            Name = "Field Of View",
            Range = {0, 120},
            Increment = 10,
            Suffix = "FOV",
            CurrentValue = 70,
            Flag = "FOVSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
            -- The function that takes place when the slider changes
            -- The variable (Value) is a number which correlates to the value the slider is currently at
            _workspace.Camera.FieldOfView = (Value)
            end,
        })
    end
