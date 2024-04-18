-- made by nick7/kidnoob_you for scriptblox <3
local anti = game.Workspace:GetChildren()
for i,v in pairs(anti) do
	if v.Name == "Anti-Block" then
		v:Destroy()
	end
end
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
while getgenv().mmrp.Autofarm do
	local char = game.Players.LocalPlayer.Character
	if char and getRoot(char) then
		getRoot(char).CFrame = game:GetService("Workspace").Movers.Begining["Touch Me To Go to Spawn Area"].Head.CFrame
	end
	task.wait()
end