-- made by kidnoob_you with <3 to scriptblox
-- support me @ https://link-hub.net/1135925/support-nick7
local Player = game.Players.LocalPlayer.Character
local Money = game:GetService("Workspace").Buildings.DeadBurger.DumpsterMoneyMaker.MoneyHitbox
Money.Rotation = Vector3.new(0,0,0)
local TweenService = game:GetService("TweenService")
if getgenv().bdfs.VisibleHitbox then
	Money.Transparency = 0.8
else
	Money.Transparency = 1
end
if getgenv().bdfs.LoadGui then
	loadstring(game:HttpGet("https://gitverse.ru/api/repos/stonifam/scripts/raw/branch/master/bdfs-gui"))() -- gui
end
--*--*--*-- AFK spot thingy --*--*--*--
local _color = Color3.new(0.231373, 0.231373, 0.231373)
local _offset = Vector3.new(math.random(-100000, 100000), math.random(-50,500), math.random(-100000,100000))
local floor = Instance.new("Part")
floor.Anchored = true
floor.Position = Vector3.new(0, 0, 0) + _offset
floor.Size = Vector3.new(10,1,10)
floor.Parent = workspace
floor.Transparency = 0.4
local wall1 = Instance.new("Part")
wall1.Anchored = true
wall1.Size = Vector3.new(1, 10, 10)
wall1.Position = Vector3.new(5, 5, 0) + _offset
wall1.Transparency = 0.4
wall1.Parent = workspace
local wall2 = Instance.new("Part")
wall2.Anchored = true
wall2.Size = Vector3.new(1, 10, 10)
wall2.Position = Vector3.new(-5, 5, 0) + _offset
wall2.Transparency = 0.4
wall2.Parent = workspace
local wall3 = Instance.new("Part")
wall3.Anchored = true
wall3.Size = Vector3.new(10, 10, 1)
wall3.Position = Vector3.new(0, 5, -5) + _offset
wall3.Transparency = 0.4
wall3.Parent = workspace
local wall4 = Instance.new("Part")
wall4.Anchored = true
wall4.Size = Vector3.new(10, 10, 1)
wall4.Position = Vector3.new(0, 5, 5) + _offset
wall4.Transparency = 0.4
wall4.Parent = workspace
local ceiling = Instance.new("Part")
ceiling.Anchored = true
ceiling.Position = Vector3.new(0, 10, 0) + _offset
ceiling.Size = Vector3.new(10,1,10)
ceiling.Parent = workspace
ceiling.Transparency = 0.4
floor.Color = _color
wall1.Color = _color
wall2.Color = _color
wall3.Color = _color
wall4.Color = _color
ceiling.Color = _color
getgenv().bdfs.DONOTCHANGE.offset = _offset + Vector3.new(0,5,0)
--*--*--*-- end of the thingy --*--*--*--
function a()
	for _,v in pairs(workspace:GetChildren()) do
		if v.Name == "Trashcan" and v:IsA("UnionOperation") then
			if #v:GetChildren() ~= 2 then
				v:Destroy()
			end
		end
	end
end
a()
function GetChildrenOfClass(parentObject, className)
	local allChildren = parentObject:GetChildren()
	local filteredChildren = {}
	for i, child in ipairs(allChildren) do
		if child:IsA(className) then
			table.insert(filteredChildren, child)
		end
	end
	return filteredChildren
end
function autoequip()
	local parts = GetChildrenOfClass(game.Players.LocalPlayer.Character, "Tool")
	for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.name == "Garbage Bag" then
			if #parts == 0 then
				v.Parent = game.Players.LocalPlayer.Character
			end
		end
	end
end

function eat()
	if not game.Players.LocalPlayer.Backpack:FindFirstChild("Burger") then
		fireclickdetector(game:GetService("Workspace").Buildings.DeadBurger.burgre.ClickDetector)
	end
	wait(0.1)
	local _burger = game.Players.LocalPlayer.Backpack:WaitForChild("Burger")
	_burger.Parent = Player
	_burger:Activate()
	wait(1.5)
end

for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
	if v.Name == "Trashcan" and v:IsA("UnionOperation") then
		while wait(0.01) do
			if getgenv().bdfs.Autofarm then
				if getgenv().bdfs.UseTweenMethod then
					local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
					local hunger = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Hunger").Hunger.Value
					local tween = TweenService:Create(Money, tweenInfo, {Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position})
					tween:Play()
					wait(0.43)
					Money.Position = Player.HumanoidRootPart.Position + Vector3.new(10,0,0)
					fireclickdetector(v.ClickDetector)
					fireclickdetector(game:GetService("Workspace").Buildings["Red House"].Computer.Monitor.Part.ClickDetector)
					autoequip()
					if hunger < 50 then
						eat()
						wait(1)
					end
				else
					local hunger = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Hunger").Hunger.Value
					Money.Position = Player.HumanoidRootPart.Position
					Money.Rotation = Money.Rotation + Vector3.new(3,3,3)
					fireclickdetector(v.ClickDetector)
					fireclickdetector(game:GetService("Workspace").Buildings["Red House"].Computer.Monitor.Part.ClickDetector)
					autoequip()
					wait(0.1)
					Money.Position = Money.Position + Vector3.new(30,0,0)
					if hunger < 50 then
						eat()
						wait(1)
					end
				end
			end
		end
	end
end