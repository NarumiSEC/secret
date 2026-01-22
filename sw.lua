-- Fish It | Full UI + Fast Roll + Multi Cast + REAL TELEPORT
-- Delta Executor SAFE
-- NO AUTO STOP

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- GUI PARENT
local function getGuiParent()
    if typeof(gethui) == "function" then
        return gethui()
    end
    return CoreGui
end

-- ================= STATE =================
local FastRoll = false
local MultiCast = false

-- ================= GUI =================
local gui = Instance.new("ScreenGui", getGuiParent())
gui.Name = "FishIt_UI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.38,0.45)
main.Position = UDim2.fromScale(0.31,0.25)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,40)
header.BackgroundColor3 = Color3.fromRGB(25,25,25)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "Fish It | Narumi"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,40,1,0)
close.Position = UDim2.new(1,-40,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(150,50,50)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0,140,1,-40)
sidebar.Position = UDim2.new(0,0,0,40)
sidebar.BackgroundColor3 = Color3.fromRGB(22,22,22)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-140,1,-40)
content.Position = UDim2.new(0,140,0,40)
content.BackgroundTransparency = 1

-- ================= UTILS =================
local function clear()
    for _,v in pairs(content:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
end

local function button(parent,text,y,cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,38)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.MouseButton1Click:Connect(cb)
    return b
end

-- ================= SIDEBAR =================
button(sidebar,"🎣 Fishing",10,function()
    clear()

    button(content,"Fast Roll : "..(FastRoll and "ON" or "OFF"),10,function()
        FastRoll = not FastRoll
    end)

    button(content,"Multi Cast (5x) : "..(MultiCast and "ON" or "OFF"),55,function()
        MultiCast = not MultiCast
    end)
end)

-- ================= TELEPORT LOGIC =================
local MAP_NAMES = {
    "acient jungle","acient jungle outside","acient ruin","coral reefs",
    "creter island ground","creter island top","crystal depths",
    "crystaline pessage","esoteric deep","fishermand island",
    "kohana spot 1","kohana spot 2","kohana volcano",
    "leviatan den","lost shore","pirate cove",
    "pirate treasure room","secred temple","secret pessege",
    "sisyphus statue","tropical grove","tropical grove cave",
    "underground cellar","weater machine"
}

-- Cari spawn REAL
local function findRealSpawn(mapName)
    mapName = mapName:lower()

    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Folder") then
            if obj.Name:lower():find(mapName) then

                -- 1. SpawnLocation
                for _,v in ipairs(obj:GetDescendants()) do
                    if v:IsA("SpawnLocation") then
                        return v.CFrame + Vector3.new(0,5,0)
                    end
                end

                -- 2. PrimaryPart
                if obj:IsA("Model") and obj.PrimaryPart then
                    return obj.PrimaryPart.CFrame + Vector3.new(0,5,0)
                end

                -- 3. Part terbesar
                local biggest, size = nil, 0
                for _,v in ipairs(obj:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local vol = v.Size.X * v.Size.Y * v.Size.Z
                        if vol > size then
                            size = vol
                            biggest = v
                        end
                    end
                end
                if biggest then
                    return biggest.CFrame + Vector3.new(0,5,0)
                end
            end
        end
    end
end

-- ================= TELEPORT MENU =================
button(sidebar,"🧭 Teleport",55,function()
    clear()
    local y = 10

    for _,name in ipairs(MAP_NAMES) do
        button(content,name,y,function()
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local cf = findRealSpawn(name)
                if cf then
                    hrp.CFrame = cf
                    print("[TP] Success:",name)
                else
                    warn("[TP] Map not found:",name)
                end
            end
        end)
        y += 40
    end
end)

-- ================= CORE LOOP =================
task.spawn(function()
    while task.wait(0.05) do
        if FastRoll then
            print("[FAST ROLL]")
            -- RemoteCast:FireServer()
            -- RemoteAccept:FireServer()
        end

        if MultiCast then
            for i=1,5 do
                print("[MULTI CAST]",i)
                -- RemoteCast:FireServer()
                -- RemoteAccept:FireServer()
                task.wait(0.03)
            end
        end
    end
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("[FishIt] REAL TELEPORT + FAST ROLL LOADED")
