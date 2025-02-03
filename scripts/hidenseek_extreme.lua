local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	game.Players.LocalPlayer.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end
getgenv().n7 = {
	autoplay = false,
	cage = CFrame.new(0,0,0),
	espIt = false,
	boombox = false
}
local RunService = game:GetService("RunService")
local char = game.Players.LocalPlayer
function getIt()
	local plrs = game.Players:GetPlayers()
	for _,v in plrs do
		local char = v.Character
		if char then
			if char:FindFirstChild("ItScript") then
				return char
			end
		end
	end
end
-- CAGE
if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
local folder = Instance.new("Folder", workspace)
folder.Name = "Cage (nick7hub)"
local _color = Color3.fromRGB(79, 79, 79)
local _offset = Vector3.new(math.random(-100000, 100000), math.random(-50,1500), math.random(-100000,100000))
--+ Creating
local parts = {}
local floor = Instance.new("Part", folder)
local wall1 = Instance.new("Part", folder)
local wall2 = Instance.new("Part", folder)
local wall3 = Instance.new("Part", folder)
local wall4 = Instance.new("Part", folder)
local ceiling = Instance.new("Part", folder)
local parts = {floor,wall1,wall2,wall3,wall4,ceiling}
--+ sum things
for _,v in pairs(parts) do
	v.Anchored = true
	v.Transparency = 0.4
	v.Color = _color
	v.Name = "discord.gg/NGAaby4y4b"
end
--+ Position
floor.Position = Vector3.new(0, 0, 0) + _offset
wall1.Position = Vector3.new(5, 5, 0) + _offset
wall2.Position = Vector3.new(-5, 5, 0) + _offset
wall3.Position = Vector3.new(0, 5, -5) + _offset
wall4.Position = Vector3.new(0, 5, 5) + _offset
ceiling.Position = Vector3.new(0, 10, 0) + _offset
--+ Size
floor.Size = Vector3.new(10,1,10)
wall1.Size = Vector3.new(1, 10, 10)
wall2.Size = Vector3.new(1, 10, 10)
wall3.Size = Vector3.new(10, 10, 1)
wall4.Size = Vector3.new(10, 10, 1)
ceiling.Size = Vector3.new(10,1,10)
--
local frame = _offset + Vector3.new(0,4,0)
getgenv().n7.cage = CFrame.new(frame)
-- CAGE
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local ui = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()
ui.ShowCallbackErrors = true
local Window = ui:CreateWindow({
	Title = "nick7 hub",
	SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 100,
	Size = UDim2.fromOffset(470, 300),
	Acrylic = false,
	Theme = "Amethyst"
})
local Tabs = {
    main = Window:AddTab({ Title = "Main", Icon = "sparkles" }),
    misc = Window:AddTab({ Title = "Misc", Icon = "file-box" }),
    cfg = Window:AddTab({ Title = "Settings", Icon = "cog" })
}
local AutoPlay = Tabs.main:AddToggle("Auto-play", { Title = "Auto-play", Default = false })

AutoPlay:OnChanged(function(Value)
	getgenv().n7.autoplay = Value
	if getgenv().n7.autoplay then
        while getgenv().n7.autoplay do
            task.wait()
            if game.Players.LocalPlayer.Character then
                if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored then
                    for i,v in workspace.GameObjects:GetChildren() do
                        if string.match(v.Name, "Credit") then
                            if game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) then
                                getRoot(game.Players.LocalPlayer.Character).CFrame = v.CFrame
                                task.wait()
                            end
                        end
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild("ItScript") then
                        for _,v in game.Players:GetPlayers() do
                            local target = v.Character
                            if game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) then
                                if target and getRoot(target) then
                                    getRoot(game.Players.LocalPlayer.Character).CFrame = getRoot(target).CFrame
                                    task.wait()
                                end
                            end
                            task.wait()
                        end
                    elseif not game.Players.LocalPlayer.Character:FindFirstChild("ItScript") then
                        if game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) then
                            getRoot(game.Players.LocalPlayer.Character).CFrame = getgenv().n7.cage
                        end
                    end
                end
            end
        end
	end
