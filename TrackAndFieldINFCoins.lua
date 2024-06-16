local screenGui = Instance.new("ScreenGui")
local textButton = Instance.new("TextButton")

screenGui.Name = "ToggleGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

textButton.Name = "ToggleButton"
textButton.Parent = screenGui
textButton.Size = UDim2.new(0, 100, 0, 50)
textButton.Position = UDim2.new(0.5, -50, 0.5, -25)
textButton.Text = "ON"
textButton.BackgroundColor3 = Color3.new(0, 1, 0)

local on = true
local dragging = false
local dragStart, startPos

local function startLoop()
    while on do
        game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, 1836846947, true)
        wait(0.1)
    end
end

textButton.MouseButton1Click:Connect(function()
    on = not on
    textButton.Text = on and "ON" or "OFF"
    textButton.BackgroundColor3 = on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    if on then
        startLoop()
    end
end)

textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = textButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

textButton.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        textButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

startLoop()
