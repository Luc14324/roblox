--made by kidnoob_you/nick7 for scriptblox with <3
-- support me @ https://link-hub.net/1135925/support-nick7
if game.PlaceId == 537413528 then
	local GuiService = game:GetService("GuiService")
	local Players = game:GetService("Players")
	local TeleportService = game:GetService("TeleportService")
	local PlaceId = game.PlaceId
	local JobId = game.JobId
	task.spawn(function()
		while getgenv().babftn7 do
			game:GetService("Workspace").Gravity = 0
			local path = game:GetService("Workspace").BoatStages.NormalStages
			for i = 1, 10 do
				local stage = path["CaveStage" .. i]
				local darknessPart = stage.DarknessPart
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = stage.DarknessPart.CFrame
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

	GuiService.ErrorMessageChanged:Connect(function()
		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("\nRejoining...")
			wait()
			TeleportService:Teleport(PlaceId, Players.LocalPlayer)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
		end
	end)
else
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "can't launch babft autofarm here!";
		Color = Color3.fromRGB(255, 0, 4);
		Font = Enum.Font.Fantasy
	})	
end