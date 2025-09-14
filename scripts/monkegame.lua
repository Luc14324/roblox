local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local Lighting = game:GetService("Lighting")

--- g VARIABLE ---

local defaults = {
    ResetIfMonke = {
        Enabled = false
    },
    ForceEnableReset = {
        Enabled = true
    },
    VentSpam = {
        Enabled = false
    }
}

local g
if getfenv().getgenv then
    g = getfenv().getgenv()
else
    warn("Can't find getgenv! Using local variable, will lead to unpredictable behavior")
    g = {}
end

g.n7 = defaults

--- FUNCTIONS ---


function randomString() -- from iy
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local function getChar(player)
    player = player or Player
    return Player.Character or Player.CharacterAdded:Wait()
end

local function getRoot(player)
    player = player or Player
    return getChar():WaitForChild('HumanoidRootPart')
end

local function getHumanoid(player)
    player = player or Player
    return getChar():WaitForChild('Humanoid')
end

local function touch(part:BasePart) -- Added this because firetouchinterest is repeating too much
    firetouchinterest(getRoot(), part, 0)
    firetouchinterest(getRoot(), part, 1)
end

local function bool(value:any):boolean
    return not not value
end

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

local cloneref = missing("function", cloneref, function(...) return ... end)

local CoreGui = cloneref(game:GetService("CoreGui"))

local ESPObjects = {}

local function ESP(object:BasePart, text:string, color:Color3):Instance
    local function Create(parent)
        local box = Instance.new('BoxHandleAdornment')
        box.Name = randomString()
        box.AlwaysOnTop = true
        box.Transparency = 0.3
        box.ZIndex = 10
        box.Adornee = parent
        box.Size = parent.Size
        box.Parent = CoreGui
        box.Color3 = color
        table.insert(ESPObjects, {Type = 'Box', espObject = box, Object = parent, ObjectName = object.Name})
        return box
    end

    local function Label(target, parent) -- from iy
        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")
        BillboardGui.Adornee = target
        BillboardGui.Name = randomString()
        BillboardGui.Parent = parent
        BillboardGui.Size = UDim2.new(0, 100, 0, 150)
        BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
        BillboardGui.AlwaysOnTop = true
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0, 0, 0, -50)
        TextLabel.Size = UDim2.new(0, 100, 0, 100)
        TextLabel.Font = Enum.Font.SourceSansSemibold
        TextLabel.TextSize = 20
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
        TextLabel.Text = text
        table.insert(ESPObjects, {Type = 'Label', espObject = {BillboardGui, TextLabel}, Object = parent, ObjectName = target.Name})
        return BillboardGui, TextLabel
    end

    if object:IsA('Model') then
        for _,obj:BasePart in ipairs(object:GetChildren()) do
            Create(obj)
        end
        Label(object.PrimaryPart, CoreGui)
    elseif object:IsA('BasePart') then
        Create(object)
        Label(object, CoreGui)
    end
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
g.n7.loaded = true

--- REGUI THEMES ---

Themes = loadstring(game:HttpGet('https://gist.githubusercontent.com/WhateverNick7/818c6873f0e5cc2f107abd5c1d347387/raw/d2519b02ae7830642ceb7ef18f8b1be21725440d/ReGuiThemes.lua'))()
Themes(ReGui)

local Window = ReGui:TabsWindow({
	Title = "nick7 hub | Monke Game",
	Size = UDim2.fromOffset(400, 300),
    NoClose = true
})
Window:Center()

local Tabs = {
    Player = Window:CreateTab({ Name = 'Player' }),
    Visual = Window:CreateTab({ Name = 'Visual' }),
    Infect = Window:CreateTab({ Name = 'Infect' }),
    Settings = Window:CreateTab({ Name = 'Settings' }),
    Credits = Window:CreateTab({ Name = 'Credits' })
}

--- PLAYER ---

