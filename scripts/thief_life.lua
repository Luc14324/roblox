--[[
nick7 hub | THIEF LIFE Simulator ( github.com/nick7-hub/roblox/ )
by Stonifam
]]

--- DEBUG ---

PROD = true -- true: no debug mode

local function dbg(data:any)
    if not PROD then
        print(`[debug n7] {data}`)
    end
end

--- VARIABLES ---
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--- HANDLE INCORRECT SESSION ---

local crash = false
xpcall(function() -- Protect from crashing on getgenv()
    if game.PlaceId ~= 2693739238 and not getgenv().forceLoadN7 then
        warn('[nick7 hub] Wrong game to load this script')
        crash = true
        return true
    end

    if (getfenv().n7.loaded or getgenv().n7.loaded) and not getgenv().forceLoadN7 then -- Defined with getgenv().n7
        warn('[nick7 hub] nick7 hub is already loaded!')
        crash = true
        return true
    end
end, function(a,b)
    if not b then
        if game.PlaceId ~= 2693739238 then
            warn('[nick7 hub] Wrong game to load this script')
            crash = true
        elseif not (getfenv().getgenv or getgenv) then
            warn("[nick7 hub] Can't check if nick7 is loaded or not.")
            crash = true
        end
    end
end)

if crash then
    return
end

--- EVENTS VARIABLE ---

local Events = ReplicatedStorage.Events

--- FUNCTIONS ---

local function bool(value:any):boolean
    return not not value
end

local function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

local function comma(Value)
    return tostring(Value):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function void()end

local function getChar(player)
    player = player or Player
    return player.Character or player.CharacterAdded:Wait()
end

local function getRoot(player)
    player = player or Player
    return getChar():WaitForChild('HumanoidRootPart')
end

local function getHumanoid(player)
    player = player or Player
    return getChar():WaitForChild('Humanoid')
end

local function dump(t, name, indent, seen)
    name, indent, seen = name or "root", indent or "", seen or {}
    local result = ""

    local T = type(t)
    if T ~= "table" then
        result = result .. indent .. name .. " = " .. ((T == "string") and ("%q"):format(t) or tostring(t)) .. " (" .. T .. ")\n"
        return result
    end

    if seen[t] then
        result = result .. indent .. name .. " = *circular*\n"
        return result
    end
    seen[t] = true

    result = result .. indent .. name .. " = {\n"
    local pad = indent .. "  "
    for k, v in pairs(t) do
        result = result .. dump(v, "[" .. (type(k) == "string" and ("%q"):format(k) or tostring(k)) .. "]", pad, seen)
    end
    result = result .. indent .. "}\n"
    
    return result
end

local function rejoin()
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nRejoining...")
        task.wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

--- g VARIABLE ---

local defaults = {
    BlurEvent = missing('userdata', Player.PlayerGui.Blur) or missing('userdata', Player.PlayerGui.BlurN7),
    Target = nil,
    crash = false, -- related to: Targeting -> Action (Once) -> "CRASH SERVER"
    Targeting = {
        Trade = { Enabled = false },
        Club = { Enabled = false },
        Kill = { Enabled = false }
    },
    FixCamera = {
        Enabled = false
    },
    Farms = {
        XP = {
            Enabled = false,
            Laggy = true,
            Iterations = 10
        },
        Money = {
            FarmWith = 'RareM4A1',
            Enabled = false
        }
    }
}

local g
if missing('function', getgenv) then
    g = getgenv()
else
    warn("Can't find getgenv! Using local variable, will lead to unpredictable behavior")
    g = {}
end

g.n7 = defaults

--- SAFE BLUR ---

if not g.n7.BlurEvent then
    warn("(nick7 hub) FAILED TO FIND BLUR EVENT!!!\nREJOIN TO FIX IT\n\nIf rejoining didn't helped you, contact us\nhttps://discord.gg/NGAaby4y4b")
end

--- ANTI-AFK ---

