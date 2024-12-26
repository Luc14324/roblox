-- made by nick7 with <3

local plr = game:GetService("Players").LocalPlayer
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
local defaults = {
	autofarm = false,
	annoy = {
		toggle = false,
		vip = false,
		exclusive = false
	},
	tp_method = true,
	tp_for_autofarm = true
}
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

pcall(function()
    if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
        g.n7 = game:GetService("HttpService"):JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
    end
end)

do
	local function CheckNils(tbl, usingDefaults)
		for k, default_v in pairs(usingDefaults) do
			if type(default_v) == "table" then
				if tbl[k] == nil then
					tbl[k] = {}
				end
				CheckNils(tbl[k], default_v)
			elseif tbl[k] == nil then
				tbl[k] = default_v
			end
		end
	end

	CheckNils(g.n7, defaults)
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


Tabs.Main:AddButton({Title = 'Remove Morphs door', Callback = function()
	if workspace:FindFirstChild('Morphs') then
		workspace.Morphs:Destroy()
	else
		Fluent:Notify({
			Title = "nick7 hub | WARN",
			Content = "Already removed or name got changed.",
			Duration = 10
		})
	end
end})

local autofarm = Tabs.Main:AddToggle("Autofarm", { Title = "Autofarm wins", Default = g.n7.autofarm})

local annoy = Tabs.Main:AddToggle("Annoy", { Title = "Annoy", Description = 'Spam spawns all boxes', Default = g.n7.annoy.toggle})