Tabs.Player:Separator({ Text = 'General' })

Tabs.Player:SliderInt({
    Label = 'WalkSpeed',
    Value = getHumanoid().WalkSpeed,
    Minimum = 14,
    Maximum = 300,
    Callback = function(self, Value)
        getHumanoid().WalkSpeed = Value
    end
})

Tabs.Player:SliderInt({
    Label = 'JumpPower',
    Value = getHumanoid().JumpPower,
    Minimum = 33,
    Maximum = 300,
    Callback = function(self, Value)
        getHumanoid().JumpPower = Value
    end
})

Tabs.Player:Checkbox({
    Label = 'Vent Spam',
    Value = g.n7.VentSpam.Enabled,
    Callback = function(self, Value)
        g.n7.VentSpam.Enabled = Value

        local vents = {
            --{Object = Model, Touch = Part}
        }

        for _,v in ipairs(workspace:GetChildren()) do
            if v.Name == 'Vent' then
                for _, x in ipairs(v:GetDescendants()) do
                    if x:IsA("Part") and x:FindFirstChildOfClass("TouchTransmitter") then
                        table.insert(vents, {Object = v, Touch = x})
                    end
                end
            end
        end

        while g.n7 and g.n7.VentSpam.Enabled do
            for _, v in ipairs(vents) do
                touch(v.Touch)
            end
            task.wait()
        end
    end
})

Tabs.Player:Checkbox({
    Label = 'Force enable reset',
    Value = g.n7.ForceEnableReset.Enabled,
    Callback = function(self, Value)
        g.n7.ForceEnableReset.Enabled = Value
        task.spawn(function()
            while g.n7 and g.n7.ForceEnableReset.Enabled do
                game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
                task.wait(1)
            end
        end)
    end
})
local ResetIfMonkeConnection

Tabs.Player:Checkbox({
    Label = 'Reset if Monke',
    Value = g.n7.ResetIfMonke.Enabled,
    Callback = function(self, Value)
        g.n7.ResetIfMonke.Enabled = Value
        if Value then
            ResetIfMonkeConnection = Player:GetPropertyChangedSignal("Team"):Connect(function()
                if Player.Team and Players.LocalPlayer.Team.Name == "Monke" then
                    getHumanoid().Health = 0
                end
            end)
        else
            if ResetIfMonkeConnection then
                ResetIfMonkeConnection:Disconnect()
                ResetIfMonkeConnection = nil
            end
        end
    end
})

Tabs.Player:Button({
	Text = 'Remove CD Scripts',
	Callback = function()
        for _, script in ipairs(game:GetDescendants()) do -- wtf is this, cheez -- STONIFAM IT WORKS SO STOP ANNOYING ME
            if script:IsA("LocalScript") and (script.Name == "jumpa" or script.Name == "NoBag" or script.Name == "Noreset/TrackMonke") then
                script:Destroy()
            end
        end
    end
})

Tabs.Player:Button({
	Text = 'No ProximityPrompt Hold Duration',
	Callback = function()
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0
            end
        end
    end
})


if info.SuccessfulAAFK then
    Tabs.Player:Label({
        Text = 'Anti-AFK is included, just for you <3'
    })
else
    Tabs.Player:Label({
        Text = 'Failed to include Anti-AFK :('
    })
end

local pre_edit_light = {
    Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
	OutdoorAmbient = Lighting.OutdoorAmbient
}

