local plr = game.Players.LocalPlayer
function getRoot(char)return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')end
local cage
do--[[CAGE]]if workspace:FindFirstChild("Cage (nick7hub)")then workspace:FindFirstChild("Cage (nick7hub)"):Destroy()end;local a=Instance.new("Folder",workspace)a.Name="Cage (nick7hub)"local b=Color3.fromRGB(79,79,79)local c=Vector3.new(math.random(-100000,100000),math.random(-50,1500),math.random(-100000,100000))local d=Instance.new("Part",a)local e=Instance.new("Part",a)local f=Instance.new("Part",a)local g=Instance.new("Part",a)local h=Instance.new("Part",a)local i=Instance.new("Part",a)local j={d,e,f,g,h,i}for k,l in pairs(j)do l.Anchored=true;l.Transparency=0.4;l.Color=b;l.Name="discord.gg/NGAaby4y4b"end;d.Position=Vector3.new(0,0,0)+c;e.Position=Vector3.new(5,5,0)+c;f.Position=Vector3.new(-5,5,0)+c;g.Position=Vector3.new(0,5,-5)+c;h.Position=Vector3.new(0,5,5)+c;i.Position=Vector3.new(0,10,0)+c;d.Size=Vector3.new(10,1,10)e.Size=Vector3.new(1,10,10)f.Size=Vector3.new(1,10,10)g.Size=Vector3.new(10,10,1)h.Size=Vector3.new(10,10,1)i.Size=Vector3.new(10,1,10)local m=c+Vector3.new(0,4,0)cage=CFrame.new(m)end

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