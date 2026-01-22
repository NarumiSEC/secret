-- Fish It | Chloe-Style UI (FIXED SCROLL + TP SYSTEM)
-- CLIENT ONLY | DELTA FRIENDLY

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- GUI PARENT
local function getGuiParent()
    return typeof(gethui) == "function" and gethui() or CoreGui
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_Chloe_Fixed"
gui.ResetOnSpawn = false
gui.Parent = getGuiParent()

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,40)
header.BackgroundColor3 = Color3.fromRGB(28,28,28)
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Text = "Fish It | Chloe Style"
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", header)
close.Text = "X"
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0,150,1,-40)
sidebar.Position = UDim2.new(0,0,0,40)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-150,1,-40)
content.Position = UDim2.new(0,150,0,40)
content.BackgroundTransparency = 1

-- CLEAR
local function clear()
    for _,v in pairs(content:GetChildren()) do
        v:Destroy()
    end
end

-- BUTTON
local function button(parent,text)
    local b = Instance.new("TextButton", parent)
    b.Text = text
    b.Size = UDim2.new(1,-10,0,40)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

-- SIDEBAR BUTTONS
local fishingBtn = button(sidebar,"🎣 Fishing")
fishingBtn.Position = UDim2.new(0,5,0,10)

local tpBtn = button(sidebar,"🧭 Teleport")
tpBtn.Position = UDim2.new(0,5,0,60)

------------------------------------------------
-- 🧭 TELEPORT (SCROLLABLE + REAL SYSTEM)
------------------------------------------------
tpBtn.MouseButton1Click:Connect(function()
    clear()

    -- SCROLL FRAME
    local scroll = Instance.new("ScrollingFrame", content)
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.None

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,8)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
    end)

    -- MAP DATA (ISI CFrame SENDIRI)
    local maps = {
        ["Acient jungle"] = nil,
        ["Acient jungle outside"] = nil,
        ["Acient ruin"] = nil,
        ["Coral Reefs"] = nil,
        ["Creter island ground"] = nil,
        ["Creter island top"] = nil,
        ["Crystal Depths"] = nil,
        ["Crystaline Pessage"] = nil,
        ["Esoteric Deep"] = nil,
        ["Fishermand island"] = nil,
        ["Kohana spot 1"] = nil,
        ["Kohana spot 2"] = nil,
        ["Kohana Volcano"] = nil,
        ["Leviatan Den"] = nil,
        ["Lost shore"] = nil,
        ["Pirate cove"] = nil,
        ["Pirate treasure room"] = nil,
        ["Secred temple"] = nil,
        ["Secret pessege"] = nil,
        ["Sisyphus statue"] = nil,
        ["Tropical grove"] = nil,
        ["Tropical grove cave"] = nil,
        ["Underground cellar"] = nil,
        ["Weater machine"] = nil
    }

    for name,cf in pairs(maps) do
        local mapBtn = button(scroll,name)

        mapBtn.MouseButton1Click:Connect(function()
            clear()

            local back = button(content,"← Back")
            back.Position = UDim2.new(0,10,0,10)
            back.MouseButton1Click:Connect(function()
                tpBtn:Fire()
            end)

            local tp = button(content,"Teleport to Location")
            tp.Position = UDim2.new(0,10,0,60)

            tp.MouseButton1Click:Connect(function()
                local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if hrp and cf then
                    hrp.CFrame = cf
                else
                    warn("CFrame map belum diisi:",name)
                end
            end)
        end)
    end
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[Fish It] Chloe Style FIXED loaded")
