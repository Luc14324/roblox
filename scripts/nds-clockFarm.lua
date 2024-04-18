--[[
by
       _      _    ______
      (_)    | |  |___  /
 _ __  _  ___| | __  / / 
| '_ \| |/ __| |/ / / /  
| | | | | (__|   <./ /   
|_| |_|_|\___|_|\_\_/    
                         for scriptblox
                         with little bit broken gui
]]

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ClockFarm = Instance.new("ScreenGui")
local functions = Instance.new("Frame")
local top = Instance.new("Frame")
local exit = Instance.new("TextButton")
local grav1 = Instance.new("TextButton")
local grav2 = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")
local offset = Instance.new("Frame")
local get = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local clockButtons = Instance.new("Folder")
local clear = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local tp2guy = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")

--Properties:

ClockFarm.Name = "ClockFarm"
ClockFarm.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ClockFarm.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ClockFarm.ResetOnSpawn = false

functions.Name = "functions"
functions.Parent = ClockFarm
functions.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
functions.BorderColor3 = Color3.fromRGB(0, 0, 0)
functions.BorderSizePixel = 0
functions.Position = UDim2.new(0.550193071, 0, 0.259809107, 0)
functions.Size = UDim2.new(0.192406654, 0, 0.189638385, 0)

top.Name = "top"
top.Parent = functions
top.BackgroundColor3 = Color3.fromRGB(183, 0, 255)
top.BorderColor3 = Color3.fromRGB(0, 0, 0)
top.BorderSizePixel = 0
top.Size = UDim2.new(1.00000024, 0, 0.107382551, 0)

exit.Name = "exit"
exit.Parent = top
exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
exit.BorderSizePixel = 0
exit.Position = UDim2.new(0.779264212, 0, 0, 0)
exit.Size = UDim2.new(0.220735788, 0, 1, 0)
exit.Font = Enum.Font.FredokaOne
exit.Text = "exit"
exit.TextColor3 = Color3.fromRGB(0, 0, 0)
exit.TextScaled = true
exit.TextSize = 14.000
exit.TextWrapped = true

grav1.Name = "grav1"
grav1.Parent = top
grav1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
grav1.BorderColor3 = Color3.fromRGB(0, 0, 0)
grav1.BorderSizePixel = 0
grav1.Size = UDim2.new(0.220735788, 0, 1, 0)
grav1.Font = Enum.Font.FredokaOne
grav1.Text = "no gravity"
grav1.TextColor3 = Color3.fromRGB(0, 0, 0)
grav1.TextScaled = true
grav1.TextSize = 14.000
grav1.TextWrapped = true

grav2.Name = "grav2"
grav2.Parent = top
grav2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
grav2.BorderColor3 = Color3.fromRGB(0, 0, 0)
grav2.BorderSizePixel = 0
grav2.Position = UDim2.new(0.25418061, 0, 0, 0)
grav2.Size = UDim2.new(0.220735788, 0, 1, 0)
grav2.Font = Enum.Font.FredokaOne
grav2.Text = "return gravity"
grav2.TextColor3 = Color3.fromRGB(0, 0, 0)
grav2.TextScaled = true
grav2.TextSize = 14.000
grav2.TextWrapped = true

UIListLayout.Parent = functions
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0.0299999993, 0)

offset.Name = "offset"
offset.Parent = functions
offset.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
offset.BackgroundTransparency = 1.000
offset.BorderColor3 = Color3.fromRGB(0, 0, 0)
offset.BorderSizePixel = 0
offset.Position = UDim2.new(0.33277598, 0, 0.137381941, 0)
offset.Size = UDim2.new(0, 100, 0, -4)

get.Name = "get"
get.Parent = functions
get.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
get.BorderColor3 = Color3.fromRGB(0, 0, 0)
get.BorderSizePixel = 0
get.Position = UDim2.new(0.163879633, 0, 0.161073819, 0)
get.Size = UDim2.new(0.668896437, 0, 0.161073819, 0)
get.Font = Enum.Font.FredokaOne
get.Text = "Get avaliable clocks"
get.TextColor3 = Color3.fromRGB(0, 0, 0)
get.TextScaled = true
get.TextSize = 14.000
get.TextWrapped = true

UICorner.Parent = get

clockButtons.Name = "clockButtons"
clockButtons.Parent = functions

clear.Name = "clear"
clear.Parent = functions
clear.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
clear.BorderColor3 = Color3.fromRGB(0, 0, 0)
clear.BorderSizePixel = 0
clear.Position = UDim2.new(0.163879633, 0, 0.161073819, 0)
clear.Size = UDim2.new(0.668896437, 0, 0.161073819, 0)
clear.Font = Enum.Font.FredokaOne
clear.Text = "Clear clock tp buttons"
clear.TextColor3 = Color3.fromRGB(0, 0, 0)
clear.TextScaled = true
clear.TextSize = 14.000
clear.TextWrapped = true

