local gameremotes = game.ReplicatedStorage.GameRemotes
local Demo = gameremotes:FindFirstChild("Demo") or game.Workspace:FindFirstChild("Demo")
local DupeModeVal = 'Selected'
local player = game:GetService("Players").LocalPlayer
local Sel = player.PlayerGui.HUDGui.Inventory.Slots:FindFirstChild("Slot-1")

shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()
vape.Place = 'Minecrap'
loadfile('newvape/games/Universal.lua')()

local function notif(...)
    return vape:CreateNotification(...)
end

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
    Tooltip = 'Removes fall damage.'
})

local Dupe = vape.Categories.Inventory:CreateModule({
    Name = 'Dupe (WIP)',
    Function = function(callback)
        if callback then
            if DupeModeVal == 'Selected' then
                local b = Sel.SlotNA.Count
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
            end
            if err <= 1 then notif('Dupe', 'Error.', 3, 'Warning')
            else notif('Dupe', 'Duped item using ' .. DupeModeVal .. ' method.', 3) end
        end
    end,
    Tooltip = 'Dupe items.'
})

DupeMode = Dupe:CreateDropdown({
    Name = 'Method',
    List = {'Selected', ':)'},
    Function = function(val)
        DupeModeVal = val
        if val == 'Selected' then
            notif('Dupe', 'Open chest, Select item and enable dupe', 6)
    end,
    Tooltip = 'Method of duping.'
})

vape:Init()

-- i tried my best ahh