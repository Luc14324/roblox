local plr = game.Players.LocalPlayer
local char = plr.Character
local trigger = workspace.Lobby.Elevator.Trigger

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

function getRoot(char)
    char = char or plr.Character or plr.CharacterAdded:Wait()
    local rootPart = char:WaitForChild('HumanoidRootPart') or char:WaitForChild('Torso') or char:WaitForChild('UpperTorso')
    return rootPart
end

getgenv().n7 = {
    cage = CFrame.new(0,0,0),
    loop_tp = false
}

-- CAGE
if workspace:FindFirstChild("Cage (nick7hub)") then workspace:FindFirstChild("Cage (nick7hub)"):Destroy() end
local folder = Instance.new("Folder", workspace)
folder.Name = "Cage (nick7hub)"
local _color = Color3.fromRGB(79, 79, 79)
local _offset = Vector3.new(math.random(-100000, 100000), math.random(-50,1500), math.random(-100000,100000))
--+ Creating
local floor = Instance.new("Part", folder)
local wall1 = Instance.new("Part", folder)
local wall2 = Instance.new("Part", folder)
local wall3 = Instance.new("Part", folder)
local wall4 = Instance.new("Part", folder)
local ceiling = Instance.new("Part", folder)
local parts = {floor,wall1,wall2,wall3,wall4,ceiling}
--+ sum things
for _,v in pairs(parts) do
	v.Anchored = true
	v.Transparency = 0.4
	v.Color = _color
	v.Name = "discord.gg/6tgCfU2fX8"
end
--+ Position
floor.Position = Vector3.new(0, 0, 0) + _offset
wall1.Position = Vector3.new(5, 5, 0) + _offset
wall2.Position = Vector3.new(-5, 5, 0) + _offset
wall3.Position = Vector3.new(0, 5, -5) + _offset
wall4.Position = Vector3.new(0, 5, 5) + _offset
ceiling.Position = Vector3.new(0, 10, 0) + _offset
--+ Size
floor.Size = Vector3.new(10,1,10)
wall1.Size = Vector3.new(1, 10, 10)
wall2.Size = Vector3.new(1, 10, 10)
wall3.Size = Vector3.new(10, 10, 1)
wall4.Size = Vector3.new(10, 10, 1)
ceiling.Size = Vector3.new(10,1,10)
--
local frame = _offset + Vector3.new(0,4,0)
getgenv().n7.cage = CFrame.new(frame)
-- CAGE

local library, imgui = loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/imgui.lua"))()

local window = library:AddWindow("nick7 hub | Elevator", {
	main_color = Color3.fromRGB(41, 74, 122),
	min_size = Vector2.new(170, 120),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})
local main = window:AddTab("Main")

main:AddSwitch("Autofarm", function(Value)
	getgenv().n7.autofarm = Value
    if getgenv().n7.autofarm then
        if char and getRoot(char) then
            getRoot(char).CFrame = trigger.CFrame
            task.wait(4)
            while getgenv().n7.autofarm do
                getRoot(char).CFrame = getgenv().n7.cage
                task.wait()
            end
        end
    end
end)

main:AddButton("Destroy", function()
	imgui:Destroy()
end)

main:Show()
library:FormatWindows()
