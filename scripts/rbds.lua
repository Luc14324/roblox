-- made by nick7 with <3
-- scripts used: https://pastebin.com/raw/Cmm23T9g and https://pastebin.com/raw/jj3gMMVD

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

local library, imgui = loadstring(game:HttpGet("https://raw.githubusercontent.com/WhateverNick7/roblox/main/imgui.lua"))()

getgenv().n7 = {
	autofarm = false,
	annoy = false
}

local Window = library:AddWindow("nick7 hub | RBDS", {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(160, 160),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})
local Tab = Window:AddTab("Main")

Tab:AddButton("Unlock VIP", function()
	if workspace:FindFirstChild("VIPDoor") and workspace:FindFirstChild("SuperVIPDoor") then
		workspace.VIPDoor:Destroy()
		workspace.SuperVIPDoor:Destroy()
	end
end)

Tab:AddSwitch("Autofarm", function(Value)
	getgenv().n7.autofarm = Value
	local parts = game:GetService("Workspace"):GetChildren()
	while getgenv().n7.autofarm do
		for i, v in pairs(parts) do
			if v.Name == "SpawnLocation" then
				v.CanCollide = false
				v.Position = game.Players.LocalPlayer.Character.Torso.Position + Vector3.new(0,40,0)
				task.wait()
				v.Position = game.Players.LocalPlayer.Character.Torso.Position
			end
		end
	end
end)

Tab:AddSwitch("Annoy", function(Value)
	local spawners = {}
	getgenv().n7.annoy = Value
	while getgenv().n7.annoy do
		local objects = game:GetService("Workspace"):GetChildren()
		for i, v in pairs(objects) do
			if v then
				if v.Name == "Model1" then
					for a, b in pairs(v:GetChildren()) do
						if b.Name == "Regen Button" then
							table.insert(spawners, b)
						end
					end
				end
			end
		end
		for i,v in pairs(spawners) do
			task.spawn(function()
				local _ = v.Position
				v.CanCollide = false
				v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				wait(0.1)
				v.Position = _
			end)
		end
		task.wait()
	end
end)

Tab:AddButton("Destroy", function()
	imgui:Destroy()
end)

Tab:Show()
library:FormatWindows()