local info
do
    local a,b = pcall(function()
        local GC = getconnections or get_signal_cons
        for _,v in pairs(GC(Players.LocalPlayer.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
            elseif v["Disconnect"] then
                v["Disconnect"](v)
            end
        end
        return true
    end)

    info = {
        ['SuccessfulAAFK'] = bool(a and b)
    }
end

--- WAIT ---

if not game:IsLoaded() then game.Loaded:Wait() end

--- REGUI ---

local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()

--- REGUI THEMES ---

Themes = loadstring(game:HttpGet('https://gist.githubusercontent.com/WhateverNick7/818c6873f0e5cc2f107abd5c1d347387/raw/d2519b02ae7830642ceb7ef18f8b1be21725440d/ReGuiThemes.lua'))()
Themes(ReGui)

--- WINDOW ---

local Window = ReGui:TabsWindow({
    Title = "nick7 hub | THIEF LIFE Simulator",
    Size = UDim2.fromOffset(425, 300),
    NoClose = true
})
Window:Center()

local Tabs = {
    Farm = Window:CreateTab({ Name = 'Farm' }),
    Player = Window:CreateTab({ Name = 'Player' }),
    Club = Window:CreateTab({ Name = 'Club' }),
    Targeting = Window:CreateTab({ Name = 'Targeting' }),
    Teleports = Window:CreateTab({ Name = 'Teleports' }),
    Settings = Window:CreateTab({ Name = 'Settings' }),
    Credits = Window:CreateTab({ Name = 'Credits' })
}

--- FARM ---

Tabs.Farm:Separator({ Text = 'Inventory' })

local FarmRow = Tabs.Farm:Row()

FarmRow:Button({
    Text = 'Sell every sellable',
    Callback = function()
        Events.Shop.RequestSellAll:FireServer(-1)
    end
})

local MAX_BACKPACK_SIZE = 50 -- REPLACE 50 TO MAX SIZE BACKPACK AVAILABLE IF GAME GETS AN UPDATE

FarmRow:Button({
    Text = 'Sell everything',
    Callback = function()
        for _=0,MAX_BACKPACK_SIZE do
            Events.Shop.RequestSellItem:FireServer(1)
        end
    end
})

Tabs.Farm:Separator({ Text = 'XP' })

local XPRow = Tabs.Farm:Row({ Spacing = 10 })

XPRow:Checkbox({ -- shitty code, but works.. for some reason
    Label = 'XP Farm',
    Value = g.n7.Farms.XP.Enabled,
    Callback = function(self, Value)
        g.n7.Farms.XP.Enabled = Value
        if Value then
            local pre_edit = g.n7.BlurEvent.Name
            g.n7.BlurEvent.Name = `{g.n7.BlurEvent.Name}N7`
            -- Player.PlayerGui.LevelUp.Enabled = false
            Player.PlayerGui.LootGUI.LootWindow.LootRecieved.Enabled = false -- unfinished code in prod yippee
            while g.n7 and g.n7.Farms.XP.Enabled do
                if g.n7.Farms.XP.Laggy then
                    for _=0,g.n7.Farms.XP.Iterations do
                        Events.Loot.RequestLoot:FireServer(500)
                    end
                else
                    Events.Loot.RequestLoot:FireServer(500)
                end
                task.wait()
            end
            task.wait(0.5)
            Player.PlayerGui.LootGUI.LootWindow.LootRecieved.Enabled = true
            g.n7.BlurEvent.Name = pre_edit
        end
    end
})

XPRow:Checkbox({
    Label = 'Fast',
    Value = g.n7.Farms.XP.Laggy,
    Callback = function(self, Value)
        g.n7.Farms.XP.Laggy = Value
    end
})

Tabs.Farm:Separator({ Text = 'Money' })

local RecentInventoryData = {UpdateID = 0, Data = {}}

local SendLoot = Events.Loot.SendLoot

local Connections = {
    SendLoot.OnClientEvent:Connect(function(_,data)
        table.insert(RecentInventoryData.Data, data)
        RecentInventoryData.UpdateID += 1
    end)
}

Tabs.Farm:Button({
    Text = 'Get starter money',
    Callback = function()
        local data
        local successful_ID
        for i=402,502 do
            Events.Loot.RequestLoot:FireServer(i)
            local _,_data = SendLoot.OnClientEvent:Wait()
            dbg(#_data)
            dbg()
            if #_data > 0 then
                successful_ID = i
                data = _data
                break
            end
        end

        if successful_ID then
            for _,v in ipairs(data) do
                Events.Loot.RequestPickUp:FireServer(v.ID)
                task.wait(0.5)
            end
            Events.Shop.RequestSellAll:FireServer(-1)
        else
            dbg('failed to find successful id')
        end
    end
})

Tabs.Farm:Checkbox({
    Label = 'Farm money',
    Value = g.n7.Farms.Money.Enabled,
    Callback = function(self, Value)
        g.n7.Farms.Money.Enabled = Value
        if Value then
            -- setup
            for _=0,MAX_BACKPACK_SIZE do
                Events.Shop.RequestSellItem:FireServer(1)
            end

            while g.n7 and g.n7.Farms.Money.Enabled do
                Events.GunShop.RequestBuy:FireServer(g.n7.Farms.Money.FarmWith)
                Events.Shop.RequestSellItem:FireServer(1)

                task.wait()
            end
        end
    end
})

local MoneyFarm = {
    {
        Display = '#1 (Costs: $100 / Value: $250)',
        Backend = 'VIPGlock17'
    },
    {
        Display = '#2 (Costs: $100 / Value: $35k)',
        Backend = 'VIPAK47'
    },
    {
        Display = '#3 (Costs: $95k / Value: $400k)',
        Backend = 'RareM4A1',
        Default = true
    }
}

local MoneyFarmDisplay = {}
local MoneyFarmDefault

for _,v in ipairs(MoneyFarm) do
    table.insert(MoneyFarmDisplay, v.Display)

    if v.Default then
        MoneyFarmDefault = v.Display
        g.n7.Farms.Money.FarmWith = v.Backend
    end
end

do
    local indent = Tabs.Farm:Indent({ Offset = 23 })
    local row = indent:Row({ Spacing = 3 })

    row:Label({ Text = 'Farm with' })

    row:Combo({
        Label = '',
        Selected = MoneyFarmDefault,
        Items = MoneyFarmDisplay,
        Callback = function(self, Name)
            for _,v in ipairs(MoneyFarm) do
                if v.Display == Name then
                    g.n7.Farms.Money.FarmWith = v.Backend
                end
            end
        end,
    })
end

--- PLAYER ---

Tabs.Player:Separator({ Text = 'General' })

Tabs.Player:SliderInt({
    Label = 'WalkSpeed',
    Value = getHumanoid().WalkSpeed,
    Minimum = 0,
    Maximum = 300,
    Callback = function(self, Value)
        getHumanoid().WalkSpeed = Value
    end
})

Tabs.Player:SliderInt({
    Label = 'JumpPower',
    Value = getHumanoid().JumpPower,
    Minimum = 0,
    Maximum = 300,
    Callback = function(self, Value)
        getHumanoid().JumpPower = Value
    end
})

Tabs.Player:Checkbox({
    Label = 'Fix camera zoom',
    Value = g.n7.FixCamera.Enabled,
    Callback = function(self, Value)
        g.n7.FixCamera.Enabled = Value
        task.spawn(function()
            while g.n7 and g.n7.FixCamera.Enabled do
                Player.CameraMinZoomDistance = 0.5
                Player.CameraMaxZoomDistance = 100000
                RunService.RenderStepped:Wait()
            end
        end)
    end
})

Tabs.Player:Separator({ Text = 'Equipment' })

Tabs.Player:Button({
    Text = 'Buy best ($183,000)',
    Callback = function()
        Events.BackpackShop.RequestBuy:FireServer("Backpack9")
        Events.Toolshop.RequestBuy:FireServer("Plasmacutter","Tools")
        Events.Toolshop.RequestBuy:FireServer("Automaticpicklock", "Picklocks")
        Events.Toolshop.RequestBuy:FireServer("Hackingdevice", "Electricaltools")
        Events.Toolshop.RequestBuy:FireServer("Stethoscope", "Safetools")
        Events.PetShop.RequestBuy:FireServer("Bulldog")
    end
})

Tabs.Player:Button({
    Text = 'Buy best armor ($515,000)',
    Callback = function()
        Events.ArmourShop.RequestBuy:FireServer("HeavyBodyArmour3")
    end
})

do -- Weapon
    local weapons = {}

    for _,v in ipairs(ReplicatedStorage.Weapons:GetChildren()) do
        table.insert(weapons, {
            Name = v.Name,
            Cost = v.Cost.Value,
            Damage = v.Damage.Value
        })
    end

    table.sort(weapons, function(a, b) return a.Cost < b.Cost end)

    local backend = {}
    local display = {}

    for _,v in ipairs(weapons) do
        local text = `{v.Name} (${comma(v.Cost)}) {v.Damage}DMG`
        table.insert(backend, {Display = text, Backend = v.Name})
        table.insert(display, text)
    end

    local SelectedWeapon = nil

    Tabs.Player:Combo({
        Label = 'Select weapon',
        Items = display,
        Callback = function(self, Value)
            for _,v in ipairs(backend) do
                if Value == v.Display then
                    SelectedWeapon = v.Backend
                end
            end
        end
    })

    Tabs.Player:Button({
        Text = 'Buy weapon',
        Callback = function()
            Events.GunShop.RequestBuy:FireServer(SelectedWeapon)
        end
    })
end

Tabs.Player:Separator({ Text = 'World' })

Tabs.Player:Button({
    Text = 'Unlock all zones',
    Callback = function()
        for i=1,6 do
            Events.Access.RequestBuyAccess:FireServer(i)
        end
    end
})

do
    local function VIP (toggle)
        for _,v in ipairs(workspace.Camera.AccessWalls.VIP:GetChildren()) do
            if v:IsA('BasePart') then
                v.CanCollide = not toggle
                if v.Name == 'VIPONLY' then
                    pcall(function()
                        v.SurfaceGui.ImageLabel.Image = toggle and 'rbxassetid://5205790785' --[["nick7 hub" cat]] or 'rbxassetid://2701433023' --[[Default image]]
                        local count = 0
                        for _,x:TextLabel in ipairs(v.SurfaceGui:GetChildren()) do
                            if x:IsA('TextLabel') then
                                count += 1
                                if count == 1 then
                                    x.Text = toggle and 'nick7 hub :3' or 'LOCKED'
                                elseif count == 2 then
                                    x.Text = toggle and 'for you (& VIP)' or 'VIP USERS'
                                end
                            end
                        end
                    end)
                end
            end
        end
    end

    Tabs.Player:Checkbox({
        Label = 'Unlock VIP',
        Value = true,
        Callback = function(self, Value)
            VIP(Value)
        end
    })
end

--- CLUB ---

Tabs.Club:Button({
    Text = 'Leave club',
    Callback = function()
        Events.Guild.LeaveGuild:FireServer()
    end
})

Tabs.Club:Separator({ Text = 'Creation' })

do
    local ClubData = {
        Name = 'cool name',
        Color = Color3.fromRGB(157, 96, 255),
        Icon = 'rbxassetid://5205790785',
        Description = 'cool description'
    }

    Tabs.Club:InputTextMultiline({
        Label = 'Name',
        Value = ClubData.Name,
        Callback = function(self, Value)
            ClubData.Name = Value
        end
    })

    Tabs.Club:SliderColor3({
        Label = 'Color',
        Value = ClubData.Color,
        Callback = function(self, Value)
            ClubData.Color = Value
        end
    })

    local icon = Tabs.Club:InputInt({
        Label = 'Icon',
        Value = string.match(ClubData.Icon, '%d+')
    })

    Tabs.Club:InputTextMultiline({
        Label = 'Description',
        Value = ClubData.Description,
        Callback = function(self, Value)
            ClubData.Description = Value
        end
    })

    local row = Tabs.Club:Row()
    row:Label({ Text = 'Icon preview:' })
    local image = row:Image({ Size = UDim2.fromOffset(30,30) })

    icon.Callback = function(self, Value)
        ClubData.Icon = 'rbxassetid://'..Value
        image.Image = 'rbxassetid://'..Value
    end

    task.spawn(function()
        task.wait()
        image.Image = ClubData.Icon
    end)

    Tabs.Club:Button({
        Text = 'Create club',
        Callback = function()
            Events.Guild.SendCreateGuild:FireServer(
                ClubData.Name,
                ClubData.Color,
                ClubData.Icon,
                ClubData.Description
            )
        end
    })
end

--[[
{
    "", -- Club name
    { -- Club color / RGB / Color3.new .R .G .B
        R = 0.8156863451004028,
        G = 0.14901961386203766,
        B = 0.6705882549285889
    },
    "rbxassetid://2999066695", -- Club icon
    "" -- Club description
}
]]

--- TARGETING ---

local SearchBy = 1

Tabs.Targeting:Separator({ Text = 'Selection' })

do
    Tabs.Targeting:Label({ Text = [[Type "all" to target entire server
You can write incomplete nickname to select a player]]})

    local row = Tabs.Targeting:Row()

    row:Label({ Text = 'Search by' })

    local ByDisplay = row:Radiobox({ Label = 'Display name', Value = true })
    local ByUser = row:Radiobox({ Label = 'Username' })

    ByDisplay.Callback = function(self, Value)
        local prev = ByUser.Callback
        ByUser.Callback = void
        ByUser:SetValue(not Value)
        ByUser.Callback = prev
        SearchBy = 1
    end

    ByUser.Callback = function(self, Value)
        local prev = ByDisplay.Callback
        ByDisplay.Callback = void
        ByDisplay:SetValue(not Value)
        ByDisplay.Callback = prev
        SearchBy = 2
    end
end

do
    local function selectPlayer(search:string):Player
        local low_search = string.lower(search)
        if not low_search or #low_search == 0 then
            return 'none'
        elseif string.lower(low_search) == 'all' then
            return 'all'
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Player then
                    local target = string.lower(SearchBy == 1 and player.DisplayName or player.Name)
                    if string.sub(target, 1, #low_search) == low_search then
                        return player
                    end
                end
            end
        end
        return 'ftf'
    end


    local label_template = 'Selected: %s'
    local input = Tabs.Targeting:InputText({Label = "Target",Value = ""})
    local label = Tabs.Targeting:Label({ Text = string.format(label_template, g.n7.Target or '<none>') })

    input.Callback = function(self, Value)
        local result = selectPlayer(Value)

        if result == 'all' then
            g.n7.Target = 'all'
            label.Text = string.format(label_template, '<all>')
        elseif result == 'none' then
            g.n7.Target = nil
            label.Text = string.format(label_template, '<none>')
        elseif type(result) ~= "userdata" then
            g.n7.Target = nil
            label.Text = string.format(label_template, "<can't find / error>")
        else
            if result:IsA('Player') then
                g.n7.Target = result

                if result.DisplayName == result.Name then
                    label.Text = string.format(label_template, result.Name)
                else
                    label.Text = string.format(label_template, `{result.Name} | {result.DisplayName}`)
                end
            end
        end
    end
end

do
    local funcs = {
        trade = function(player:Player)
            if missing('userdata', player) and player:IsA('Player') then
                Events.Trade.AcceptTrade:FireServer(player.UserId)
            end
        end,
        club = function(player:Player)
            if missing('userdata', player) and player:IsA('Player') then
                Events.Guild.SendInvite:FireServer(player)
                Events.Guild.RequestChangeTitle:FireServer({["ID"] = player.UserId, ["Name"] = player, ["Status"] = "Requests"}, "Member")
            end
        end,
        kill = function(player:Player)
            local tries = 0
            local tries_limit = 70
            if missing('userdata', player) and player:IsA('Player') then
                local char = getChar(player)
                repeat
                    Events.Weapon.RequestHit:FireServer(char)
                    tries += 1
                    dbg(`char:{char} health: {char.Humanoid.Health}`)
                    RunService.RenderStepped:Wait()
                until not char or char.Humanoid.Health <= 0 or tries >= tries_limit
            end
        end
    }

    Tabs.Targeting:Separator({ Text = 'Action (Once)' })

    local ReadItAll = false
    Tabs.Targeting:Button({ -- if you gonna steal it, at least credit me.
        Text = 'CRASH SERVER',
        Callback = function()
            if g.n7.crash then return end
            ReadItAll = false
            local modal = Window:PopupModal({ Title = 'nick7 hub | INFO' })
            modal:Label({
                Text =
[[DOES: Break current save & will rollback to previous save
DOES NOT: Shutdown the server

This feature will leave your current club.
Returning in that same club without an invite and
just keeping same save data is not guaranteed.

After you will proceed to server crashing, your player will:
1) Create a club
2) Invite WHOLE server to it
3) REJOIN
And server will be crashed.]],
                TextWrapped = true
            })
            modal:Separator()
            modal:Checkbox({
                Label = 'I read it all and understood.',
                Callback = function(self, Value)
                    ReadItAll = true
                end
            })
            local row = modal:Row({Expanded = true})
            row:Button({
                Text = 'Proceed',
                Callback = function()
                    if ReadItAll then
                        modal:ClosePopup()
                        g.n7.crash = true
                        print('[nick7 hub] status: leaving current club')
                        Events.Guild.LeaveGuild:FireServer()
                        print('[nick7 hub] status: creating a club')

                        local funny_patterns = {
                            function():string
                                return `hello, how are you, {math.random(0,1000000)}?\nnick7`
                            end,
                            function():string
                                return `order #{math.random(1,1000)}\nfrom: nick7`
                            end,
                            function():string
                                return `sponsored by {Players:GetPlayers()[math.random(1,#Players:GetPlayers())].Name}\nmade with nick7`
                            end,
                            function():string
                                local length = math.random(3,20)
                                local str = ''
                                local function hi()
                                    return math.random(1,2) == 1 and 'hi' or 'hello'
                                end
                                for _=1,length do
                                    str = str .. hi() .. '\n'
                                end
                                return str
                            end,
                            function():string
                                local length = math.random(5,60)
                                local array = {}
                                for i = 1, length do
                                    array[i] = string.char(math.random(32, 126))
                                end
                                return table.concat(array)
                            end
                        }

                        local GotAnswer = false

                        local function CreateClub()
                            local function random_name():string
                                return funny_patterns[math.random(1,#funny_patterns)]()
                            end

                            local name = random_name()
                            Events.Guild.SendCreateGuild:FireServer( name, Color3.fromRGB(157, 96, 255), 'rbxassetid://5205790785', 'hi' )

                            Events.Guild.SendGuildInfo.OnClientEvent:Once(function()
                                GotAnswer = true
                            end)
                            Events.Guild.SendMinimalGuildInfo.OnClientEvent:Once(function()
                                GotAnswer = true
                            end)

                            --repeat task.wait() until GotAnswer or start+2<time()
                        end

                        repeat
                            task.wait()
                            CreateClub()
                        until not g.n7 or GotAnswer

                        if not g.n7 then return end

                        print('[nick7 hub] status: created a club')

                        print('[nick7 hub] status: sending invite to all players')

                        for _,player in ipairs(Players:GetPlayers()) do
                            if player ~= Player then
                                Events.Guild.SendInvite:FireServer(player)
                                Events.Guild.RequestChangeTitle:FireServer({["ID"] = player.UserId, ["Name"] = player, ["Status"] = "Requests"}, "Member")
                            end
                        end

                        print('[nick7 hub] status: rejoining')

                        rejoin()
                    end
                end
            })
            row:Button({
                Text = 'Cancel',
                Callback = function()
                    modal:ClosePopup()
                end
            })
        end
    })

    local function boring(func)
        if type(g.n7.Target) == "string" and g.n7.Target == 'all' then
            for _,player:Player in ipairs(Players:GetPlayers()) do
                if player ~= Player then
                    task.spawn(function()
                        dbg(`func:{func};Player:{player};PlayerType:{type(player)}`)
                        funcs[func](player)
                    end)
                end
            end
        elseif type(g.n7.Target) == "table" then
            for _,player:Player in ipairs(g.n7.Target) do
                if player ~= Player then
                    task.spawn(function()
                        dbg(`func:{func};Player:{player};PlayerType:{type(player)}`)
                        funcs[func](player)
                    end)
                end
            end
        elseif type(g.n7.Target) == "userdata" then
            funcs[func](g.n7.Target)
        end
    end

    Tabs.Targeting:Button({
        Text = 'Force trade',
        Callback = function()
            boring('trade')
        end
    })

    do
        local row = Tabs.Targeting:Row()
        row:Button({
            Text = 'Force club member',
            Callback = function()
                boring('club')
            end
        })
        row:Label({ Text = 'Note: you have to be a president rank to do it' })
    end

    local function Kill(id:string)
        boring('kill')
        ReplicatedStorage.RemoteEvents.unequip:FireServer()
    end
    local KillApproach = {
        cs = function() -- wrote that because I couldn't find an error. works.
            local function check()
                for _,v in ipairs(Player.PlayerGui.ViewBackpack.LootWindow.Backpack:GetChildren()) do
                    if v:IsA('Frame') then
                        if v.IsWeapon.Value then
                            return v.Name
                        end
                    end
                end
            end

            local GunID = check()

            if not GunID then
                Events.Player.RequestViewBackpack:FireServer()
                Events.Player.SendViewBackpack.OnClientEvent:Wait()
                GunID = check()
                
                if not GunID then
                    if tonumber(string.match(Player.leaderstats.Money.Value, '%d+')) >= 100 then
                        Events.GunShop.RequestBuy:FireServer('VIPAK47')
                        Events.Player.RequestViewBackpack:FireServer()
                        Events.Player.SendViewBackpack.OnClientEvent:Wait()
                        GunID = check()
                    else
                        warn('[nick7 hub] not enough money')
                    end
                end
            end

            Events.Weapon.RequestEquip:FireServer(GunID)
            return GunID
        end,

        ss = function() -- better than cs
            ReplicatedStorage.RemoteEvents.unequip:FireServer()

            local function check()
                Events.Player.RequestViewBackpack:FireServer()
                local x:RemoteEvent = Events.Player.SendViewBackpack

                local data = x.OnClientEvent:Wait()

                local _data = {}
                for _, item in ipairs(data) do
                    if item.Type == 'WeaponLoot' then
                        table.insert(_data, item.ID)
                    end
                end

                dbg('check() returning:')
                dbg(dump(_data))

                if #_data == 0 then
                    dbg("returning 0 items (nil)")
                    return nil
                else
                    dbg(`returning >0 items ({#_data}); returning item #{#_data}`)
                    return _data[#_data]
                end
            end

            local GunID = check()
            if not GunID then
                for _=1,5 do
                    GunID = check()
                    dbg(GunID)
                    if GunID then break end
                end
            end

            if not GunID then
                if tonumber(string.match(Player.leaderstats.Money.Value, '%d+')) >= 100 then
                    Events.GunShop.RequestBuy:FireServer('VIPAK47')
                    check()
                else
                    warn('[nick7 hub] not enough money')
                end
            end

            Events.Weapon.RequestEquip:FireServer(GunID)
            return GunID
        end
    }
    Tabs.Targeting:Button({
        Text = 'Kill',
        Callback = function()
            local GunID = KillApproach.ss() -- setup
            Kill(GunID)
        end
    })

    Tabs.Targeting:Separator({ Text = 'Action (Loop)' })

    Tabs.Targeting:Checkbox({
        Label = 'Force trade',
        Value = false,
        Callback = function(self, Value)
            g.n7.Targeting.Trade.Enabled = Value
            if Value then
                while g.n7 and g.n7.Targeting.Trade.Enabled do
                    boring('trade')
                    RunService.RenderStepped:Wait()
                end
            end
        end
    })

    Tabs.Targeting:Checkbox({
        Label = 'Force club member',
        Value = false,
        Callback = function(self, Value)
            g.n7.Targeting.Club.Enabled = Value
            if Value then
                while g.n7 and g.n7.Targeting.Club.Enabled do
                    boring('club')
                    RunService.RenderStepped:Wait()
                end
            end
        end
    })

    Tabs.Targeting:Checkbox({
        Label = 'Kill',
        Value = false,
        Callback = function(self, Value)
            g.n7.Targeting.Kill.Enabled = Value
            if Value then
                local GunID = KillApproach.ss()
                while g.n7 and g.n7.Targeting.Kill.Enabled do
                    Kill(GunID)
                    RunService.RenderStepped:Wait()
                    task.wait(0.5)
                end
            end
        end
    })
end

--- TELEPORTS ---

for _,v in ipairs({
    {
        Category = 'Useful',
        Teleports = {
            {Name = 'Sell It!', Position = Vector3.new(-1356, 19, 9)},
            {Name = 'Underground Tools', Position = Vector3.new(-1388, 5, -20)},
            {Name = 'Exclusive Backpacks!', Position = Vector3.new(-1352, 13, -51)},
            {Name = 'Pet Shop', Position = Vector3.new(-1371, 14, 64)},
            {Name = 'Armour Shop', Position = Vector3.new(-1359, 14, 163)},
            {Name = 'Guns and Ammo', Position = Vector3.new(-1058, 14, 127)},
            {Name = 'Safe', Position = Vector3.new(-1154, 14, -37)}
        }
    },
    {
        Category = 'Misc',
        Teleports = {
            {Name = 'VIP Zone', Position = Vector3.new(-1214, -8, -158)},
            {Name = 'Vacation island', Position = Vector3.new(341, 60, -10)}, --341, 47, -10
            {Name = 'Lava crystals', Position = Vector3.new(-1200, -180, 195)},
        }
    },
    {
        Category = 'Maps',
        Teleports = {
            {Name = 'Warehouse', Position = Vector3.new(-2260, 13, 886)},
            {Name = 'Suburbs', Position = Vector3.new(-1335, 13, 793)},
            {Name = 'Grocery', Position = Vector3.new(-2457, 13, -1016)},
            {Name = 'Boat club', Position = Vector3.new(-2457, 13, -1016)},
            {Name = 'Desert base', Position = Vector3.new(-548, 3, 4152)},
            {Name = 'Jewelry store', Position = Vector3.new(-2164, 13, 1419)},
            {Name = 'Luxury club', Position = Vector3.new(-2728, 13, 1616)},
        }
    }
}) do
    Tabs.Teleports:Separator({ Text = v.Category })

    for _,teleport in ipairs(v.Teleports) do
        Tabs.Teleports:Button({
            Text = teleport.Name,
            Callback = function()
                getRoot().CFrame = CFrame.new(teleport.Position)
            end
        })
    end
end

--- SETTINGS ---

if info.SuccessfulAAFK then
    Tabs.Settings:Label({
        Text = 'Anti-AFK is included, just for you <3'
    })
else
    Tabs.Settings:Label({
        Text = 'Failed to include Anti-AFK </3'
    })
end

Tabs.Settings:Separator({ Text = 'Client' })

-- Rejoin and Server hop stolen from Infinite Yield source

local ClientRow = Tabs.Settings:Row()

ClientRow:Button({
    Text = 'Rejoin',
    Callback = rejoin
})

ClientRow:Button({
    Text = 'Server hop',
    Callback = function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
        local body = game:GetService('HttpService'):JSONDecode(req)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
        else
            warn('Failed to find a server.')
        end
    end
})

Tabs.Settings:Separator({ Text = 'Farm' })

Tabs.Settings:SliderInt({
    Label = 'Fast XP Farm iterations',
    Value = g.n7.Farms.XP.Iterations,
    Minimum = 1,
    Maximum = 300,
    Callback = function(self, Value)
        g.n7.Farms.XP.Iterations = Value
    end
})

Tabs.Settings:Separator({ Text = 'UI' })

Tabs.Settings:Combo({
    Selected = "DarkTheme",
    Label = "Colors",
    Items = ReGui.ThemeConfigs,
    Callback = function(self, Name)
        Window:SetTheme(Name)
    end,
})

Tabs.Settings:Keybind({
    Label = "Toggle UI visibility",
    Value = Enum.KeyCode.RightShift,
    Callback = function()
        Window:ToggleVisibility()
    end,
})

Tabs.Settings:Button({
    Text = 'Unload GUI',
    Callback = function()
        pcall(function()
            g.n7.loaded = false
        end)
        for _,v in ipairs(Connections) do
            v:Disconnect()
        end

        g.n7 = nil
        Window:Close()
    end
})

--- CREDITS ---

Tabs.Credits:Label({
    Text = [[Script made by Stonifam
Using Dear ReGui (github.com/depthso/Dear-ReGui)
Skidded some code from Infinite Yield (github.com/EdgeIY/infiniteyield)]],
    TextWrapped = true
})

local clipboard = missing('function', setclipboard)

if clipboard then
    Tabs.Credits:Button({
        Text = 'Copy discord server invite',
        Callback = function()
            clipboard('https://discord.gg/NGAaby4y4b')
        end
    })
else
    Tabs.Credits:Label({
        Text = 'Join our discord community: https://discord.gg/NGAaby4y4b',
        TextColor3 = Color3.new(0.486274, 0.705882, 0.960784),
    })
end

g.n7.loaded = true

pcall(function()
    local sysmsg = ReplicatedStorage.Events.Message.SendNotice
    firesignal(sysmsg.OnClientEvent, "Loaded nick7 hub", "rbxassetid://5205790785")
    firesignal(sysmsg.OnClientEvent, "Enjoy <3", "rbxassetid://5205790785")
end)