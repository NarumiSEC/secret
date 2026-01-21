-- Fish It | Auto Secret UI FIXED
-- Delta Executor | UI + Icon Minimize

-- ================= SERVICES =================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- ================= ROOT GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "FishIt_FIXED"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)

-- ================= MAIN FRAME =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55,0.6)
main.Position = UDim2.fromScale(0.22,0.2)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.ZIndex = 10
Instance.new("UICorner", main)
Instance.new("UIStroke", main).Color = Color3.fromRGB(80,80,80)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(28,28,28)
header.ZIndex = 11
Instance.new("UICorner", header)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "Fish It | Auto Secret"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Left
title.ZIndex = 12

local function headBtn(txt,x)
    local b = Instance.new("TextButton", header)
    b.Size = UDim2.new(0,32,0,32)
    b.Position = UDim2.new(1,x,0,6)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.ZIndex = 12
    Instance.new("UICorner", b)
    return b
end

local minBtn = headBtn("–",-75)
local closeBtn = headBtn("X",-38)
closeBtn.TextColor3 = Color3.fromRGB(255,80,80)

-- ================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,0,0,45)
content.Size = UDim2.new(1,0,1,-45)
content.BackgroundTransparency = 1
content.ZIndex = 10

local pad = Instance.new("UIPadding", content)
pad.PaddingTop = UDim.new(0,15)
pad.PaddingLeft = UDim.new(0,20)

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,12)

-- ================= BUTTON MAKER =================
local function makeBtn(txt)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-40,0,40)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.new(1,1,1)
    b.ZIndex = 11
    Instance.new("UICorner", b)
    Instance.new("UIStroke", b).Color = Color3.fromRGB(70,70,70)
    b.Parent = content
    return b
end

-- ================= FEATURES =================
local autoFishBtn = makeBtn("Auto Fishing [ OFF ]")
local chanceInfo = Instance.new("TextLabel", content)
chanceInfo.Size = UDim2.new(1,-40,0,32)
chanceInfo.BackgroundTransparency = 1
chanceInfo.Text = "Secret Chance: BOOSTED (Fast Roll)"
chanceInfo.Font = Enum.Font.Gotham
chanceInfo.TextSize = 12
chanceInfo.TextColor3 = Color3.fromRGB(200,200,200)
chanceInfo.ZIndex = 11

local rollInfo = Instance.new("TextLabel", content)
rollInfo.Size = UDim2.new(1,-40,0,28)
rollInfo.BackgroundTransparency = 1
rollInfo.Text = "Rolls: 0"
rollInfo.Font = Enum.Font.Gotham
rollInfo.TextSize = 12
rollInfo.TextColor3 = Color3.fromRGB(180,180,180)
rollInfo.ZIndex = 11

-- ================= ICON MODE =================
local icon = Instance.new("ImageButton", gui)
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.fromScale(0.05,0.4)
icon.BackgroundTransparency = 1
icon.Visible = false
icon.ZIndex = 20
icon.Image = "rbxassetid://0" -- GANTI ID LOGO LU

-- ================= AUTO FISH LOGIC =================
local cast,pull
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local n=v.Name:lower()
        if n:find("cast") then cast=v end
        if n:find("pull") or n:find("reel") then pull=v end
    end
end

local auto=false
local rolls=0

autoFishBtn.MouseButton1Click:Connect(function()
    auto=not auto
    autoFishBtn.Text = auto and "Auto Fishing [ ON ]" or "Auto Fishing [ OFF ]"
end)

task.spawn(function()
    while task.wait(0.85) do
        if auto and cast and pull then
            cast:FireServer()
            task.wait(0.2)
            pull:FireServer()
            rolls+=1
            rollInfo.Text="Rolls: "..rolls
        end
    end
end)

-- ================= MINIMIZE =================
minBtn.MouseButton1Click:Connect(function()
    main.Visible=false
    icon.Visible=true
end)

icon.MouseButton1Click:Connect(function()
    icon.Visible=false
    main.Visible=true
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