UICorner_2.Parent = clear

tp2guy.Name = "tp2guy"
tp2guy.Parent = functions
tp2guy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tp2guy.BorderColor3 = Color3.fromRGB(0, 0, 0)
tp2guy.BorderSizePixel = 0
tp2guy.Position = UDim2.new(0.163879633, 0, 0.161073819, 0)
tp2guy.Size = UDim2.new(0.668896437, 0, 0.161073819, 0)
tp2guy.Font = Enum.Font.FredokaOne
tp2guy.Text = "teleport to guy"
tp2guy.TextColor3 = Color3.fromRGB(0, 0, 0)
tp2guy.TextScaled = true
tp2guy.TextSize = 14.000
tp2guy.TextWrapped = true

UICorner_3.Parent = tp2guy

-- Scripts:

local function GKSH_fake_script() -- exit.LocalScript 
	local script = Instance.new('LocalScript', exit)

	script.Parent.Activated:Connect(function()
		script.Parent.Parent.Parent.Parent:Destroy()
	end)
end
coroutine.wrap(GKSH_fake_script)()
local function BLIZXNS_fake_script() -- grav1.LocalScript 
	local script = Instance.new('LocalScript', grav1)

	script.Parent.Activated:Connect(function()
		workspace.Gravity = 0
	end)
end
coroutine.wrap(BLIZXNS_fake_script)()
local function IXNSE_fake_script() -- grav2.LocalScript 
	local script = Instance.new('LocalScript', grav2)

	script.Parent.Activated:Connect(function()
		workspace.Gravity = 196.1999969482422
	end)
end
coroutine.wrap(IXNSE_fake_script)()
local function AQZG_fake_script() -- get.LocalScript 
	local script = Instance.new('LocalScript', get)

	function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	local function getPart(obj)
		for i, v in pairs(obj:GetDescendants()) do
			if v.ClassName == "Part" then
				return v
			end
		end
	end
	function createButton(num, obj)
		local example = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		example.Name = "tp2"..num
		example.Parent = script.Parent.Parent
		example.BackgroundColor3 = Color3.fromRGB(255, 137, 3)
		example.BorderColor3 = Color3.fromRGB(0, 0, 0)
		example.BorderSizePixel = 0
		example.Position = UDim2.new(0.19314386, 0, 0.331610769, 0)
		example.Size = UDim2.new(0.329431534, 0, 0.161073819, 0)
		example.Font = Enum.Font.FredokaOne
		example.Text = "tp to "..num
		example.TextColor3 = Color3.fromRGB(0, 0, 0)
		example.TextScaled = true
		example.TextSize = 14.000
		example.TextWrapped = true
		example:SetAttribute("isClockButton", true)
		UICorner.Parent = example
		task.spawn(function()
			example.Activated:Connect(function()
				local char = game.Players.LocalPlayer.Character
				if char and getRoot(char) then
					getRoot(char).CFrame = getPart(obj).CFrame
				end
			end)
		end)
	end
	script.Parent.Activated:Connect(function()
		local clocks = workspace.Clocks:GetChildren()
		script.Parent.Text = "Total clocks: "..#clocks
		if #clocks ~= 0 then
			for i, v in pairs(clocks) do
				createButton(i, v)
			end
		else
			script.Parent.Text = "No clocks!"
		end
	end)
end
coroutine.wrap(AQZG_fake_script)()
local function FRUGE_fake_script() -- clear.LocalScript 
	local script = Instance.new('LocalScript', clear)

	script.Parent.Activated:Connect(function()
		local all = script.Parent.Parent:GetChildren()
		for i,v in pairs(all) do
			if v:GetAttribute("isClockButton") then
				v:Destroy()
			end
		end
	end)
end
coroutine.wrap(FRUGE_fake_script)()
local function KRFGJN_fake_script() -- tp2guy.LocalScript
	local script = Instance.new('LocalScript', tp2guy)
	script.Parent.Activated:Connect(function()
		local char = game.Players.LocalPlayer.Character
		if char and getRoot(char) then
			getRoot(char).CFrame = CFrame.new(-320, 194, 323)
		end
	end)
end
coroutine.wrap(KRFGJN_fake_script)()
local function INSYQN_fake_script() -- functions.GUI drag 
	local script = Instance.new('LocalScript', functions)

	--*--*-- GUI DRAG --*--*--
	local UserInputService = game:GetService("UserInputService")
	local gui = functions
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(INSYQN_fake_script)()
