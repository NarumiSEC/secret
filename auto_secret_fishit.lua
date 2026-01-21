-- Fish It | Auto Secret LITE
-- Delta Executor | Stable Build v1

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

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,42)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)
header.ZIndex = 51
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "Fish It | Auto Secret"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.ZIndex = 52
title.TextXAlignment = Enum.TextXAlignment.Left

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-70,0,6)
minBtn.Text = "–"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
minBtn.ZIndex = 53
Instance.new("UICorner", minBtn)

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,6)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,90,90)
closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
closeBtn.ZIndex = 53
Instance.new("UICorner", closeBtn)

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,42)
sidebar.Size = UDim2.new(0.28,0,1,-42)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
sidebar.ZIndex = 51

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.28,0,0,42)
content.Size = UDim2.new(0.72,0,1,-42)
content.BackgroundTransparency = 1

local function makeBtn(parent,text,y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9,0,0,36)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.ZIndex = 52
    Instance.new("UICorner", b)
    return b
end

-- SIDEBAR BUTTONS
local tabFishing = makeBtn(sidebar,"Fishing",15)
local tabTeleport = makeBtn(sidebar,"Teleport",60)

-- CONTENT BUTTONS
local autoFishBtn = makeBtn(content,"Auto Fishing [OFF]",20)
local hopBtn = makeBtn(content,"Server Hop",65)

-- ================= LOGIC =================
-- FIND REMOTES
local castRemote, pullRemote
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n = v.Name:lower()
        if n:find("cast") then castRemote = v end
        if n:find("pull") or n:find("reel") then pullRemote = v end
    end
end

-- AUTO FISH
local auto = false
autoFishBtn.MouseButton1Click:Connect(function()
    auto = not auto
    autoFishBtn.Text = auto and "Auto Fishing [ON]" or "Auto Fishing [OFF]"
end)

task.spawn(function()
    while task.wait(0.25) do
        if auto and castRemote and pullRemote then
            pcall(function()
                castRemote:FireServer()
                task.wait(0.9) -- timing stabil
                pullRemote:FireServer()
            end)
        end
    end
end)

-- SERVER HOP (RESET RNG)
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
