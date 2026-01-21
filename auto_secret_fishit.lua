-- Fish It | Auto Secret LITE+++ (Icon Minimize)
-- Delta Executor | Stable

-- ================= SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

-- ================= UI ROOT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_UI"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)

-- ================= MAIN UI =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.ZIndex = 10
Instance.new("UICorner", main)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,42)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "Fish It | Auto Secret"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Left

-- BUTTON HEADER
local function hBtn(txt,x)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.new(0,30,0,30)
    b.Position = UDim2.new(1,x,0,6)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b)
    return b
end

local minBtn = hBtn("–",-70)
local closeBtn = hBtn("X",-35)
closeBtn.TextColor3 = Color3.fromRGB(255,90,90)

-- ================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,0,0,42)
content.Size = UDim2.new(1,0,1,-42)
content.BackgroundTransparency = 1

local function btn(text,y)
    local b = Instance.new("TextButton", content)
    b.Size = UDim2.new(0.9,0,0,38)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b)
    return b
end

local autoFishBtn = btn("Auto Fishing [OFF]",20)

local info = Instance.new("TextLabel", content)
info.Size = UDim2.new(0.9,0,0,35)
info.Position = UDim2.new(0.05,0,0,70)
info.BackgroundTransparency = 1
info.Text = "Rolls: 0"
info.TextColor3 = Color3.fromRGB(200,200,200)
info.Font = Enum.Font.Gotham
info.TextSize = 12

-- ================= ICON MODE =================
local icon = Instance.new("ImageButton", gui)
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.fromScale(0.05,0.4)
icon.BackgroundTransparency = 1
icon.Visible = false
icon.ZIndex = 20

-- 🔥 GANTI ID INI DENGAN LOGO LU
icon.Image = "rbxassetid://0"

-- ================= CORE LOGIC =================
local cast,pull
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n=v.Name:lower()
        if n:find("cast") then cast=v end
        if n:find("pull") or n:find("reel") then pull=v end
    end
end

local autoFish=false
local rolls=0

autoFishBtn.MouseButton1Click:Connect(function()
    autoFish=not autoFish
    autoFishBtn.Text = autoFish and "Auto Fishing [ON]" or "Auto Fishing [OFF]"
end)

task.spawn(function()
    while task.wait(0.9) do
        if autoFish and cast and pull then
            cast:FireServer()
            task.wait(0.2)
            pull:FireServer()
            rolls+=1
            info.Text="Rolls: "..rolls
        end
    end
end)

-- ================= MINIMIZE LOGIC =================
minBtn.MouseButton1Click:Connect(function()
    main.Visible=false
    icon.Visible=true
end)

icon.MouseButton1Click:Connect(function()
    icon.Visible=false
    main.Visible=true
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