end)

local manual = Tabs.main:AddSection("Manual")

manual:AddButton({
	Title = "Collect coins",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if getIt() ~= char then
			for i,v in workspace.GameObjects:GetChildren() do
				if string.match(v.Name, "Credit") then
					if char and getRoot(char) then
						getRoot(char).CFrame = v.CFrame
						task.wait()
					end
				end
			end
		end
	end
})

manual:AddButton({
    Title = "Teleport to cage",
    Description = "Where seeker can't reach you",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
		if char and getRoot(char) then
			getRoot(char).CFrame = getgenv().n7.cage
		end
    end
})

manual:AddButton({
    Title = "Kill all (ONLY AS SEEKER)",
    Description = "Will catch all players",
    Callback = function()
        local plrs = game.Players:GetPlayers()
		for _,v in pairs(plrs) do
			local target = v.Character
			local char = game.Players.LocalPlayer.Character
			if char and getRoot(char) then
				if target and getRoot(target) then
					getRoot(char).CFrame = getRoot(target).CFrame
					task.wait(.1)
				end
			end
		end
    end
})

local BoomboxToggle = Tabs.misc:AddToggle("Boombox", { Title = "Boombox", Description = "No gamepass needed.", Default = false })

BoomboxToggle:OnChanged(function(Value)
	getgenv().n7.boombox = Value
	while getgenv().n7.boombox do
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.BoomboxFrame.Visible = true
		RunService.RenderStepped:Wait(.4)
	end
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.BoomboxFrame.Visible = false
end)

Tabs.misc:AddButton({
	Title = "View Seeker (It)",
	Callback = function()
		workspace.Camera.CameraSubject = getIt():FindFirstChild("Humanoid")
	end
})

Tabs.misc:AddButton({
	Title = "Unview Seeker (It)",
	Callback = function()
		workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	end
})

local HighlightSeeker = Tabs.misc:AddToggle("HighlightSeeker", { Title = "Highlight on Seeker (It)", Default = false })

HighlightSeeker:OnChanged(function(Value)
	getgenv().n7.espIt = Value
    while getgenv().n7.espIt do
        for _,v in game.Players:GetPlayers() do
            local ch = v.Character
            if ch:FindFirstChildOfClass("Highlight") and ch ~= getIt() then
                ch:FindFirstChildOfClass("Highlight"):Destroy()
            end
        end
        if not getIt():FindFirstChildOfClass("Highlight") then
            local hl = Instance.new("Highlight")
            hl.Parent = getIt()
            hl.Adornee = getIt()
        end
        task.wait(.5)
    end
end)

local UISection = Tabs.cfg:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Description = "Changes the UI Theme",
	Values = ui.Themes,
	Default = ui.Theme,
	Callback = function(Value)
		ui:SetTheme(Value)
	end
})

if ui.UseAcrylic then
	UISection:AddToggle("AcrylicToggle", {
		Title = "Acrylic",
		Description = "Blurred Background requires Graphic Quality >= 8",
		Default = ui.Acrylic,
		Callback = function(Value)
			if not Value then
				ui:ToggleAcrylic(Value)
			else
				Window:Dialog({
					Title = "Warning",
					Content = "This Option can be detected! Activate it anyway?",
					Buttons = {
						{
							Title = "Confirm",
							Callback = function()
								ui:ToggleAcrylic(Value)
							end
						},
						{
							Title = "Cancel",
							Callback = function()
								ui.Options.AcrylicToggle:SetValue(false)
							end
						}
					}
				})
			end
		end
	})
end

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = ui.Transparency,
	Callback = function(Value)
		ui:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift"})
ui.MinimizeKeybind = ui.Options.MinimizeKeybind

local credits = Tabs.cfg:AddSection("Credits")
credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script is made by Stonifam & kosoor\nUsing forked UI lib by @ttwiz_z"
})
credits:AddButton({
	Title = "Copy discord invite",
	Description = "nick7 community",
	Callback = function()
		setclipboard("https://discord.gg/NGAaby4y4b")
	end
})

Window:SelectTab(1)