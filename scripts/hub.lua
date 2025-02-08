--[[ nick7 hub ]]

if getfenv().getconnections then for a,b in next,getfenv().getconnections(game:GetService("ScriptContext").Error)do b:Disable()end;for a,b in next,getfenv().getconnections(game:GetService("LogService").MessageOut)do b:Disable()end end
local id = game.PlaceId
function outdated_warn()
    warn("(nick7 hub) Script is outdated for this game!")
end
function load(str)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nick7-hub/roblox/main/scripts/"..str))()
end
local games = {
    [205224386] = 'load("hidenseek_extreme.lua")',
    [2693739238] = 'load("thief_life.lua")',
    [9647190122] = 'load("max_obby.lua")',
    [32331218] = 'load("mmrp-autofarm.lua")',
    [2882332175] = 'load("bdfs.lua")',
    [6999691637] = 'load("rbds.lua")',
    [10660791703] = 'load("cran.lua")',
    [230362888] = 'load("normal_elevator.lua")',
    [15410077867] = 'load("superhero_obby.lua")',
    [2537430692] = 'load("bnp.lua")',
    [537413528] = 'load("babft.lua")',
    [3411100258] = 'load("bordr_autofarm.lua")',
    [394773622] = 'workspace.DoShopPurchase:InvokeServer(game.Players.LocalPlayer.leaderstats.Coins, -945986745698454679,"skill3")',
    [15214140740] = 'load("UltimateTownSandbox.lua")'
}
local broken = {}
local supported = false
for k, _ in pairs(games) do
    if k == id then
        supported = true
        break
    end
end
if supported then
    if not table.find(broken, id) then
        loadstring(games[id])()
    else
        outdated_warn()
    end
else
    print("--=(nick7 hub)=--")
    warn(`Game ({id}) is not supported by nick7 hub!`)
    print("If game IS supported, create a ticket in our discord: discord.gg/NGAaby4y4b")
    print("--=(nick7 hub)=--")
    local notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua", true))()
    notif:Notify("nick7 hub","Game is not supported! Check \"/console\"",20)
end 