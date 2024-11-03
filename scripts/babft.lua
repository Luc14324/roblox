--' Script made by Stonifam. Thanks for at least viewing source code xd
local plr = game:GetService("Players").LocalPlayer
--local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
--mini-functions
do local a=getconnections or get_signal_cons;if a then for b,c in pairs(a(plr.Idled))do if c["Disable"]then c["Disable"](c)elseif c["Disconnect"]then c["Disconnect"](c)end end else plr.Idled:Connect(function()local d=game:GetService("VirtualUser")d:CaptureController()d:ClickButton2(Vector2.new())end)end end

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()
local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
	SubTitle = "BABFT",
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Amethyst"
})

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "factory" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}

getfenv().n7 = {
	theme = "Amethyst",
	transparency = true,
	goldfarm = false,
	goldskip = false,
	candyfarm = false,
	betacandy = false
}

local job = {
	workinggold = false,
	workingcandy = false,
	laststage = 1
}

task.spawn(function()
	xpcall(function()
		if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
			getfenv().n7 = game:GetService("HttpService"):JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
			Fluent:SetTheme(getfenv().n7.theme)
		end
	end, function()
		Fluent:Notify({
			Title = "nick7 hub | ERROR",
			Content = "Loading config wasn't successful!\nTry to re-create config file.",
			Duration = 12
		})
	end)
end)

local status = Tabs.Main:AddParagraph({Title = "Farm status will be here"})


Tabs.Main:AddToggle("GoldFarm", { Title = "Farm gold", Default = getfenv().n7.goldfarm or false, Callback = function(Value)
	getfenv().n7.goldfarm = Value
	task.spawn(function()
		while getfenv().n7.goldfarm do
			pcall(function()
				status:SetTitle("Waiting for character")
				status:SetDesc("")
				repeat task.wait() until plr.Character.HumanoidRootPart
				workspace.Gravity = 0
				local path = workspace.BoatStages.NormalStages
				for i = 1, 10 do
					status:SetTitle(string.format("Teleporting to stage (%s/10)",i))
					job.laststage = i
					job.workinggold = true
					local stage = path["CaveStage" .. i]
					do for _,b in workspace.BoatStages.NormalStages:GetChildren()do if string.find(b.Name,"CaveStage")then b.DarknessPart.Transparency=0.5 end end end
					plr.Character.HumanoidRootPart.CFrame = stage.DarknessPart.CFrame
					plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
					plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,-50)
					local spinny_animation_support = 1
					local spinny_animation = {"|", "/", "-", "\\"}
					for i=25,0,-1 do
						if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
						spinny_animation_support += 1
						status:SetDesc(string.format("Waiting %.1f %s", i / 10, spinny_animation[spinny_animation_support]))
						task.wait(0.1)
						if not getfenv().n7.goldfarm or Fluent.Unloaded then
							status:SetDesc("Stopped gold farm")
							return
						end
					end
					plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
				end
				if not getfenv().n7.goldfarm then
					status:SetDesc("Stopped gold farm")
					return
				end
				status:SetTitle("Finishing loop")
				workspace.Gravity = 196.1999969482422
				plr.Character.Humanoid:AddTag("PreDeathN7N7N7yk")
				if getfenv().n7.goldskip then
					status:SetTitle("Killing character")
					plr.Character.Humanoid.Health = 0
				else
					for i = 0, 15 do
						status:SetTitle(string.format("Collecting chest (%s/15)",i))
						plr.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 30, 0)
						task.wait(0.2)
						plr.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 15, 0)
						task.wait(0.5)
						repeat task.wait() 
							if not getfenv().n7.goldfarm then
								break
							end
						until not job.workingcandy
						if not getfenv().n7.goldfarm then
							break
						end
					end
					status:SetTitle("Waiting for new character")
				end
				repeat
					for _,v in pairs({"|", "/", "-", "\\"}) do
						status:SetDesc(string.format("Waiting %s", v))
						task.wait(0.2)
					end
				until plr.Character.HumanoidRootPart and not plr.Character.Humanoid:HasTag("PreDeathN7N7N7yk") and plr.Character.Humanoid.Health > 20
				job.workinggold = false
			end)
		end
		status:SetTitle("Farm status will be here")
		status:SetDesc("")
	end)
