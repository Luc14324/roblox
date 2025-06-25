-- Skidded IY's source code for better security (i hope)

local n7w = {};

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback or nil
end

cloneref = missing("function", cloneref, function(...) return ... end)
COREGUI = cloneref(game:GetService("CoreGui"))

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local e,v = pcall(function()
	return COREGUI:FindFirstChild("RobloxGui")
end)

local PARENT = nil
if get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	n7w["1"] = Instance.new("ScreenGui")
	n7w["1"]["Parent"] = hiddenUI()
	n7w["1"]["Name"] = randomString()
	PARENT = n7w["1"]
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	n7w["1"] = Instance.new("ScreenGui")
	n7w["1"]["Name"] = randomString()
	syn.protect_gui(n7w["1"])
	n7w["1"].Parent = COREGUI
	PARENT = n7w["1"]
elseif e and v then
	PARENT = COREGUI.RobloxGui
else
	local a,b = pcall(function()
		n7w["1"] = Instance.new("ScreenGui")
		n7w["1"]["Name"] = randomString()
		n7w["1"]["Parent"] = COREGUI
		PARENT = n7w["1"]
	end)
	if not a then
		n7w["1"] = Instance.new("ScreenGui")
		n7w["1"]["Name"] = randomString()
		n7w["1"]["Parent"] = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		PARENT = n7w["1"]
	end
end

n7w["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

n7w["2"] = Instance.new("CanvasGroup", PARENT);
n7w["2"]["BorderSizePixel"] = 0;
n7w["2"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
n7w["2"]["Size"] = UDim2.new(0.28974, 0, 0.41975, 0);
n7w["2"]["Position"] = UDim2.new(0.35513, 0, 0.29012, 0);
n7w["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);

n7w["3"] = Instance.new("UICorner", n7w["2"]);
n7w["3"]["CornerRadius"] = UDim.new(0.1, 0);

n7w["4"] = Instance.new("CanvasGroup", n7w["2"]);
n7w["4"]["BorderSizePixel"] = 0;
n7w["4"]["BackgroundColor3"] = Color3.fromRGB(37, 37, 37);
n7w["4"]["Size"] = UDim2.new(1, 0, 0.17132, 0);
n7w["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
n7w["4"]["Name"] = randomString();

n7w["5"] = Instance.new("TextLabel", n7w["4"]);
n7w["5"]["TextWrapped"] = true;
n7w["5"]["BorderSizePixel"] = 0;
n7w["5"]["TextScaled"] = true;
n7w["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
n7w["5"]["TextSize"] = 14;
n7w["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/RobotoMono.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
n7w["5"]["TextColor3"] = Color3.fromRGB(90, 183, 73);
n7w["5"]["BackgroundTransparency"] = 1;
n7w["5"]["RichText"] = true;
n7w["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
n7w["5"]["Size"] = UDim2.new(0.9, 0, 1, 0);
n7w["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
n7w["5"]["Text"] = [[nick7 hub]];
n7w["5"]["Name"] = randomString();
n7w["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

n7w["6"] = Instance.new("TextLabel", n7w["2"]);
n7w["6"]["TextWrapped"] = true;
n7w["6"]["BorderSizePixel"] = 0;
n7w["6"]["TextScaled"] = true;
n7w["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
n7w["6"]["TextSize"] = 14;
n7w["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
n7w["6"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
n7w["6"]["BackgroundTransparency"] = 1;
n7w["6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
n7w["6"]["Size"] = UDim2.new(0.9, 0, 0.15588, 0);
n7w["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
n7w["6"]["Text"] = [[! WARNING !]];
n7w["6"]["Name"] = randomString();
n7w["6"]["Position"] = UDim2.new(0.5, 0, 0.24926, 0);

n7w["7"] = Instance.new("TextLabel", n7w["2"]);
n7w["7"]["TextWrapped"] = true;
n7w["7"]["BorderSizePixel"] = 0;
n7w["7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
n7w["7"]["TextYAlignment"] = Enum.TextYAlignment.Top;
n7w["7"]["TextScaled"] = true;
n7w["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
n7w["7"]["TextSize"] = 35;
n7w["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
n7w["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
n7w["7"]["BackgroundTransparency"] = 1;
n7w["7"]["RichText"] = true;
n7w["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
n7w["7"]["Size"] = UDim2.new(0.9, 0, 0.58603, 0);
n7w["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
n7w["7"]["Text"] = [[Script is obfuscated using pixsec. Roblox might freeze up to 30 seconds. Please wait for script to load]];
n7w["7"]["Name"] = randomString();
n7w["7"]["Position"] = UDim2.new(0.5, 0, 0.65184, 0);

return PARENT, require;