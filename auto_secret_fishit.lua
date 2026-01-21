-- narumi.lua
-- UI exploit simulator (SAFE VERSION)
-- Script by NarumiStore

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
if not player then return end

--------------------------------------------------
-- GUI PARENT FIX (INI YANG BIKIN JALAN DI DELTA)
--------------------------------------------------
local function getGuiParent()
    if gethui then
        return gethui()
    end
    return CoreGui
end

local gui = Instance.new("ScreenGui")
gui.Name = "NarumiExploitUI"
gui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(gui)
end

gui.Parent = getGuiParent()

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.36,0.56)
main.Position = UDim2.fromScale(0.32,0.2)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", top)

local title = Instance.new("TextLabel", top)
title.Text = "Fish It Simulator\nScript by NarumiStore"
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextSize = 14

local close = Instance.new("TextButton", top)
close.Text = "X"
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)

local mini = Instance.new("TextButton", top)
mini.Text = "_"
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-70,0,5)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,120,1,-40)
side.Position = UDim2.new(0,0,0,40)
side.BackgroundColor3 = Color3.fromRGB(25,25,25)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-120,1,-40)
content.Position = UDim2.new(0,120,0,40)
content.BackgroundTransparency = 1

--------------------------------------------------
-- UTIL
--------------------------------------------------
local function clear()
    for _,v in pairs(content:GetChildren()) do
        if v:IsA("GuiObject") then v:Destroy() end
    end
end

local function btn(parent,text,y)
    local b = Instance.new("TextButton", parent)
    b.Text = text
    b.Size = UDim2.new(1,-10,0,40)
    b.Position = UDim2.new(0,5,0,y)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

--------------------------------------------------
-- SIDEBAR BUTTONS
--------------------------------------------------
local fishingBtn = btn(side,"🎣 Fishing",10)
local tpBtn = btn(side,"🧭 Teleport",60)

--------------------------------------------------
-- FISHING (SIMULASI)
--------------------------------------------------
fishingBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10
    for _,fish in ipairs({"Secret","Legendary","Mythic"}) do
        local b = btn(content, fish.." Fish", y)
        y += 50
        b.MouseButton1Click:Connect(function()
            warn("[SIMULATION] Fishing request:", fish)
        end)
    end
end)

--------------------------------------------------
-- TELEPORT (SIMULASI)
--------------------------------------------------
tpBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10
    for _,map in ipairs({"Island1","Island2","SecretIsland"}) do
        local b = btn(content, map, y)
        y += 50
        b.MouseButton1Click:Connect(function()
            warn("[SIMULATION] Teleport request:", map)
        end)
    end
end)

--------------------------------------------------
-- CLOSE & MINIMIZE
--------------------------------------------------
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local minimized = false
mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    TweenService:Create(main, TweenInfo.new(0.25), {
        Size = minimized and UDim2.new(0,300,0,40) or UDim2.fromScale(0.36,0.56)
    }):Play()
end)

print("[Narumi] UI loaded (Delta compatible)")
ar)
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
