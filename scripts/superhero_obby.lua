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

local library, imgui = loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/imgui.lua"))()

getgenv().n7 = {
	autofarm = true
}

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local _levels = game:GetService("Workspace").PointFolder:GetChildren()

local Window = library:AddWindow("nick7 hub | Obby", {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(160, 120),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})
local Tab = Window:AddTab("Main")

Tab:AddSwitch("Autofarm", function(Value)
	getgenv().n7.autofarm = Value
	while getgenv().n7.autofarm do
		local char = game.Players.LocalPlayer.Character
		if char and getRoot(char) then
			getRoot(char).CFrame = game:GetService("Workspace").PointFolder:FindFirstChild(tostring(#_levels - 1)).CFrame
			game.ReplicatedStorage.Rebirth:FireServer("Actual")
		end
		task.wait()
	end
end)

Tab:AddButton("Destroy", function()
	imgui:Destroy()
end)

Tab:Show()
library:FormatWindows()
