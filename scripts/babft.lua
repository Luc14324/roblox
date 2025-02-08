--' Script made by Stonifam. Thanks for at least viewing source code xd
task.spawn(function()
	local msg = Instance.new("Hint", workspace)
    msg.Text = "Started loading nick7 hub, please wait... // "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Build A Boat For Treasure"
    task.wait(5)
    msg:Destroy()
end)
local xm
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
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
local zf=''if xm then zf = " | DEBUG"end
local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
	SubTitle = `BABFT{zf}`,
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Amethyst"
})zf=nil

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "factory" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}

if xm then
	Tabs.Debug = Window:AddTab({ Title = "DEBUG", Icon = "bug" })
end

local n7 = {
	theme = "Amethyst",
	transparency = true,
	goldfarm = false,
	goldskip = false,
	candyfarm = false,
	betacandy = false,
	rendering = true,
	rendering_gui = true,
	gb_only = false,
	autorejoin = true,
	autoexec = false
}
local job = {
	workinggold = false,
	workingcandy = false,
	laststage = 1
}
if not xm then
	task.spawn(function()
		xpcall(function()
			if getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.n7", game.GameId)) and getfenv().readfile(string.format("%s.n7", game.GameId)) then
				n7 = game:GetService("HttpService"):JSONDecode(getfenv().readfile(string.format("%s.n7", game.GameId)))
				Fluent:SetTheme(n7.theme)
			end
		end, function()
			Fluent:Notify({
				Title = "nick7 hub | ERROR",
				Content = "Loading config wasn't successful!\nTry to re-create config file.",
				Duration = 12
			})
		end)
	end)
end

local status = Tabs.Main:AddParagraph({Title = "Farm status will be here"})

local n7fps
local stattext
--Status Text Placeholder
local stp = {
	`<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Total gold farmed: %i | Per minute: %i\nTotal gold blocks farmed: %i</font>\n\n<font size="30">Status: %s</font>`,
	`<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Total candy farmed: %i\nBlue candys farmed: %i\nPurple candys farmed: %i\nOrange candys farmed: %i\nPink candys farmed: %i</font>\n\n<font size="30">Status: %s</font>`,
	`Total gold farmed: %i | Per minute: %i\nTotal gold blocks farmed: %i`
}
local stp_default = `<font size="25">nick7 hub autofarm | Disabled 3D rendering</font>\n\n<font size="35">Nothing to display!\nStart a farm to change this text</font>`

local gold_path = plr.Data.Gold
local gold_block_path = plr.Data.GoldBlock
local start_gold = plr.Data.Gold.Value
local start_gold_block = plr.Data.GoldBlock.Value
local saved_gold = 0
local gpm = 0
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
function getp(id:number) -- get preset
	if id == 1 or id == 3 then
		if n7.goldskip then
			return string.format(string.gsub(stp[id], "\nTotal gold blocks farmed: ..", ""), (gold_path.Value-start_gold), gpm, "%s")
		elseif n7.gb_only then
			return string.format(string.gsub(stp[id], "Total gold farmed: .. | Per minute: ..\n", ""), (gold_block_path.Value-start_gold_block), "%s")
		else
			return string.format(stp[id], (gold_path.Value-start_gold), gpm, (gold_block_path.Value - start_gold_block), "%s")
		end
	elseif id == 2 then
		return string.format(stp[id], (c.path.blue.Value+c.path.orange.Value+c.path.pink.Value+c.path.purple.Value)-(c.start.blue+c.start.orange+c.start.pink+c.start.purple), c.path.blue.Value-c.start.blue, c.path.purple.Value-c.start.purple, c.path.orange.Value-c.start.orange, c.path.pink.Value-c.start.pink, "%s")
	end
end

function t(id,text)
	if n7fps then stattext.Text = string.format(getp(id), text) end
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

