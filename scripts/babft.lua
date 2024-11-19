--' Script made by Stonifam. Thanks for at least viewing source code xd
task.spawn(function()
	local msg = Instance.new("Hint", workspace)
    msg.Text = "Started loading nick7 hub, please wait.. // BABFT"
    task.wait(5)
    msg:Destroy()
end)
local plr = game:GetService("Players").LocalPlayer
--local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
--mini-functions
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
	betacandy = false,
	rendering = true,
	rendering_gui = true,
	gb_only = false
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

function u(unit, time)
	return unit/(time/60)
end

local n7fps
local stattext
--Status Text Placeholder
local stp = { --defaults, so I could revert to it :V
	`<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Total gold farmed: %i | Per minute: %i\nTotal gold blocks farmed: %i</font>\n\n<font size="30">Status: %s</font>`,
	`<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Total candy farmed: %i\nBlue candys farmed: %i\nPurple candys farmed: %i\nOrange candys farmed: %i\nPink candys farmed: %i</font>\n\n<font size="30">Status: %s</font>`
}
local stp_gold = stp[1]
local stp_candy = stp[2]
local stp_default = `<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Nothing to display!\nStart a farm to change this text</font>`

local gold_path = plr.Data.Gold
local gold_block_path = plr.Data.GoldBlock
local start_gold = plr.Data.Gold.Value
local start_gold_block = plr.Data.GoldBlock.Value
local saved_gold = 0
local c= {
	start = {
		blue = plr.Data.CandyBlue.Value,
		orange = plr.Data.CandyOrange.Value,
		pink = plr.Data.CandyPink.Value,
		purple = plr.Data.CandyPurple.Value
	},
	path = {
		blue = plr.Data.CandyBlue,
		orange = plr.Data.CandyOrange,
		pink = plr.Data.CandyPink,
		purple = plr.Data.CandyPurple
	}
}
function getp(id:number, arg:table) -- get preset
	if id == 1 then
		if arg ~= nil and #arg == 2 then
			saved_gold = u(arg[1], arg[2])
		end
		if getfenv().n7.goldskip then
			return string.format(string.gsub(stp[1], "\nTotal gold blocks farmed: ..", ""), (gold_path.Value-start_gold), saved_gold, "%s")
		elseif getfenv().n7.gb_only then
			return string.format(string.gsub(stp[1], "Total gold farmed: .. | Per minute: ..\n", ""), (gold_block_path.Value-start_gold_block), "%s")
		else
			return string.format(stp_gold, (gold_path.Value-start_gold), saved_gold, (gold_block_path.Value - start_gold_block), "%s")
		end
	elseif id == 2 then
		return string.format(stp_candy, (c.path.blue.Value+c.path.orange.Value+c.path.pink.Value+c.path.purple.Value)-(c.start.blue+c.start.orange+c.start.pink+c.start.purple), c.path.blue.Value-c.start.blue, c.path.purple.Value-c.start.purple, c.path.orange.Value-c.start.orange, c.path.pink.Value-c.start.pink, "%s")
	end
end

do -- Rendering // white screen hurts my eyes
	function randomString() -- from iy
		local length = math.random(10,20)
		local array = {}
		for i = 1, length do
			array[i] = string.char(math.random(32, 126))
		end
		return table.concat(array)
	end
	n7fps = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
	n7fps.ResetOnSpawn = false
	local Frame = Instance.new("Frame", n7fps)
	stattext = Instance.new("TextLabel", Frame)
	n7fps.Enabled = false
	n7fps.Name = randomString()
	n7fps.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	n7fps.IgnoreGuiInset = true
	Frame.Name = randomString()
	Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Frame.Size = UDim2.new(1, 0, 1, 0)
	stattext.Name = randomString()
	stattext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	stattext.BackgroundTransparency = 1.000
	stattext.Size = UDim2.new(1, 0, 1, 0)
	stattext.Font = Enum.Font.SourceSans
	stattext.RichText = true
	stattext.Text = stp_default
	stattext.TextColor3 = Color3.fromRGB(209, 209, 209)
	stattext.TextScaled = false
	stattext.TextSize = 14.000
	stattext.TextWrapped = true
