local RunService = game:GetService("RunService")
local lp = game:GetService("Players").LocalPlayer
local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(lp.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	lp.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

getgenv().n7 = {
	vip = true,
	farmtab = {
		farm = false,
		farmw = "RareM4A1",
		farmxp = false
	},
	clubtab = {
		club = {
			name = "cool name",
			color = Color3.fromRGB(255,0,0),
			decal = "rbxassetid://5205790785",
			description = "cool description"
		},
		evade = false
	},
	target = {
		user = nil,
		trade = false,
		member = false,
		kill = false,
	}
}

function match(s1, s2)
	return string.match(string.lower(s1), string.lower(s2))
end

local replicated = game:GetService("ReplicatedStorage")
local ui = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()
local Window = ui:CreateWindow({
	Title = "nick7 hub",
	SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	TabWidth = 100,
	Size = UDim2.fromOffset(470, 300),
	Acrylic = false,
	Theme = "Amethyst"
})
local tabs = {
    main = Window:AddTab({ Title = "Main & Misc", Icon = "banknote" }),
	target = Window:AddTab({ Title = "Targeting", Icon = "target" }),
    weapons = Window:AddTab({ Title = "Weapons", Icon = "skull" }),
    club = Window:AddTab({ Title = "Club", Icon = "flag"}),
    cfg = Window:AddTab({ Title = "Settings", Icon = "cog"}),
    creds = Window:AddTab({ Title = "Credits", Icon = "person-standing"})
}
local section = {
	farming = tabs.main:AddSection("Farming"),
	world = tabs.main:AddSection("World"),
	equipment = tabs.main:AddSection("Equipment"),
	buying = tabs.weapons:AddSection("Buying"),
	clubEvade = tabs.club:AddSection("Club evading"),
	clubCreate = tabs.club:AddSection("Club creation"),
}


function user(str)
	if string.lower(str) == "server" or string.lower(str) == "all" then
		return "server"
	end
	local PartialName = str
	local Players = game.Players:GetPlayers()
	for i = 1, #Players do
		if string.lower(Players[i].Name):sub(1, #PartialName) == string.lower(PartialName) then
			return Players[i]
		end
	end
    ui:Notify({
        Title = "nick7 hub | Warn",
        Content = "Can't find player!",
        Duration = 5
    })
end

section.farming:AddButton({
	Title = "Sell all",
	Callback = function()
		for i=1,70 do
			replicated.Events.Shop.RequestSellItem:FireServer(1)
		end
	end
})

section.farming:AddButton({
	Title = "[UNSAFE] Farm XP (~5 seconds)",
    Description = "COULD crash or freeze your device!",
	Callback = function()
		for i=1,1000 do
			replicated.Events.Loot.RequestLoot:FireServer(500)
		end
	end
})

section.farming:AddToggle("SafeXPFarm", { Title = "[SAFE] Farm XP", Default = false, Callback = function(Value)
    getgenv().n7.farmtab.farmxp = Value
    while getgenv().n7.farmtab.farmxp do
		replicated.Events.Loot.RequestLoot:FireServer(500)
		RunService.RenderStepped:Wait()
    end
end})

section.farming:AddInput("RequestLoot", {
    Title = "Request loot (1-769)",
    Default = "502",
    Placeholder = "502",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        replicated.Events.Loot.RequestLoot:FireServer(Value)
    end
})

local FarmMoney = section.farming:AddToggle("FarmMoney", {Title = "Farm money", Default = false})

FarmMoney:OnChanged(function(Value)
	getgenv().n7.farmtab.farm = Value
	if Value then
		for _=1,50 do
			replicated.Events.Shop.RequestSellItem:FireServer(1)
		end
		while getgenv().n7.farmtab.farm do
			replicated.Events.GunShop.RequestBuy:FireServer(getgenv().n7.farmtab.farmw)
			replicated.Events.Shop.RequestShop:FireServer()
			replicated.Events.Shop.RequestSellItem:FireServer(1)
			RunService.RenderStepped:Wait()
		end
	end
end)

section.farming:AddDropdown("FarmWith", {
	Title = "Farm with",
	Values = {"VIPGlock17","VIPAK47","RareM4A1"},
	Multi = false,
	Default = 3,
	Callback = function(Value)
		getgenv().n7.farmtab.farmw = Value
	end
})

section.world:AddButton({
	Title = "Unlock all zones",
	Callback = function()
		for i=1,10 do
			replicated.Events.Access.RequestBuyAccess:FireServer(i)
		end
	end
})

local UnlockVIP = section.world:AddToggle("UnlockVIP", { Title = "Unlock VIP", Default = true})

local vip_safe = {} -- i no wanna explod these stupid doors >:(

for _,a in pairs(workspace:GetChildren()) do
	if match(a.Name, "Safe") then
		if a:FindFirstChild("Door") then
			table.insert(vip_safe, a)
			a.Door.Transparency = .5
			a.Door.CanCollide = false
			break
		end
	end
end
for _, thing in ipairs(vip_safe) do
	if thing:IsA("BasePart") then
		thing:GetPropertyChangedSignal("CanCollide"):Connect(function()
			thing.CanCollide = false
			task.wait()
		end)
	end
end

UnlockVIP:OnChanged(function(Value)
    getgenv().n7.vip = Value
	for _,v in pairs(workspace.Camera.AccessWalls.VIP:GetChildren()) do
		if Value then
			v.CanCollide = false
			if v.Name == "VIPONLY" then
				if v:FindFirstChild("SurfaceGui") then
					for _,j in pairs(v.SurfaceGui:GetChildren()) do
						if j:IsA("TextLabel") then
							if j.Text == "LOCKED" then
								j.Text = "nick7 hub :3"
							elseif j.Text == "VIP USERS" then
								j.Text = "for you (& VIP)"
							end
						elseif j:IsA("ImageLabel") then
							j.Image = 'rbxassetid://5205790785'
						end
					end
				end
			end
		else
			v.CanCollide = true
			if v.Name == "VIPONLY" then
				if v:FindFirstChild("SurfaceGui") then
					for _,j in pairs(v.SurfaceGui:GetChildren()) do
						if j:IsA("TextLabel") then
							if j.Text == "nick7 hub :3" then
								j.Text = "LOCKED"
							elseif j.Text == "for you (& VIP)" then
								j.Text = "VIP USERS"
							end
						elseif j:IsA("ImageLabel") then
							j.Image = 'rbxassetid://2701433023'
						end
					end
				end
			end
		end
	end
end)

tabs.target:AddParagraph({Title = "WARNING", Content = "KILLING a target requires EQUIPPED WEAPON\nFORCING MEMBER a target requires you to have president rank in club."})
tabs.target:AddParagraph({Title = "Type \"server\" or \"all\" to target whole server!", Content = "(without quotes ofc)"})
local target = tabs.target:AddParagraph({Title = "Target: <no target>"})

tabs.target:AddInput("Target", {
	Title = "Target",
	Description = "Will target player / players.",
	Numeric = false,
	Finished = true,
	Placeholder = "server",
	Callback = function(Value)
		local val = user(Value)
		if val == "server" then
			target:SetTitle("Target: Everyone")
		else
			target:SetTitle("Target: " .. val.Name .. " | " .. val.DisplayName)
		end
		getgenv().n7.target.user = val
	end
})

local targetOnce = tabs.target:AddSection("Once")
local targetLoop = tabs.target:AddSection("Loop")
--[[ TARGET FUNCTIONS ]]
function kill(plr:Player)
	if plr then
		if plr ~= lp then
			local tries = 0
			local tries_limit = 70
			if plr.Character then
				repeat
					replicated.Events.Weapon.RequestHit:FireServer(plr.Character)
					tries += 1
					RunService.RenderStepped:Wait()
				until plr.Character.Humanoid.Health <= 0 or tries >= tries_limit
			end
			if tries >= tries_limit then
				ui:Notify({
					Title = "nick7 hub | Error",
					Content = string.format("Killing %s wasn't successful! Function ran out of tries. %s/%s", plr.Name, tries, tries_limit),
					Duration = 5
				})
			end
		end
	else
		ui:Notify({
			Title = "nick7 hub | FATAL Error",
			Content = "\"Killing\" function didn't got any info about who to target. Please check if you chosen who to target.\nplr: ".. plr,
			Duration = 5
		})
	end
end

function force_trade(plr:Player)
	if plr then
		if plr ~= lp then
			replicated.Events.Trade.AcceptTrade:FireServer(plr.UserId)
		end
	else
		ui:Notify({
			Title = "nick7 hub | FATAL Error",
			Content = "\"Force trade\" function didn't got any info about who to target. Please check if you chosen who to target.\nplr: ".. plr,
			Duration = 5
		})
	end
end

function force_member(plr:Player)
	if plr then
		if plr ~= lp then
			replicated.Events.Guild.SendInvite:FireServer(plr)
			replicated.Events.Guild.RequestChangeTitle:FireServer({["ID"] = plr.UserId, ["Name"] = plr, ["Status"] = "Requests"}, "Member")
		end
	else
		ui:Notify({
			Title = "nick7 hub | FATAL Error",
			Content = "\"Force member\" function didn't got any info about who to target. Please check if you chosen who to target.\nplr: ".. plr,
			Duration = 5
		})
	end
end
-- [[ END OF TARGET FUNCTIONS ]]
targetOnce:AddButton({
	Title = "Force trade",
	Callback = function()
		if getgenv().n7.target.user == "server" then
			for _,player in game:GetService("Players"):GetPlayers() do
				task.spawn(function()
					force_trade(player)
					RunService.RenderStepped:Wait()
				end)
			end
		else
			force_trade(getgenv().n7.target.user)
		end
	end
})

targetOnce:AddButton({
	Title = "Force club member",
	Description = "Will force target to join your club",
	Callback = function()
		if getgenv().n7.target.user == string.lower("server") then
			for _,player in game:GetService("Players"):GetPlayers() do
				task.spawn(function()
					force_member(player)
					RunService.RenderStepped:Wait()
				end)
			end
		else
			force_member(getgenv().n7.target.user)
		end
	end
})

targetOnce:AddButton({
	Title = "Kill",
	Description = "ONLY when weapon is equipped",
	Callback = function()
		if getgenv().n7.target.user == string.lower("server") then
			for _,player in game:GetService("Players"):GetPlayers() do
				task.spawn(function()
					kill(player)
				end)
			end
		else
			kill(getgenv().n7.target.user)
		end
	end
})

targetLoop:AddToggle("ForceTradeLoop", {
	Title = "Force trade",
	Default = false,
	Callback = function(Value)
		getgenv().n7.target.trade = Value
		if getgenv().n7.target.user == "server" then
			while getgenv().n7.target.trade do
				for _,player in game:GetService("Players"):GetPlayers() do
					force_trade(player)
					task.wait()
				end
			end
		else
			while getgenv().n7.target.trade do
				force_trade(getgenv().n7.target.user)
				RunService.RenderStepped:Wait()
			end
		end
	end
})

targetLoop:AddToggle("ForceMemberLoop", {
	Title = "Force club member",
	Default = false,
	Callback = function(Value)
		getgenv().n7.target.member = Value
		if getgenv().n7.target.user == "server" then
			while getgenv().n7.target.member do
				for _,player in game:GetService("Players"):GetPlayers() do
					force_member(player)
					RunService.RenderStepped:Wait()
				end
			end
		else
			while getgenv().n7.target.member do
				force_member(getgenv().n7.target.user)
				RunService.RenderStepped:Wait()
			end
		end
	end
})

targetLoop:AddToggle("PlayerKillLoop", {
	Title = "Kill",
	Default = false,
	Callback = function(Value)
		getgenv().n7.target.kill = Value
		if getgenv().n7.target.user == "server" then
			while getgenv().n7.target.kill do
				for _,player in game:GetService("Players"):GetPlayers() do
					kill(player)
					task.wait()
				end
			end
		else
			while getgenv().n7.target.kill do
				kill(getgenv().n7.target.user)
				RunService.RenderStepped:Wait()
			end
		end
	end
})

section.equipment:AddButton({Title = "Buy best ($183,000)", Callback = function()
	replicated.Events.BackpackShop.RequestBuy:FireServer("Backpack9")
	replicated.Events.Toolshop.RequestBuy:FireServer("Plasmacutter","Tools")
	replicated.Events.Toolshop.RequestBuy:FireServer("Automaticpicklock", "Picklocks")
	replicated.Events.Toolshop.RequestBuy:FireServer("Hackingdevice", "Electricaltools")
	replicated.Events.Toolshop.RequestBuy:FireServer("Stethoscope", "Safetools")
	replicated.Events.PetShop.RequestBuy:FireServer("Bulldog")
end})

section.equipment:AddButton({
	Title = "Buy best armor ($515,000)",
	Callback = function()
		replicated.Events.ArmourShop.RequestBuy:FireServer("HeavyBodyArmour3")
	end
})

function comma(Value)
    local Number
    local Formatted = Value
    while true do
        Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (Number == 0) then
            break
        end
    end
    return Formatted
end

local fwlist = {}
local wlist = {}
local weapons = {}

for _,v in game:GetService("ReplicatedStorage").Weapons:GetChildren() do
    table.insert(weapons, {Name = v.Name, Cost = v.Cost.Value, Damage = v.Damage.Value})
end
table.sort(weapons, function(a, b) return a.Cost < b.Cost end)
for _,v in pairs(weapons) do
    table.insert(fwlist, v.Name .. " ($" .. comma(v.Cost) .. ") " .. v.Damage .. "DMG")
    table.insert(wlist, v.Name)
end

section.buying:AddDropdown("BuyWeapon", {
    Title = "Buy weapon",
    Values = fwlist,
    Multi = false,
    Callback = function(Value)
        local allowed = wlist
        local output = ""
        local maxLength = 0
        for _,v in pairs(allowed) do
            if string.find(Value, v) and #v > maxLength then
                output = v
                maxLength = #v
            end
        end
        replicated.Events.GunShop.RequestBuy:FireServer(output)
    end
})

section.clubEvade:AddButton({
	Title = "Leave",
	Callback = function()
		replicated.Events.Guild.LeaveGuild:FireServer()
	end
})

section.clubEvade:AddToggle("AutoClanLeave", {
	Title = "Auto leave",
	Default = false,
	Callback = function(Value)
		getgenv().n7.clubtab.evade = Value
		while getgenv().n7.clubtab.evade do
			replicated.Events.Guild.LeaveGuild:FireServer()
			task.wait(.4)
		end
	end
})
-- bGl0ZXJhbGx5IG5vYm9keSBpcyByZWFkaW5nIHRoaXMgc2hpdC1jb2RlLCBzby4uIEkgaGF2ZSBzZXJpb3VzIG1lbnRhbCBpc3N1ZXMgdGhhdCBJJ20gaGlkaW5nIGZvciBiZXN0LCBhbmQgb25seSB0aGluZyBJIHdhbnQgaXMgbW9yZSB1c2VycyBvZiBuaWNrNyBodWIuLi4KaWYgeW91J3JlIHJlYWRpbmcgdGhpcywgZG8gbm90IHB1Ymxpc2ggdGhpcyB0ZXh0Li4gcGxlYXNlLgpUaGFua3MgZm9yIHVzaW5nIG5pY2s3ISA8MwotIHN0b25pZmFt
section.clubCreate:AddParagraph({Title = "Clan note", Content = "Club that will be created is broken and it's temporary in most of the cases"})

section.clubCreate:AddInput("ClubName", {
	Title = "Club title",
	Default = "cool name",
	Placeholder = "cool name",
	Numeric = false,
	Finished = true,
	Callback = function(Value)
		getgenv().n7.clubtab.club.name = Value
	end
})

section.clubCreate:AddColorpicker("ClubColor", {
	Title = "Color",
	Default = Color3.fromRGB(157, 96, 255),
	Callback = function(Value)
		getgenv().n7.clubtab.club.color = Value
	end
})

section.clubCreate:AddInput("ClubDecal", {
	Title = "Decal",
	Default = "5205790785",
	Placeholder = "5205790785",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		getgenv().n7.clubtab.club.decal = "rbxassetid://"..Value
	end
})

section.clubCreate:AddInput("ClubDescription", {
	Title = "Description",
	Default = "cool description",
	Placeholder = "cool description",
	Numeric = false,
	Finished = true,
	Callback = function(Value)
		getgenv().n7.clubtab.club.description = Value
	end
})

section.clubCreate:AddButton({
	Title = "Create club",
	Callback = function()
		replicated.Events.Guild.RequestGuildInfo:FireServer()
		replicated.Events.Guild.SendCreateGuild:FireServer(getgenv().n7.clubtab.club.name, getgenv().n7.clubtab.club.color, getgenv().n7.clubtab.club.decal, getgenv().n7.clubtab.club.description)
		ui:Notify({
			Title = "nick7 hub | Info",
			Content = "Requested club creation, press on club icon to check",
			Duration = 15
		})
	end
})

local UISection = tabs.cfg:AddSection("UI")
UISection:AddDropdown("InterfaceTheme", {
	Title = "Theme",
	Description = "Changes the UI Theme",
	Values = ui.Themes,
	Default = ui.Theme,
	Callback = function(Value)
		ui:SetTheme(Value)
	end
})

if ui.UseAcrylic then
	UISection:AddToggle("AcrylicToggle", {
		Title = "Acrylic",
		Description = "Blurred Background requires Graphic Quality >= 8",
		Default = ui.Acrylic,
		Callback = function(Value)
			if not Value then
				ui:ToggleAcrylic(Value)
			else
				Window:Dialog({
					Title = "Warning",
					Content = "This Option can be detected! Activate it anyway?",
					Buttons = {
						{
							Title = "Confirm",
							Callback = function()
								ui:ToggleAcrylic(Value)
							end
						},
						{
							Title = "Cancel",
							Callback = function()
								ui.Options.AcrylicToggle:SetValue(false)
							end
						}
					}
				})
			end
		end
	})
end

UISection:AddToggle("TransparentToggle", {
	Title = "Transparency",
	Description = "Makes the UI Transparent",
	Default = ui.Transparency,
	Callback = function(Value)
		ui:ToggleTransparency(Value)
	end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Minimize Key", Description = "Changes the Minimize Key", Default = "RightShift"})
ui.MinimizeKeybind = ui.Options.MinimizeKeybind

tabs.creds:AddParagraph({
	Title = "nick7 hub",
	Content = "Main script is made by Stonifam & kosoor\nUsing forked UI lib by @ttwiz_z\nThank you for using nick7 hub! <3"
})
if setclipboard then
	tabs.creds:AddButton({
		Title = "Copy discord invite",
		Description = "nick7 community",
		Callback = function()
			setclipboard("https://discord.gg/6tgCfU2fX8")
		end
	})
else
	tabs.creds:AddButton({
		Title = "Notify discord invite",
		Description = "nick7 community",
		Callback = function()
			ui:Notify({
				Title = "nick7 hub | Info",
				Content = "https://discord.gg/6tgCfU2fX8",
				Duration = 15
			})
		end
	})
end

Window:SelectTab(1)