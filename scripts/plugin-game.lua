-- made by nick7/kidnoob_you for <2 minutes
-- example game: https://www.roblox.com/games/16597722190/Pet-Explore
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
while getgenv().pluginGame.Autofarm do
	local coins = game:GetService("Workspace").Map.CollectAreas.Area:GetChildren()
	local char = game.Players.LocalPlayer.Character
	for i, v in pairs(coins) do
		if char and getRoot(char) then
			v.Position = getRoot(char).Position
		end
	end
	if getgenv().pluginGame.Autorebirth then
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Rebirth"):FireServer()
	end
	task.wait()
end