end
local max = 0
for _,v in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
	if string.match(v.Name, "CaveStage") then
		max += 1
	end
end
Tabs.Main:AddToggle("GoldFarm", { Title = "Farm gold", Default = getfenv().n7.goldfarm or false, Callback = function(Value)
	getfenv().n7.goldfarm = Value
	task.spawn(function()
		local time = os.clock()
		local first_launch = true
		local function chest()
			local h = plr.Character:FindFirstChild("HumanoidRootPart")
			local fog = game:GetService("Lighting").FogEnd
			local count = 0
			local spinny_animation_support = 1
			local spinny_animation = {"|", "/", "-", "\\"}
			local critical_mode = false -- if chest won't trigger in <critical> tries
			local critical = 10
			local _critical_string = `\nCritical mode. {critical}+ tries`
			local critical_string=""
			repeat
				if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
				spinny_animation_support += 1
				count += 1
				critical_mode = count >= critical
				if count >= critical then critical_string = _critical_string end
				status:SetTitle(string.format(`Collecting chest...`))
				status:SetDesc(`Tried {count} time(-s){critical_string}`)
				if n7fps then stattext.Text = string.format(getp(1), `Collecting chest (tried {count} time(-s)) {spinny_animation[spinny_animation_support]}{critical_string}`) end
				if not critical_mode then
					h.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(-10, 30, 0)
					task.wait(0.2)
					h.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 15, 0)
					task.wait(0.5)
				else
					if count < 20 then
						workspace.Gravity = 0
						h.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 30, -50)
						task.wait(0.2)
						game:GetService("TweenService"):Create(h, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame}):Play()
						task.wait(0.6)
						workspace.Gravity = 196.1999969482422
					elseif count < 30 then
						workspace.Gravity = 0
						h.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 30, -50)
						task.wait(0.2)
						game:GetService("TweenService"):Create(h, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame}):Play()
						task.wait(1.3)
						workspace.Gravity = 196.1999969482422
					elseif count >= 30 then
						local x = "Too much tries. Resetting character."
						status:SetDesc(x)
						if n7fps then stattext.Text = string.format(getp(1), x) end
						plr.Character.Humanoid.Health = 0
					end
				end
				repeat task.wait()
					if not getfenv().n7.goldfarm then
						break
					end
				until not job.workingcandy
				if not getfenv().n7.goldfarm then
					break
				end
			until game:GetService("Lighting").FogEnd ~= fog or Fluent.Unloaded or not getfenv().n7.goldfarm or plr.Character.Humanoid.Health <20
		end

		if getfenv().n7.goldfarm then
			while getfenv().n7.goldfarm and not Fluent.Unloaded do
				xpcall(function()
					local t1 = os.clock()
					status:SetTitle("Waiting for character")
					status:SetDesc("")
					repeat task.wait() until plr.Character:FindFirstChild("HumanoidRootPart")
					local g1 = gold_path.Value
					saved_gold = gold_path.Value
					if not getfenv().n7.gb_only then -- ignore, function didn't worked correctly with `or`.
						if not first_launch then
							task.wait(0.1)
							repeat
								task.wait(0.05) -- random number
								workspace.ClaimRiverResultsGold:FireServer() -- to solve count gold on 2nd stage
								local statustext = "Getting gold"
								status:SetDesc(statustext)
								if n7fps then stattext.Text = string.format(getp(1), statustext) end
							until gold_path.Value ~= saved_gold or not getfenv().n7.goldfarm or Fluent.Unloaded
						end
					end
					saved_gold = gold_path.Value
					if n7fps then stattext.Text = string.format(getp(1, {saved_gold-g1, t1-time}), "Updating GPM") end
					workspace.Gravity = 0
					local path = workspace.BoatStages.NormalStages
					time = os.clock()
					if not getfenv().n7.gb_only then
						for istage = 1, max do
							status:SetTitle(string.format("Teleporting to stage (%i/%i)",istage,max))
							job.laststage = istage
							job.workinggold = true
							local stage = path["CaveStage" .. istage]
							do for _,b in workspace.BoatStages.NormalStages:GetChildren()do if string.find(b.Name,"CaveStage")then b.DarknessPart.Transparency=0.5 end end end
							plr.Character.HumanoidRootPart.CFrame = stage.DarknessPart.CFrame
							plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,-50)
							local spinny_animation_support = 1
							local spinny_animation = {"|", "/", "-", "\\"}
							for i=25,0,-1 do
								if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
								spinny_animation_support += 1
								local statustext = string.format("(Stage %i/%i) Waiting %.1f %s", istage, max, i / 10, spinny_animation[spinny_animation_support])
								status:SetDesc(statustext)
								if n7fps then stattext.Text = string.format(getp(1), statustext) end
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
							chest()
							status:SetTitle("Waiting for character...")
						end
					else
						status:SetTitle("Started gold block farm")
						if n7fps then stattext.Text = string.format(getp(1), "Started gold block farm") end
						task.wait(0.1)
						local spinny_animation_support = 1
						local spinny_animation = {"|", "/", "-", "\\"}
						repeat task.wait(0.05)
							if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
							spinny_animation_support += 1
							status:SetTitle(string.format("Waiting for character %s", spinny_animation[spinny_animation_support]))
							if n7fps then stattext.Text = string.format(getp(1), `Waiting for character {spinny_animation[spinny_animation_support]}`) end
						until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") or Fluent.Unloaded or not getfenv().n7.goldfarm
						local h = plr.Character:FindFirstChild("HumanoidRootPart")
						status:SetTitle("Teleporting to stage 1")
						for i=0,2 do
							local statustext = `Triggering stage 1 ({i}/4)`
							status:SetDesc(statustext)
							if n7fps then stattext.Text = string.format(getp(1), statustext) end
							h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame + Vector3.new(0,0,-20)
							game:GetService("TweenService"):Create(h,TweenInfo.new(0.6,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{CFrame=workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame}):Play()
							task.wait(0.7)
						end
						local statustext = `Triggering stage 1 (3/4)`
						status:SetDesc(statustext)
						if n7fps then stattext.Text = string.format(getp(1), statustext) end
						plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
						plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
						h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame
						plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,-50)
						task.wait(0.3)
						local statustext = `Triggering stage 1 (4/4)`
						status:SetDesc(statustext)
						if n7fps then stattext.Text = string.format(getp(1), statustext) end
						h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame + Vector3.new(0,0,-20)
						game:GetService("TweenService"):Create(h,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{CFrame=workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame+Vector3.new(0,0,20)}):Play()
						for i=25,0,-1 do
							if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
							spinny_animation_support += 1
							local statustext = string.format("Waiting %.1f %s", i / 10, spinny_animation[spinny_animation_support])
							status:SetDesc(statustext)
							if n7fps then stattext.Text = string.format(getp(1), statustext) end
							task.wait(0.1)
							if not getfenv().n7.gb_only or Fluent.Unloaded then
								status:SetDesc("Stopped gold farm")
								return
							end
						end
						status:SetDesc("")
						plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
						workspace.Gravity = 196.1999969482422
						plr.Character.Humanoid:AddTag("PreDeathN7N7N7yk")
						chest()
					end
					repeat
						for _,v in pairs({"|", "/", "-", "\\"}) do
							local statustext = string.format("Waiting for character %s", v)
							status:SetDesc(statustext)
							if n7fps then stattext.Text = string.format(getp(1), "(Loop restart) "..statustext) end
							task.wait(0.2)
						end
					until plr.Character.HumanoidRootPart and not plr.Character.Humanoid:HasTag("PreDeathN7N7N7yk") and plr.Character.Humanoid.Health > 20
					local t2 = os.clock()
	
					if n7fps then stattext.Text = string.format(getp(1), "Waiting for new loop to start") end
					first_launch = false
					job.workinggold = false
				end, function(err)
					print(err)
				end)
			end
			if n7fps then stattext.Text = string.format(getp(1), "Finished gold farm") end
		end
		status:SetTitle("Farm status will be here")
		status:SetDesc("")
	end)
