-- made by nick7/kidnoob_you
-- support me @ https://link-hub.net/1135925/support-nick7

-- Gui to Lua
-- Version: 3.2

-- Instances:

local babft_stages = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local top = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local func = Instance.new("Frame")
local icon = Instance.new("ImageLabel")
local name = Instance.new("TextLabel")
local num = Instance.new("TextLabel")
local selected = Instance.new("TextLabel")
local minus = Instance.new("TextButton")
local plus = Instance.new("TextButton")

--Properties:

babft_stages.Name = "babft_stages"
babft_stages.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
babft_stages.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
babft_stages.ResetOnSpawn = false

main.Name = "main"
main.Parent = babft_stages
main.AnchorPoint = Vector2.new(0.5, 0)
main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
main.BorderColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, 0, 0.0949999988, 0)
main.Size = UDim2.new(0.231865287, 0, 0.198731497, 0)

top.Name = "top"
top.Parent = main
top.BackgroundColor3 = Color3.fromRGB(225, 2, 255)
top.BorderColor3 = Color3.fromRGB(0, 0, 0)
top.BorderSizePixel = 0
top.Size = UDim2.new(1, 0, 0.127659574, 0)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(205, 5, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient.Parent = top

title.Name = "title"
title.Parent = top
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0.315642446, 0, 0, 0)
title.Size = UDim2.new(0.365921795, 0, 1, 0)
title.Font = Enum.Font.Gotham
title.Text = "babft stages"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

close.Name = "close"
close.Parent = top
close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 0.300
close.BorderColor3 = Color3.fromRGB(0, 0, 0)
close.BorderSizePixel = 0
close.Position = UDim2.new(0.849161983, 0, 0, 0)
close.Size = UDim2.new(0.150837988, 0, 1, 0)
close.Font = Enum.Font.Gotham
close.Text = "Close"
close.TextColor3 = Color3.fromRGB(255, 0, 4)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true

func.Name = "func"
func.Parent = main
func.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
func.BackgroundTransparency = 1.000
func.BorderColor3 = Color3.fromRGB(0, 0, 0)
func.BorderSizePixel = 0
func.Position = UDim2.new(0, 0, 0.127659574, 0)
func.Size = UDim2.new(1, 0, 0.872340441, 0)

icon.Name = "icon"
icon.Parent = func
icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
icon.BorderSizePixel = 0
icon.Position = UDim2.new(0.0352356993, 0, 0.0548780486, 0)
icon.Size = UDim2.new(0.279181123, 0, 0.603902519, 0)
icon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

name.Name = "name"
name.Parent = func
name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
name.BorderColor3 = Color3.fromRGB(0, 0, 0)
name.BorderSizePixel = 0
name.Position = UDim2.new(0.357541889, 0, 0.0548780486, 0)
name.Size = UDim2.new(0.575418949, 0, 0.256097555, 0)
name.Font = Enum.Font.Gotham
name.Text = "stage name"
name.TextColor3 = Color3.fromRGB(0, 0, 0)
name.TextScaled = true
name.TextSize = 14.000
name.TextWrapped = true

num.Name = "num"
num.Parent = func
num.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
num.BorderColor3 = Color3.fromRGB(0, 0, 0)
num.BorderSizePixel = 0
num.Position = UDim2.new(0.357541889, 0, 0.402439028, 0)
num.Size = UDim2.new(0.575418949, 0, 0.256097555, 0)
num.Font = Enum.Font.Gotham
num.Text = "stage num"
num.TextColor3 = Color3.fromRGB(0, 0, 0)
num.TextScaled = true
num.TextSize = 14.000
num.TextWrapped = true

selected.Name = "selected"
selected.Parent = func
selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
selected.BorderColor3 = Color3.fromRGB(0, 0, 0)
selected.BorderSizePixel = 0
selected.Position = UDim2.new(0.432999998, 0, 0.699999988, 0)
selected.Size = UDim2.new(0.128000006, 0, 0.256000012, 0)
selected.Font = Enum.Font.Gotham
selected.Text = "1"
selected.TextColor3 = Color3.fromRGB(0, 0, 0)
selected.TextScaled = true
selected.TextSize = 14.000
selected.TextWrapped = true

minus.Name = "minus"
minus.Parent = func
minus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minus.BorderColor3 = Color3.fromRGB(0, 0, 0)
minus.BorderSizePixel = 0
minus.Position = UDim2.new(0.284999996, 0, 0.699999988, 0)
minus.Size = UDim2.new(0.128491625, 0, 0.256097555, 0)
minus.Font = Enum.Font.Gotham
minus.Text = "-"
minus.TextColor3 = Color3.fromRGB(0, 0, 0)
minus.TextScaled = true
minus.TextSize = 14.000
minus.TextWrapped = true

plus.Name = "plus"
plus.Parent = func
plus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
plus.BorderColor3 = Color3.fromRGB(0, 0, 0)
plus.BorderSizePixel = 0
plus.Position = UDim2.new(0.578000009, 0, 0.699999988, 0)
plus.Size = UDim2.new(0.128000006, 0, 0.256000012, 0)
plus.Font = Enum.Font.Gotham
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

-----------------------------
local path = game.Workspace.BoatStages.StageInfo
local var_selected = 1

plus.Activated:Connect(function()
	if not (var_selected >= 9) then
		var_selected = var_selected + 1
		selected.Text = tostring(var_selected)
		local res_icon = path:FindFirstChild("Stage"..var_selected).StageIcon.Value
		icon.Image = res_icon
		local res_name = path:FindFirstChild("Stage"..var_selected).StageName.Value
		name.Text = res_name
		local res_num = path:FindFirstChild("Stage"..var_selected).StageNum.Value
		num.Text = tostring(res_num)
	else
		task.spawn(function()
			selected.BackgroundColor3 = Color3.fromRGB(255,0,0)
			selected.TextColor3 = Color3.fromRGB(255,255,255)
			task.wait(0.2)
			selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selected.TextColor3 = Color3.fromRGB(0,0,0)
		end)
	end
end)

minus.Activated:Connect(function()
	if not (var_selected <= 1) then
		var_selected = var_selected - 1
		selected.Text = tostring(var_selected)
		local res_icon = path:FindFirstChild("Stage"..var_selected).StageIcon.Value
		icon.Image = res_icon
		local res_name = path:FindFirstChild("Stage"..var_selected).StageName.Value
		name.Text = res_name
		local res_num = path:FindFirstChild("Stage"..var_selected).StageNum.Value
		num.Text = tostring(res_num)
	else
		task.spawn(function()
			selected.BackgroundColor3 = Color3.fromRGB(255,0,0)
			selected.TextColor3 = Color3.fromRGB(255,255,255)
			task.wait(0.2)
			selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selected.TextColor3 = Color3.fromRGB(0,0,0)
		end)
	end
end)

close.Activated:Connect(function()
	babft_stages:Destroy()
end)

function getMaxStages()
	local stages_table = path:GetChildren()
	return #stages_table
end

task.spawn(function() -- title
	local prev_text = title.Text
	while true do
		title.Text = prev_text
		task.wait(2)
		title.Text = "Max stages: "..tostring(getMaxStages())
		task.wait(2)
	end
end)

--*--*-- GUI DRAG --*--*--
local UserInputService = game:GetService("UserInputService")
local gui = main
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