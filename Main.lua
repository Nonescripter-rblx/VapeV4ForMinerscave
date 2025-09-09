local gameremotes = game.ReplicatedStorage.GameRemotes
local Demo = gameremotes:FindFirstChild("Demo") or game.Workspace:FindFirstChild("Demo")
local DupeModeVal = 'Selected'
local strafeRange
local run = function(func)
    func()
end
local Players = game:GetService("Players")
local player = game:GetService("Players").LocalPlayer
local slot = player.PlayerGui.HUDGui.Inventory.Slots:FindFirstChild("Slot-1")
local moveitems = gameremotes:FindFirstChild("MoveItem") or gameremotes:FindFirstChild("MoveItems")
local fluidFolder = Workspace:FindFirstChild("Fluid")


shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()
vape.Place = 'Minecrap'
loadfile('newvape/games/Universal.lua')()

local function notif(...)
    return vape:CreateNotification(...)
end

notif('From Nonescripter', 'I\'m sorry, i was lazy to add much module.')

local NoFall = vape.Categories.Blatant:CreateModule({
    Name = 'NoFall',
    Function = function(callback)
        if callback then
            if Demo.Parent == gameremotes then Demo.Parent = game.Workspace
            else Demo.Parent = game.Workspace end
        else 
            if Demo.Parent == gameremotes then Demo.Parent = game.Workspace
            else Demo.Parent = game.Workspace end
        end
    end,
    ExtraText = function() return 'NoRemote' end,
    Tooltip = 'Removes fall damage.'
})

local Dupe = vape.Categories.Inventory:CreateModule({
    Name = 'Dupe (Broken BTW)',
    Function = function(callback)
        if callback then
            if DupeModeVal == 'Selected' then
                local b = slot.SlotNA.Count
                local bCount = tonumber(b.Text)
                if not bCount then
                    return
                end
                     
                if bCount == 64 then
                    return
                end
    
                local howmuch = 64 - bCount
                local usetables = false
                
                local success, err = pcall(function()
                    if usetables then
                        moveitems:InvokeServer({[1] = -1, [2] = 82, [3] = true, [4] = -howmuch})
                    else
                        moveitems:InvokeServer(-1, 82, true, -howmuch)
                    end
                end)
                notif('Dupe', 'Duped item using ' .. DupeModeVal .. ' method.', 3)
            end
        end
    end,
    ExtraText = function() return DupeModeVal end,
    Tooltip = 'Dupe items.'
})

DupeMode = Dupe:CreateDropdown({
    Name = 'Method',
    List = {'Selected', ':)'},
    Function = function(val)
        DupeModeVal = val
        if val == 'Selected' then notif('Dupe', 'Open chest, Select item and enable dupe', 6) end
    end,
    Tooltip = 'Method of duping.'
})

local FastBreak = vape.Categories.World:CreateModule({
    Name = 'FastBreak',
    Function = function(callback)
        while callback do
            gameremotes.AcceptBreakBlock:InvokeServer()
            task.wait()
        end
    end,
    ExtraText = function() return 'RemoteSpam' end,
    Tooltip = 'Break blocks fast if you have right tool.'
})

vape:Init()