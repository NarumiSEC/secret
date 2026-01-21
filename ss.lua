if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local Remotes = RS:WaitForChild("Remotes")
local lp = Players.LocalPlayer

-- GUI PARENT
local function getGuiParent()
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
local rollBtn    = button(sidebar,"⚡ Fast Roll",60)

-- FISHING
fishingBtn.MouseButton1Click:Connect(function()
    clear()
    local y = 10
    for _,mode in ipairs({"Secret","Legendary","Mythic"}) do
        local b = button(content,mode.." Fish",y)
        y += 50
        b.MouseButton1Click:Connect(function()
            Remotes.Fish:FireServer(mode)
        end)
    end
end)

-- FAST ROLL
rollBtn.MouseButton1Click:Connect(function()
    clear()
    local info = Instance.new("TextLabel", content)
    info.Size = UDim2.new(1,-20,0,60)
    info.Position = UDim2.new(0,10,0,10)
    info.Text = "Fast Roll ACTIVE"
    info.TextColor3 = Color3.new(1,1,1)
    info.BackgroundTransparency = 1

    Remotes.FastRoll:FireServer()
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[FishIt] UI LOADED (SERVER BASED)")
