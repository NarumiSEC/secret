--[[
    AUTO SECRET SCRIPT - FISH IT (ROBLOX)
    ======================================
    PERINGATAN: Script ini hanya untuk tujuan TESTING dan EDUKASI saja!
    Penggunaan script ini dalam permainan dapat:
    - Melanggar Terms of Service Roblox
    - Mengakibatkan ban akun
    - Merusak pengalaman bermain orang lain
    
    Gunakan dengan bijak dan hanya untuk memahami cara kerja script tersebut.
]]

-- Konfigurasi
local config = {
    enabled = true,
    checkInterval = 0.5, -- Interval pengecekan (detik)
    autoClick = true,
    autoCollect = true,
    debugMode = true, -- Tampilkan log untuk testing
    maxDistance = 100 -- Max jarak untuk click secret fish
}

-- Daftar ikan secret yang diketahui
local secretFishes = {
    "El Gren",
    "Maja",
    "Megalodon",
    "Loch Ness",
    "Lockness",
    "Leviathan",
    "Kraken",
    "Cthulhu",
    "Poseidon",
    "Titan",
    "Behemoth",
    "Hydra",
    "Serpent",
    "Dragon Fish",
    "Ancient",
    "Legendary"
}

-- Variabel global
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Fungsi untuk logging (untuk testing)
local function log(message)
    if config.debugMode then
        print("[AUTO SECRET] " .. tostring(message))
    end
end

-- Fungsi untuk mendapatkan lokasi mancing saat ini
local function getCurrentFishingLocation()
    local character = player.Character
    if not character then
        return nil
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return nil
    end
    
    local workspace = game:GetService("Workspace")
    local currentLocation = nil
    
    -- Cari lokasi mancing berdasarkan posisi player
    -- Biasanya ada model/part yang menandakan lokasi mancing
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local name = obj.Name:lower()
            -- Cek apakah player berada di area lokasi mancing
            if name:find("location") or name:find("spot") or name:find("area") or 
               name:find("beach") or name:find("ocean") or name:find("lake") or
               name:find("river") or name:find("island") or name:find("dock") then
                local objPosition = obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") or obj
                if objPosition and objPosition:IsA("BasePart") then
                    local distance = getDistance(humanoidRootPart.Position, objPosition.Position)
                    if distance < 200 then -- Dalam radius 200 studs
                        currentLocation = obj.Name
                        log("Current Location: " .. obj.Name)
                        break
                    end
                end
            end
        end
    end
    
    return currentLocation
end

-- Fungsi untuk mencari ikan secret berdasarkan lokasi
local function findSecretFishes()
    local secretFishesFound = {}
    local workspace = game:GetService("Workspace")
    local currentLocation = getCurrentFishingLocation()
    
    -- Cari semua objek yang mungkin merupakan ikan secret
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("Model") then
            local name = obj.Name
            local nameLower = name:lower()
            
            -- Cek apakah ini ikan secret
            for _, secretName in pairs(secretFishes) do
                if nameLower:find(secretName:lower()) or 
                   nameLower:find("secret") or 
                   nameLower:find("legendary") or
                   nameLower:find("rare") then
                    
                    -- Cek apakah ikan ini visible dan bisa diinteraksi
                    local isVisible = true
                    if obj:IsA("Model") then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart")
                        if primaryPart then
                            isVisible = primaryPart.Transparency < 1
                        end
                    else
                        isVisible = obj.Transparency < 1
                    end
                    
                    if isVisible and obj.Parent then
                        table.insert(secretFishesFound, {
                            object = obj,
                            name = name,
                            location = currentLocation or "Unknown"
                        })
                        log("Found Secret Fish: " .. name .. " at " .. (currentLocation or "Unknown"))
                    end
                end
            end
        end
    end
    
    -- Cari juga di UI/Inventory untuk ikan secret yang sudah tertangkap
    local playerGui = player:WaitForChild("PlayerGui")
    for _, gui in pairs(playerGui:GetDescendants()) do
        if gui:IsA("TextLabel") or gui:IsA("TextButton") then
            local text = gui.Text or ""
            local textLower = text:lower()
            
            for _, secretName in pairs(secretFishes) do
                if textLower:find(secretName:lower()) then
                    log("Found Secret Fish in UI: " .. text)
                end
            end
        end
    end
    
    return secretFishesFound
end

-- Fungsi untuk mencari secret spots (backward compatibility)
local function findSecretSpots()
    local secretSpots = {}
    local secretFishesFound = findSecretFishes()
    
    for _, fish in pairs(secretFishesFound) do
        if fish.object:IsA("Part") or fish.object:IsA("MeshPart") then
            table.insert(secretSpots, fish.object)
        elseif fish.object:IsA("Model") then
            local primaryPart = fish.object.PrimaryPart or fish.object:FindFirstChild("HumanoidRootPart")
            if primaryPart then
                table.insert(secretSpots, primaryPart)
            end
        end
    end
    
    return secretSpots
