--[[
  /$$$$$$  /$$                                     /$$ /$$       /$$   /$$           /$$      
 /$$__  $$| $$                                    | $$| $$      | $$  | $$          | $$      
| $$  \ $$| $$$$$$$  /$$   /$$  /$$$$$$$  /$$$$$$ | $$| $$      | $$  | $$ /$$   /$$| $$$$$$$ 
| $$$$$$$$| $$__  $$| $$  | $$ /$$_____/ |____  $$| $$| $$      | $$$$$$$$| $$  | $$| $$__  $$
| $$__  $$| $$  \ $$| $$  | $$|  $$$$$$   /$$$$$$$| $$| $$      | $$__  $$| $$  | $$| $$  \ $$
| $$  | $$| $$  | $$| $$  | $$ \____  $$ /$$__  $$| $$| $$      | $$  | $$| $$  | $$| $$  | $$
| $$  | $$| $$$$$$$/|  $$$$$$$ /$$$$$$$/|  $$$$$$$| $$| $$      | $$  | $$|  $$$$$$/| $$$$$$$/
|__/  |__/|_______/  \____  $$|_______/  \_______/|__/|__/      |__/  |__/ \______/ |_______/ 
                     /$$  | $$                                                                
                    |  $$$$$$/                                                                
                     \______/  
]]

getgenv().AbysallHubSettings = {
	Name = "Abysall Hub",
	DiscordInvite = "https://discord.gg/DXJNkSwje3",
	SelectedLibrary = "Obsidian",
	GameName = "Placeholder",
	ExecutorSupport = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "/Components/ExecutorSupport.lua"))()
	Repository = "https://raw.githubusercontent.com/bocaj111004/AbysallHubNew/refs/heads/main/"
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
  LocalPlayer:Kick("Your executor doesn't support Abysall Hub.\nTry looking for executors on trustworthy sites such as whatexpsare.online or voxlis.net!")
  return
end
local LoaderData = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "/Misc/LoaderData.lua"))()
local NameData = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "/Misc/LoaderData.lua"))()
local ESP = loadstring(game:HttpGet(AbysallHubSettings.Repository .. "/Components/ESP.lua"))()
local SelectedLoader = LoaderData[game.GameId] or LoaderData[0]
AbysallHubSettings.GameName = NameData[SelectedLoader]
loadstring(game:HttpGet(AbysallHubSettings.Repository .. "Places/" .. SelectedLoader .. "/Loader.lua"))()