end})
if workspace:FindFirstChild("Houses") then
	Tabs.Main:AddToggle("CandyFarm", { Title = "Farm candy", Default = getfenv().n7.candyfarm or false, Callback = function(Value)
		getfenv().n7.candyfarm = Value
		task.spawn(function()
			while getfenv().n7.candyfarm do
				pcall(function()
					status:SetTitle("Starting candy farm")
					status:SetDesc(string.format("Houses left %s",#workspace.Houses:GetChildren()))
					for _,house in workspace.Houses:GetChildren() do
						if plr.Character:WaitForChild("HumanoidRootPart") then
							job.workingcandy = true
							workspace.Gravity = 0
							plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
							status:SetTitle("Teleporting to door")
							plr.Character.HumanoidRootPart.CFrame = house.Door.DoorInnerTouch.CFrame
							task.wait()
							if firetouchinterest and getfenv().n7.betacandy then -- buggy
								for i=0,10 do
									status:SetTitle(string.format("Triggering door (%s/10)",i))
									status:SetDesc(string.format("Houses left %s",#workspace.Houses:GetChildren()))
									plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
									plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
									firetouchinterest(plr.Character.HumanoidRootPart, house.Door.DoorInnerTouch.TouchInterest, 0)
									firetouchinterest(plr.Character.HumanoidRootPart, house.Door.DoorInnerTouch.TouchInterest, 1)
									task.wait(0.15)
								end
							else
								for i=1,4 do
									status:SetTitle(string.format("Triggering door (%s/4)",i))
									plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,40,0)
									plr.Character.HumanoidRootPart.CFrame = house.Door.DoorInnerTouch.CFrame
									task.wait(0.4)
									plr.Character.HumanoidRootPart.CFrame = CFrame.new(-242, 1000, 955)
									task.wait(0.1)
								end
								plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							end
							workspace.Gravity = 196.1999969482422
							status:SetDesc(string.format("Houses left %s",#workspace.Houses:GetChildren()))
						else
							local _ = plr.Character:WaitForChild("HumanoidRootPart")
						end
					end
					task.wait(.1)
				end)
				job.workingcandy = false
				if job.workinggold then
					repeat
						if not getfenv().n7.candyfarm then
							break
						end
						task.wait(.1)
					until #workspace.Houses:GetChildren() > 0
				else
					repeat
						task.wait(.1)
						status:SetTitle("Candy farm is on idle.")
						for _,v in pairs({"|", "/", "-", "\\"}) do
							status:SetDesc(string.format("Waiting for house %s", v))
							task.wait(0.2)
						end
						
						if not getfenv().n7.candyfarm or Fluent.Unloaded then
							break
						end
					until #workspace.Houses:GetChildren() > 0
				end
			end
			status:SetTitle("Farm status will be here")
			status:SetDesc("")
		end)
	end})
end

local UISection = Tabs.Settings:AddSection("Farm")

UISection:AddToggle("GoldSkip", { Title = "Farm only gold", Default = getfenv().n7.goldskip, Callback = function(Value)
	getfenv().n7.goldskip = Value
end})

if workspace:FindFirstChild("Houses") and firetouchinterest then
	UISection:AddToggle("BetaCandyFarm", { Title = "Unstable candy farm", Description = "Uses unstable touching system for candy farm.", Default = getfenv().n7.betacandy, Callback = function(Value)
		getfenv().n7.betacandy = Value
	end})
end

local UISection = Tabs.Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Values = Fluent.Themes,
	Default = getfenv().n7.theme or Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
		getfenv().n7.theme = Value
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = getfenv().n7.transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
		getfenv().n7.transparency = Value
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
				local ExportedConfiguration = game:GetService("HttpService"):JSONEncode(getfenv().n7)

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
			setclipboard("https://discord.gg/6tgCfU2fX8")
		end
	})
else
	Tabs.Credits:AddButton({
		Title = "Notify discord invite",
		Description = "nick7 community",
		Callback = function()
			Fluent:Notify({
				Title = "https://discord.gg/6tgCfU2fX8",
				Content = "nick7 discord invite",
				Duration = 20
			})
		end
	})
end

Window:SelectTab(1)

if workspace:FindFirstChild("Houses") and false then
	local keepFarm = true
	plr.OnTeleport:Connect(function(State)
		if keepFarm and queueteleport then
			queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/scripts/hub.lua"))()')
		end
	end)
end

Fluent:Notify({
	Title = "nick7 hub | Fluent",
	Content = "The script has been loaded.",
	Duration = 8
})

repeat task.wait(0.5) until Fluent.Unloaded --! DO NOT WRITE ANY CODE THAT IS NOT ABOUT UNLOADING --> !!BELOW!! <-- . IT WILL NOT WORK
getfenv().n7 = nil