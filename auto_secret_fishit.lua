-- Fish It LITE | Chloe-X Style (DELTA SAFE)
-- Fokus: Auto Fish (roll cepat), Server Hop, Quest Ruby

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local lp = Players.LocalPlayer

-- ================= UI =================
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "FishItLite"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.5,0.55)
main.Position = UDim2.fromScale(0.25,0.22)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0.28,0,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,12)

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.28,0,0,0)
content.Size = UDim2.new(0.72,0,1,0)
content.BackgroundTransparency = 1

local function mkBtn(parent, txt, y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9,0,0,36)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b)
    return b
end

-- Sidebar buttons
local tabFishing = mkBtn(sidebar, "Fishing", 20)
local tabQuest   = mkBtn(sidebar, "Quest", 65)
local tabTP      = mkBtn(sidebar, "Teleport", 110)

-- Content buttons (Fishing)
local autoFishBtn = mkBtn(content, "Auto Fishing [OFF]", 40)
local hopBtn      = mkBtn(content, "Server Hop (Secret Map)", 85)

-- ================= LOGIC =================
-- Cari RemoteEvent umum (aman Delta)
local cast,pull,quest
for _,v in pairs(RS:GetDescendants())_
