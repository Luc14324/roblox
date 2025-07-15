local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--- HANDLE INCORRECT SESSION ---

local crash = false
xpcall(function() -- Protect from crashing on getgenv()
    if game.PlaceId ~= 72842684855320 and not getgenv().forceLoadN7 then
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
        if game.PlaceId ~= 72842684855320 then
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

--- g VARIABLE ---

local defaults = {
    KillAll = false,
    FilterEXE = true,
    KA_tool = nil, -- "Caches" tool that was already stacked with POP (doesn't work atm)
    ForceEnableReset = true
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

local function msg(txt)
    local x = Instance.new('Hint')
    x.Name = randomString()
    x.Text = txt
    x.Parent = workspace
    return x
end

local function bool(value:any):boolean
    return not not value
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

--- THEMES ---

ReGui:DefineTheme("CatppuccinFrappe", {
	TitleAlign = Enum.TextXAlignment.Center,
	Text = Color3.fromRGB(198, 208, 245),
	TextDisabled = Color3.fromRGB(166, 173, 200),
	ErrorText = Color3.fromRGB(231, 130, 132),

	FrameBg = Color3.fromRGB(48, 52, 70),
	FrameBgTransparency = 0.3,
	FrameBgActive = Color3.fromRGB(69, 71, 90),
	FrameBgTransparencyActive = 0.3,

	CheckMark = Color3.fromRGB(198, 160, 246),
	SliderGrab = Color3.fromRGB(198, 160, 246),
	ButtonsBg = Color3.fromRGB(198, 160, 246),
	CollapsingHeaderBg = Color3.fromRGB(198, 160, 246),
	CollapsingHeaderText = Color3.fromRGB(198, 208, 245),

	RadioButtonHoveredBg = Color3.fromRGB(198, 160, 246),
	ResizeGrab = Color3.fromRGB(198, 160, 246),

	HeaderBg = Color3.fromRGB(166, 173, 200),
	HeaderBgTransparency = 0.7,
	HistogramBar = Color3.fromRGB(229, 200, 144),
	ProgressBar = Color3.fromRGB(229, 200, 144),
	RegionBg = Color3.fromRGB(48, 52, 70),
	RegionBgTransparency = 0.1,

	Separator = Color3.fromRGB(166, 173, 200),
	SeparatorTransparency = 0.5,
	ConsoleLineNumbers = Color3.fromRGB(198, 208, 245),

	MenuBar = Color3.fromRGB(30, 32, 48),
	PopupCanvas = Color3.fromRGB(30, 32, 48),

	TabText = Color3.fromRGB(166, 173, 200),
	TabBg = Color3.fromRGB(48, 52, 70),
	TabTextActive = Color3.fromRGB(198, 208, 245),
	TabBgActive = Color3.fromRGB(198, 160, 246),
	TabsBarBg = Color3.fromRGB(36, 36, 40),
	TabsBarBgTransparency = 1,

	WindowBg = Color3.fromRGB(30, 32, 48),
	WindowBgTransparency = 0.05,

	ModalWindowDimBg = Color3.fromRGB(24, 24, 37),
	Border = Color3.fromRGB(108, 112, 134),
	BorderTransparency = 0.8,
	BorderTransparencyActive = 0.5,

	Title = Color3.fromRGB(198, 208, 245),
	TitleBarBg = Color3.fromRGB(30, 32, 48),
	TitleBarBgActive = Color3.fromRGB(48, 52, 70),
	TitleBarBgCollapsed = Color3.fromRGB(0, 0, 0),
	TitleBarTransparency = 0,
	TitleBarTransparencyActive = 0.05,
	TitleBarTransparencyCollapsed = 0.6
})

ReGui:DefineTheme("CatppuccinMacchiato", {
	TitleAlign = Enum.TextXAlignment.Center,
	Text = Color3.fromRGB(202, 211, 245),
	TextDisabled = Color3.fromRGB(166, 173, 200),
	ErrorText = Color3.fromRGB(237, 135, 150),

	FrameBg = Color3.fromRGB(36, 39, 58),
	FrameBgTransparency = 0.3,
	FrameBgActive = Color3.fromRGB(65, 66, 89),
	FrameBgTransparencyActive = 0.3,

	CheckMark = Color3.fromRGB(198, 160, 246),
	SliderGrab = Color3.fromRGB(198, 160, 246),
	ButtonsBg = Color3.fromRGB(198, 160, 246),
	CollapsingHeaderBg = Color3.fromRGB(198, 160, 246),
	CollapsingHeaderText = Color3.fromRGB(202, 211, 245),

	RadioButtonHoveredBg = Color3.fromRGB(198, 160, 246),
	ResizeGrab = Color3.fromRGB(198, 160, 246),

	HeaderBg = Color3.fromRGB(166, 173, 200),
	HeaderBgTransparency = 0.7,
	HistogramBar = Color3.fromRGB(238, 212, 159),
	ProgressBar = Color3.fromRGB(238, 212, 159),
	RegionBg = Color3.fromRGB(36, 39, 58),
	RegionBgTransparency = 0.1,

	Separator = Color3.fromRGB(166, 173, 200),
	SeparatorTransparency = 0.5,
	ConsoleLineNumbers = Color3.fromRGB(202, 211, 245),

	MenuBar = Color3.fromRGB(24, 25, 38),
	PopupCanvas = Color3.fromRGB(24, 25, 38),

	TabText = Color3.fromRGB(166, 173, 200),
	TabBg = Color3.fromRGB(36, 39, 58),
	TabTextActive = Color3.fromRGB(202, 211, 245),
	TabBgActive = Color3.fromRGB(198, 160, 246),
	TabsBarBg = Color3.fromRGB(36, 36, 40),
	TabsBarBgTransparency = 1,

	WindowBg = Color3.fromRGB(24, 25, 38),
	WindowBgTransparency = 0.05,

	ModalWindowDimBg = Color3.fromRGB(20, 21, 31),
	Border = Color3.fromRGB(108, 112, 134),
	BorderTransparency = 0.8,
	BorderTransparencyActive = 0.5,

	Title = Color3.fromRGB(202, 211, 245),
	TitleBarBg = Color3.fromRGB(24, 25, 38),
	TitleBarBgActive = Color3.fromRGB(36, 39, 58),
	TitleBarBgCollapsed = Color3.fromRGB(0, 0, 0),
	TitleBarTransparency = 0,
	TitleBarTransparencyActive = 0.05,
	TitleBarTransparencyCollapsed = 0.6
})

ReGui:DefineTheme("CatppuccinMocha", {
	TitleAlign = Enum.TextXAlignment.Center,
	Text = Color3.fromRGB(205, 214, 244), -- text
	TextDisabled = Color3.fromRGB(166, 173, 200), -- subtext1

	ErrorText = Color3.fromRGB(243, 139, 168), -- red

	FrameBg = Color3.fromRGB(30, 30, 46), -- base
	FrameBgTransparency = 0.3,
	FrameBgActive = Color3.fromRGB(49, 50, 68), -- surface1
	FrameBgTransparencyActive = 0.3,

	CheckMark = Color3.fromRGB(203, 166, 247), -- mauve
	SliderGrab = Color3.fromRGB(203, 166, 247),
	ButtonsBg = Color3.fromRGB(203, 166, 247),
	CollapsingHeaderBg = Color3.fromRGB(203, 166, 247),
	CollapsingHeaderText = Color3.fromRGB(205, 214, 244), -- text

	RadioButtonHoveredBg = Color3.fromRGB(203, 166, 247),
	ResizeGrab = Color3.fromRGB(203, 166, 247),

	HeaderBg = Color3.fromRGB(166, 173, 200), -- subtext1
	HeaderBgTransparency = 0.7,
	HistogramBar = Color3.fromRGB(249, 226, 175), -- yellow
	ProgressBar = Color3.fromRGB(249, 226, 175),
	RegionBg = Color3.fromRGB(30, 30, 46), -- base
	RegionBgTransparency = 0.1,

	Separator = Color3.fromRGB(166, 173, 200), -- subtext1
	SeparatorTransparency = 0.5,
	ConsoleLineNumbers = Color3.fromRGB(205, 214, 244),

	MenuBar = Color3.fromRGB(17, 17, 27), -- crust
	PopupCanvas = Color3.fromRGB(17, 17, 27), -- crust

	-- Tabs
	TabText = Color3.fromRGB(166, 173, 200),
	TabBg = Color3.fromRGB(30, 30, 46),
	TabTextActive = Color3.fromRGB(205, 214, 244),
	TabBgActive = Color3.fromRGB(203, 166, 247),
	TabsBarBg = Color3.fromRGB(36, 36, 40),
	TabsBarBgTransparency = 1,

	-- Window
	WindowBg = Color3.fromRGB(17, 17, 27), -- crust
	WindowBgTransparency = 0.05,

	ModalWindowDimBg = Color3.fromRGB(24, 24, 37), -- mantle
	Border = Color3.fromRGB(108, 112, 134), -- surface2

	BorderTransparency = 0.8,
	BorderTransparencyActive = 0.5,

	Title = Color3.fromRGB(205, 214, 244),
	TitleBarBg = Color3.fromRGB(17, 17, 27), -- crust
	TitleBarBgActive = Color3.fromRGB(30, 30, 46), -- base
	TitleBarBgCollapsed = Color3.fromRGB(0, 0, 0),

	TitleBarTransparency = 0,
	TitleBarTransparencyActive = 0.05,
	TitleBarTransparencyCollapsed = 0.6
})

local Window = ReGui:TabsWindow({
	Title = "nick7 hub | Sonic.EXE: Stay Alive",
	Size = UDim2.fromOffset(400, 300),
    NoClose = true
})
Window:Center()

local Tabs = {
    Player = Window:CreateTab({ Name = 'Player' }),
    Survivor = Window:CreateTab({ Name = 'Survivor' }),
    EXE = Window:CreateTab({ Name = 'EXE' }),
    Teleports = Window:CreateTab({ Name = 'Teleports' }),
    Settings = Window:CreateTab({ Name = 'Settings' }),
    Credits = Window:CreateTab({ Name = 'Credits' })
}

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
    Label = 'Camera tilt',
    Value = Player.PlayerGui:WaitForChild('Tilt').Enabled,
    Callback = function(self, Value: boolean)
        Player.PlayerGui:WaitForChild('Tilt').Enabled = Value
    end
})

do
    local music_script = Player.PlayerScripts.LocalBackgroundMusic
    Tabs.Player:Checkbox({
        Label = 'Mute music',
        Value = not music_script.Enabled,
        Callback = function(self, Value)
            music_script.Enabled = not Value
            pcall(function()
                if music_script:FindFirstChildOfClass('Sound') then
                    music_script:FindFirstChildOfClass('Sound'):Destroy()
                end
            end)
        end
    })
end

Tabs.Player:Checkbox({
    Label = 'Force enable reset',
    Value = g.n7.ForceEnableReset,
    Callback = function(self, Value)
        g.n7.ForceEnableReset = Value
        task.spawn(function()
            while g.n7 and g.n7.ForceEnableReset do
                game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
                task.wait(1)
            end
        end)
    end
})

    if info.SuccessfulAAFK then
    Tabs.Player:Label({
        Text = 'Anti-AFK is included, just for you <3'
    })
else
    Tabs.Player:Label({
        Text = 'Failed to include Anti-AFK </3'
    })
end

--- CHARACTERS ---

local function Unequip() -- Unequips all tools
    for _,v in getChar():GetChildren() do
        pcall(function()
            if v:IsA('Tool') then
                v.Parent = Player.Backpack
            end
        end)
    end
end

local Patch = {
    NoCD = function(toolName:string, NoUnequip:boolean):Tool -- toolName: any string
        Unequip()

        local x:Hint = msg(`Equip {toolName} to patch it`) -- not required, just to make sure that already equipped tool will be patched as intended

        local a,b = pcall(function()
            local CanContinue = false
            local tool

            local z = Player.Character.ChildAdded:Connect(function(child:Instance)
                pcall(function()
                    if child:IsA('Tool') then
                        child.Scripts:FindFirstChildOfClass('LocalScript').Enabled = false

                        child.Activated:Connect(function()
                            child.Events.Fire:FireServer()
                        end)
                        tool = child
                        CanContinue = true
                    end
                end)
            end)

            repeat task.wait() until CanContinue -- Player.Character.ChildAdded:Wait() didn't worked as intended
            if not NoUnequip then
                Unequip()
            end

            z:Disconnect()
            
            return tool
        end)

        if a and b then
            x.Text = `Patched {toolName}.`
        else
            x.Text = `Failed to patch {toolName}!`
        end

        task.wait(3)
        x:Destroy()
    end,

    POP = function(NoUnequip):Tool
        Unequip()

        local x:Hint = msg(`Equip melee to patch it`)
        local tool

        local a,b = pcall(function()
            local CanContinue = false

            local z = Player.Character.ChildAdded:Connect(function(child:Instance)
                if child:IsA('Tool') then
                    for _=1,80 do
                        child.Events.Fire:FireServer()
                    end
                    tool = child
                    CanContinue = true
                end
            end)

            repeat task.wait() until CanContinue
            if not NoUnequip then
                Unequip()
            end

            z:Disconnect()

            return tool
        end)

        if a and b then
            x.Text = `Patched.`
        else
            x.Text = `Failed to patch!`
        end

        task.wait(3)
        x:Destroy()
    end,

    SpamTool = function(toolName:string, NoUnequip:boolean):Tool -- toolName: any string
        Unequip()

        local x:Hint = msg(`Equip {toolName} to replicate it`)
        local tool

        local a,b = pcall(function()
            local CanContinue = false

            local z = Player.Character.ChildAdded:Connect(function(child:Instance)
                pcall(function()
                    if child:IsA('Tool') then
                        if child.Events.Fire then
                            tool = Instance.new('Tool')
                            tool.Name = randomString()
                            tool.TextureId = child.TextureId
                            tool.Parent = Player.Backpack

                            tool.RequiresHandle = false
                            tool.CanBeDropped = false

                            local isEquipped = true

                            tool.Unequipped:Connect(function()
                                isEquipped = false
                            end)
                            
                            tool.Equipped:Connect(function()
                                isEquipped = true
                                while isEquipped do
                                    child.Events.Fire:FireServer()

                                    RunService.Heartbeat:Wait()
                                end
                            end)
    
                            CanContinue = true
                        end
                    end
                end)
            end)

            repeat task.wait() until CanContinue
            if NoUnequip then
                Unequip()
            end

            z:Disconnect()

            return tool
        end)

        if a and b then
            x.Text = `Replicated {toolName}.`
        else
            x.Text = `Failed to replicate {toolName}!`
        end

        task.wait(3)
        x:Destroy()
    end
}

local function PopulateTabWithPatches(PatchesList:table, Parent)
    for _,char in ipairs(PatchesList) do
        local c = Parent:TreeNode({
            Title = char.Character
        })
    
        for _,item in ipairs(char.Patches) do
            c:Separator({ Text = item.Name })
    
            for _,patch in ipairs(item.Patches) do
                if patch == 'cd' then
                    c:Button({
                        Text = 'No cooldown',
                        Callback = function()
                            Patch.NoCD(item.Name)
                        end
                    })
                elseif patch == 'pop' then
                    c:Button({
                        Text = 'Punch without Punching',
                        Callback = function()
                            Patch.POP()
                        end
                    })
                elseif patch == 'spam' then
                    c:Button({
                        Text = 'Spam (TOOL)',
                        Callback = function()
                            Patch.SpamTool(item.Name)
                        end
                    })
                end
            end
        end
    end
end

--- SURVIVORS ---

local SurvivorPatchesList = {
    {
        Character = 'Tails',
        Patches = {
            {
                Name = 'ArmCanon',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Fly',
                Patches = {'cd'}
            }
        }
    },
    {
        Character = 'Knuckles',
        Patches = {
            {
                Name = 'Punch',
                Patches = {'cd', 'pop', 'spam'}
            },
            {
                Name = 'Bomb',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Glide',
                Patches = {'cd'}
            }
        }
    },
    {
        Character = 'Eggman',
        Patches = {
            {
                Name = 'JetPack',
                Patches = {'cd'}
            },
            {
                Name = 'BombTrap',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'HealTrap',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Amy Rose',
        Patches = {
            {
                Name = 'HammerAttack',
                Patches = {'cd', 'pop', 'spam'}
            },
            {
                Name = 'HammerThrow',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Gamble all (spam tool)',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Cream',
        Patches = {
            {
                Name = 'Heal Ring',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Speed boost',
                Patches = {'cd'}
            }
        }
    },
    {
        Character = 'Sally Acorn',
        Patches = {
            {
                Name = 'Give Shield',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Shield',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Hide Tag',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Shadow',
        Patches = {
            {
                Name = 'Chaos Boost',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Chaos Spears',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Chaos Control',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Rouge',
        Patches = {
            {
                Name = 'Dodge',
                Patches = {'cd'}
            },
            {
                Name = 'FlashBang',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Sensor',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Metal Sonic',
        Patches = {
            {
                Name = 'Push',
                Patches = {'cd'}
            }
        }
    }
}

local function NoJumpCooldownButton(Parent)
    Parent:Button({
        Text = 'No jump cooldown',
        Callback = function()
            getChar():WaitForChild('JumpCooldown').Enabled = false
        end
    })
end

Tabs.Survivor:Separator({ Text = 'Universal' })

Tabs.Survivor:Button({
    Text = 'Turn into EXE',
    Callback = function()
        getHumanoid().Health = 0
    end
})

NoJumpCooldownButton(Tabs.Survivor)

Tabs.Survivor:Separator()

PopulateTabWithPatches(SurvivorPatchesList, Tabs.Survivor)

--- EXE ---

local EXEPatchesList = {
    {
        Character = 'Exeller',
        Patches = {
            {
                Name = 'Attack',
                Patches = {'cd', 'pop', 'spam'}
            },
            {
                Name = 'SpinDash',
                Patches = {'cd'}
            },
            {
                Name = 'Spawn Clone',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Sonic.exe',
        Patches = {
            {
                Name = 'Attack',
                Patches = {'cd', 'pop', 'spam'}
            },
            {
                Name = 'Invisible',
                Patches = {'cd'}
            },
            {
                Name = 'Counter',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Exetior',
        Patches = {
            {
                Name = 'Attack',
                Patches = {'cd', 'pop', 'spam'}
            },
            {
                Name = 'BlackRing',
                Patches = {'cd', 'spam'}
            }
        }
    },
    {
        Character = 'Chaos',
        Patches = {
            {
                Name = 'Fly',
                Patches = {'cd'}
            },
            {
                Name = 'HydroBall',
                Patches = {'cd', 'spam'}
            },
            {
                Name = 'Dash Attack',
                Patches = {'cd', 'spam'}
            }
        }
    }
}

do
    Tabs.EXE:Separator({Text = 'Universal'})

    NoJumpCooldownButton(Tabs.EXE)

    local Row = Tabs.EXE:Row()
    Row:Checkbox({
        Value = g.n7.KillAll,
        Label = 'Kill All',
        Callback = function(self, Value)
            g.n7.KillAll = Value
            if Value then
                if not g.n7.KA_tool then
                    g.n7.KA_tool = Patch.POP(true)
                end

                while g.n7.KillAll do
                    for _,plr:Player in ipairs(game:GetService('Players'):GetPlayers()) do
                        pcall(function()
                            if plr ~= Player and not (g.n7.FilterEXE and plr.Team.Name == 'Exes') then
                                if plr.Character then
                                    if plr.Character.HumanoidRootPart and plr.Character.collision then
                                        plr.Character.HumanoidRootPart.Anchored = false
                                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(getRoot().Position + Vector3.new(1,0,0))
                                        plr.Character.HumanoidRootPart.Anchored = true
                                    end
                                    task.wait()
                                end
                            end
                        end)
                    end
                    pcall(function()
                        g.n7.KA_tool.Events.Fire:FireServer()
                    end)
                    task.wait()
                end

                for _,plr in ipairs(game:GetService('Players'):GetPlayers()) do
                    pcall(function()
                        plr.Character.HumanoidRootPart.Anchored = false
                    end)
                end
            end
        end
    })

    Row:Checkbox({
        Value = g.n7.FilterEXE,
        Label = 'Filter EXE',
        Callback = function(self, Value)
            g.n7.FilterEXE = Value
        end
    })
end

Tabs.EXE:Separator()

PopulateTabWithPatches(EXEPatchesList, Tabs.EXE)

--- TELEPORTS ---

for _,v in ipairs({
    {
        Category = 'Lobbies',
        Teleports = {
            {Name = 'Main lobby', Position = Vector3.new(208, -21, 1467)},
            {Name = 'Survivors lobby', Position = Vector3.new(288, -21, 1087)},
            {Name = 'EXEs lobby', Position = Vector3.new(289, -21, 1217)}
        }
    },
    {
        Category = 'Maps',
        Teleports = {
            {Name = 'Kind And Fair', Position = Vector3.new(1992, 403, 1537)},
            {Name = 'Bingo Forest', Position = Vector3.new(2143, 480, 7983)},
            {Name = 'TestZone', Position = Vector3.new(-389, 490, 2123)}
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
    Text = 'Unload GUI',
    Callback = function()
        pcall(function()
            g.n7.loaded = false
        end)
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