-- why there's whole fucking error with entitylib

shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()
local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("GameRemotes")
loadfile('newvape/games/Universal.lua')()
local lol = function(code)
    code()
end
vape.Place = 'Minecrap'



vape:CreateNotification('From Nonescripter', 'I\'m sorry, i was lazy to add much module.', 20) -- :P

-- Remove Some Broken Modules
vape:Remove('SilentAim')
vape:Remove('AutoClicker')
vape:Remove('TriggerBot')
vape:Remove('MurderMystery')
vape:Remove('Reach')
vape:Remove('Invisible')
vape:Remove('Swim')
vape:Remove('AntiFall')
vape:Remove('AutoRejoin')
vape:Remove('AntiRagdoll')
vape:Remove('Disabler')
vape:Remove('StaffDetector')
vape:Remove('PlayerModel')
vape:Remove('Killaura')
-- End


-- NoFall module
lol(function()
    local FDH = game:GetService("ReplicatedStorage"):FindFirstChild("GameRemotes"):FindFirstChild("Demo") or game:GetService("Workspace"):FindFirstChild("Demo")

    local NoFall = vape.Categories.Blatant:CreateModule({
        Name = 'NoFall',
        Function = function(callback)
            if callback then -- enabled
                if FDH.Parent == Remotes then FDH.Parent = game:GetService("Workspace") end
            else -- disabled
                if FDH.Parent == game:GetService("Workspace") then FDH.Parent = Remotes end
            end
        end,
        ExtraText = function() return 'Minecraft' end,
        Tooltip = 'Removes fall damage.'
    })
end)


-- Dupe Module
lol(function()
    local Count = 64
    local Method = 'Chest'
    local Selected = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HUDGui").Inventory.Slots:FindFirstChild("Slot-1")
    local Move = Remotes:FindFirstChild("MoveItem") or Remotes:FindFirstChild("MoveItems")

    local Dupe = vape.Categories.Inventory:CreateModule({
        Name = 'Dupe (Broken btw)',
        Function = function(callback)
            if callback then -- enabled
                if Method == 'Chest' then
                    local Target = Selected.SlotNA.Count
                    local CurrentCount = tonumber(Target.Text)

                    if not CurrentCount or CurrentCount <= Count then -- Not selected or full
                        return
                    end
                    
                    local done, err = pcall(function()
                        Move:InvokeServer({
                            [1] = -1,
                            [2] = 82,
                            [3] = true,
                            [4] = -(CurrentCount - Count)
                        })
                    end)
                    vape:CreateNotification('Dupe', 'Duped item using ' .. DupeModeVal .. ' method.', 3)
                    Dupe:Toggle()
                end
            end
        end,
        ExtraText = function() return Method end,
        Tooltip = 'Dupe items.'
    })

    DupeMethod = Dupe:CreateDropdown({
        Name = 'Method',
        List = {'Chest'},
        Function = function(val)
            Method = val
            if val == 'Chest' then notif('Dupe', 'Open chest, Select item and enable dupe', 6) end
        end,
        Tooltip = 'Method of duping.'
    })

    CountSlider = Dupe:CreateSlider({
        Name = 'Dupe Count',
        Min = 1,
        Max = 64,
        Function = function(val)
            Count = val
        end,
        Tooltip = 'Amount of dupe'
    })
    
    CountSlider:SetValue(64)
end)


-- FastBreak
lol(function()
    local FastBreak = vape.Categories.World:CreateModule({
        Name = 'FastBreak',
        Function = function(callback)
            while callback do -- enabled
                game:GetService('ReplicatedStorage'):FindFirstChild('GameRemotes').AcceptBreakBlock:InvokeServer()
                task.wait()
            end
        end,
        ExtraText = function() return 'Minecraft' end,
        Tooltip = 'Break blocks fast if you have right tool.'
    })
end)


-- KillAura
lol(function()
    local Attack = game:GetService('ReplicatedStorage'):FindFirstChild('GameRemotes').Attack
    local LocalPlayer = game:GetService('Players').LocalPlayer
    local Players = game:GetService('Players')
    local SearchDistance = 16
    local status = 'Waiting'
    local Target
    local Method = 'Health'
    local KillAura

    local function GetHealthTarget()
        local Lowest = math.huge
        local CurrentTarget = nil
        local LocalRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

        if not LocalRoot then return nil end

        for _, Search in ipairs(Players:GetPlayers()) do
            if Search ~= LocalPlayer and Search.Character then -- if target isn't localplayer and target is alive
                local SearchRoot = Search.Character:FindFirstChild("HumanoidRootPart")
                local SearchHumanoid = Search.Character:FindFirstChild("Humanoid")
                
                if SearchHumanoid and SearchRoot and SearchHumanoid.Health > 0 then
                    local Distance = (SearchRoot.Position - LocalRoot.Position).Magnitude

                    if Distance <= SearchDistance and SearchHumanoid.Health < Lowest then
                        Lowest = SearchHumanoid.Health
                        CurrentTarget = Search
                    end
                end
            end
        end
        
        return CurrentTarget
    end

    local function GetDistanceTarget()
        local Closest = math.huge
        local CurrentTarget = nil
        local LocalRoot = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')

        if not LocalRoot then return nil end

        for _, Search in ipairs(Players:GetPlayers()) do
            if Search ~= LocalPlayer and Search.Character then -- if target isn't localplayer and target is alive
                local SearchRoot = Search.Character:FindFirstChild("HumanoidRootPart")
                local SearchHumanoid = Search.Character:FindFirstChild("Humanoid")
                
                if SearchHumanoid and SearchRoot and SearchHumanoid.Health > 0 then
                    local Distance = (SearchRoot.Position - LocalRoot.Position).Magnitude

                    if Distance <= SearchDistance and Distance < Closest then
                        Closest = Distance
                        CurrentTarget = Search
                    end
                end
            end
        end
        
        return CurrentTarget
    end

    KillAura = vape.Categories.Blatant:CreateModule({
        Name = 'KillAura',
        Function = function(callback)
            while KillAura.Enabled do
                if Method == 'Health' then Target = GetHealthTarget()
                elseif Method == 'Distance' then Target = GetDistanceTarget() end

                if Target and Target.Character then
                    local Root = Target.Character:FindFirstChild('HumanoidRootPart')
                    if Root and LocalPlayer:DistanceFromCharacter(Root.Position) <= SearchDistance then
                        Attack:InvokeServer(Target.Character)
                    end
                end
                task.wait(0.3)
            end
        end,
        ExtraText = function() return Method end,
        Tooltip = 'Attack Enemy Without hitting them.'
    })

    RangeSlider = KillAura:CreateSlider({
        Name = 'Range',
        Min = 0,
        Max = 16,
        Function = function(val)
            SearchDistance = val
        end,
        Suffix = function(val)
            return val == 1 and 'stud' or 'studs'
        end,
        Tooltip = 'Range to Attack'
    })

    RangeSlider:SetValue(16)

    dropdown = KillAura:CreateDropdown({
        Name = 'Target',
        List = {'Health', 'Distance'},
        Function = function(val)
            Method = val
        end,
        Tooltip = 'Target to Attack'
    })
end)

vape:Init()
