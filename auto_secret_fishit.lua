-- AUTO SECRET FISH (DELTA SAFE VERSION)
-- Focus: RemoteEvent only

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local ENABLED = true
local SCAN_DELAY = 1.5

-- nama ikan secret (basic)
local SECRET_KEYWORDS = {
    "secret",
    "legendary",
    "mythic",
    "ancient",
    "kraken",
    "leviathan",
    "megalodon"
}

-- cari RemoteEvent fishing
local function findFishingRemote()
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local n = v.Name:lower()
            if n:find("fish") or n:find("catch") or n:find("hook") then
                return v
            end
        end
    end
end

local FISH_REMOTE = findFishingRemote()

if not FISH_REMOTE then
    warn("[AUTO SECRET] Fishing Remote NOT FOUND")
    return
end

print("[AUTO SECRET] Using Remote:", FISH_REMOTE.Name)

-- scan ikan secret (ringan)
local function findSecretFish()
    for _, obj in pairs(workspace:GetChildren()) do
        local name = obj.Name:lower()
        for _, key in pairs(SECRET_KEYWORDS) do
            if name:find(key) then
                return obj
            end
        end
    end
end

-- loop utama
task.spawn(function()
    while ENABLED do
        task.wait(SCAN_DELAY)

        local fish = findSecretFish()
        if fish then
            print("[AUTO SECRET] Found:", fish.Name)

            -- fire remote (multi attempt biar kena)
            pcall(function()
                FISH_REMOTE:FireServer(fish)
                FISH_REMOTE:FireServer(fish.Name)
                FISH_REMOTE:FireServer({target = fish})
            end)
        end
    end
end)