do
	local winner = workspace.Winners.TouchInterest.Parent
	local spawnLocation = workspace.SpawnLocation

	autofarm:OnChanged(function(Value)
		g.n7.autofarm = Value

		if not (firetouchinterest and not g.n7.tp_method) then
			spawnLocation.Transparency = g.n7.autofarm and 1 or 0 -- kinda fixes fps issue
		end

		while g.n7.autofarm and not Fluent.Unloaded do
			pcall(function()
				if plr.Character and plr.Character:FindFirstChild('HumanoidRootPart') then
					local root = plr.Character:FindFirstChild('HumanoidRootPart')
					if firetouchinterest and not g.n7.tp_method then
						firetouchinterest(root, winner, 0)
						firetouchinterest(root, winner, 1)
						firetouchinterest(root, spawnLocation, 0)
						firetouchinterest(root, spawnLocation, 1)
					else
						local pre_pos = {winner.Position, spawnLocation.Position}
						local pre_collision = {winner.CanCollide, spawnLocation.CanCollide}
						winner.CanCollide = false
						winner.Position = root.Position
						task.wait()
						winner.Position = pre_pos[1]
						winner.CanCollide = pre_collision[1]
						spawnLocation.Position = root.Position
						spawnLocation.CanCollide = false
						task.wait()
						spawnLocation.Position = pre_pos[2]
						spawnLocation.CanCollide = pre_collision[2]
					end
				end
			end)
			task.wait()
		end
	end)

	local boxes = {}

	local function GetBoxes()
		local EXLUSIVE_COLOR = BrickColor.new('Bright red')
		local VIP_COLOR = BrickColor.new('Dark Curry')

		boxes = {}

		for _, part in ipairs(workspace.Boxes:GetDescendants()) do
			if part:IsA("BasePart") and not (part.BrickColor == EXLUSIVE_COLOR and not g.n7.annoy.exclusive) and not (part.BrickColor == VIP_COLOR and not g.n7.annoy.vip) and not part.Parent.Parent:IsA('Model') then
				table.insert(boxes, part)
			end
		end
	end

	GetBoxes()

	annoy:OnChanged(function(Value)
		g.n7.annoy.toggle = Value
		while g.n7.annoy.toggle and not Fluent.Unloaded do
			pcall(function()
				if plr.Character and plr.Character:FindFirstChild('HumanoidRootPart') then
					local root = plr.Character:FindFirstChild('HumanoidRootPart')
					for _,spawner in boxes do
						if firetouchinterest and not (g.n7.tp_method and not g.n7.tp_for_autofarm) then
							firetouchinterest(root, spawner, 0)
							firetouchinterest(root, spawner, 1)
						else
							local pre_pos = spawner.Position
							spawner.Position = root.Position
							spawner.CanCollide = false
							task.wait()
							spawner.Position = pre_pos
							spawner.CanCollide = true
						end
						task.wait()
					end
				end
			end)
			task.wait()
		end
	end)


	Tabs.Settings:AddButton({Title = "Fix annoy", Description = "Re-makes list with spawners.", Callback = function()
		GetBoxes()
		if firetouchinterest and plr.Character:FindFirstChild('HumanoidRootPart') and not (g.n7.tp_method and not g.n7.tp_for_autofarm) then
			for _,spawner in boxes do
				task.spawn(function()
					local highlight = Instance.new('Highlight',spawner)
					local root = plr.Character:FindFirstChild('HumanoidRootPart')
					firetouchinterest(root, spawner, 0)
					firetouchinterest(root, spawner, 1)
					task.wait(5)
					highlight:Destroy()
				end)
			end
		else
			for _,spawner in boxes do
				task.spawn(function()
					local highlight = Instance.new('Highlight',spawner)
					task.wait(5)
					highlight:Destroy()
				end)
			end
		end
		
		Fluent:Notify({
			Title = "nick7 hub | Info",
			Content = "Highlighted all spawners. If all (free) spawners are highlighted - annoy is fixed",
			Duration = 8
		})
	end})

	if firetouchinterest then
		Tabs.Settings:AddToggle('ForceTeleportMethod', {
			Title = 'Force teleport method',
			Description = 'Will teleport things to you instead of firing (faking) touch.\nPossible FPS issues, but better results',
			Default = g.n7.tp_method,
			Callback = function(Value)
				g.n7.tp_method = Value
		end})

		Tabs.Settings:AddToggle('TPMethodForAutofarm', {
			Title = 'Teleport method only for autofarm',
			Description = 'Uses teleport method only for autofarm',
			Default = g.n7.tp_for_autofarm,
			Callback = function(Value)
				g.n7.tp_for_autofarm = Value
			end
		})	
	end

	Tabs.Settings:AddToggle('ToggleVIPAnnoy', {Title = 'Include VIP for Annoy', Description = 'After enabling, press on "fix annoy"', Default = g.n7.annoy.vip, Callback = function(Value)
		g.n7.annoy.vip = Value
	end})

	Tabs.Settings:AddToggle('ToggleExclusiveAnnoy', {Title = 'Include exclusive boxes for Annoy', Description = 'After enabling, press on "fix annoy"', Default = g.n7.annoy.exclusive, Callback = function(Value)
		g.n7.annoy.exclusive = Value
	end})
end


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

if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
	local ConfigurationManager = Tabs.Settings:AddSection("Configuration Manager")

	ConfigurationManager:AddButton({
		Title = "Export Configuration",
		Description = "Overwrites the Game Configuration File",
		Callback = function()
			xpcall(function()
				local ExportedConfiguration = game:GetService("HttpService"):JSONEncode(g.n7)

				getfenv().writefile(string.format("%s.n7", game.GameId), ExportedConfiguration)
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully overwritten!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end, function()
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("An Error occurred when overwriting the Configuration File %s.n7", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end)
		end
	})

	ConfigurationManager:AddButton({
		Title = "Delete Configuration File",
		Description = "Deletes the Game Configuration File",
		Callback = function()
			if getfenv().isfile(string.format("%s.n7", game.GameId)) then
				getfenv().delfile(string.format("%s.n7", game.GameId))
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 has been successfully deleted!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			else
				Window:Dialog({
					Title = "Configuration Manager",
					Content = string.format("Configuration File %s.n7 could not be found!", game.GameId),
					Buttons = {
						{
							Title = "Confirm"
						}
					}
				})
			end
		end
	})
end

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