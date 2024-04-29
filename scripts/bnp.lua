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

if game.Workspace.Map.Classic.KillBrick then
	game.Workspace.Map.Classic.KillBrick:Destroy()
end

local Window = library:AddWindow("nick7 hub | BnP", {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(160, 120),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})
local Tab = Window:AddTab("Main")

Tab:AddSwitch("Autofarm", function(Value)
	getgenv().n7.autofarm = Value
	while getgenv().n7.autofarm do
		if game.Players.LocalPlayer.Team.Name == "Destroyer" then
			repeat
				if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
					if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 100 then
						game.Players.LocalPlayer.Character.Head:Destroy()
					end
				end
				task.wait()
			until game.Players.LocalPlayer.Team.Name ~= "Destroyer"
		elseif game.Players.LocalPlayer.Team.Name == "Towers" then
			local _l = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			repeat 
				wait(.1)
			until _l
			game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game:GetService("Workspace").Map.Classic.Button.CFrame
		end
		wait(.4)
	end
end)

Tab:AddButton("Destroy", function()
	imgui:Destroy()
end)

Tab:Show()
library:FormatWindows()
