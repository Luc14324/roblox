local plr = game:GetService("Players").LocalPlayer

function getRoot(char)return char:FindFirstChild('HumanoidRootPart')end

local cage

do
	local folder = Instance.new("Folder", workspace)
	folder.Name = "Cage (nick7hub)"

	cageModel = folder

	local offset = Vector3.new(math.random(-100000, 100000), math.random(-50,1500), math.random(-100000,100000))
	local floor = Instance.new("Part", folder)
	local wall1 = Instance.new("Part", folder)
	local wall2 = Instance.new("Part", folder)
	local wall3 = Instance.new("Part", folder)
	local wall4 = Instance.new("Part", folder)
	local ceiling = Instance.new("Part", folder)
	local light = Instance.new("PointLight", ceiling)

	local parts = {floor, wall1, wall2, wall3, wall4, ceiling}

	for _, part in ipairs(parts) do
		part.Anchored = true
		part.Transparency = 0.4
		part.Position = offset
		part.Color = Color3.fromRGB(79, 79, 79)
		part.Name = "discord.gg/NGAaby4y4b"
	end

	floor.Position += Vector3.new(0, 0, 0)
	floor.Size = Vector3.new(10,1,10)

	wall1.Position += Vector3.new(5, 5, 0)
	wall1.Size = Vector3.new(1, 10, 10)

	wall2.Position += Vector3.new(-5, 5, 0)
	wall2.Size = Vector3.new(1, 10, 10)

	wall3.Position += Vector3.new(0, 5, -5)
	wall3.Size = Vector3.new(10, 10, 1)

	wall4.Position += Vector3.new(0, 5, 5)
	wall4.Size = Vector3.new(10, 10, 1)

	ceiling.Position += Vector3.new(0, 10, 0)
	ceiling.Size = Vector3.new(10,1,10)

	light.Range = 20
	light.Brightness = 10
	light.Shadows = false

	local frame = offset + Vector3.new(0,4,0)
	CagePosition = CFrame.new(frame)
end

local GC = getconnections or get_signal_cons
if GC then
	for _,v in pairs(GC(plr.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	plr.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

local g = {}
local defaults = {autofarm = false}
if getgenv then
	getgenv().n7 = defaults
	g = getgenv()
else
	g.n7 = defaults
	task.spawn(function()
		local m=Instance.new("Message", workspace)
		local txt="nick7 hub | WARNING\n\nYour exploit DOES NOT support getgenv function!\nThis could lead to detecting you and possible ban (not in this game and not with this script)\nnick7 hub will load now.\n\n"
		m.Text=txt
		for i=15,0,-1 do
			m.Text=txt..i
			task.wait(1)
		end
		m:Destroy()
	end)
end

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
    SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Dark"
})

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "factory" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}

local autofarm = Tabs.Main:AddToggle("Autofarm", { Title = "(AFK) Autofarm", Default = false})
autofarm:OnChanged(function(Value)
	g.n7.autofarm = Value
	if g.n7.autofarm then
		local char = plr.Character
		do local _=plr.Character:WaitForChild("HumanoidRootPart") end
		if char and getRoot(char) then
			getRoot(char).CFrame = workspace.Lobby.Elevator.Trigger.CFrame
			task.wait(4)
		end
		while g.n7.autofarm do
			getRoot(char).CFrame = cage
			game:GetService("RunService").Heartbeat:Wait()
		end
	end
end)

local UISection = Tabs.Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift"})
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

Tabs.Credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script is made by Stonifam\nUsing forked Fluent UI lib by @ttwiz_z"
})
if setclipboard then
	Tabs.Credits:AddButton({
		Title = "Copy discord invite",
		Description = "nick7 community",
		Callback = function()
			setclipboard("https://discord.gg/NGAaby4y4b")
		end
	})
else
	Tabs.Credits:AddButton({
		Title = "Notify discord invite",
		Description = "nick7 community",
		Callback = function()
			Fluent:Notify({
				Title = "https://discord.gg/NGAaby4y4b",
				Content = "nick7 discord invite",
				Duration = 20
			})
		end
	})
end

Window:SelectTab(1)

Fluent:Notify({
	Title = "nick7 hub | Fluent",
	Content = "The script has been loaded.",
	Duration = 8
})

repeat task.wait(0.5) until Fluent.Unloaded --! DO NOT WRITE ANY CODE THAT IS NOT ABOUT UNLOADING --> !!BELOW!! <-- . IT WILL NOT WORK
g.n7 = nil