local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChild("Humanoid")

-- ANTICHEAT BYPASS FOR TELEPORTATION AND WALKSPEED
local anticheat = game.ReplicatedStorage.RemoteEvents:FindFirstChild("Sanity")

if anticheat then
    anticheat:Destroy()
    print("Anticheat bypassed")
else
    print("Anticheat already bypassed")
end

local Window = Fluent:CreateWindow({
    Title = "Atom Hub ",
    SubTitle = "by Atom.mp4",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({
        Title = "Main",
        Icon = "chevrons-up"
    }),
    Gamepasses = Window:AddTab({
        Title = "Gamepasses",
        Icon = "dollar-sign"
    })
}

Tabs.Main:AddParagraph({
    Title = "Anticheat Bypassed",
    Content = "You can fly or do whatever, anticheat is bypassed and it's all clientsided :skull:"
})

local WalkSpeedSlider = Tabs.Main:AddSlider("WalkSpeedSlider", {
    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        humanoid.WalkSpeed = Value
    end
})

local JumpHeightSlider = Tabs.Main:AddSlider("JumpHeightSlider", {
    Title = "Jump Power",
    Default = 16,
    Min = 7.2,
    Max = 50,
    Rounding = 0,
    Callback = function(Value)
        humanoid.JumpHeight = Value
    end
})

local function UpdateValues()
    if humanoid and WalkSpeedSlider and JumpHeightSlider then
        humanoid.WalkSpeed = WalkSpeedSlider.Value
        humanoid.JumpHeight = JumpHeightSlider.Value
    end
end

game:GetService("RunService").Heartbeat:Connect(UpdateValues)

local InfiniteCoinsToggle = Tabs.Main:AddToggle("Infinite Coins", {
    Title = "Infinite Coins",
    Default = false
})

local function CoinLoop()
    while InfiniteCoinsToggle.Value do
        game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId,
            1836846947, true)
        task.wait(0.2)
    end
end

InfiniteCoinsToggle:OnChanged(function()
    if InfiniteCoinsToggle.Value then
        CoinLoop()
    end
end)

Tabs.Main:AddParagraph({
    Title = "Made by Atom.mp4 ",
    Content = "Contact me on discord for suggestions"
})

Tabs.Main:AddParagraph({
    Title = "UI by DawidScripts - Fluent",
    Content = ""
})

Tabs.Gamepasses:AddParagraph({
    Title = "VIP AND CELEBRATIONS ARE CLIENTSIDED",
    Content = ""
})

local VIPToggle = Tabs.Gamepasses:AddToggle("VIP", {
    Title = "VIP",
    Default = false
})

VIPToggle:OnChanged(function(value)
    LocalPlayer.playerstats.Gamepasses.VIP.Value = value
end)

VIPToggle:SetValue(false)

local CelebrationsToggle = Tabs.Gamepasses:AddToggle("Celebrations", {
    Title = "Celebrations",
    Default = false
})

CelebrationsToggle:OnChanged(function(value)
    LocalPlayer.playerstats.Gamepasses["Finish Celebrations"].Value = value
end)

CelebrationsToggle:SetValue(false)

local RelaySettingsToggle = Tabs.Gamepasses:AddToggle("More Relay Settings", {
    Title = "More Relay Settings",
    Default = false
})

RelaySettingsToggle:OnChanged(function(value)
    LocalPlayer.playerstats.Gamepasses["More Relay Settings"].Value = value
end)

RelaySettingsToggle:SetValue(false)

print("Hi, thanks for using this script!, for suggestions you can add me on discord at atom.mp4")
