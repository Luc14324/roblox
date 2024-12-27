-- nick7 hub: cart ride around nothing (10660791703) // by stonifam
-- 0% UNC required, Anti-AFK is optional

local plr = game:GetService("Players").LocalPlayer

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

local Window = Fluent:CreateWindow({
	Title = "nick7 hub",
    SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 30,
	Size = UDim2.fromOffset(370, 280),
	Acrylic = false,
	Theme = "Dark"
})

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "factory" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	Credits = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}

Tabs.Main:AddButton({
    Title = "Complete cart ride",
    Description = "Will automatically finish CRAN",
    Callback = function()
        if plr.Character then
            local pre_enter_door_pos = workspace.CartCheckRoom.DoorPairEntrance.L.Position

            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChild("Humanoid")

            humanoid.Sit = false
            task.wait()
            root.CFrame = workspace.CartCheckRoom.TriggerZone.CFrame

            repeat task.wait() until workspace.CartCheckRoom.DoorPairEntrance.L.Position ~= pre_enter_door_pos or Fluent.Unloaded

            root.CFrame = workspace.CartCheckRoom.HumanoidCheckZone.CFrame
            humanoid.Sit = true

            local pre_open_door_pos = workspace.CartCheckRoom.DoorPairExit.L.Position

            repeat task.wait() until workspace.CartCheckRoom.DoorPairExit.L.Position ~= pre_open_door_pos or Fluent.Unloaded

            humanoid.Sit = false
            
            local platform = Instance.new("Part", workspace)
            platform.Size = Vector3.new(15,2,15)
            platform.Color = Color3.fromRGB(79, 79, 79)
            platform.Transparency = 0.4
            platform.Anchored = true
            platform.Position = workspace.CartCheckRoomFinish.TriggerZone.Position + Vector3.new(0, -2.5, 0)

            local pre_enter_win_door_pos = workspace.CartCheckRoomFinish.DoorPairEntrance.L.Position

            root.CFrame = CFrame.new(workspace.CartCheckRoomFinish.TriggerZone.Position)

            repeat task.wait() until workspace.CartCheckRoomFinish.DoorPairEntrance.L.Position ~= pre_enter_win_door_pos or Fluent.Unloaded

            local pre_open_win_door_pos = workspace.CartCheckRoomFinish.DoorPairExit.L.Position
            
            root.CFrame = CFrame.new(workspace.CartCheckRoomFinish.HumanoidCheckZone.Position)
            humanoid.Sit = true
            platform:Destroy()

            repeat task.wait() until workspace.CartCheckRoomFinish.DoorPairExit.L.Position ~= pre_open_win_door_pos

            humanoid.Sit = false
            root.CFrame = CFrame.new(workspace.Misc.WinnerSpawnLocation.Position+Vector3.new(0,2.5,0))

            Fluent:Notify({
                Title = "nick7 hub | Info",
                Content = "Finished auto-complete.",
                Duration = 8
            })
        end
    end
})

local UISection = Tabs.Settings:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Values = Fluent.Themes,
	Default = Fluent.Theme,
	Callback = function(Value)
		Fluent:SetTheme(Value)
	end
})

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = Fluent.Transparency,
	Callback = function(Value)
		Fluent:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift"})
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

Tabs.Credits:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script is made by Stonifam\nUsing forked Fluent UI lib by @ttwiz_z"
})


if setclipboard then
	Tabs.Credits:AddButton({
		Title = "Copy discord invite",
		Description = "nick7 community",
		Callback = function()
			setclipboard("https://discord.gg/6tgCfU2fX8")
		end
	})
else
	Tabs.Credits:AddButton({
		Title = "Notify discord invite",
		Description = "nick7 community",
		Callback = function()
			Fluent:Notify({
				Title = "https://discord.gg/6tgCfU2fX8",
				Content = "nick7 discord invite",
				Duration = 20
			})
		end
	})
end

Window:SelectTab(1)

Fluent:Notify({
	Title = "nick7 hub | Fluent",
	Content = "The script has been loaded.",
	Duration = 8
})

local GC = getconnections or get_signal_cons
if GC then
    for _,v in pairs(GC(plr.Idled)) do
        if v["Disable"] then
            v["Disable"](v)
        elseif v["Disconnect"] then
            v["Disconnect"](v)
        end
    end
else
    plr.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end