function gold()
	local tx = os.clock()
	local function chest()
		local h = plr.Character:FindFirstChild("HumanoidRootPart")
		local fog = game:GetService("Lighting").FogEnd
		local count = 0
		local spinny_animation_support = 1
		local spinny_animation = {"|", "/", "-", "\\"}
		local critical_mode = false
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
			status:SetDesc(`Tried {count} time(-s){critical_string}\n{getp(3)}`)
			t(1,`Collecting chest (tried {count} time(-s)) {spinny_animation[spinny_animation_support]}{critical_string}`)
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
					status:SetDesc(`{x}\n{getp(3)}`)
					t(1,x)
					plr.Character.Humanoid.Health = 0
				end
			end
			repeat task.wait()
				if not n7.goldfarm then
					break
				end
			until not job.workingcandy
			if not n7.goldfarm then
				break
			end
		until game:GetService("Lighting").FogEnd ~= fog or Fluent.Unloaded or not n7.goldfarm or plr.Character.Humanoid.Health <20
	end
	xpcall(function()
		status:SetTitle("Waiting for character")
		status:SetDesc(getp(3))
		repeat task.wait() until plr.Character
		workspace.Gravity = 0
		local path = workspace.BoatStages.NormalStages
		local t1 = os.clock()
		if not n7.gb_only then
			for istage = 1, max do
				status:SetTitle(`Teleporting to stage ({istage}/{max})`)
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
					--local statustext = string.format("(Stage %i/%i) Waiting %.1f %s", istage, max, i / 10, spinny_animation[spinny_animation_support])
					local statustext = `Waiting {i/10} {spinny_animation[spinny_animation_support]}`
					status:SetDesc(`{statustext}\n{getp(3)}`)
					t(1, `(Stage {istage}/{max}) {statustext}`)
					task.wait(0.1)
					if not n7.goldfarm or Fluent.Unloaded then
						status:SetDesc("Stopped gold farm")
						return
					end
				end
				plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
			end
			if not n7.goldfarm then
				status:SetDesc("Stopped gold farm")
				return
			end
			status:SetTitle("Finishing loop")
			workspace.Gravity = 196.1999969482422
			plr.Character.Humanoid:AddTag("PreDeathN7N7N7yk")
			if n7.goldskip then
				status:SetTitle("Killing character")
				plr.Character.Humanoid.Health = 0
			else
				chest()
				status:SetTitle("Waiting for character...")
			end
		else
			status:SetTitle("Started gold block farm")
			t(1,"Started gold block farm")
			task.wait(0.1)
			local spinny_animation_support = 1
			local spinny_animation = {"|", "/", "-", "\\"}
			repeat task.wait(0.05)
				if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
				spinny_animation_support += 1
				status:SetTitle(string.format("Waiting for character %s", spinny_animation[spinny_animation_support]))
				t(1,`Waiting for character {spinny_animation[spinny_animation_support]}`)
			until plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") or Fluent.Unloaded or not n7.goldfarm
			local h = plr.Character:FindFirstChild("HumanoidRootPart")
			status:SetTitle("Teleporting to stage 1")
			for i=0,2 do
				local statustext = `Triggering stage 1 ({i}/4)`
				status:SetDesc(`{statustext}\n{getp(3)}`)
				t(1,statustext)
				h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame + Vector3.new(0,0,-20)
				game:GetService("TweenService"):Create(h,TweenInfo.new(0.6,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{CFrame=workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame}):Play()
				task.wait(0.7)
			end
			local statustext = `Triggering stage 1 (3/4)`
			status:SetDesc(`{statustext}\n{getp(3)}`)
			t(1,statustext)
			plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
			plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
			h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame
			plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,-50)
			task.wait(0.3)
			local statustext = `Triggering stage 1 (4/4)`
			status:SetDesc(`{statustext}\n{getp(3)}`)
			t(1,statustext)
			h.CFrame = workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame + Vector3.new(0,0,-20)
			game:GetService("TweenService"):Create(h,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{CFrame=workspace.BoatStages.NormalStages.CaveStage1.DarknessPart.CFrame+Vector3.new(0,0,20)}):Play()
			for i=25,0,-1 do
				if spinny_animation_support >= #spinny_animation then spinny_animation_support = 1 end
				spinny_animation_support += 1
				local statustext = string.format("Waiting %.1f %s", i / 10, spinny_animation[spinny_animation_support])
				status:SetDesc(`{statustext}\n{getp(3)}`)
				t(1,statustext)
				task.wait(0.1)
				if not n7.gb_only or Fluent.Unloaded then
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
		local statustext = "Waiting for character"
		status:SetDesc(`{statustext}\n{getp(3)}`)
		t(1,`(Loop restart) {statustext}`)
		saved_gold = gold_path.Value
		plr.CharacterAdded:Wait()
		repeat
			game:GetService("RunService").RenderStepped:Wait()
			task.wait() -- attempt to save from complete client freeze
		until plr.Character:FindFirstChild("HumanoidRootPart") and not plr.Character.Humanoid:HasTag("PreDeathN7N7N7yk") and plr.Character.Humanoid.Health > 20
 		if not n7.gb_only then -- ignore, function didn't worked correctly with `or`.
			task.wait(0.1)
			tx = os.clock()
			repeat
				task.wait(0.1) -- random number
				workspace.ClaimRiverResultsGold:FireServer() -- to solve count gold on 2nd stage
				local statustext = "Getting gold"
				status:SetDesc(`{statustext}\n{getp(3)}`)
				t(1,statustext)
			until gold_path.Value ~= saved_gold or not n7.goldfarm or Fluent.Unloaded or (os.clock()-tx)>3 -- in rare cases
		end
		t(1,"Updating GPM")
		if xm then
			print("-===-")
			print(`gold.Value = {gold_path.Value} ;; saved_gold = {saved_gold}`)
			print(`t1 = {t1} ;; tx = {tx}`)
			print('-===-')
		end
		gpm = (gold_path.Value-saved_gold)/((tx-t1)/60)
		t(1,"Waiting for new loop to start")
		job.workinggold = false
	end, function(err)
		if xm then
			warn(err)
		end
	end)
	status:SetDesc("")
