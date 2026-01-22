-- Fish It | Chloe-Style UI (SAFE TEST VERSION)
-- For Testing / Own Game Only
-- Delta Executor Friendly

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- GUI PARENT
local function getGuiParent()
    if typeof(gethui) == "function" then
        return gethui()
    end
    return CoreGui
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_ChloeStyle"
gui.ResetOnSpawn = false
gui.Parent = getGuiParent()

-- MAIN FRAME
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
title.Text = "Fish It | Chloe Style (TEST)"
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

-- UTILS
local function clear()
    for _,v in pairs(content:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
end

local function button(parent,text,y)
    local b = Instance.new("TextButton", parent)
    b.Text = text
    b.Size = UDim2.new(1,-10,0,40)
    b.Position = UDim2.new(0,5,0,y)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

-- SIDEBAR BUTTONS
local fishingBtn = button(sidebar,"🎣 Fishing",10)
local tpBtn      = button(sidebar,"🧭 Teleport",60)
local rollBtn    = button(sidebar,"⚡ Fast Roll",110)

-------------------------------------------------
-- ⚡ FAST ROLL + FAST CAST (CLIENT SIDE)
-------------------------------------------------
local FastRoll = false
local FastCast = false

rollBtn.MouseButton1Click:Connect(function()
    clear()

    local y = 10

    local fr = button(content,"Fast Roll : OFF",y)
    y += 50
    fr.MouseButton1Click:Connect(function()
        FastRoll = not FastRoll
        fr.Text = "Fast Roll : "..(FastRoll and "ON" or "OFF")
    end)

    local fc = button(content,"Fast Cast : OFF",y)
    y += 50
    fc.MouseButton1Click:Connect(function()
        FastCast = not FastCast
        fc.Text = "Fast Cast : "..(FastCast and "ON" or "OFF")
    end)

    local info = Instance.new("TextLabel", content)
    info.Size = UDim2.new(1,-20,0,80)
    info.Position = UDim2.new(0,10,0,y)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.new(1,1,1)
    info.TextWrapped = true
    info.Text = [[
Fast Roll & Cast (CLIENT):
- Skip delay
- Spam roll input
- No auto stop
- Safe for testing
]]
end)

-------------------------------------------------
-- 🎣 FISHING (MULTI CAST SIMULATION)
-------------------------------------------------
fishingBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10

    local cast = button(content,"Cast x5 (Test)",y)
    y += 50

    cast.MouseButton1Click:Connect(function()
        task.spawn(function()
            for i=1,5 do
                if FastCast then
                    print("[FAST CAST]",i)
                else
                    print("[NORMAL CAST]",i)
                end
                -- GANTI BAGIAN INI DENGAN REMOTE GAME LU SENDIRI
                task.wait(FastCast and 0.05 or 0.5)
            end
        end)
    end)
end)

-------------------------------------------------
-- 🧭 TELEPORT (CHLOE STYLE)
-------------------------------------------------
tpBtn.MouseButton1Click:Connect(function()
    clear()

    local maps = {
        "Acient jungle",
        "Acient jungle outside",
        "Acient ruin",
        "Coral Reefs",
        "Creter island ground",
        "Creter island top",
        "Crystal Depths",
        "Crystaline Pessage",
        "Esoteric Deep",
        "Fishermand island",
        "Kohana spot 1",
        "Kohana spot 2",
        "Kohana Volcano",
        "Leviatan Den",
        "Lost shore",
        "Pirate cove",
        "Pirate treasure room",
        "Secred temple",
        "Secret pessege",
        "Sisyphus statue",
        "Tropical grove",
        "Tropical grove cave",
        "Underground cellar",
        "Weater machine"
    }

    local y = 10
    for _,name in ipairs(maps) do
        local b = button(content,name,y)
        y += 45

        b.MouseButton1Click:Connect(function()
            clear()
            local info = Instance.new("TextLabel", content)
            info.Size = UDim2.new(1,-20,0,60)
            info.Position = UDim2.new(0,10,0,10)
            info.Text = name
            info.TextColor3 = Color3.new(1,1,1)
            info.BackgroundTransparency = 1

            local tp = button(content,"Teleport to Location",80)
            tp.MouseButton1Click:Connect(function()
                local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- GANTI CFrame INI SESUAI MAP GAME LU
                    hrp.CFrame = hrp.CFrame + Vector3.new(0,0,0)
                    print("[TP]",name)
                end
            end)
        end)
    end
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[Fish It] Chloe-Style UI Loaded (TEST)")
