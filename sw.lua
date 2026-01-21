-- Fish It | Full UI + Sidebar + Fast Roll
-- Delta Executor SAFE

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local lp
repeat lp = Players.LocalPlayer task.wait() until lp

-- GUI PARENT
local function getGuiParent()
    if typeof(gethui) == "function" then
        return gethui()
    end
    return CoreGui
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_UI"
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
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Text = "Fish It | Narumi UI"
title.Size = UDim2.new(1,-80,1,0)
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
sidebar.Size = UDim2.new(0,130,1,-40)
sidebar.Position = UDim2.new(0,0,0,40)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-130,1,-40)
content.Position = UDim2.new(0,130,0,40)
content.BackgroundTransparency = 1

-- UTILS
local function clear()
    for _,v in pairs(content:GetChildren()) do
        if v:IsA("GuiObject") then v:Destroy() end
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

-- ================= FISHING =================
fishingBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10
    for _,mode in ipairs({"Secret","Legendary","Mythic"}) do
        local b = button(content,mode.." Fish",y)
        y += 50
        b.MouseButton1Click:Connect(function()
            print("[Fishing] Mode:",mode)
            -- TEMPAT PANGGIL REMOTE SERVER LU
        end)
    end
end)

-- ================= TELEPORT =================
tpBtn.MouseButton1Click:Connect(function()
    clear()
    local maps = {
        ["Island 1"] = CFrame.new(0,10,0),
        ["Island 2"] = CFrame.new(500,10,500),
        ["Secret"]   = CFrame.new(1000,10,-500)
    }

    local y = 10
    for name,cf in pairs(maps) do
        local b = button(content,name,y)
        y += 50
        b.MouseButton1Click:Connect(function()
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = cf
            end
        end)
    end
end)

-- ================= FAST ROLL =================
rollBtn.MouseButton1Click:Connect(function()
    clear()

    local info = Instance.new("TextLabel", content)
    info.Size = UDim2.new(1,-20,0,60)
    info.Position = UDim2.new(0,10,0,10)
    info.Text = "Fast Roll ACTIVE\n(Client spam request)"
    info.TextColor3 = Color3.new(1,1,1)
    info.BackgroundTransparency = 1

    -- SIMULASI FAST LOOP (REAL JIKA SERVER ADA)
    task.spawn(function()
        while task.wait(0.1) do
            -- GANTI INI DENGAN RemoteEvent:FireServer()
            print("[FAST ROLL] request sent")
        end
    end)
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[FishIt] FULL UI LOADED")
