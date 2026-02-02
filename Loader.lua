
getgenv().AbysallHubSettings = {
	Name = "MR-S",
	DiscordInvite = "http://qins.mc.hi.cn/MR-S",
	SelectedLibrary = "Obsidian",
	GameName = "Placeholder",
	ExecutorSupport = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "ExecutorSupport.lua"))()
	Repository = "https://github.com/doghwrf001/111/raw/refs/heads/222/"
}
local LocalPlayer = game:GetService("Players").LocalPlayer
local RequiredFunctions = {"writefile", "delfile", "readfile", "isfile", "listfiles", "makefolder", "delfolder", "isfolder", "cloneref"}
local ExecutorSupported = true
for Index, Name in pairs(RequiredFunctions) do
if not AbysallHubSettings.ExecutorSupport[Name] then
    ExecutorSupported = false
  end
end
if ExecutorSupported == false then
  LocalPlayer:Kick("Your executor doesn't support MR-S\nTry looking for executors on trustworthy sites such as whatexpsare.online or voxlis.net!")
  return
end
local LoaderData = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "LoaderData.lua"))()
local NameData = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "LoaderData.lua"))()
local ESP = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "ESP.lua"))()
local SelectedLoader = LoaderData[game.GameId] or LoaderData[0]
AbysallHubSettings.GameName = NameData[SelectedLoader]
loadstring(game:HttpGet(AbysallHubSettings.Repository .. "MR-S-1/" .. SelectedLoader .. "/Loader.lua"))()
