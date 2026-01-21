-- AUTO FISH FAST LOOP (DELTA COMPATIBLE)
-- Effect: roll cepat & konsisten (bukan force RNG)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ====== CONFIG ======
local ENABLED = true
local CAST_DELAY = 0.15      -- jeda antar cast (detik)
local BITE_WAIT = 0.9        -- tunggu bite sebelum pull
local PULL_DELAY = 0.1       -- jeda pull
local LOOP_DELAY = 0.2       -- jeda antar siklus
-- ====================

-- Cari RemoteEvent fishing (umum)
local function findFishingRemotes()
    local cast, pull
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local n = v.Name:lower()
            if (n:find("cast") or n:find("throw")) and not cast then
                cast = v
            elseif (n:find("pull") or n:find("reel") or n:find("catch")) and not pull then
                pull = v
            end
        end
    end
    return cast, pull
end

local CAST_REMOTE, PULL_REMOTE = findFishingRemotes()

if not CAST_REMOTE or not PULL_REMOTE then
    warn("[AUTO FISH] Remote cast/pull tidak ketemu.")
    warn("[AUTO FISH] Coba set manual nama RemoteEvent di script.")
    return
end

print("[AUTO FISH] Cast:", CAST_REMOTE.Name)
print("[AUTO FISH] Pull:", PULL_REMOTE.Name)

-- Helper aman fire server
local function safeFire(remote, ...)
    pcall(function()
        remote:FireServer(...)
    end)
end

-- Loop utama
task.spawn(function()
    while ENABLED do
        -- CAST
        safeFire(CAST_REMOTE)
        task.wait(CAST_DELAY)

        -- TUNGGU BITE (timing stabil biar valid)
        task.wait(BITE_WAIT)

        -- PULL / REEL
        safeFire(PULL_REMOTE)
        task.wait(PULL_DELAY)

        -- ULANG CEPAT
        task.wait(LOOP_DELAY)
    end
end)
