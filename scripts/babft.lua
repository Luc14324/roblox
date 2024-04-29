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
	autofarm = false
}

local Window = library:AddWindow("nick7 hub | BABFT", {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(160, 110),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})
local Tab = Window:AddTab("Main")

Tab:AddSwitch("Autofarm", function(Value)
	getgenv().n7.autofarm = Value
	while getgenv().n7.autofarm do
		game:GetService("Workspace").Gravity = 0
		local path = game:GetService("Workspace").BoatStages.NormalStages
		for i = 1, 10 do
			local stage = path["CaveStage" .. i]
			local darknessPart = stage.DarknessPart
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = stage.DarknessPart.CFrame
			game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
			task.wait(2.5)
		end
		game:GetService("Workspace").Gravity = 196.1999969482422
		for i = 1, 15 do
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame + Vector3.new(0, 20, 0)
			task.wait(.5)
		end
		wait(14)
		while true do
			local h = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			if h then
				break
			end
			task.wait()
		end
		task.wait()
	end
end)

Tab:AddButton("Destroy", function()
	imgui:Destroy()
end)

Tab:Show()
library:FormatWindows()
