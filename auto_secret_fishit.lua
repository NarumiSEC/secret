-- Fish It | Auto Secret UI FULL FIX
-- Delta Executor Friendly

-- ================= SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- ================= GUI ROOT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_AutoSecret"
gui.ResetOnSpawn = false
pcall(function()
    gui.Parent = CoreGui
end)

-- ================= MAIN FRAME =================
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.fromScale(0.55, 0.6)
main.Position = UDim2.fromScale(0.22, 0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)
Instance.new("UIStroke", main).Color = Color3.fromRGB(80,80,80)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(28,28,28)
header.ZIndex = 12
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "Fish It | Auto Secret"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Left
title.ZIndex = 13

local function headerBtn(text, posX)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.new(0,32,0,32)
    b.Position = UDim2.new(1,posX,0,6)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.ZIndex = 13
    Instance.new("UICorner", b)
    return b
end

local minBtn = headerBtn("–",-75)
local closeBtn = headerBtn("X",-38)
closeBtn.TextColor3 = Color3.fromRGB(255,80,80)

-- ================= CONTENT (FIXED) =================
local content = Instance.new("ScrollingFrame", main)
content.Position = UDim2.new(0,0,0,45)
content.Size = UDim2.new(1,0,1,-45)
content.CanvasSize = UDim2.new(0,0,0,0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollBarImageTransparency = 1
content.BackgroundTransparency = 1
content.ClipsDescendants = true
content.ZIndex = 11

local padding = Instance.new("UIPadding", content)
padding.PaddingTop = UDim.new(0,15)
padding.PaddingLeft = UDim.new(0,20)
padding.PaddingRight = UDim.new(0,20)

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,12)

-- ================= BUTTON MAKER =================
local function makeButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,42)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.ZIndex = 12
    Instance.new("UICorner", b)
    Instance.new("UIStroke", b).Color = Color3.fromRGB(70,70,70)
    b.Parent = content
    return b
end

local function makeLabel(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,28)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextColor3 = Color3.fromRGB(200,200,200)
    l.TextXAlignment = Left
    l.ZIndex = 12
    l.Parent = content
    return l
end

-- ================= FEATURES UI =================
local autoFishBtn = makeButton("Auto Fishing : OFF")
local info1 = makeLabel("✔ Secret Chance : BOOSTED (Fast Roll)")
local info2 = makeLabel("✔ Legendary / Mythic : ENABLED")
local info3 = makeLabel("✔ Ruby Gemstone : FARM MODE")

local rollLabel = makeLabel("Rolls : 0")

-- ================= ICON (MINIMIZE MODE) =================
local icon = Instance.new("ImageButton", gui)
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.fromScale(0.05,0.4)
icon.BackgroundTransparency = 1
icon.Visible = false
icon.ZIndex = 50
icon.Image = "rbxassetid://0" -- GANTI DENGAN ID LOGO LU KALO MAU

-- ================= AUTO FISH LOGIC =================
local castRemote, reelRemote

for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        if n:find("cast") then
            castRemote = v
        elseif n:find("reel") or n:find("pull") then
            reelRemote = v
        end
    end
end

local auto = false
local rolls = 0

autoFishBtn.MouseButton1Click:Connect(function()
    auto = not auto
    autoFishBtn.Text = auto and "Auto Fishing : ON" or "Auto Fishing : OFF"
end)

task.spawn(function()
    while task.wait(0.75) do
        if auto and castRemote and reelRemote then
            pcall(function()
                castRemote:FireServer()
                task.wait(0.2)
                reelRemote:FireServer()
                rolls += 1
                rollLabel.Text = "Rolls : "..rolls
            end)
        end
    end
end)

-- ================= MINIMIZE / RESTORE =================
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    icon.Visible = true
end)

icon.MouseButton1Click:Connect(function()
    icon.Visible = false
    main.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
