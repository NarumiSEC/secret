-- FISH IT LITE (DELTA SAFE)
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TP = game:GetService("TweenService")
local lp = Players.LocalPlayer

-- ===== UI =====
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "FishItLite"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35,0.45)
frame.Position = UDim2.fromScale(0.33,0.27)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Fish It Lite"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function button(txt, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b)
    return b
end

local autoFishBtn = button("Auto Fishing [OFF]",60)
local questBtn = button("Auto Quest",105)
local tpLost = button("Teleport: Lost Isle",150)
local tpCoral = button("Teleport: Coral Reef",195)
local closeBtn = button("Close",240)

-- ===== FIND REMOTES =====
local cast,pull,quest
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        if n:find("cast") then cast=v end
        if n:find("pull") or n:find("reel") then pull=v end
        if n:find("quest") then quest=v end
    end
end

-- ===== AUTO FISH =====
local autofish = false
autoFishBtn.MouseButton1Click:Connect(function()
    autofish = not autofish
    autoFishBtn.Text = autofish and "Auto Fishing [ON]" or "Auto Fishing [OFF]"
end)

task.spawn(function()
    while true do
        if autofish and cast and pull then
            cast:FireServer()
            task.wait(0.9)
            pull:FireServer()
        end
        task.wait(0.2)
    end
end)

-- ===== AUTO QUEST =====
questBtn.MouseButton1Click:Connect(function()
    if quest then
        quest:FireServer("Complete")
    end
end)

-- ===== TELEPORT =====
local maps = {
    ["Lost Isle"] = Vector3.new(1200,50,-800),
    ["Coral Reef"] = Vector3.new(-900,40,600),
}

tpLost.MouseButton1Click:Connect(function()
    lp.Character:PivotTo(CFrame.new(maps["Lost Isle"]))
end)

tpCoral.MouseButton1Click:Connect(function()
    lp.Character:PivotTo(CFrame.new(maps["Coral Reef"]))
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
