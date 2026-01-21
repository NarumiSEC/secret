-- Fish It | Auto Secret LITE (UI FIXED VERSION)
-- UI + Logic Fix Only (Stable)

-- ================= SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")

local lp = Players.LocalPlayer

-- ================= UI INIT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_Lite_UI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    gui.Parent = CoreGui
end)

-- ================= MAIN =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,42)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
header.ZIndex = 51
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "Fish It | Auto Secret (FIX)"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 52

-- MIN / CLOSE
local function headerBtn(txt,pos,color)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.new(0,30,0,30)
    b.Position = pos
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = color
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.ZIndex = 53
    Instance.new("UICorner", b)
    return b
end

local minBtn   = headerBtn("–",UDim2.new(1,-70,0,6),Color3.new(1,1,1))
local closeBtn = headerBtn("X",UDim2.new(1,-35,0,6),Color3.fromRGB(255,90,90))

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,42)
sidebar.Size = UDim2.new(0.28,0,1,-42)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
sidebar.ZIndex = 51

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,10)
sideLayout.HorizontalAlignment = Center
sideLayout.VerticalAlignment = Top

-- ================= CONTENT HOLDER =================
local contentHolder = Instance.new("Frame", main)
contentHolder.Position = UDim2.new(0.28,0,0,42)
contentHolder.Size = UDim2.new(0.72,0,1,-42)
contentHolder.BackgroundTransparency = 1

-- ================= UTILS =================
local function makeBtn(parent,text)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9,0,0,36)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.ZIndex = 52
    Instance.new("UICorner", b)
    return b
end

local function makePage()
    local f = Instance.new("Frame", contentHolder)
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundTransparency = 1
    f.Visible = false
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,10)
    l.HorizontalAlignment = Center
    l.VerticalAlignment = Top
    return f
end

-- ================= TABS =================
local tabFishingBtn  = makeBtn(sidebar,"Fishing")
local tabTeleportBtn = makeBtn(sidebar,"Teleport")

local fishingPage  = makePage()
local teleportPage = makePage()
fishingPage.Visible = true

local function switchTab(page)
    fishingPage.Visible  = false
    teleportPage.Visible = false
    page.Visible = true
end

tabFishingBtn.MouseButton1Click:Connect(function()
    switchTab(fishingPage)
end)

tabTeleportBtn.MouseButton1Click:Connect(function()
    switchTab(teleportPage)
end)

-- ================= FISHING PAGE =================
local autoFishBtn = makeBtn(fishingPage,"Auto Fishing [OFF]")

local rollCounter = Instance.new("TextLabel", fishingPage)
rollCounter.Size = UDim2.new(0.9,0,0,30)
rollCounter.Text = "Total Rolls : 0"
rollCounter.Font = Enum.Font.Gotham
rollCounter.TextSize = 13
rollCounter.TextColor3 = Color3.new(1,1,1)
rollCounter.BackgroundTransparency = 1

local logBox = Instance.new("TextLabel", fishingPage)
logBox.Size = UDim2.new(0.9,0,0,120)
logBox.Text = "Log:\n- Ready"
logBox.TextWrapped = true
logBox.TextYAlignment = Top
logBox.Font = Enum.Font.Code
logBox.TextSize = 12
logBox.TextColor3 = Color3.fromRGB(180,180,180)
logBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", logBox)

-- ================= TELEPORT PAGE =================
local hopBtn = makeBtn(teleportPage,"Server Hop")

-- ================= LOGIC =================
local castRemote, pullRemote
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        if n:find("cast") then castRemote = v end
        if n:find("pull") or n:find("reel") then pullRemote = v end
    end
end

local auto = false
local rolls = 0

autoFishBtn.MouseButton1Click:Connect(function()
    auto = not auto
    autoFishBtn.Text = auto and "Auto Fishing [ON]" or "Auto Fishing [OFF]"
end)

task.spawn(function()
    while task.wait(0.35) do
        if auto and castRemote and pullRemote then
            pcall(function()
                castRemote:FireServer()
                task.wait(0.8)
                pullRemote:FireServer()
                rolls += 1
                rollCounter.Text = "Total Rolls : "..rolls
                logBox.Text = "Log:\n- Roll "..rolls.." done"
            end)
        end
    end
end)

hopBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, lp)
end)

-- ================= WINDOW CONTROL =================
local minimized = false
local fullSize = main.Size

minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        main.Size = UDim2.new(fullSize.X.Scale,0,0,42)
    else
        main.Size = fullSize
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
