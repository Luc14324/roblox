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
getgenv().n7hns = {
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
	v.Name = "discord.gg/6tgCfU2fX8"
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
getgenv().n7hns.cage = CFrame.new(frame)
-- CAGE
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local ui = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local window = ui:MakeWindow({Name = "nick7 hub | ".. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, HidePremium = false, SaveConfig = false, IntroEnabled = false})
local main = window:MakeTab({Name = "Main",Icon = nil,PremiumOnly = false})
local misc = window:MakeTab({Name = "Misc",Icon = nil,PremiumOnly = false})
local cfg = window:MakeTab({Name = "Settings & Credits",Icon = nil,PremiumOnly = false})

main:AddToggle({
	Name = "Auto-play",
	Default = false,
	Callback = function(Value)
		getgenv().n7hns.autoplay = Value
		while getgenv().n7hns.autoplay do
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
							getRoot(game.Players.LocalPlayer.Character).CFrame = getgenv().n7hns.cage
						end
					end
				end
			end
		end
	end    
})

main:AddSection({Name = "Manual"})

main:AddButton({
	Name = "Collect coins",
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

main:AddButton({
	Name = "Teleport to cage",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char and getRoot(char) then
			getRoot(char).CFrame = getgenv().n7hns.cage
		end
	end
})

main:AddButton({
	Name = "Kill all (ONLY AS \"IT\")",
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

misc:AddToggle({
	Name = "Boombox GUI",
	Default = false,
	Callback = function(Value)
		getgenv().n7hns.boombox = Value
		while getgenv().n7hns.boombox do
			game:GetService("Players").LocalPlayer.PlayerGui.MainGui.BoomboxFrame.Visible = true
			RunService.RenderStepped:Wait(.4)
		end
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.BoomboxFrame.Visible = false
	end,
})

misc:AddButton({
	Name = "View It",
	Callback = function()
		workspace.Camera.CameraSubject = getIt():FindFirstChild("Humanoid")
	end
})

misc:AddButton({
	Name = "Unview It",
	Callback = function()
		workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	end
})

cfg:AddToggle({
	Name = "Highlight on It",
	Default = false,
	Callback = function(Value)
		getgenv().n7hns.espIt = Value
		while getgenv().n7hns.espIt do
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
	end
})
cfg:AddSection({Name = "Settings"})
cfg:AddButton({Name = "Destroy GUI", Callback = function() ui:Destroy() end})
cfg:AddSection({Name = "Credits"})
cfg:AddLabel("Script made by nick7 with <3")
cfg:AddLabel("Join nick7 community - discord.gg/6tgCfU2fX8")
cfg:AddLabel("Using Orion UI library for this script.")

ui:Init()