end

local goldfarm = Tabs.Main:AddToggle("GoldFarm", { Title = "Farm gold", Default = n7.goldfarm or false})
task.spawn(function()
	while game:GetService("RunService").RenderStepped:Wait() and not Fluent.Unloaded do
		local x = "Gold and gold blocks"
		if n7.gb_only then
			x = string.gsub(x, "Gold and g", "G")
		elseif n7.goldskip then
			x = string.gsub(x, " and gold blocks", "")
		end
		goldfarm:SetDesc(`Farming: {x}`)
	end
end)
goldfarm:OnChanged(function(Value)
	n7.goldfarm = Value
	task.spawn(function()
		if n7.goldfarm then
			while n7.goldfarm and not Fluent.Unloaded do
				gold()
				workspace.ClaimRiverResultsGold:FireServer()
			end
			t(1,"Finished gold farm")
		end
		status:SetTitle("Farm status will be here")
		status:SetDesc("")
	end)
end)
if workspace:FindFirstChild("Houses") then
	Tabs.Main:AddToggle("CandyFarm", { Title = "Farm candy", Default = n7.candyfarm or false, Callback = function(Value)
		n7.candyfarm = Value
		task.spawn(function()
			while n7.candyfarm and not Fluent.Unloaded do
				pcall(function()
					status:SetTitle("Starting candy farm")
					t(2,"Starting candy farm.")
					local statustext = string.format("Houses left %s",#workspace.Houses:GetChildren())
					status:SetDesc(statustext)
					t(2,statustext)
					for _,house in workspace.Houses:GetChildren() do
						if plr.Character:WaitForChild("HumanoidRootPart") then
							job.workingcandy = true
							workspace.Gravity = 0
							plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
							status:SetTitle("Teleporting to door")
							t(2,"Teleporting to door")
							plr.Character.HumanoidRootPart.CFrame = house.Door.DoorInnerTouch.CFrame
							task.wait()
							if firetouchinterest and n7.betacandy then -- buggy
								for i=0,10 do
									t(2,`Triggering door ({i}/10`)
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
									local s = `Triggering door ({i}/4)`
									status:SetTitle(s)
									t(2,s)
									plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,40,0)
									plr.Character.HumanoidRootPart.CFrame = house.Door.DoorInnerTouch.CFrame
									task.wait(0.4)
									plr.Character.HumanoidRootPart.CFrame = CFrame.new(-242, 1000, 955)
									task.wait(0.1)
								end
								plr.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
							end
							workspace.Gravity = 196.1999969482422
							status:SetDesc(`Houses left {#workspace.Houses:GetChildren()}`)
						else
							plr.CharacterAdded:Wait()
						end
					end
					task.wait(.1)
				end)
				job.workingcandy = false
				if job.workinggold then
					repeat
						if not n7.candyfarm then
							break
						end
						task.wait(.1)
					until #workspace.Houses:GetChildren() > 0
				else
					repeat
						task.wait(.1)
						status:SetTitle("Candy farm is on idle.")
						for _,v in pairs({"|", "/", "-", "\\"}) do
							local s = `Waiting for house {v}`
							t(2,s)
							status:SetDesc(s)
							task.wait(0.2)
						end
						if not n7.candyfarm or Fluent.Unloaded then
							break
						end
					until #workspace.Houses:GetChildren() > 0
				end
			end
			t(2,"Finished candy farm")
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

	UISection:AddToggle("Rendering", { Title = "Toggle 3D rendering", Description = "Roblox uses less system resources to render.", Default = n7.rendering, Callback = function(Value)
		n7.rendering = Value
		game:GetService("RunService"):Set3dRenderingEnabled(Value)
		if n7fps and n7.rendering_gui then
			n7fps.Enabled = not Value
		end
	end})
	UISection:AddToggle("Rendering", { Title = "Toggle GUI", Description = "Gives you useful information about autofarm", Default = n7.rendering_gui, Callback = function(Value)
		n7.rendering_gui = Value
		if n7fps and not n7.rendering then
			n7fps.Enabled = Value
		end
	end})
else
	n7fps:Destroy()
end

local UISection = Tabs.Settings:AddSection("Farm")

local goldskip = UISection:AddToggle("GoldSkip", { Title = "Farm only gold", Default = n7.goldskip})
local gb_only = UISection:AddToggle("GoldBlockOnly", { Title = "Farm only gold blocks", Default = n7.gb_only})
local aa=""if not queueteleport then aa="Pointless without auto-execution.\nYour exploit doesn't support queueteleport"end
local autorejoin = UISection:AddToggle("AutoRejoin", { Title = "Auto-rejoin", Description = aa, Default = n7.autorejoin})aa=nil
if queueteleport then
	local autoexec = UISection:AddToggle("AutoExec", { Title = "Auto-execute", Description="Will automatically execute autofarm when auto-rejoin is enabled", Default = n7.autoexec})
	autoexec:OnChanged(function(Value)
		n7.autoexec = Value
	end)
end

goldskip:OnChanged(function(v)
	n7.goldskip = v
end)
gb_only:OnChanged(function(v)
	n7.gb_only = v
end)
local fa = 0
autorejoin:OnChanged(function(Value)
	n7.autorejoin = Value
	if Value and fa==0 then
		fa+=1
		GuiService.ErrorMessageChanged:Connect(function()
			if n7.autorejoin then
				if #plrs:GetPlayers() <= 1 then
					plrs.LocalPlayer:Kick("\nRejoining...")
					task.wait()
					TeleportService:Teleport(game.PlaceId, plr)
				else
					TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
				end
			end
		end)
	elseif fa ~= 0 and Value then
		Fluent:Notify({
			Title = "nick7 hub | WARN",
			Content = "Already enabled!",
			Duration = 20
		})
	end
end)
plr.OnTeleport:Connect(function()
	if n7.autoexec and queueteleport then
		queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/scripts/hub.lua"))()')
	end
end)

if workspace:FindFirstChild("Houses") and firetouchinterest then
	UISection:AddToggle("BetaCandyFarm", { Title = "Unstable candy farm", Description = "Uses unstable touching system for candy farm.", Default = n7.betacandy, Callback = function(Value)
		n7.betacandy = Value
	end})
end

local UISection = Tabs.Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Values = Fluent.Themes,
	Default = n7.theme or Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
		n7.theme = Value
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = n7.transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
		n7.transparency = Value
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
				local ExportedConfiguration = game:GetService("HttpService"):JSONEncode(n7)

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
if xm then
	task.spawn(function()local a=Instance.new("Message",workspace)a.Text="Loaded debug mode";task.wait(10)a:Destroy()end)local dstat = Tabs.Debug:AddParagraph({Title = "debug"})
	Tabs.Debug:AddButton({
		Title = "gold test",Description = "doesn't work, so debug mode is pointless",Callback = function()
			n7.goldfarm = true
			local gtime={}
			for u,y in pairs({{gb_only = false, goldskip = false}, {gb_only = false, goldskip = true}, {gb_only = true, goldskip = false}}) do
				n7.gb_only = y.gb_only
				n7.goldskip = y.goldskip
				for n,m in y do
					local name = `{u}g`
					n7.gb_only = m[1]
					n7.goldskip = m[2]
					for x=0,2 do
						local t=os.clock()
						dstat:SetDesc(`{name} ({x}/3)`)
						gold()
						gtime[name]=''
						gtime[name] = `{gtime[name]}, {tostring(math.floor(os.clock()-t))}`
					end
				end
			end
			for f,l in pairs(gtime) do
				print(`{f}: {l} //dbg`)
			end
			n7.goldfarm = false
		end
	})
end

stattext.Text = stp_default

Window:SelectTab(1)

if workspace:FindFirstChild("Houses") and false then
	plr.OnTeleport:Connect(function()
		if n7.autoexec and queueteleport then
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
n7 = nil
if n7fps then n7fps:Destroy();game:GetService("RunService"):Set3dRenderingEnabled(true) end