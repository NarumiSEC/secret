-- Fish It | Mode Selector UI (FIXED & SAFE)
-- Delta Executor Friendly

-- ================= SERVICES =================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")

local lp = Players.LocalPlayer

-- ================= UI INIT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_Mode_UI"
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
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,42)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
header.ZIndex = 11
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "Fish It | Mode Selector"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 12

local function headerBtn(txt,pos,color)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.new(0,30,0,30)
    b.Position = pos
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = color
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.ZIndex = 13
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
sidebar.ZIndex = 11

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,12)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0,15)

-- ================= CONTENT =================
local content = Instance.new("ScrollingFrame", main)
content.Position = UDim2.new(0.28,0,0,42)
content.Size = UDim2.new(0.72,0,1,-42)
content.CanvasSize = UDim2.new(0,0,0,0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollBarImageTransparency = 1
content.BackgroundTransparency = 1
content.ZIndex = 11

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

local pad = Instance.new("UIPadding", content)
pad.PaddingTop = UDim.new(0,15)

-- ================= UI UTILS =================
local function makeBtn(parent,text)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9,0,0,36)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.ZIndex = 12
    Instance.new("UICorner", b)
    return b
end

-- ================= MODE DROPDOWN =================
local currentMode = "Secret"
local modeBtn = makeBtn(content,"Mode : Secret")

local modeOpen = false
local modes = {"Secret","Legendary","Mythic"}
local modeBtns = {}

for _,m in ipairs(modes) do
    local b = makeBtn(content,"→ "..m)
    b.Visible = false
    b.MouseButton1Click:Connect(function()
        currentMode = m
        modeBtn.Text = "Mode : "..m
        for _,x in pairs(modeBtns) do x.Visible = false end
        modeOpen = false
    end)
    table.insert(modeBtns,b)
end

modeBtn.MouseButton1Click:Connect(function()
    modeOpen = not modeOpen
    for _,b in pairs(modeBtns) do
        b.Visible = modeOpen
    end
end)

-- ================= MAP DROPDOWN =================
local currentMap = "None"
local mapBtn = makeBtn(content,"Map : Select")

local maps = {
    ["Lost Isle"] = CFrame.new(2200,30,-500),
    ["Coral Reefs"] = CFrame.new(1200,15,800),
    ["Tropical Grove"] = CFrame.new(-900,20,1400),
    ["Fisherman Island"] = CFrame.new(0,10,0)
}

local mapOpen = false
local mapBtns = {}

for name,cf in pairs(maps) do
    local b = makeBtn(content,"→ "..name)
    b.Visible = false
    b.MouseButton1Click:Connect(function()
        currentMap = name
        mapBtn.Text = "Map : "..name
        lp.Character:WaitForChild("HumanoidRootPart").CFrame = cf
        for _,x in pairs(mapBtns) do x.Visible = false end
        mapOpen = false
    end)
    table.insert(mapBtns,b)
end

mapBtn.MouseButton1Click:Connect(function()
    mapOpen = not mapOpen
    for _,b in pairs(mapBtns) do
        b.Visible = mapOpen
    end
end)

-- ================= INFO =================
local info = Instance.new("TextLabel", content)
info.Size = UDim2.new(0.9,0,0,60)
info.TextWrapped = true
info.Text = "INFO:\nMode dipakai sebagai FOCUS & LOG.\nChance ditentukan server."
info.Font = Enum.Font.Gotham
info.TextSize = 12
info.TextColor3 = Color3.fromRGB(180,180,180)
info.BackgroundTransparency = 1

-- ================= WINDOW CONTROL =================
local minimized = false
local fullSize = main.Size

minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    main.Size = minimized and UDim2.new(fullSize.X.Scale,0,0,42) or fullSize
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