end

-- Fungsi untuk mendapatkan jarak antara dua posisi
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

-- Fungsi untuk auto click secret fish
local function autoClickSecret(secretObject)
    if not secretObject or not secretObject.Parent then
        return false
    end
    
    local character = player.Character
    if not character then
        return false
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return false
    end
    
    -- Dapatkan posisi objek
    local objPosition = secretObject.Position
    if secretObject:IsA("Model") then
        local primaryPart = secretObject.PrimaryPart or secretObject:FindFirstChild("HumanoidRootPart")
        if primaryPart then
            objPosition = primaryPart.Position
        else
            return false
        end
    end
    
    -- Cek jarak (jika terlalu jauh, tidak bisa click)
    local distance = getDistance(humanoidRootPart.Position, objPosition)
    if distance > config.maxDistance then
        return false
    end
    
    log("Attempting to click secret fish: " .. secretObject.Name .. " (Distance: " .. math.floor(distance) .. " studs)")
    
    -- Method 1: ClickDetector (untuk objek yang bisa di-click langsung)
    local clickDetector = secretObject:FindFirstChild("ClickDetector")
    if not clickDetector and secretObject:IsA("Model") then
        -- Cari ClickDetector di child objects
        for _, child in pairs(secretObject:GetDescendants()) do
            if child:IsA("ClickDetector") then
                clickDetector = child
                break
            end
        end
    end
    
    if clickDetector then
        fireclickdetector(clickDetector)
        log("✓ Secret fish clicked via ClickDetector: " .. secretObject.Name)
        return true
    end
    
    -- Method 2: Remote Events (untuk interaksi via server)
    local remoteNames = {
        "FishSecret",
        "SecretFish",
        "CatchFish",
        "FishEvent",
        "Interact",
        "ClickSecret",
        "CollectSecret"
    }
    
    for _, remoteName in pairs(remoteNames) do
        local remoteEvent = ReplicatedStorage:FindFirstChild(remoteName)
        if not remoteEvent then
            remoteEvent = ReplicatedStorage:FindFirstChild(remoteName, true) -- Recursive search
        end
        
        if remoteEvent and remoteEvent:IsA("RemoteEvent") then
            -- Coba fire dengan berbagai parameter
            pcall(function()
                remoteEvent:FireServer(secretObject)
                remoteEvent:FireServer(secretObject.Name)
                remoteEvent:FireServer({fish = secretObject, action = "catch"})
            end)
            log("✓ Secret fish event fired: " .. secretObject.Name .. " via " .. remoteName)
            return true
        end
    end
    
    -- Method 3: ProximityPrompt (untuk Roblox ProximityPrompt system)
    local proximityPrompt = secretObject:FindFirstChild("ProximityPrompt")
    if not proximityPrompt and secretObject:IsA("Model") then
        for _, child in pairs(secretObject:GetDescendants()) do
            if child:IsA("ProximityPrompt") then
                proximityPrompt = child
                break
            end
        end
    end
    
    if proximityPrompt then
        proximityPrompt:InputHoldBegin()
        wait(0.1)
        proximityPrompt:InputHoldEnd()
        log("✓ Secret fish activated via ProximityPrompt: " .. secretObject.Name)
        return true
    end
    
    -- Method 4: Touch/Click pada part langsung
    if secretObject:IsA("Part") or secretObject:IsA("MeshPart") then
        -- Simulasi touch event
        local touchEvent = secretObject:FindFirstChild("Touched")
        if touchEvent then
            touchEvent:Fire(humanoidRootPart)
            log("✓ Secret fish touched: " .. secretObject.Name)
            return true
        end
    end
    
    log("✗ Could not interact with secret fish: " .. secretObject.Name)
    return false
end

-- Fungsi untuk auto collect rewards
local function autoCollectRewards()
    -- Cari UI elements yang menandakan reward tersedia
    local screenGui = playerGui:FindFirstChild("ScreenGui")
    if not screenGui then
        return false
    end
    
    -- Cari tombol collect (contoh struktur)
    for _, gui in pairs(screenGui:GetDescendants()) do
        if gui:IsA("TextButton") or gui:IsA("ImageButton") then
            local text = gui.Text:lower() or ""
            if text:find("collect") or text:find("claim") or text:find("ambil") then
                -- Simulasi click tombol
                gui:Fire("MouseButton1Click")
                log("Reward collected")
                return true
            end
        end
    end
    
    return false
end

