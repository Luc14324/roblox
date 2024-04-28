getgenv().maxs_obby = {}
getgenv().maxs_obby.Autofarm = getgenv().maxs_obby.Autofarm or true  

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local auto = Instance.new("ScreenGui")
local background = Instance.new("Frame")
local top = Instance.new("Frame")
local title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local close = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local func = Instance.new("Frame")
local toggle = Instance.new("TextButton")
local visual = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local text = Instance.new("TextLabel")
local UIStroke = Instance.new("UIStroke")

auto.Name = "auto"
auto.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
auto.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
auto.ResetOnSpawn = false

background.Name = "background"
background.Parent = auto
background.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
background.BorderColor3 = Color3.fromRGB(0, 0, 0)
background.BorderSizePixel = 0
background.Position = UDim2.new(0.293393791, 0, 0.26638478, 0)
background.Size = UDim2.new(0.211787567, 0, 0.0983086675, 0)

top.Name = "top"
top.Parent = background
top.BackgroundColor3 = Color3.fromRGB(8, 142, 199)
top.BorderColor3 = Color3.fromRGB(0, 0, 0)
top.BorderSizePixel = 0
top.Position = UDim2.new(0, 0, 1.64073001e-07, 0)
top.Size = UDim2.new(1, 0, 0.319428891, 0)

title.Name = "title"
title.Parent = top
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 0.750
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0.223241597, 0, 0.0285714287, 0)
title.Size = UDim2.new(0.550458729, 0, 0.914285719, 0)
title.Font = Enum.Font.FredokaOne
title.Text = "Max's obby GUI"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

UICorner.Parent = title

close.Name = "close"
close.Parent = top
close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 0.800
close.BorderColor3 = Color3.fromRGB(0, 0, 0)
close.BorderSizePixel = 0
close.Position = UDim2.new(0.847094774, 0, 0.0285714287, 0)
close.Size = UDim2.new(0.134556562, 0, 0.914285719, 0)
close.Font = Enum.Font.FredokaOne
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 0, 4)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true

UICorner_2.Parent = close

func.Name = "func"
func.Parent = background
func.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
func.BackgroundTransparency = 1.000
func.BorderColor3 = Color3.fromRGB(0, 0, 0)
func.BorderSizePixel = 0
func.Position = UDim2.new(0, 0, 0.319429129, 0)
func.Size = UDim2.new(1, 0, 0.68057102, 0)

toggle.Name = "toggle"
toggle.Parent = func
toggle.AnchorPoint = Vector2.new(0, 0.5)
toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggle.BackgroundTransparency = 1.000
toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
toggle.BorderSizePixel = 0
toggle.Position = UDim2.new(0.0975474343, 0, 0.484200358, 0)
toggle.Size = UDim2.new(0.80733943, 0, 0.726777434, 0)
toggle.Font = Enum.Font.SourceSans
toggle.Text = ""
toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
toggle.TextSize = 14.000

visual.Name = "visual"
visual.Parent = toggle
if getgenv().maxs_obby.Autofarm then
	visual.BackgroundColor3 = Color3.new(0,1,0)
elseif not getgenv().maxs_obby.Autofarm then
	visual.BackgroundColor3 = Color3.new(1,0,0)
end
visual.BorderColor3 = Color3.fromRGB(0, 0, 0)
visual.BorderSizePixel = 0
visual.Position = UDim2.new(0.195898116, 0, 0.156313688, 0)
visual.Size = UDim2.new(0.114591189, 0, 0.669773281, 0)

UICorner_3.Parent = visual

text.Name = "text"
text.Parent = toggle
text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 1.000
text.BorderColor3 = Color3.fromRGB(0, 0, 0)
text.BorderSizePixel = 0
text.Position = UDim2.new(0.340908408, 0, 0.0434782617, 0)
text.Size = UDim2.new(0.496598452, 0, 0.913043499, 0)
text.Font = Enum.Font.Gotham
text.Text = "Toggle"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.TextSize = 14.000
text.TextWrapped = true

UIStroke.Name = "UIStroke"
UIStroke.Parent = visual
UIStroke.Color = Color3.new(1,1,1)
UIStroke.Thickness = 2.9
-------------------------------

close.Activated:Connect(function()
	auto:Destroy()
end)
toggle.Activated:Connect(function()
	if getgenv().maxs_obby.Autofarm then
		visual.BackgroundColor3 = Color3.new(1,0,0)
		getgenv().maxs_obby.Autofarm = false
	elseif not getgenv().maxs_obby.Autofarm then
		visual.BackgroundColor3 = Color3.new(0,1,0)
		getgenv().maxs_obby.Autofarm = true
	end
end)

task.spawn(function()
	while true do
		task.wait()
		if getgenv().maxs_obby.Autofarm then 
			local a = game:GetService("Workspace").Checkpoints:GetChildren()
			local char = game.Players.LocalPlayer.Character
			for i = 1, #a do
				task.wait()
				if char and getRoot(char) then
					getRoot(char).CFrame = game:GetService("Workspace").Checkpoints:FindFirstChild(i).CFrame
				end
			end
			task.wait()
			game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
		end
	end
end)

--*--*-- GUI DRAG --*--*--
local UserInputService = game:GetService("UserInputService")
local gui = background
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
