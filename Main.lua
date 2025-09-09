local gameremotes = game.ReplicatedStorage.GameRemotes
local Demo = gameremotes:FindFirstChild("Demo") or game.Workspace:FindFirstChild("Demo")
local DupeModeVal

shared.VapeIndependent = true
local vape = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))()
vape.Place = 'Minecrap'
loadfile('newvape/games/Universal.lua')()

local NoFall = vape.Categories.Blatant:CreateModule({
    Name = 'NoFall',
    Function = function(callback)
        if callback then Demo.Parent = game.Workspace
        else Demo.Parent = gameremotes end
        print(callback)
    end,
    Tooltip = 'Removes fall damage.'
})

local Dupe = vape.Categories.Inventory:CreateModule({
    Name = 'Dupe',
    Function = function(callback)
        if callback then
            print("yea it got enabled and method is " .. DupeModeVal)
            Dupe:Toggle()
        end
    end,
    Tooltip = 'Dupe items with chest.'
})

DupeMode = Dupe:CreateDropdown({
    Name = 'Method',
    List = {'Chest', 'whatever'},
    Function = function(val)
        DupeModeVal = val
    end,
    Tooltip = 'Method of duping.'
})

vape:Init()