end})
if workspace:FindFirstChild("Houses") then
	Tabs.Main:AddToggle("CandyFarm", { Title = "Farm candy", Default = getfenv().n7.candyfarm or false, Callback = function(Value)
		getfenv().n7.candyfarm = Value
		task.spawn(function()
			while getfenv().n7.candyfarm and not Fluent.Unloaded do
				pcall(function()
					status:SetTitle("Starting candy farm")
					if n7fps then stattext.Text = string.format(getp(2), "Starting candy farm.") end
					local statustext = string.format("Houses left %s",#workspace.Houses:GetChildren())
					status:SetDesc(statustext)
					if n7fps then stattext.Text = string.format(getp(2), statustext) end
					for _,house in workspace.Houses:GetChildren() do
						if plr.Character:WaitForChild("HumanoidRootPart") then
							job.workingcandy = true
							workspace.Gravity = 0
							plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
							status:SetTitle("Teleporting to door")
							if n7fps then stattext.Text = string.format(getp(2), "Teleporting to door") end
							plr.Character.HumanoidRootPart.CFrame = house.Door.DoorInnerTouch.CFrame
							task.wait()
							if firetouchinterest and getfenv().n7.betacandy then -- buggy
								for i=0,10 do
									if n7fps then stattext.Text = string.format(getp(2), string.format("Triggering door (%i/10)",i)) end
									status:SetTitle(string.format("Triggering door (%i/10)",i))
									status:SetDesc(string.format("Houses left %i",#workspace.Houses:GetChildren()))
									plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
									plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
									firetouchinterest(plr.Character.HumanoidRootPart, house.Door.DoorInnerTouch.TouchInterest, 0)
									firetouchinterest(plr.Character.HumanoidRootPart, house.Door.DoorInnerTouch.TouchInterest, 1)
									task.wait(0.15)
								end
							else
								for i=1,4 do
									status:SetTitle(string.format("Triggering door (%s/4)",i))
									if n7fps then stattext.Text = string.format(getp(2), string.format("Triggering door (%s/4)",i)) end
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
							if n7fps then stattext.Text = string.format(getp(2), string.format("Waiting for house %s", v)) end
							status:SetDesc(string.format("Waiting for house %s", v))
							task.wait(0.2)
						end
						if not getfenv().n7.candyfarm or Fluent.Unloaded then
							break
						end
					until #workspace.Houses:GetChildren() > 0
				end
			end
			if n7fps then stattext.Text = string.format(getp(2), "Finished candy farm") end
			status:SetTitle("Farm status will be here")
			status:SetDesc("")
		end)
	end})
end

local rendering_toggle = false -- DO NOT TRUST THIS TITLE. I meant if rendering toggle is possible.
pcall(function()
	game:GetService("RunService"):Set3dRenderingEnabled(true)
	rendering_toggle = true
end)

if rendering_toggle then
	local UISection = Tabs.Settings:AddSection("Rendering")

	UISection:AddToggle("Rendering", { Title = "Toggle 3D rendering", Description = "Roblox uses less system resources to render.", Default = getfenv().n7.rendering, Callback = function(Value)
		getfenv().n7.rendering = Value
		game:GetService("RunService"):Set3dRenderingEnabled(Value)
		if n7fps and getfenv().n7.rendering_gui then
			n7fps.Enabled = not Value
		end
	end})
	UISection:AddToggle("Rendering", { Title = "Toggle GUI", Description = "Gives you useful information about autofarm", Default = getfenv().n7.rendering_gui, Callback = function(Value)
		getfenv().n7.rendering_gui = Value
		if n7fps and not getfenv().n7.rendering then
			n7fps.Enabled = Value
		end
	end})
else
	n7fps:Destroy()
end

local UISection = Tabs.Settings:AddSection("Farm")

local goldskip = UISection:AddToggle("GoldSkip", { Title = "Farm only gold", Default = getfenv().n7.goldskip})
local gb_only = UISection:AddToggle("GoldBlockOnly", { Title = "Farm only gold blocks", Description = "May be broken\nreport bugs to discord server", Default = getfenv().n7.gb_only})

goldskip:OnChanged(function(v)
	getfenv().n7.goldskip = v
end)
gb_only:OnChanged(function(v)
	getfenv().n7.gb_only = v
end)

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

stattext.Text = stp_default

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
if n7fps then n7fps:Destroy();game:GetService("RunService"):Set3dRenderingEnabled(true) end