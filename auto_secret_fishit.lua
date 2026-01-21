local CoreGui = game:GetService("CoreGui")

local g = Instance.new("ScreenGui", CoreGui)
g.Name = "TESTUI"
g.ResetOnSpawn = false
g.IgnoreGuiInset = true

local f = Instance.new("Frame", g)
f.Size = UDim2.fromScale(0.4,0.4)
f.Position = UDim2.fromScale(0.3,0.3)
f.BackgroundColor3 = Color3.fromRGB(25,25,25)
f.ZIndex = 100
Instance.new("UICorner", f)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.fromScale(1,1)
t.Text = "UI MASUK = AMAN"
t.TextColor3 = Color3.new(1,1,1)
t.BackgroundTransparency = 1
t.ZIndex = 101