Tabs.Visual:Checkbox({
    Label = 'Fullbright',
    Value = false, -- no need to change it to g.n7...
    Callback = function(self, Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = pre_edit_light.Brightness
            Lighting.ClockTime = pre_edit_light.ClockTime
            Lighting.FogEnd = pre_edit_light.FogEnd
            Lighting.GlobalShadows = pre_edit_light.GlobalShadows
            Lighting.OutdoorAmbient = pre_edit_light.OutdoorAmbient
        end
    end
})

Tabs.Visual:Separator({ Text = 'UI Removal' })

Tabs.Visual:Button({
	Text = 'Remove Pink Transformation UI',
	Callback = function()
	    game.ReplicatedStorage.Bigbrain:Destroy()
    end
})

local ESPConnections = {}

Tabs.Visual:Separator({ Text = 'ESP on players' })

for _,team:Team in ipairs(game:GetService('Teams'):GetChildren()) do -- TODO: FIX THIS
    if team:IsA('Team') then
        Tabs.Visual:Checkbox({
            Label = team.Name,
            Value = false,
            Callback = function(self, Value)
                if Value then
                    for _,player:Player in ipairs(Players:GetPlayers()) do
                        if player.Team.Name == team then
                            if player.Character then
                                ESP(player.Character, player.Name, team.TeamColor.Color)
                            else
                                player.CharacterAdded:Wait()
                                ESP(player.Character, player.Name, team.TeamColor.Color)
                            end

                            table.insert(ESPConnections, {Type = 'plr', Data = { Player = player }, Connection = player.CharacterAdded:Connect(function(char)
                                ESP(char, player.Name, team.TeamColor.Color)
                            end)})
                        end
                    end
                else
                    for _,connection in ipairs(ESPConnections) do
                        if connection.Type == 'plr' then
                            local Connection:RBXScriptConnection = connection.Connection

                            if connection.Data.Player.Team == team then
                                Connection:Disconnect()
                            end
                        end
                    end
                end
            end
        })
    end
end

Tabs.Visual:Separator({ Text = 'ESP on objects' })

for _,v in ipairs({ -- ESP on objects
    { DisplayName = 'Toolbox', Parent = workspace, ObjectName = 'Toolbox', ObjectClass = 'MeshPart', Color = Color3.fromRGB(111, 123, 231) },
    { DisplayName = 'Banana', Parent = workspace, ObjectName = 'Banana', ObjectClass = 'Part', Color = Color3.fromRGB(236, 238, 107) },
    { DisplayName = 'Apple', Parent = workspace, ObjectName = 'Apple', ObjectClass = 'Part', Color = Color3.fromRGB(255, 111, 111) },
    --{ DisplayName = '', Parent = nil, ObjectName = '', ObjectClass = '', Color = Color3 }
}) do
    local DisplayName:string = v.DisplayName
    local Parent:Instance = v.Parent
    local ObjectName:string = v.ObjectName
    local ObjectClass:string = v.ObjectClass
    local Color:Color3 = v.Color

    Tabs.Visual:Checkbox({
        Label = DisplayName,
        Value = false, -- don't change it, it's a for loop.
        Callback = function(self, Value: boolean)
            if Value then
                for _,x:Instance in ipairs(Parent:GetChildren()) do
                    if x.Name == ObjectName and x.ClassName == ObjectClass then
                        ESP(x, DisplayName, Color)
                    end
                end

                table.insert(ESPConnections, {Type = 'obj', ESPonObjects = v, Connection = Parent.ChildAdded:Connect(function(children)
                    if children.Name == ObjectName and children.ClassName == ObjectClass then
                        ESP(children, DisplayName, Color)
                    end
                end)})
            else -- Don't insert ObjectClass unless game updates
                for _,connection in ipairs(ESPConnections) do
                    if connection.Type == 'obj' then
                        local Connection:RBXScriptConnection = connection.Connection
                        local ESPonObjects = connection.ESPonObjects

                        if ESPonObjects.DisplayName == v.DisplayName then
                            Connection:Disconnect()
                        end
                    end
                end

                for _,esp in ipairs(ESPObjects) do
                    if esp.ObjectName == ObjectName then
                        if esp.Type == 'Label' then
                            for _,q in ipairs(esp.espObject) do
                                pcall(function()
                                    q:Destroy()
                                    esp = nil
                                end)
                            end
                        elseif esp.Type == 'Box' then
                            pcall(function()
                                esp.espObject:Destroy()
                                esp = nil
                            end)
                        end
                        
                    end
                end
            end
        end
    })
end

Tabs.Infect:Separator({ Text = 'Infection' })

Tabs.Infect:Checkbox({
    Label = 'Toggle infection from puddles',
    Value = false,
    Callback = function(self, Value)
        for _,v in ipairs(workspace.Regen:GetChildren()) do
            if v.Name == 'InfectPart' then
                v.CanTouch = Value
            end
        end
    end
})

Tabs.Infect:Checkbox({
    Label = 'Toggle killzone',
    Value = false,
    Callback = function(self, Value)
        for _,v in ipairs(workspace.Killll:GetChildren()) do
            v.CanTouch = Value
        end
    end 
})

local SpecialPuddles = {
    Blue = {},
    Orange = {}
}

for _,puddle in ipairs(workspace.Regen:GetChildren()) do -- Replaces :GetChildren()[...]
    if puddle:IsA('BasePart') then
        if puddle.Color == Color3.fromRGB(16, 42, 220) then -- Don't forget to use Color3.fromRGB, not Color3.new
            table.insert(SpecialPuddles.Blue, puddle)
        elseif puddle.Color == Color3.fromRGB(226, 155, 64) then
            table.insert(SpecialPuddles.Orange, puddle)
        end
    end
end

if #SpecialPuddles.Blue == 0 or #SpecialPuddles.Orange == 0 then
    error(string.format('Failed to find special puddles (Blue or Orange)\nBlue puddles: %d; Orange puddles: %d', #SpecialPuddles.Blue, #SpecialPuddles.Orange))
end

for _,mod in ipairs({
    {Name = 'Brown', Object = workspace.Regen:FindFirstChild("InfectPart")},
    {Name = 'Blue', Object = SpecialPuddles.Blue[1]},
    {Name = 'Green', Object = workspace.Regen.InfectPartBanana},
    {Name = 'Orange', Object = SpecialPuddles.Orange[1]},
}) do
    Tabs.Infect:Button({
        Text = `{mod.Name} monke`,
        Callback = function()
            mod.Object.CanTouch = true
            touch(mod.Object)
            mod.Object.CanTouch = false
        end
    })
end

--- SETTINGS ---

Tabs.Settings:Separator({ Text = 'Client' })

-- Rejoin and Server hop stolen from Infinite Yield source :*

local ClientRow = Tabs.Settings:Row({ Spacing = 10 })

ClientRow:Button({
    Text = 'Rejoin',
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            task.wait()
            game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
        else
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end
    end
})

ClientRow:Button({
    Text = 'Server Hop',
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

--- UI SETTINGS ---

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
    Text = 'Unload UI',
    Callback = function()
        -- Remove ESP
        for _,connection in ipairs(ESPConnections) do
            connection.Connection:Disconnect()
        end

        for _,esp in ipairs(ESPObjects) do
            if esp.Type == 'Label' then
                for _,q in ipairs(esp.espObject) do
                    pcall(function()
                        q:Destroy()
                    end)
                    esp = nil
                end
            elseif esp.Type == 'Box' then
                pcall(function()
                    esp.espObject:Destroy()
                end)
                esp = nil
            end
        end
        -- Unloading
        pcall(function()
            g.n7.loaded = false
        end)
        g.n7 = nil
        Window:Close()
    end
})

--- CREDITS ---

Tabs.Credits:Label({
    Text = [[Script made by Stonifam and cheez
Using Dear ReGui (github.com/depthso/Dear-ReGui)
Skidded some code from Infinite Yield, Rejoin, and serverhop. (github.com/EdgeIY/infiniteyield)]],
    TextWrapped = true
})

local clipboard
pcall(function()
    clipboard = getgenv().setclipboard or getfenv().setclipboard or setclipboard
end)

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
