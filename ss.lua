-- Fish It | Mode Selector UI
-- Delta Executor SAFE BASE

-- ================= LOAD SAFE =================
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ================= SERVICES =================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- WAIT PLAYER (INI PENTING)
local lp
repeat
    lp = Players.LocalPlayer
    task.wait()
until lp

-- GUI PARENT FIX (DELTA)
local function getGuiParent()
    if typeof(gethui) == "function" then
        return gethui()
    end
    return CoreGui
end

-- ================= UI INIT =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_Mode_UI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = getGuiParent()

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

-- ================= CONTENT =================
local content = Instance.new("ScrollingFrame", main)
content.Position = UDim2.new(0,0,0,42)
content.Size = UDim2.new(1,0,1,-42)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollBarImageTransparency = 1
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local pad = Instance.new("UIPadding", content)
pad.PaddingTop = UDim.new(0,15)

local function makeBtn(text)
    local b = Instance.new("TextButton", content)
    b.Size = UDim2.new(0.9,0,0,36)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b)
    return b
end

-- ================= MODE =================
local currentMode = "Secret"
local modeBtn = makeBtn("Mode : Secret")

local modes = {"Secret","Legendary","Mythic"}
local modeBtns = {}
local open = false

for _,m in ipairs(modes) do
    local b = makeBtn("→ "..m)
    b.Visible = false
    b.MouseButton1Click:Connect(function()
        currentMode = m
        modeBtn.Text = "Mode : "..m
        for _,x in pairs(modeBtns) do x.Visible = false end
        open = false
    end)
    table.insert(modeBtns,b)
end

modeBtn.MouseButton1Click:Connect(function()
    open = not open
    for _,b in pairs(modeBtns) do
        b.Visible = open
    end
end)

-- ================= PLACEHOLDER LOGIC =================
-- ⬇⬇⬇
-- TEMPEL CODE LAMA LU DI SINI
-- fast roll / fishing logic / hook remote
-- JANGAN BIKIN UI DI ATAS LAGI
-- ⬆⬆⬆

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

print("[FishIt] UI Loaded Successfully")
