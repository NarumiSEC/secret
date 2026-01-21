-- Narumi Fish UI - REAL + FAST ROLL (DELTA SAFE)
-- For DEV / TESTING in YOUR OWN GAME

--------------------------------------------------
-- LOADER FIX (WAJIB UNTUK DELTA)
--------------------------------------------------
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player
repeat
    player = Players.LocalPlayer
    task.wait()
until player

local remote = ReplicatedStorage:WaitForChild("GameAction")

--------------------------------------------------
-- GUI PARENT FIX
--------------------------------------------------
local function getGuiParent()
    if typeof(gethui) == "function" then
        return gethui()
    end
    return CoreGui
end

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "NarumiExploitUI"
gui.ResetOnSpawn = false

pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end
end)

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

--------------------------------------------------
-- TOP BAR
--------------------------------------------------
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", top)

local title = Instance.new("TextLabel", top)
title.Text = "Fish It DEV PANEL\nNarumiStore"
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

--------------------------------------------------
-- SIDEBAR & CONTENT
--------------------------------------------------
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
        if v:IsA("GuiObject") then
            v:Destroy()
        end
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
-- SIDEBAR BUTTON
--------------------------------------------------
local fishingBtn = btn(side,"🎣 Fishing",10)

--------------------------------------------------
-- FISHING UI
--------------------------------------------------
fishingBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10

    -- NORMAL ROLL
    for _,rarity in ipairs({"Common","Legendary","Mythic","Secret"}) do
        local b = btn(content, rarity.." Roll", y)
        y += 45

        b.MouseButton1Click:Connect(function()
            remote:FireServer("Fishing", rarity, 1)
        end)
    end

    y += 10

    -- FAST ROLL (DEV MODE)
    local fast = btn(content,"⚡ Fast Roll (x10)", y)
    fast.BackgroundColor3 = Color3.fromRGB(80,40,40)

    fast.MouseButton1Click:Connect(function()
        -- 1 REQUEST, BUKAN SPAM
        remote:FireServer("Fishing", "Secret", 10)
    end)
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[Narumi] UI Loaded | Fast Roll Ready")