-- Main loop
local connection
local function startAutoSecret()
    if not config.enabled then
        log("Script disabled")
        return
    end
    
    log("Auto Secret Script Started")
    
    connection = RunService.Heartbeat:Connect(function()
        if not config.enabled then
            if connection then
                connection:Disconnect()
            end
            return
        end
        
        -- Cari ikan secret
        local secretFishesFound = findSecretFishes()
        
        if #secretFishesFound > 0 then
            log("Found " .. #secretFishesFound .. " secret fish(es)")
            
            -- Coba click ikan secret yang terdekat
            if config.autoClick then
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local closestSecret = nil
                        local closestDistance = math.huge
                        local closestFishName = ""
                        
                        for _, fishData in pairs(secretFishesFound) do
                            local fishObj = fishData.object
                            local objPosition = fishObj.Position
                            
                            if fishObj:IsA("Model") then
                                local primaryPart = fishObj.PrimaryPart or fishObj:FindFirstChild("HumanoidRootPart")
                                if primaryPart then
                                    objPosition = primaryPart.Position
                                else
                                    goto continue
                                end
                            end
                            
                            local distance = getDistance(humanoidRootPart.Position, objPosition)
                            if distance < closestDistance and distance <= config.maxDistance then
                                closestDistance = distance
                                closestSecret = fishObj
                                closestFishName = fishData.name
                            end
                            
                            ::continue::
                        end
                        
                        if closestSecret then
                            log("Targeting: " .. closestFishName .. " (" .. math.floor(closestDistance) .. " studs away)")
                            autoClickSecret(closestSecret)
                        end
                    end
                end
            end
        end
        
        -- Auto collect rewards
        if config.autoCollect then
            autoCollectRewards()
        end
    end)
end

-- Fungsi untuk stop script
local function stopAutoSecret()
    config.enabled = false
    if connection then
        connection:Disconnect()
    end
    log("Auto Secret Script Stopped")
end

-- UI untuk kontrol (opsional, untuk testing)
local statusLabel = nil
local fishCountLabel = nil
local locationLabel = nil

local function createTestUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoSecretUI"
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 200)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    frame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    title.Text = "🐟 Auto Secret Fish (TEST)"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.9, 0, 0, 30)
    toggleBtn.Position = UDim2.new(0.05, 0, 0, 40)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    toggleBtn.Text = "ENABLED"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.Gotham
    toggleBtn.TextSize = 12
    toggleBtn.Parent = frame
    
    toggleBtn.MouseButton1Click:Connect(function()
        config.enabled = not config.enabled
        if config.enabled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            toggleBtn.Text = "ENABLED"
            startAutoSecret()
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            toggleBtn.Text = "DISABLED"
            stopAutoSecret()
        end
    end)
    
    locationLabel = Instance.new("TextLabel")
    locationLabel.Size = UDim2.new(0.9, 0, 0, 20)
    locationLabel.Position = UDim2.new(0.05, 0, 0, 80)
    locationLabel.BackgroundTransparency = 1
    locationLabel.Text = "Location: Detecting..."
    locationLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    locationLabel.Font = Enum.Font.Gotham
    locationLabel.TextSize = 10
    locationLabel.TextXAlignment = Enum.TextXAlignment.Left
    locationLabel.Parent = frame
    
    fishCountLabel = Instance.new("TextLabel")
    fishCountLabel.Size = UDim2.new(0.9, 0, 0, 20)
    fishCountLabel.Position = UDim2.new(0.05, 0, 0, 105)
    fishCountLabel.BackgroundTransparency = 1
    fishCountLabel.Text = "Secret Fish: 0"
    fishCountLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    fishCountLabel.Font = Enum.Font.Gotham
    fishCountLabel.TextSize = 10
    fishCountLabel.TextXAlignment = Enum.TextXAlignment.Left
    fishCountLabel.Parent = frame
    
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
    statusLabel.Position = UDim2.new(0.05, 0, 0, 130)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Ready"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 10
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame
    
    -- Update UI secara berkala
    spawn(function()
        while wait(1) do
            if locationLabel then
                local currentLoc = getCurrentFishingLocation()
                locationLabel.Text = "Location: " .. (currentLoc or "Unknown")
            end
            
            if fishCountLabel then
                local fishes = findSecretFishes()
                fishCountLabel.Text = "Secret Fish: " .. #fishes
                if #fishes > 0 then
                    fishCountLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    fishCountLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                end
            end
            
            if statusLabel then
                if config.enabled then
                    statusLabel.Text = "Status: Active"
                    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    statusLabel.Text = "Status: Inactive"
                    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
        end
    end)
    
    log("Test UI Created")
end

-- Inisialisasi
wait(2) -- Tunggu game load
log("Initializing Auto Secret Script...")
createTestUI()

-- Auto start (opsional)
-- startAutoSecret()

-- Export functions untuk testing manual
return {
    start = startAutoSecret,
    stop = stopAutoSecret,
    config = config,
    findSecretSpots = findSecretSpots,
    findSecretFishes = findSecretFishes,
    getCurrentFishingLocation = getCurrentFishingLocation,
    autoClickSecret = autoClickSecret,
    autoCollectRewards = autoCollectRewards,
    secretFishes = secretFishes
}
