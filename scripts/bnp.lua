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
if workspace.Map.Classic:FindFirstChild("KillBrick") then
	workspace.Map.Classic.KillBrick:Destroy()
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
	SubTitle = "Blocks n' Props",
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

local AutoFinish = Tabs.Main:AddToggle("AutoFinish", { Title = "Auto-finish", Description = "Will automatically finish round as playing team.", Default = false})
AutoFinish:OnChanged(function(Value)
	g.n7.autofarm = Value
	while g.n7.autofarm do
		if plr.Team.Name == "Destroyer" then
			repeat
				task.wait(1)
				if plr.Character:FindFirstChild("Head") then
					plr.Character:WaitForChild("Humanoid").Health = 0
					if plr.Character:FindFirstChild("Humanoid").Health ~= 100 then
						plr.Character.Head:Destroy()
					end
				elseif plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(0,-1000000,0)
				task.wait(0.5)
				end
			until plr.Team.Name ~= "Destroyer" or Fluent.Unloaded or not g.n7.autofarm
		elseif plr.Team.Name == "Towers" then
			repeat task.wait(0.1) until plr.Character:WaitForChild("HumanoidRootPart")
			repeat
			plr.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace.Map.Classic.Button.CFrame	
				task.wait(0.5)
			until plr.Team.Name ~= "Towers" or Fluent.Unloaded or not g.n7.autofarm
		end
		task.wait(0.4)
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