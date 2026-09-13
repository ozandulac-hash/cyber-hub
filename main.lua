-- ============================================================
-- CYBER HUB — DROP 1 : BASE GUI + API
-- ============================================================

local Players    = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui    = game:GetService("CoreGui")
local LP         = Players.LocalPlayer

-- Eski GUI'leri temizle
do
    local names = {"CyberHub", "CH_StealBar", "StealBarGui"}
    local function clean(parent)
        if not parent then return end
        pcall(function()
            for _, n in ipairs(names) do
                local old = parent:FindFirstChild(n)
                if old then old:Destroy() end
            end
        end)
    end
    clean(LP:FindFirstChild("PlayerGui"))
    clean(CoreGui)
    if type(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then clean(hui) end
    end
end

-- Renk paleti
local TA = Color3.fromRGB(220, 30, 60)
local TAD = Color3.fromRGB(140, 20, 40)
local C = {
    BG = Color3.fromRGB(10, 6, 9),
    PANEL = Color3.fromRGB(16, 10, 14),
    CARD = Color3.fromRGB(24, 16, 20),
    CARD_HOV = Color3.fromRGB(36, 22, 28),
    STROKE = Color3.fromRGB(80, 40, 50),
    TEXT = Color3.fromRGB(240, 230, 235),
    TEXT_DIM = Color3.fromRGB(160, 130, 140),
    INPUT = Color3.fromRGB(14, 8, 12),
    GRID = Color3.fromRGB(55, 55, 60),
    DOT = Color3.fromRGB(90, 90, 95),
}

-- ScreenGui
local SG = Instance.new("ScreenGui")
SG.Name = "CyberHub"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true

local parented = false
pcall(function()
    if gethui then SG.Parent = gethui(); parented = true end
end)
if not parented then
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(SG) end
    end)
    pcall(function() SG.Parent = CoreGui; parented = true end)
end
if not parented then
    SG.Parent = LP:WaitForChild("PlayerGui")
end

-- Ana Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 720)
Main.Position = UDim2.new(0.5, -240, 0.5, -360)
Main.BackgroundColor3 = C.BG
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = SG
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

local MS = Instance.new("UIStroke", Main)
MS.Color = TA
MS.Thickness = 1.5
MS.Transparency = 0.35
MS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local BgLayer = Instance.new("Frame", Main)
BgLayer.Size = UDim2.new(1, 0, 1, 0)
BgLayer.BackgroundTransparency = 1
BgLayer.BorderSizePixel = 0
BgLayer.ZIndex = 1
BgLayer.ClipsDescendants = true
Instance.new("UICorner", BgLayer).CornerRadius = UDim.new(0, 20)

local BgGrad = Instance.new("Frame", BgLayer)
BgGrad.Size = UDim2.new(1, 0, 1, 0)
BgGrad.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BgGrad.BorderSizePixel = 0
BgGrad.ZIndex = 1
Instance.new("UICorner", BgGrad).CornerRadius = UDim.new(0, 20)

local BgGradG = Instance.new("UIGradient", BgGrad)
BgGradG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 18, 22)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 8, 11)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 3, 5)),
})
BgGradG.Rotation = 90

for i = 0, 50 do
    local line = Instance.new("Frame", BgLayer)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0, i * 15)
    line.BackgroundColor3 = C.GRID
    line.BackgroundTransparency = 0.82
    line.BorderSizePixel = 0
    line.ZIndex = 2
end
for i = 0, 34 do
    local line = Instance.new("Frame", BgLayer)
    line.Size = UDim2.new(0, 1, 1, 0)
    line.Position = UDim2.new(0, i * 15, 0, 0)
    line.BackgroundColor3 = C.GRID
    line.BackgroundTransparency = 0.82
    line.BorderSizePixel = 0
    line.ZIndex = 2
end
for i = 1, 100 do
    local dot = Instance.new("Frame", BgLayer)
    dot.Size = UDim2.new(0, 2, 0, 2)
    dot.Position = UDim2.new(math.random(), 0, math.random(), 0)
    dot.BackgroundColor3 = C.DOT
    dot.BackgroundTransparency = 0.5
    dot.BorderSizePixel = 0
    dot.ZIndex = 3
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
end

local TB = Instance.new("Frame", Main)
TB.Size = UDim2.new(1, 0, 0, 46)
TB.BackgroundColor3 = C.PANEL
TB.BackgroundTransparency = 0.1
TB.BorderSizePixel = 0
TB.ZIndex = 5
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 20)

local TF = Instance.new("Frame", TB)
TF.Size = UDim2.new(1, 0, 0, 14)
TF.Position = UDim2.new(0, 0, 1, -14)
TF.BackgroundColor3 = C.PANEL
TF.BackgroundTransparency = 0.1
TF.BorderSizePixel = 0
TF.ZIndex = 5

local TL = Instance.new("Frame", TB)
TL.Size = UDim2.new(1, 0, 0, 1)
TL.Position = UDim2.new(0, 0, 1, -1)
TL.BackgroundColor3 = TA
TL.BackgroundTransparency = 0.55
TL.BorderSizePixel = 0
TL.ZIndex = 6

local TLabel = Instance.new("TextLabel", TB)
TLabel.Size = UDim2.new(0, 400, 1, 0)
TLabel.Position = UDim2.new(0, 20, 0, 0)
TLabel.BackgroundTransparency = 1
TLabel.Text = "CYBER  HUB"
TLabel.Font = Enum.Font.GothamBlack
TLabel.TextSize = 16
TLabel.TextColor3 = C.TEXT
TLabel.TextXAlignment = Enum.TextXAlignment.Left
TLabel.ZIndex = 6

local MB = Instance.new("TextButton", TB)
MB.Size = UDim2.new(0, 28, 0, 28)
MB.Position = UDim2.new(1, -38, 0, 9)
MB.BackgroundColor3 = TAD
MB.BackgroundTransparency = 0.15
MB.Text = "—"
MB.TextColor3 = Color3.fromRGB(255, 230, 235)
MB.Font = Enum.Font.GothamBold
MB.TextSize = 15
MB.AutoButtonColor = false
MB.ZIndex = 6
Instance.new("UICorner", MB).CornerRadius = UDim.new(0, 7)
MB.MouseEnter:Connect(function()
    TweenService:Create(MB, TweenInfo.new(0.15), {BackgroundColor3 = TA, BackgroundTransparency = 0}):Play()
end)
MB.MouseLeave:Connect(function()
    TweenService:Create(MB, TweenInfo.new(0.15), {BackgroundColor3 = TAD, BackgroundTransparency = 0.15}):Play()
end)

local SB = Instance.new("Frame", Main)
SB.Name = "Sidebar"
SB.Size = UDim2.new(0, 150, 1, -46)
SB.Position = UDim2.new(0, 0, 0, 46)
SB.BackgroundColor3 = C.PANEL
SB.BackgroundTransparency = 0.2
SB.BorderSizePixel = 0
SB.ClipsDescendants = true
SB.ZIndex = 4
Instance.new("UICorner", SB).CornerRadius = UDim.new(0, 20)

local NC = Instance.new("Frame", SB)
NC.Size = UDim2.new(1, -16, 1, -16)
NC.Position = UDim2.new(0, 8, 0, 8)
NC.BackgroundTransparency = 1
NC.ZIndex = 6

local NL = Instance.new("UIListLayout", NC)
NL.Padding = UDim.new(0, 8)
NL.SortOrder = Enum.SortOrder.LayoutOrder

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -166, 1, -62)
Content.Position = UDim2.new(0, 158, 0, 54)
Content.BackgroundTransparency = 1
Content.ZIndex = 8
Content.ClipsDescendants = true

local Pages = {}

local function createPage(name)
    local h = Instance.new("ScrollingFrame", Content)
    h.Name = name .. "Page"
    h.Size = UDim2.new(1, 0, 1, 0)
    h.BackgroundTransparency = 1
    h.BorderSizePixel = 0
    h.CanvasSize = UDim2.new(0, 0, 0, 0)
    h.AutomaticCanvasSize = Enum.AutomaticSize.Y
    h.ScrollBarThickness = 3
    h.ScrollBarImageColor3 = TA
    h.ScrollBarImageTransparency = 0.4
    h.Visible = false
    h.ZIndex = 9

    local l = Instance.new("UIListLayout", h)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, 8)

    local p = Instance.new("UIPadding", h)
    p.PaddingLeft = UDim.new(0, 4)
    p.PaddingRight = UDim.new(0, 4)
    p.PaddingTop = UDim.new(0, 4)
    p.PaddingBottom = UDim.new(0, 16)

    return h
end

local _LO = 0
local function LO()
    _LO = _LO + 1
    return _LO
end

local function mkSect(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 24)
    f.BackgroundTransparency = 1
    f.LayoutOrder = LO()

    local d = Instance.new("Frame", f)
    d.Size = UDim2.new(0, 3, 0, 18)
    d.Position = UDim2.new(0, 4, 0.5, -9)
    d.BackgroundColor3 = TA
    d.BorderSizePixel = 0
    Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -20, 1, 0)
    l.Position = UDim2.new(0, 16, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = string.upper(text)
    l.Font = Enum.Font.GothamBlack
    l.TextSize = 12
    l.TextColor3 = TA
    l.TextXAlignment = Enum.TextXAlignment.Left
    return f
end

local function mkRow(parent, h)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -2, 0, h or 44)
    f.BackgroundColor3 = C.CARD
    f.BackgroundTransparency = 0.15
    f.BorderSizePixel = 0
    f.LayoutOrder = LO()
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

    local s = Instance.new("UIStroke", f)
    s.Color = C.STROKE
    s.Thickness = 1
    s.Transparency = 0.4
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    f.MouseEnter:Connect(function()
        TweenService:Create(f, TweenInfo.new(0.1), {BackgroundColor3 = C.CARD_HOV}):Play()
    end)
    f.MouseLeave:Connect(function()
        TweenService:Create(f, TweenInfo.new(0.1), {BackgroundColor3 = C.CARD}):Play()
    end)
    return f
end

local function mkLabel(row, text)
    local l = Instance.new("TextLabel", row)
    l.Size = UDim2.new(0.55, 0, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextColor3 = C.TEXT
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

local function mkBox(row, default, width, offsetRight, onChange)
    local t = Instance.new("TextBox", row)
    t.Size = UDim2.new(0, width or 60, 0, 26)
    t.Position = UDim2.new(1, -(offsetRight or 72), 0.5, -13)
    t.BackgroundColor3 = C.INPUT
    t.BackgroundTransparency = 0.15
    t.BorderSizePixel = 0
    t.Text = tostring(default)
    t.TextColor3 = TA
    t.Font = Enum.Font.GothamBold
    t.TextSize = 11
    t.ClearTextOnFocus = false
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 7)

    local s = Instance.new("UIStroke", t)
    s.Color = C.STROKE
    s.Thickness = 1
    s.Transparency = 0.3

    t.FocusLost:Connect(function()
        local n = tonumber(t.Text)
        if n and onChange then
            onChange(n)
        else
            t.Text = tostring(default)
        end
    end)
    return t
end

local _anyKeyListening = false

local function mkToggle(parent, label, default, onToggle)
    local row = mkRow(parent, 44)
    mkLabel(row, label)

    local on = default
    local pill = Instance.new("Frame", row)
    pill.Size = UDim2.new(0, 46, 0, 24)
    pill.Position = UDim2.new(1, -56, 0.5, -12)
    pill.BackgroundColor3 = on and TA or C.INPUT
    pill.BorderSizePixel = 0
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame", pill)
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.Position = on and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    dot.BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton", pill)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Activated:Connect(function()
        if _anyKeyListening then return end
        on = not on
        TweenService:Create(pill, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
            BackgroundColor3 = on and TA or C.INPUT,
        }):Play()
        TweenService:Create(dot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
            Position = on and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
            BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150),
        }):Play()
        if onToggle then onToggle(on) end
    end)

    return function(v)
        on = v
        TweenService:Create(pill, TweenInfo.new(0.18), {BackgroundColor3 = v and TA or C.INPUT}):Play()
        TweenService:Create(dot, TweenInfo.new(0.18), {
            Position = v and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        }):Play()
    end
end

local NAV = {
    {name = "Combat",   icon = "⚔"},
    {name = "Movement", icon = "✦"},
    {name = "Visual",   icon = "◉"},
    {name = "Settings", icon = "⚙"},
}

local NavButtons = {}
local activePageName = nil

local function switchPage(name)
    if activePageName == name then return end
    activePageName = name
    for n, p in pairs(Pages) do
        p.Visible = (n == name)
    end
    for n, b in pairs(NavButtons) do
        local a = (n == name)
        TweenService:Create(b, TweenInfo.new(0.18), {
            BackgroundColor3 = a and TA or C.CARD,
        }):Play()
        local st = b:FindFirstChildOfClass("UIStroke")
        if st then
            TweenService:Create(st, TweenInfo.new(0.18), {
                Color = a and TA or C.STROKE,
                Transparency = a and 0.1 or 0.5,
            }):Play()
        end
    end
end

for i, item in ipairs(NAV) do
    local b = Instance.new("TextButton", NC)
    b.Name = item.name .. "Btn"
    b.Size = UDim2.new(1, 0, 0, 44)
    b.BackgroundColor3 = C.CARD
    b.BackgroundTransparency = 0.15
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.LayoutOrder = i
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    local bs = Instance.new("UIStroke", b)
    bs.Color = C.STROKE
    bs.Thickness = 1
    bs.Transparency = 0.5

    local ac = Instance.new("Frame", b)
    ac.Size = UDim2.new(0, 3, 0, 24)
    ac.Position = UDim2.new(0, 6, 0.5, -12)
    ac.BackgroundColor3 = TA
    ac.BorderSizePixel = 0
    Instance.new("UICorner", ac).CornerRadius = UDim.new(1, 0)

    local ic = Instance.new("TextLabel", b)
    ic.Size = UDim2.new(0, 26, 1, 0)
    ic.Position = UDim2.new(0, 16, 0, 0)
    ic.BackgroundTransparency = 1
    ic.Text = item.icon
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 15
    ic.TextColor3 = TA

    local lb = Instance.new("TextLabel", b)
    lb.Size = UDim2.new(1, -50, 1, 0)
    lb.Position = UDim2.new(0, 46, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text = item.name
    lb.Font = Enum.Font.GothamBold
    lb.TextSize = 13
    lb.TextColor3 = C.TEXT
    lb.TextXAlignment = Enum.TextXAlignment.Left

    NavButtons[item.name] = b

    b.MouseEnter:Connect(function()
        if activePageName ~= item.name then
            TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = C.CARD_HOV}):Play()
        end
    end)
    b.MouseLeave:Connect(function()
        if activePageName ~= item.name then
            TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = C.CARD}):Play()
        end
    end)
    b.MouseButton1Click:Connect(function() switchPage(item.name) end)

    Pages[item.name] = createPage(item.name)
end

switchPage("Combat")

local settingsPage = Pages["Settings"]

mkSect(settingsPage, "GUI SIZE")

do
    local row = mkRow(settingsPage, 44)
    mkLabel(row, "Width")
    mkBox(row, 480, 70, 80, function(v)
        if v >= 300 and v <= 900 then
            Main.Size = UDim2.new(0, v, 0, Main.Size.Y.Offset)
        end
    end)
end

do
    local row = mkRow(settingsPage, 44)
    mkLabel(row, "Height")
    mkBox(row, 720, 70, 80, function(v)
        if v >= 300 and v <= 1000 then
            Main.Size = UDim2.new(0, Main.Size.X.Offset, 0, v)
        end
    end)
end

mkSect(settingsPage, "PRESETS")

local function presetRow(labelText, w, h)
    local row = mkRow(settingsPage, 44)
    mkLabel(row, labelText)
    local b = Instance.new("TextButton", row)
    b.Size = UDim2.new(0, 80, 0, 28)
    b.Position = UDim2.new(1, -90, 0.5, -14)
    b.BackgroundColor3 = C.INPUT
    b.BackgroundTransparency = 0.15
    b.Text = "APPLY"
    b.TextColor3 = TA
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    local s = Instance.new("UIStroke", b)
    s.Color = C.STROKE
    s.Thickness = 1
    s.Transparency = 0.3
    b.MouseButton1Click:Connect(function()
        Main.Size = UDim2.new(0, w, 0, h)
        Main.Position = UDim2.new(0.5, -w / 2, 0.5, -h / 2)
    end)
end

presetRow("Small (360x540)", 360, 540)
presetRow("Medium (480x720)", 480, 720)
presetRow("Large (600x900)", 600, 900)

mkSect(settingsPage, "LAYOUT")

do
    local row = mkRow(settingsPage, 44)
    mkLabel(row, "Horizontal / Vertical")
    local b = Instance.new("TextButton", row)
    b.Size = UDim2.new(0, 80, 0, 28)
    b.Position = UDim2.new(1, -90, 0.5, -14)
    b.BackgroundColor3 = C.INPUT
    b.BackgroundTransparency = 0.15
    b.Text = "SWAP"
    b.TextColor3 = TA
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    local s = Instance.new("UIStroke", b)
    s.Color = C.STROKE
    s.Thickness = 1
    s.Transparency = 0.3
    b.MouseButton1Click:Connect(function()
        local w = Main.Size.X.Offset
        local h = Main.Size.Y.Offset
        Main.Size = UDim2.new(0, h, 0, w)
    end)
end

local minimized = false
MB.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        SB.Visible = false
        Content.Visible = false
        Main.Size = UDim2.new(0, Main.Size.X.Offset, 0, 46)
        MB.Text = "☐"
    else
        SB.Visible = true
        Content.Visible = true
        Main.Size = UDim2.new(0, Main.Size.X.Offset, 0, Main.Size.Y.Offset + 674)
        MB.Text = "—"
    end
end)

_G.CyberHub = {
    Pages        = Pages,
    combatPage   = Pages["Combat"],
    movePage     = Pages["Movement"],
    visPage      = Pages["Visual"],
    settingsPage = Pages["Settings"],
    mkSect       = mkSect,
    mkRow        = mkRow,
    mkLabel      = mkLabel,
    mkBox        = mkBox,
    mkToggle     = mkToggle,
    TA           = TA,
    TAD          = TAD,
    C            = C,
    TS           = TweenService,
    LP           = LP,
    UIS          = UserInputService,
    Main         = Main,
    SB           = SB,
    Content      = Content,
    switchPage   = switchPage,
    getListen    = function() return _anyKeyListening end,
    setListen    = function(v) _anyKeyListening = v end,
}

print("[CYBER HUB] DROP 1 loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 2 : COMBAT
-- Requires: DROP 1
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local mkBox    = H.mkBox
    local mkToggle = H.mkToggle
    local TA       = H.TA
    local C        = H.C
    local TS       = H.TS
    local LP       = H.LP
    local combatPage = H.Pages["Combat"]

    local Players    = game:GetService("Players")
    local RunService = game:GetService("RunService")

    _G.CH_Combat = _G.CH_Combat or {}
    local CB = _G.CH_Combat

    CB.autoSwing         = CB.autoSwing         or false
    CB.batCounter        = CB.batCounter        or false
    CB.medCounter        = CB.medCounter        or false
    CB.antiRagdoll       = CB.antiRagdoll       or false
    CB.antiDie           = CB.antiDie           or false
    CB.antiVoid          = CB.antiVoid          or false
    CB.noPlayerCollision = CB.noPlayerCollision or false
    CB.bodyLock          = CB.bodyLock          or false
    CB.bodyLockRadius    = CB.bodyLockRadius    or 60
    CB.tpBat             = CB.tpBat             or false
    CB.aimbotMode        = CB.aimbotMode        or "Normal"
    CB.aimbotOn          = CB.aimbotOn          or false
    CB.aimbotSpeed       = CB.aimbotSpeed       or 58
    CB.aimbotConn        = CB.aimbotConn        or nil
    CB.aimbotTarget      = CB.aimbotTarget      or nil
    CB.aimbotLastScan    = CB.aimbotLastScan    or 0
    CB.aimbotSwingCd     = CB.aimbotSwingCd     or false
    CB.tpBatConn         = CB.tpBatConn         or nil
    CB.bodyLockConn      = CB.bodyLockConn      or nil
    CB.antiRagdollConn   = CB.antiRagdollConn   or nil
    CB.antiVoidConn      = CB.antiVoidConn      or nil
    CB.antiDieConn       = CB.antiDieConn       or nil
    CB.batCounterConn    = CB.batCounterConn    or nil
    CB.medCounterConns   = CB.medCounterConns   or {}
    CB.noCollisionConns  = CB.noCollisionConns  or {}
    CB.counterCooldown   = CB.counterCooldown   or 0
    CB.medLastUsed       = CB.medLastUsed       or 0
    CB.medCooldown       = CB.medCooldown       or 25
    CB.antiVoidSafe      = CB.antiVoidSafe      or nil

    function CB.findBat()
        local char = LP.Character
        if not char then return nil end
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                local n = tool.Name:lower()
                if n:find("bat") or n:find("slap") then return tool end
            end
        end
        local bp = LP:FindFirstChildOfClass("Backpack")
        if bp then
            for _, tool in ipairs(bp:GetChildren()) do
                if tool:IsA("Tool") then
                    local n = tool.Name:lower()
                    if n:find("bat") or n:find("slap") then return tool end
                end
            end
        end
        return nil
    end

    function CB.ensureBat()
        local char = LP.Character
        if not char then return nil end
        local eq = char:FindFirstChildOfClass("Tool")
        if eq then return eq end
        local bat = CB.findBat()
        if bat and bat.Parent ~= char then
            bat.Parent = char
        end
        return bat
    end

    function CB.isRagdoll(hum)
        if not hum then return false end
        local st = hum:GetState()
        return st == Enum.HumanoidStateType.Physics
            or st == Enum.HumanoidStateType.Ragdoll
            or st == Enum.HumanoidStateType.FallingDown
            or hum.PlatformStand == true
    end

    function CB.getClosestPlayerRoot(maxRange)
        local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil, math.huge end
        local closest, minDist = nil, maxRange or math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local tr = plr.Character:FindFirstChild("HumanoidRootPart")
                local th = plr.Character:FindFirstChildOfClass("Humanoid")
                if tr and th and th.Health > 0 then
                    local d = (tr.Position - myRoot.Position).Magnitude
                    if d < minDist then minDist = d; closest = tr end
                end
            end
        end
        return closest, minDist
    end

    CB.aimbotTrySwing = CB.aimbotTrySwing or function()
        if CB.aimbotSwingCd then return end
        CB.aimbotSwingCd = true
        pcall(function()
            local bat = CB.ensureBat()
            if bat and bat:IsA("Tool") then bat:Activate() end
        end)
        task.delay(0.08, function() CB.aimbotSwingCd = false end)
    end

    CB.startAimbot = function()
        if CB.aimbotConn then CB.aimbotConn:Disconnect(); CB.aimbotConn = nil end
        CB.aimbotOn = true

        local hum0 = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum0 then hum0.AutoRotate = false end

        local isBypass = CB.aimbotMode == "Anti Bypass"

        CB.aimbotConn = RunService.Heartbeat:Connect(function()
            if not CB.aimbotOn then return end
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not char or not hum or not root or hum.Health <= 0 then return end

            hum.AutoRotate = false

            if not char:FindFirstChildOfClass("Tool") then
                CB.ensureBat()
            end

            local now = tick()
            if isBypass then
                local target, dist = CB.getClosestPlayerRoot(300)
                if not target then
                    root.AssemblyAngularVelocity = Vector3.zero
                    return
                end

                local targetPos = target.Position + Vector3.new(0, 1, 0)
                local flatLook = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)

                if flatLook.Magnitude > 0.01 then
                    local targetYaw = math.deg(math.atan2(-flatLook.X, -flatLook.Z))
                    local yawDelta = (targetYaw - root.Orientation.Y + 180) % 360 - 180
                    local yawRate = math.clamp(yawDelta * 8, -28, 28)
                    root.AssemblyAngularVelocity = Vector3.new(0, yawRate, 0)
                end

                local look = targetPos - root.Position
                if look.Magnitude > 0.01 then
                    local dir = look.Unit
                    local standPos = targetPos - (dir * -2.8) + Vector3.new(0, 4.75, 0)
                    local moveDir = standPos - root.Position
                    local hDir = Vector3.new(moveDir.X, 0, moveDir.Z)
                    local spd = CB.aimbotSpeed
                    local hVel = hDir.Magnitude > 0.1 and hDir.Unit * spd or Vector3.zero
                    local vVel = Vector3.new(0, math.clamp(moveDir.Y * 3, -52, 52), 0)
                    root.AssemblyLinearVelocity = hVel + vVel
                    if hDir.Magnitude > 0.5 then hum:Move(hDir.Unit, false) end
                end

                if CB.autoSwing and dist and dist < 6 then
                    CB.aimbotTrySwing()
                end
            else
                local target = CB.aimbotTarget
                if now - CB.aimbotLastScan > 0.1 or not target or not target.Parent then
                    CB.aimbotLastScan = now
                    local t = CB.getClosestPlayerRoot(math.huge)
                    CB.aimbotTarget = t
                    target = t
                end

                if not target then
                    hum.AutoRotate = true
                    root.AssemblyAngularVelocity = Vector3.zero
                    return
                end

                local th = target.Parent and target.Parent:FindFirstChildOfClass("Humanoid")
                if not th or th.Health <= 0 then
                    CB.aimbotTarget = nil
                    return
                end

                local vel = target.AssemblyLinearVelocity
                local aimPos = target.Position + (vel * math.clamp(vel.Magnitude / 130, 0.05, 0.15)) + Vector3.new(0, 1, 0)
                local look = aimPos - root.Position
                local flat = Vector3.new(look.X, 0, look.Z)

                if look.Magnitude > 0.01 and flat.Magnitude > 0.01 then
                    local targetYaw = math.deg(math.atan2(-flat.X, -flat.Z))
                    local yawDelta = (targetYaw - root.Orientation.Y + 180) % 360 - 180
                    local yawRate = math.clamp(math.rad(yawDelta) * 285, -28, 28)

                    local targetPitch = math.deg(math.atan2(look.Y, flat.Magnitude))
                    local pitchDelta = (targetPitch - root.Orientation.X + 180) % 360 - 180
                    local pitchRate = math.clamp(math.rad(pitchDelta) * 285, -28, 28)

                    local yawRad = math.rad(root.Orientation.Y)
                    local rightAxis = Vector3.new(math.cos(yawRad), 0, -math.sin(yawRad))
                    root.AssemblyAngularVelocity = Vector3.new(0, yawRate, 0) + (rightAxis * pitchRate)
                end

                local dir = look.Magnitude > 0.01 and look.Unit or Vector3.zero
                local standPos = aimPos - (dir * -2.8) + Vector3.new(0, 4.75, 0)
                local moveDir = standPos - root.Position
                local hDir = Vector3.new(moveDir.X, 0, moveDir.Z)
                local spd = CB.aimbotSpeed
                local hVel = hDir.Magnitude > 0.1 and hDir.Unit * spd or Vector3.zero
                local vVel = math.abs(moveDir.Y) > 0.1
                    and Vector3.new(0, math.sign(moveDir.Y) * 52, 0)
                    or Vector3.new(0, -2, 0)
                root.AssemblyLinearVelocity = hVel + vVel
                if hDir.Magnitude > 0.5 then hum:Move(hDir.Unit, false) end

                if CB.autoSwing then
                    local bat = char:FindFirstChild("Bat") or CB.findBat()
                    if bat and bat:IsA("Tool") then
                        pcall(function() bat:Activate() end)
                    end
                end
            end
        end)
    end

    CB.stopAimbot = function()
        CB.aimbotOn = false
        if CB.aimbotConn then CB.aimbotConn:Disconnect(); CB.aimbotConn = nil end
        CB.aimbotTarget = nil
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if root then root.AssemblyAngularVelocity = Vector3.zero end
        if hum then hum.AutoRotate = true end
    end

    CB.toggleAimbot = function()
        if CB.aimbotOn then CB.stopAimbot() else CB.startAimbot() end
    end

    CB.startTpBat = function()
        if CB.tpBatConn then CB.tpBatConn:Disconnect() end
        CB.tpBat = true
        CB.tpBatConn = RunService.Heartbeat:Connect(function()
            if not CB.tpBat then return end
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not char or not hum or not root or hum.Health <= 0 then return end

            local target = CB.getClosestPlayerRoot(math.huge)
            if not target then return end

            if sethiddenproperty then
                pcall(sethiddenproperty, root, "PhysicsRepRootPart", target)
            end

            local tpPos = target.Position + Vector3.new(0, 0.9, 0)
            if (root.Position - tpPos).Magnitude > 8 then
                root.CFrame = CFrame.new(tpPos)
            end

            local cam = workspace.CurrentCamera
            if cam then
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            end

            if not CB.aimbotSwingCd then
                CB.aimbotSwingCd = true
                pcall(function()
                    local bat = CB.ensureBat()
                    if bat and bat:IsA("Tool") then
                        bat:Activate()
                        local ev = bat:FindFirstChildWhichIsA("RemoteEvent")
                        if ev then ev:FireServer() end
                    end
                end)
                task.delay(0.08, function() CB.aimbotSwingCd = false end)
            end
        end)
    end

    CB.stopTpBat = function()
        CB.tpBat = false
        if CB.tpBatConn then CB.tpBatConn:Disconnect(); CB.tpBatConn = nil end
    end

    CB.toggleTpBat = function()
        if CB.tpBat then CB.stopTpBat() else CB.startTpBat() end
    end

    CB.getNearestBodyLock = function()
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local nearest, shortest = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local tr = plr.Character:FindFirstChild("HumanoidRootPart")
                local th = plr.Character:FindFirstChildOfClass("Humanoid")
                if tr and th and th.Health > 0 then
                    local d = (tr.Position - root.Position).Magnitude
                    if d <= CB.bodyLockRadius and d < shortest then
                        shortest = d; nearest = plr
                    end
                end
            end
        end
        return nearest
    end

    CB.startBodyLock = function()
        if CB.bodyLockConn then return end
        CB.bodyLock = true
        CB.bodyLockConn = RunService.Heartbeat:Connect(function()
            if not CB.bodyLock then return end
            local char = LP.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then return end
            local target = CB.getNearestBodyLock()
            if target and target.Character then
                local tr = target.Character:FindFirstChild("HumanoidRootPart")
                if tr then
                    local off = Vector3.new(tr.Position.X, root.Position.Y, tr.Position.Z) - root.Position
                    if off.Magnitude > 0.1 then
                        hum.AutoRotate = false
                        local lookDir = off.Unit
                        local curDir = root.CFrame.LookVector
                        local cross = curDir:Cross(lookDir)
                        local curVel = root.AssemblyAngularVelocity
                        root.AssemblyAngularVelocity = Vector3.new(curVel.X, cross.Y * 40, curVel.Z)
                    end
                end
            else
                hum.AutoRotate = true
            end
        end)
    end

    CB.stopBodyLock = function()
        CB.bodyLock = false
        if CB.bodyLockConn then CB.bodyLockConn:Disconnect(); CB.bodyLockConn = nil end
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
    end

    CB.startAntiRagdoll = function()
        if CB.antiRagdollConn then return end
        CB.antiRagdoll = true
        CB.antiRagdollConn = RunService.Heartbeat:Connect(function()
            if not CB.antiRagdoll then return end
            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum or hum.Health <= 0 or not root then return end

            local st = hum:GetState()
            local ragdolled = (st == Enum.HumanoidStateType.Physics
                or st == Enum.HumanoidStateType.Ragdoll
                or st == Enum.HumanoidStateType.FallingDown)

            local endTime = LP:GetAttribute("RagdollEndTime")
            if endTime and (endTime - workspace:GetServerTimeNow()) > 0 then
                ragdolled = true
            end

            if ragdolled then
                local now = tick()
                if now - CB.counterCooldown > 0.15 then
                    CB.counterCooldown = now
                    pcall(function()
                        LP:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
                    end)
                    for _, d in ipairs(char:GetDescendants()) do
                        if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and d.Name:find("RagdollAttachment")) then
                            d:Destroy()
                        end
                    end
                    for _, obj in ipairs(char:GetDescendants()) do
                        if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled = true end
                    end
                    if hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.Running) end
                    workspace.CurrentCamera.CameraSubject = hum
                    root.Anchored = false
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end)
    end

    CB.stopAntiRagdoll = function()
        CB.antiRagdoll = false
        if CB.antiRagdollConn then CB.antiRagdollConn:Disconnect(); CB.antiRagdollConn = nil end
    end

    CB.startAntiDie = function()
        CB.antiDie = true
        if CB.antiDieConn then CB.antiDieConn:Disconnect(); CB.antiDieConn = nil end
        local function hook(char)
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            if CB.antiDieConn then CB.antiDieConn:Disconnect() end
            CB.antiDieConn = hum:GetPropertyChangedSignal("Health"):Connect(function()
                if not CB.antiDie then return end
                if hum.Health <= 0 then
                    pcall(function()
                        hum.Health = 1
                        hum.PlatformStand = false
                        hum.Sit = false
                        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end)
                end
            end)
        end
        hook(LP.Character)
        LP.CharacterAdded:Connect(function(c)
            task.wait(0.2)
            if CB.antiDie then hook(c) end
        end)
    end

    CB.stopAntiDie = function()
        CB.antiDie = false
        if CB.antiDieConn then CB.antiDieConn:Disconnect(); CB.antiDieConn = nil end
    end

    CB.startAntiVoid = function()
        CB.antiVoid = true
        CB.antiVoidSafe = CB.antiVoidSafe or nil

        if CB.antiVoidConn then CB.antiVoidConn:Disconnect(); CB.antiVoidConn = nil end
        CB.antiVoidConn = RunService.Heartbeat:Connect(function()
            if not CB.antiVoid then return end
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not root or hum.Health <= 0 then return end

            local voidY = (workspace.FallenPartsDestroyHeight or -500) + 30
            if hum.FloorMaterial ~= Enum.Material.Air and root.Position.Y > voidY + 12 then
                CB.antiVoidSafe = root.CFrame
            elseif root.Position.Y <= voidY and CB.antiVoidSafe then
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = CB.antiVoidSafe + Vector3.new(0, 4, 0)
                hum.PlatformStand = false
                hum.Sit = false
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
            end
        end)
    end

    CB.stopAntiVoid = function()
        CB.antiVoid = false
        if CB.antiVoidConn then CB.antiVoidConn:Disconnect(); CB.antiVoidConn = nil end
    end

    CB.startBatCounter = function()
        if CB.batCounterConn then return end
        CB.batCounter = true
        local debounce = false
        CB.batCounterConn = RunService.Heartbeat:Connect(function()
            if not CB.batCounter then return end
            if debounce then return end
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            if CB.isRagdoll(hum) then
                debounce = true
                task.spawn(function()
                    local bat = CB.findBat()
                    if bat then
                        if bat.Parent ~= char then
                            bat.Parent = char
                            task.wait(0.05)
                        end
                        local remote = bat:FindFirstChildOfClass("RemoteEvent")
                        if remote then
                            pcall(function() remote:FireServer() end)
                            task.wait(0.15)
                            pcall(function() remote:FireServer() end)
                        else
                            pcall(function() bat:Activate() end)
                            task.wait(0.15)
                            pcall(function() bat:Activate() end)
                        end
                    end
                    task.wait(0.5)
                    debounce = false
                end)
            end
        end)
    end

    CB.stopBatCounter = function()
        CB.batCounter = false
        if CB.batCounterConn then CB.batCounterConn:Disconnect(); CB.batCounterConn = nil end
    end

    CB.findMedusa = function()
        local c = LP.Character
        if not c then return nil end
        for _, t in ipairs(c:GetChildren()) do
            if t:IsA("Tool") then
                local n = t.Name:lower()
                if n:find("medusa") or n:find("head") or n:find("stone") then return t end
            end
        end
        local bp = LP:FindFirstChildOfClass("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") then
                    local n = t.Name:lower()
                    if n:find("medusa") or n:find("head") or n:find("stone") then return t end
                end
            end
        end
        return nil
    end

    CB.startMedCounter = function()
        CB.stopMedCounter()
        CB.medCounter = true
        local char = LP.Character
        if not char then return end

        local function onAnchor(part)
            return part:GetPropertyChangedSignal("Anchored"):Connect(function()
                if not CB.medCounter then return end
                if part.Anchored and part.Transparency == 1 then
                    if tick() - CB.medLastUsed < CB.medCooldown then return end
                    CB.medLastUsed = tick()
                    local med = CB.findMedusa()
                    if med then
                        if med.Parent ~= char then
                            med.Parent = char
                            task.wait(0.05)
                        end
                        pcall(function() med:Activate() end)
                    end
                end
            end)
        end

        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                table.insert(CB.medCounterConns, onAnchor(part))
            end
        end
        table.insert(CB.medCounterConns, char.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                table.insert(CB.medCounterConns, onAnchor(part))
            end
        end))
    end

    CB.stopMedCounter = function()
        CB.medCounter = false
        for _, c in ipairs(CB.medCounterConns) do pcall(function() c:Disconnect() end) end
        CB.medCounterConns = {}
    end

    CB.setOtherCollide = function(state)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function() part.CanCollide = state end)
                    end
                end
            end
        end
    end

    CB.startNoCollision = function()
        CB.noPlayerCollision = true
        CB.setOtherCollide(false)
        local scanElapsed = 0
        table.insert(CB.noCollisionConns, RunService.Heartbeat:Connect(function(dt)
            if not CB.noPlayerCollision then return end
            scanElapsed = scanElapsed + (dt or 0)
            if scanElapsed < 0.25 then return end
            scanElapsed = 0
            CB.setOtherCollide(false)
        end))
    end

    CB.stopNoCollision = function()
        CB.noPlayerCollision = false
        for _, c in ipairs(CB.noCollisionConns) do pcall(function() c:Disconnect() end) end
        CB.noCollisionConns = {}
        CB.setOtherCollide(true)
    end

    LP.CharacterAdded:Connect(function()
        task.wait(0.5)
        if CB.antiRagdoll then CB.stopAntiRagdoll(); CB.startAntiRagdoll() end
        if CB.antiDie then CB.startAntiDie() end
        if CB.antiVoid then CB.stopAntiVoid(); CB.startAntiVoid() end
        if CB.medCounter then CB.startMedCounter() end
        if CB.batCounter then CB.stopBatCounter(); CB.startBatCounter() end
    end)

    mkSect(combatPage, "BAT AIMBOT")

    mkToggle(combatPage, "Aimbot", false, function(on)
        if on then CB.startAimbot() else CB.stopAimbot() end
    end)

    mkToggle(combatPage, "Auto Swing", false, function(on)
        CB.autoSwing = on
    end)

    do
        local row = mkRow(combatPage, 44)
        mkLabel(row, "Aimbot Speed")
        mkBox(row, CB.aimbotSpeed, 70, 80, function(v)
            if v and v > 0 and v <= 250 then CB.aimbotSpeed = v end
        end)
    end

    do
        local row = mkRow(combatPage, 42)
        mkLabel(row, "Aimbot Mode")
        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 140, 0, 30)
        holder.Position = UDim2.new(1, -150, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local slide = Instance.new("Frame", holder)
        slide.BackgroundColor3 = TA
        slide.BackgroundTransparency = 0.1
        slide.Size = UDim2.new(0.5, -3, 1, -6)
        slide.Position = UDim2.new(0, 3, 0, 3)
        slide.BorderSizePixel = 0
        Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 6)

        local lblNormal = Instance.new("TextLabel", holder)
        lblNormal.Size = UDim2.new(0.5, 0, 1, 0)
        lblNormal.BackgroundTransparency = 1
        lblNormal.Text = "NORMAL"
        lblNormal.Font = Enum.Font.GothamBold
        lblNormal.TextSize = 10
        lblNormal.TextColor3 = C.TEXT

        local lblBypass = Instance.new("TextLabel", holder)
        lblBypass.Size = UDim2.new(0.5, 0, 1, 0)
        lblBypass.Position = UDim2.new(0.5, 0, 0, 0)
        lblBypass.BackgroundTransparency = 1
        lblBypass.Text = "BYPASS"
        lblBypass.Font = Enum.Font.GothamBold
        lblBypass.TextSize = 10
        lblBypass.TextColor3 = C.TEXT_DIM

        local btnN = Instance.new("TextButton", holder)
        btnN.Size = UDim2.new(0.5, 0, 1, 0)
        btnN.BackgroundTransparency = 1
        btnN.Text = ""
        btnN.ZIndex = 5
        btnN.Activated:Connect(function()
            CB.aimbotMode = "Normal"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            lblNormal.TextColor3 = C.TEXT
            lblBypass.TextColor3 = C.TEXT_DIM
        end)

        local btnB = Instance.new("TextButton", holder)
        btnB.Size = UDim2.new(0.5, 0, 1, 0)
        btnB.Position = UDim2.new(0.5, 0, 0, 0)
        btnB.BackgroundTransparency = 1
        btnB.Text = ""
        btnB.ZIndex = 5
        btnB.Activated:Connect(function()
            CB.aimbotMode = "Anti Bypass"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0.5, 0, 0, 3)}):Play()
            lblNormal.TextColor3 = C.TEXT_DIM
            lblBypass.TextColor3 = C.TEXT
        end)
    end

    mkSect(combatPage, "TP BAT")
    mkToggle(combatPage, "TP Bat", false, function(on)
        if on then CB.startTpBat() else CB.stopTpBat() end
    end)

    mkSect(combatPage, "BODY LOCK")
    mkToggle(combatPage, "Body Lock", false, function(on)
        if on then CB.startBodyLock() else CB.stopBodyLock() end
    end)
    do
        local row = mkRow(combatPage, 44)
        mkLabel(row, "Body Lock Radius")
        mkBox(row, CB.bodyLockRadius, 70, 80, function(v)
            if v and v > 5 and v <= 200 then CB.bodyLockRadius = v end
        end)
    end

    mkSect(combatPage, "COUNTERS")
    mkToggle(combatPage, "Bat Counter", false, function(on)
        if on then CB.startBatCounter() else CB.stopBatCounter() end
    end)
    mkToggle(combatPage, "Med Counter", false, function(on)
        if on then CB.startMedCounter() else CB.stopMedCounter() end
    end)

    mkSect(combatPage, "SURVIVAL")
    mkToggle(combatPage, "Anti Ragdoll", false, function(on)
        if on then CB.startAntiRagdoll() else CB.stopAntiRagdoll() end
    end)
    mkToggle(combatPage, "Anti Die", false, function(on)
        if on then CB.startAntiDie() else CB.stopAntiDie() end
    end)
    mkToggle(combatPage, "Anti Void", false, function(on)
        if on then CB.startAntiVoid() else CB.stopAntiVoid() end
    end)
    mkToggle(combatPage, "No Player Collision", false, function(on)
        if on then CB.startNoCollision() else CB.stopNoCollision() end
    end)

    _G.CyberHub.Combat = CB
end

print("[CYBER HUB] DROP 2 - Combat loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 3 : MOVEMENT
-- Requires: DROP 1
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local mkBox    = H.mkBox
    local mkToggle = H.mkToggle
    local TA       = H.TA
    local C        = H.C
    local TS       = H.TS
    local LP       = H.LP
    local UIS      = H.UIS
    local movePage = H.Pages["Movement"]

    local RunService = game:GetService("RunService")
    local Players    = game:GetService("Players")

    _G.CH_Move = _G.CH_Move or {}
    local M = _G.CH_Move

    M.Speed = M.Speed or {
        NS = 55, CS = 28, LAGGER = 27, LAGGER_CARRY = 15,
        Mode = "Normal",
        enabled = false,
        lastApply = 0,
        applyInterval = 1 / 20,
    }
    local SP = M.Speed

    M.AutoTP = M.AutoTP or {
        enabled = false, height = 20, conn = nil, lastRun = 0,
    }

    M.InfJump = M.InfJump or {
        enabled = false, mode = "Tap",
        held = false, lastBoost = 0,
        cooldown = 0.15, force = 48,
        started = false,
    }
    local IJ = M.InfJump

    M.AutoPath = M.AutoPath or {
        leftEnabled = false, rightEnabled = false,
        leftConn = nil, rightConn = nil,
        points = {
            L1 = Vector3.new(-476.48, -6.28, 92.73),
            L2 = Vector3.new(-483.12, -4.95, 94.80),
            LFace = Vector3.new(-482.25, -4.96, 92.09),
            R1 = Vector3.new(-476.16, -6.52, 25.62),
            R2 = Vector3.new(-483.06, -5.03, 25.48),
            RFace = Vector3.new(-482.06, -6.93, 35.47),
        },
    }
    local AP = M.AutoPath

    M.getCurrentSpeed = function()
        if SP.Mode == "Carry"        then return SP.CS end
        if SP.Mode == "Lagger"       then return SP.LAGGER end
        if SP.Mode == "Lagger Carry" then return SP.LAGGER_CARRY end
        return SP.NS
    end

    if not M.speedLoopStarted then
        M.speedLoopStarted = true
        RunService.Heartbeat:Connect(function()
            if not SP.enabled then return end
            local now = tick()
            if now - SP.lastApply < SP.applyInterval then return end
            SP.lastApply = now

            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp or hum.Health <= 0 then return end

            local state = hum:GetState()
            if hum.PlatformStand
                or state == Enum.HumanoidStateType.Physics
                or state == Enum.HumanoidStateType.Ragdoll
                or state == Enum.HumanoidStateType.FallingDown then
                return
            end

            local md = hum.MoveDirection
            if md.Magnitude < 0.01 then return end

            local spd = M.getCurrentSpeed()
            if spd <= 16 then return end

            local v = hrp.AssemblyLinearVelocity
            local target = Vector3.new(md.X * spd, v.Y, md.Z * spd)
            hrp.AssemblyLinearVelocity = v:Lerp(target, 0.55)
        end)
    end

    M.doAutoTP = function(force)
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end

        if not force then
            if hum.FloorMaterial ~= Enum.Material.Air then return end
            if hrp.Position.Y < (tonumber(M.AutoTP.height) or 20) then return end
        end

        local yaw = select(2, hrp.CFrame:ToEulerAnglesYXZ())
        hrp.CFrame = CFrame.new(hrp.Position.X, -7.00, hrp.Position.Z) * CFrame.Angles(0, yaw, 0)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        pcall(function() hrp.Velocity = Vector3.zero end)
        pcall(function() hrp.RotVelocity = Vector3.zero end)
    end

    M.startAutoTP = function()
        M.AutoTP.enabled = true
        if M.AutoTP.conn then M.AutoTP.conn:Disconnect() end
        M.AutoTP.lastRun = 0
        M.AutoTP.conn = RunService.Heartbeat:Connect(function()
            if not M.AutoTP.enabled then
                if M.AutoTP.conn then M.AutoTP.conn:Disconnect(); M.AutoTP.conn = nil end
                return
            end
            local now = tick()
            if now - M.AutoTP.lastRun < 0.15 then return end
            M.AutoTP.lastRun = now
            pcall(M.doAutoTP, false)
        end)
    end

    M.stopAutoTP = function()
        M.AutoTP.enabled = false
        if M.AutoTP.conn then M.AutoTP.conn:Disconnect(); M.AutoTP.conn = nil end
    end

    if not IJ.started then
        IJ.started = true

        UIS.InputBegan:Connect(function(inp, gpe)
            if gpe then return end
            if not IJ.enabled then return end
            if inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.Space then
                IJ.held = true
            end
        end)

        UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.Space then
                IJ.held = false
            end
        end)

        UIS.JumpRequest:Connect(function()
            if not IJ.enabled then return end
            if IJ.mode == "Tap" then
                IJ.held = true
                task.delay(0.1, function() IJ.held = false end)
            end
        end)

        RunService.Heartbeat:Connect(function()
            if not IJ.enabled then return end
            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp or hum.Health <= 0 then return end

            local state = hum:GetState()
            if hum.PlatformStand
                or state == Enum.HumanoidStateType.Physics
                or state == Enum.HumanoidStateType.Ragdoll
                or state == Enum.HumanoidStateType.FallingDown then
                return
            end

            local now = tick()
            if IJ.mode == "Tap" then
                if IJ.held and now - IJ.lastBoost > IJ.cooldown then
                    IJ.lastBoost = now
                    local v = hrp.AssemblyLinearVelocity
                    hrp.AssemblyLinearVelocity = Vector3.new(v.X, IJ.force, v.Z)
                end
            else
                if IJ.held then
                    local v = hrp.AssemblyLinearVelocity
                    if v.Y < 40 then
                        hrp.AssemblyLinearVelocity = Vector3.new(v.X, 42, v.Z)
                    end
                end
            end
        end)
    end

    M.startAutoLeft = function()
        if AP.rightEnabled then
            AP.rightEnabled = false
            if AP.rightConn then AP.rightConn:Disconnect(); AP.rightConn = nil end
        end
        if AP.leftConn then AP.leftConn:Disconnect() end
        AP.leftEnabled = true
        local phase = 1
        AP.leftConn = RunService.Heartbeat:Connect(function()
            if not AP.leftEnabled then return end
            local char = LP.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            local spd = M.getCurrentSpeed() * 0.8
            local P = AP.points
            local target, done
            if phase == 1 then
                target = Vector3.new(P.L1.X, hrp.Position.Y, P.L1.Z)
                if (target - hrp.Position).Magnitude < 1.5 then phase = 2; return end
            else
                target = Vector3.new(P.L2.X, hrp.Position.Y, P.L2.Z)
                if (target - hrp.Position).Magnitude < 1.5 then done = true end
            end
            if done then
                AP.leftEnabled = false
                if AP.leftConn then AP.leftConn:Disconnect(); AP.leftConn = nil end
                return
            end
            local d = (target - hrp.Position)
            local md = Vector3.new(d.X, 0, d.Z).Unit
            local v = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = Vector3.new(md.X * spd, v.Y, md.Z * spd)
        end)
    end

    M.startAutoRight = function()
        if AP.leftEnabled then
            AP.leftEnabled = false
            if AP.leftConn then AP.leftConn:Disconnect(); AP.leftConn = nil end
        end
        if AP.rightConn then AP.rightConn:Disconnect() end
        AP.rightEnabled = true
        local phase = 1
        AP.rightConn = RunService.Heartbeat:Connect(function()
            if not AP.rightEnabled then return end
            local char = LP.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum or hum.Health <= 0 then return end

            local spd = M.getCurrentSpeed() * 0.8
            local P = AP.points
            local target, done
            if phase == 1 then
                target = Vector3.new(P.R1.X, hrp.Position.Y, P.R1.Z)
                if (target - hrp.Position).Magnitude < 1.5 then phase = 2; return end
            else
                target = Vector3.new(P.R2.X, hrp.Position.Y, P.R2.Z)
                if (target - hrp.Position).Magnitude < 1.5 then done = true end
            end
            if done then
                AP.rightEnabled = false
                if AP.rightConn then AP.rightConn:Disconnect(); AP.rightConn = nil end
                return
            end
            local d = (target - hrp.Position)
            local md = Vector3.new(d.X, 0, d.Z).Unit
            local v = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = Vector3.new(md.X * spd, v.Y, md.Z * spd)
        end)
    end

    mkSect(movePage, "SPEED")
    mkToggle(movePage, "Speed Enabled", false, function(on)
        SP.enabled = on
    end)

    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "Normal Speed")
        mkBox(row, SP.NS, 70, 80, function(v)
            if v and v > 0 and v <= 200 then SP.NS = v end
        end)
    end
    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "Carry Speed")
        mkBox(row, SP.CS, 70, 80, function(v)
            if v and v > 0 and v <= 200 then SP.CS = v end
        end)
    end
    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "Lagger Speed")
        mkBox(row, SP.LAGGER, 70, 80, function(v)
            if v and v > 0 and v <= 200 then SP.LAGGER = v end
        end)
    end
    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "Lagger Carry Speed")
        mkBox(row, SP.LAGGER_CARRY, 70, 80, function(v)
            if v and v > 0 and v <= 200 then SP.LAGGER_CARRY = v end
        end)
    end

    do
        local row = mkRow(movePage, 42)
        mkLabel(row, "Mode")
        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 140, 0, 30)
        holder.Position = UDim2.new(1, -150, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local slide = Instance.new("Frame", holder)
        slide.BackgroundColor3 = TA
        slide.BackgroundTransparency = 0.1
        slide.Size = UDim2.new(0.5, -3, 1, -6)
        slide.Position = UDim2.new(0, 3, 0, 3)
        slide.BorderSizePixel = 0
        Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 6)

        local lblA = Instance.new("TextLabel", holder)
        lblA.Size = UDim2.new(0.5, 0, 1, 0)
        lblA.BackgroundTransparency = 1
        lblA.Text = "NORMAL"
        lblA.Font = Enum.Font.GothamBold
        lblA.TextSize = 10
        lblA.TextColor3 = C.TEXT

        local lblB = Instance.new("TextLabel", holder)
        lblB.Size = UDim2.new(0.5, 0, 1, 0)
        lblB.Position = UDim2.new(0.5, 0, 0, 0)
        lblB.BackgroundTransparency = 1
        lblB.Text = "CARRY"
        lblB.Font = Enum.Font.GothamBold
        lblB.TextSize = 10
        lblB.TextColor3 = C.TEXT_DIM

        local function apply(idx)
            TS:Create(slide, TweenInfo.new(0.18), {
                Position = (idx == 1) and UDim2.new(0, 3, 0, 3) or UDim2.new(0.5, 0, 0, 3),
            }):Play()
            lblA.TextColor3 = (idx == 1) and C.TEXT or C.TEXT_DIM
            lblB.TextColor3 = (idx == 2) and C.TEXT or C.TEXT_DIM
        end

        local btnA = Instance.new("TextButton", holder)
        btnA.Size = UDim2.new(0.5, 0, 1, 0)
        btnA.BackgroundTransparency = 1
        btnA.Text = ""
        btnA.ZIndex = 5
        btnA.Activated:Connect(function()
            if SP.Mode == "Lagger" then SP.Mode = "Normal"
            elseif SP.Mode == "Lagger Carry" then SP.Mode = "Carry"
            else SP.Mode = "Normal" end
            apply(1)
        end)

        local btnB = Instance.new("TextButton", holder)
        btnB.Size = UDim2.new(0.5, 0, 1, 0)
        btnB.Position = UDim2.new(0.5, 0, 0, 0)
        btnB.BackgroundTransparency = 1
        btnB.Text = ""
        btnB.ZIndex = 5
        btnB.Activated:Connect(function()
            if SP.Mode == "Lagger" then SP.Mode = "Lagger Carry"
            else SP.Mode = "Carry" end
            apply(2)
        end)
    end

    do
        local row = mkRow(movePage, 42)
        mkLabel(row, "Lagger Mode")
        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 140, 0, 30)
        holder.Position = UDim2.new(1, -150, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local slide = Instance.new("Frame", holder)
        slide.BackgroundColor3 = TA
        slide.BackgroundTransparency = 0.1
        slide.Size = UDim2.new(0.5, -3, 1, -6)
        slide.Position = UDim2.new(0, 3, 0, 3)
        slide.BorderSizePixel = 0
        Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 6)

        local lblA = Instance.new("TextLabel", holder)
        lblA.Size = UDim2.new(0.5, 0, 1, 0)
        lblA.BackgroundTransparency = 1
        lblA.Text = "LAGGER"
        lblA.Font = Enum.Font.GothamBold
        lblA.TextSize = 10
        lblA.TextColor3 = C.TEXT

        local lblB = Instance.new("TextLabel", holder)
        lblB.Size = UDim2.new(0.5, 0, 1, 0)
        lblB.Position = UDim2.new(0.5, 0, 0, 0)
        lblB.BackgroundTransparency = 1
        lblB.Text = "L.CARRY"
        lblB.Font = Enum.Font.GothamBold
        lblB.TextSize = 10
        lblB.TextColor3 = C.TEXT_DIM

        local function apply(idx)
            TS:Create(slide, TweenInfo.new(0.18), {
                Position = (idx == 1) and UDim2.new(0, 3, 0, 3) or UDim2.new(0.5, 0, 0, 3),
            }):Play()
            lblA.TextColor3 = (idx == 1) and C.TEXT or C.TEXT_DIM
            lblB.TextColor3 = (idx == 2) and C.TEXT or C.TEXT_DIM
        end

        local btnA = Instance.new("TextButton", holder)
        btnA.Size = UDim2.new(0.5, 0, 1, 0)
        btnA.BackgroundTransparency = 1
        btnA.Text = ""
        btnA.ZIndex = 5
        btnA.Activated:Connect(function()
            if SP.Mode == "Carry" then SP.Mode = "Normal"
            elseif SP.Mode == "Lagger Carry" then SP.Mode = "Carry"
            else SP.Mode = "Lagger" end
            apply(1)
        end)

        local btnB = Instance.new("TextButton", holder)
        btnB.Size = UDim2.new(0.5, 0, 1, 0)
        btnB.Position = UDim2.new(0.5, 0, 0, 0)
        btnB.BackgroundTransparency = 1
        btnB.Text = ""
        btnB.ZIndex = 5
        btnB.Activated:Connect(function()
            if SP.Mode == "Carry" then SP.Mode = "Lagger Carry"
            else SP.Mode = "Lagger Carry" end
            apply(2)
        end)
    end

    mkSect(movePage, "TELEPORT")
    mkToggle(movePage, "Auto TP Down", false, function(on)
        if on then M.startAutoTP() else M.stopAutoTP() end
    end)

    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "Auto TP Height")
        mkBox(row, M.AutoTP.height, 70, 80, function(v)
            if v and v >= -500 and v <= 500 then M.AutoTP.height = v end
        end)
    end

    do
        local row = mkRow(movePage, 44)
        mkLabel(row, "TP Down (Manual)")
        local b = Instance.new("TextButton", row)
        b.Size = UDim2.new(0, 80, 0, 28)
        b.Position = UDim2.new(1, -90, 0.5, -14)
        b.BackgroundColor3 = C.INPUT
        b.BackgroundTransparency = 0.15
        b.BorderSizePixel = 0
        b.Text = "EXECUTE"
        b.TextColor3 = TA
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
        local s = Instance.new("UIStroke", b)
        s.Color = C.STROKE; s.Thickness = 1; s.Transparency = 0.3
        b.Activated:Connect(function() pcall(M.doAutoTP, true) end)
    end

    mkSect(movePage, "JUMP")
    mkToggle(movePage, "Infinite Jump", false, function(on)
        IJ.enabled = on
        if not on then IJ.held = false end
    end)

    do
        local row = mkRow(movePage, 42)
        mkLabel(row, "Inf Jump Mode")
        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 140, 0, 30)
        holder.Position = UDim2.new(1, -150, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local slide = Instance.new("Frame", holder)
        slide.BackgroundColor3 = TA
        slide.BackgroundTransparency = 0.1
        slide.Size = UDim2.new(0.5, -3, 1, -6)
        slide.Position = UDim2.new(0, 3, 0, 3)
        slide.BorderSizePixel = 0
        Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 6)

        local lblA = Instance.new("TextLabel", holder)
        lblA.Size = UDim2.new(0.5, 0, 1, 0)
        lblA.BackgroundTransparency = 1
        lblA.Text = "TAP"
        lblA.Font = Enum.Font.GothamBold
        lblA.TextSize = 10
        lblA.TextColor3 = C.TEXT

        local lblB = Instance.new("TextLabel", holder)
        lblB.Size = UDim2.new(0.5, 0, 1, 0)
        lblB.Position = UDim2.new(0.5, 0, 0, 0)
        lblB.BackgroundTransparency = 1
        lblB.Text = "HOLD"
        lblB.Font = Enum.Font.GothamBold
        lblB.TextSize = 10
        lblB.TextColor3 = C.TEXT_DIM

        local btnA = Instance.new("TextButton", holder)
        btnA.Size = UDim2.new(0.5, 0, 1, 0)
        btnA.BackgroundTransparency = 1
        btnA.Text = ""
        btnA.ZIndex = 5
        btnA.Activated:Connect(function()
            IJ.mode = "Tap"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            lblA.TextColor3 = C.TEXT; lblB.TextColor3 = C.TEXT_DIM
        end)

        local btnB = Instance.new("TextButton", holder)
        btnB.Size = UDim2.new(0.5, 0, 1, 0)
        btnB.Position = UDim2.new(0.5, 0, 0, 0)
        btnB.BackgroundTransparency = 1
        btnB.Text = ""
        btnB.ZIndex = 5
        btnB.Activated:Connect(function()
            IJ.mode = "Hold"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0.5, 0, 0, 3)}):Play()
            lblA.TextColor3 = C.TEXT_DIM; lblB.TextColor3 = C.TEXT
        end)
    end

    mkSect(movePage, "AUTO PATH")
    mkToggle(movePage, "Auto Left", false, function(on)
        if on then
            M.startAutoLeft()
        else
            AP.leftEnabled = false
            if AP.leftConn then AP.leftConn:Disconnect(); AP.leftConn = nil end
        end
    end)
    mkToggle(movePage, "Auto Right", false, function(on)
        if on then
            M.startAutoRight()
        else
            AP.rightEnabled = false
            if AP.rightConn then AP.rightConn:Disconnect(); AP.rightConn = nil end
        end
    end)

    LP.CharacterAdded:Connect(function()
        task.wait(0.5)
        if AP.leftEnabled then M.startAutoLeft() end
        if AP.rightEnabled then M.startAutoRight() end
    end)

    _G.CyberHub.Movement = M
end

print("[CYBER HUB] DROP 3 - Movement loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 4 : AUTO STEAL
-- Requires: DROP 1
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local mkBox    = H.mkBox
    local mkToggle = H.mkToggle
    local TA       = H.TA
    local C        = H.C
    local TS       = H.TS
    local LP       = H.LP
    local combatPage = H.Pages["Combat"]

    local Players    = game:GetService("Players")
    local RunService = game:GetService("RunService")

    _G.CH_Steal = _G.CH_Steal or {}
    local S = _G.CH_Steal

    S.enabled       = S.enabled       or false
    S.mode          = S.mode          or "Auto Steal V3"
    S.radius        = S.radius        or 63
    S.semiRadius    = S.semiRadius    or 9
    S.conn          = S.conn          or nil
    S.progressConn  = S.progressConn  or nil
    S.active        = S.active        or false
    S.progress      = S.progress      or 0
    S.paused        = S.paused        or false
    S.pauseTime     = S.pauseTime     or nil
    S.startTime     = S.startTime     or nil
    S.dataCache     = S.dataCache     or {}
    S.StealDuration = S.StealDuration or 1.3
    S.TriggerRadius = S.TriggerRadius or 10
    S.autoResetOnMed = S.autoResetOnMed or false
    S.autoResetConns = S.autoResetConns or {}

    local getconnections_v3 = getconnections or get_signal_cons or getconnects or (syn and syn.get_signal_cons)

    S.getHRP = function()
        local c = LP.Character
        return c and c:FindFirstChild("HumanoidRootPart")
    end

    S.isMyPlot = function(plotName)
        local plots = workspace:FindFirstChild("Plots")
        if not plots then return false end
        local plot = plots:FindFirstChild(plotName)
        if not plot then return false end
        local sign = plot:FindFirstChild("PlotSign")
        if sign then
            local yb = sign:FindFirstChild("YourBase")
            if yb and yb:IsA("BillboardGui") then return yb.Enabled == true end
        end
        return false
    end

    S.findPrompt = function()
        local hrp = S.getHRP()
        if not hrp then return nil, nil end
        local plots = workspace:FindFirstChild("Plots")
        if not plots then return nil, nil end
        local bestPrompt, bestDist, bestSpawn = nil, math.huge, nil

        for _, plot in ipairs(plots:GetChildren()) do
            if plot:IsA("Model") and not S.isMyPlot(plot.Name) then
                local pods = plot:FindFirstChild("AnimalPodiums")
                if pods then
                    for _, pod in ipairs(pods:GetChildren()) do
                        pcall(function()
                            local base = pod:FindFirstChild("Base")
                            local spawn = base and base:FindFirstChild("Spawn")
                            if not spawn then return end
                            local dist = (spawn.Position - hrp.Position).Magnitude
                            if dist >= bestDist or dist > S.radius then return end

                            local function tryPrompt(container)
                                for _, ch in ipairs(container:GetChildren()) do
                                    if ch:IsA("ProximityPrompt") and ch.Enabled then
                                        bestPrompt = ch
                                        bestDist = dist
                                        bestSpawn = spawn
                                        return true
                                    end
                                end
                            end

                            local att = spawn:FindFirstChild("PromptAttachment")
                            if not (att and tryPrompt(att)) then
                                for _, ch in ipairs(spawn:GetDescendants()) do
                                    if ch:IsA("ProximityPrompt") and ch.Enabled then
                                        bestPrompt = ch
                                        bestDist = dist
                                        bestSpawn = spawn
                                        break
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
        return bestPrompt, bestSpawn
    end

    S.distToSpawn = function(spawnPart)
        local hrp = S.getHRP()
        if not hrp then return math.huge end
        if not spawnPart or not spawnPart.Parent then
            local _, ns = S.findPrompt()
            return ns and (hrp.Position - ns.Position).Magnitude or math.huge
        end
        return (hrp.Position - spawnPart.Position).Magnitude
    end

    S.updateBar = function(p, state)
        if _G.StealBar then
            pcall(function()
                _G.StealBar.SetProgress(p or 0)
                if state then _G.StealBar.SetState(state) end
            end)
        end
    end

    S.execute = function(prompt, spawnPart)
        if S.active then return end

        if not S.dataCache[prompt] then
            local data = {hold = {}, trigger = {}, ready = true}
            if getconnections_v3 then
                pcall(function()
                    for _, c in ipairs(getconnections_v3(prompt.PromptButtonHoldBegan)) do
                        if c.Function then table.insert(data.hold, c.Function) end
                    end
                    for _, c in ipairs(getconnections_v3(prompt.Triggered)) do
                        if c.Function then table.insert(data.trigger, c.Function) end
                    end
                end)
            end
            S.dataCache[prompt] = data
        end

        local data = S.dataCache[prompt]
        if not data.ready then return end
        data.ready = false
        S.active = true
        S.paused = false
        S.startTime = tick() - (S.progress * S.StealDuration)
        local pauseArmed = true

        if S.progressConn then S.progressConn:Disconnect() end
        S.updateBar(S.progress, "STEALING")

        S.progressConn = RunService.Heartbeat:Connect(function()
            if not S.active then
                if S.progressConn then S.progressConn:Disconnect(); S.progressConn = nil end
                return
            end
            if not S.enabled then
                S.active = false; S.progress = 0; S.paused = false; data.ready = true
                S.updateBar(0, "IDLE")
                return
            end
            if S.paused then
                local dist = S.distToSpawn(spawnPart)
                if dist <= S.TriggerRadius then
                    S.paused = false; S.pauseTime = nil
                    S.startTime = tick() - (0.8 * S.StealDuration)
                else
                    if not S.pauseTime then
                        S.pauseTime = tick()
                    elseif tick() - S.pauseTime >= 1.3 then
                        S.pauseTime = nil; S.paused = false; S.active = false
                        S.progress = 0; data.ready = true; pauseArmed = true
                        if S.progressConn then S.progressConn:Disconnect(); S.progressConn = nil end
                        S.updateBar(0, "READY")
                        return
                    end
                    S.progress = 0.8
                    S.updateBar(0.8, "STEALING")
                    return
                end
            end
            local elapsed = tick() - S.startTime
            local prog = math.clamp(elapsed / S.StealDuration, 0, 1)
            S.progress = prog
            if pauseArmed and prog >= 0.8 then
                S.paused = true; pauseArmed = false; S.progress = 0.8
                S.updateBar(0.8, "STEALING")
                return
            end
            S.updateBar(prog, "STEALING")
            if prog >= 1 then
                S.active = false; S.progress = 0; S.paused = false; pauseArmed = true
                if S.progressConn then S.progressConn:Disconnect(); S.progressConn = nil end
                for _, fn in ipairs(data.trigger) do
                    task.spawn(function() pcall(fn) end)
                end
                data.ready = true
                S.updateBar(0, "READY")
            end
        end)

        for _, fn in ipairs(data.hold) do
            task.spawn(function() pcall(fn) end)
        end
    end

    S.startAutoSteal = function()
        if S.conn then S.conn:Disconnect() end
        S.enabled = true
        S.StealDuration = 1.3
        S.TriggerRadius = 10
        S.conn = RunService.Heartbeat:Connect(function()
            if not S.enabled or S.active then return end
            if S.mode ~= "Auto Steal V3" then return end
            local prompt, spawnPart = S.findPrompt()
            if prompt then S.execute(prompt, spawnPart) end
        end)
        S.updateBar(0, "READY")
    end

    S.stopAutoSteal = function()
        S.enabled = false
        if S.conn then S.conn:Disconnect(); S.conn = nil end
        if S.progressConn then S.progressConn:Disconnect(); S.progressConn = nil end
        S.active = false; S.progress = 0; S.paused = false; S.pauseTime = nil
        S.dataCache = {}
        S.updateBar(0, "IDLE")
    end

    S.startAutoResetOnMed = function()
        S.autoResetOnMed = true
        for _, c in ipairs(S.autoResetConns) do pcall(function() c:Disconnect() end) end
        S.autoResetConns = {}
        local char = LP.Character
        if not char then return end
        local lastFire = 0
        local function onAnchor(part)
            return part:GetPropertyChangedSignal("Anchored"):Connect(function()
                if not S.autoResetOnMed then return end
                if part.Anchored and part.Transparency == 1 and tick() - lastFire > 2.25 then
                    lastFire = tick()
                    pcall(function()
                        local h = char:FindFirstChildOfClass("Humanoid")
                        if h then h.Health = 0 end
                    end)
                end
            end)
        end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                table.insert(S.autoResetConns, onAnchor(part))
            end
        end
        table.insert(S.autoResetConns, char.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                table.insert(S.autoResetConns, onAnchor(part))
            end
        end))
    end

    S.stopAutoResetOnMed = function()
        S.autoResetOnMed = false
        for _, c in ipairs(S.autoResetConns) do pcall(function() c:Disconnect() end) end
        S.autoResetConns = {}
    end

    if not S.barBuilt then
        S.barBuilt = true
        local sg = Instance.new("ScreenGui")
        sg.Name = "CH_StealBar"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 500
        pcall(function()
            if gethui then sg.Parent = gethui() else sg.Parent = game:GetService("CoreGui") end
        end)
        if not sg.Parent then sg.Parent = LP:WaitForChild("PlayerGui") end

        local pb = Instance.new("Frame", sg)
        pb.Name = "StealBar"
        pb.Size = UDim2.new(0, 324, 0, 56)
        pb.Position = UDim2.new(0.5, -162, 1, -70)
        pb.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        pb.BorderSizePixel = 0
        pb.Active = true
        pb.ClipsDescendants = true
        Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 15)

        local pbSt = Instance.new("UIStroke", pb)
        pbSt.Color = Color3.fromRGB(55, 55, 55)
        pbSt.Thickness = 1

        local pingLbl = Instance.new("TextLabel", pb)
        pingLbl.Size = UDim2.new(0, 150, 0, 14)
        pingLbl.Position = UDim2.new(0, 10, 0, 23)
        pingLbl.BackgroundTransparency = 1
        pingLbl.Text = "0 FPS | 0ms"
        pingLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        pingLbl.Font = Enum.Font.GothamBold
        pingLbl.TextSize = 11
        pingLbl.TextXAlignment = Enum.TextXAlignment.Left

        local discordLbl = Instance.new("TextLabel", pb)
        discordLbl.Size = UDim2.new(0, 140, 0, 14)
        discordLbl.Position = UDim2.new(1, -150, 0, 23)
        discordLbl.BackgroundTransparency = 1
        discordLbl.Text = "CYBER HUB"
        discordLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        discordLbl.Font = Enum.Font.GothamBold
        discordLbl.TextSize = 10
        discordLbl.TextXAlignment = Enum.TextXAlignment.Right

        local radLbl = Instance.new("TextLabel", pb)
        radLbl.Size = UDim2.new(0, 190, 0, 14)
        radLbl.Position = UDim2.new(1, -200, 0, 5)
        radLbl.BackgroundTransparency = 1
        radLbl.Text = "Radius: 63"
        radLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        radLbl.Font = Enum.Font.GothamBold
        radLbl.TextSize = 13
        radLbl.TextXAlignment = Enum.TextXAlignment.Right

        local pbg = Instance.new("Frame", pb)
        pbg.Size = UDim2.new(1, -18, 0, 12)
        pbg.Position = UDim2.new(0, 9, 1, -17)
        pbg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        pbg.BorderSizePixel = 0
        pbg.ClipsDescendants = true
        Instance.new("UICorner", pbg).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame", pbg)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(220, 30, 60)
        fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local pct = Instance.new("TextLabel", pb)
        pct.Size = UDim2.new(0, 64, 0, 18)
        pct.Position = UDim2.new(0, 10, 0, 3)
        pct.BackgroundTransparency = 1
        pct.Text = "0%"
        pct.TextColor3 = Color3.fromRGB(255, 255, 255)
        pct.Font = Enum.Font.GothamBlack
        pct.TextSize = 14
        pct.TextXAlignment = Enum.TextXAlignment.Left

        local function setState(state)
            if state == "STEALING" then
                fill.BackgroundColor3 = Color3.fromRGB(220, 30, 60)
                pbSt.Color = Color3.fromRGB(220, 30, 60)
            elseif state == "READY" then
                fill.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
                pbSt.Color = Color3.fromRGB(90, 90, 90)
            else
                fill.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                pbSt.Color = Color3.fromRGB(55, 55, 55)
            end
        end

        task.spawn(function()
            local lastFrame = tick()
            local fpsSamples = {}
            local fpsAvg = 60
            RunService.RenderStepped:Connect(function()
                local now = tick()
                local dt = now - lastFrame
                lastFrame = now
                if dt > 0 then
                    table.insert(fpsSamples, 1 / dt)
                    if #fpsSamples > 30 then table.remove(fpsSamples, 1) end
                    local sum = 0
                    for _, v in ipairs(fpsSamples) do sum = sum + v end
                    fpsAvg = sum / #fpsSamples
                end
            end)
            while pb and pb.Parent do
                local ping = 0
                pcall(function()
                    local Stats = game:GetService("Stats")
                    local stat = Stats.Network.ServerStatsItem["Data Ping"]
                    if stat then ping = tonumber(stat:GetValue()) or 0 end
                end)
                pingLbl.Text = string.format("%d FPS | %dms", math.floor(fpsAvg + 0.5), math.floor(ping + 0.5))
                radLbl.Text = string.format("Radius: %s", tostring(S.radius))
                task.wait(0.5)
            end
        end)

        local StealBar = {}
        function StealBar.SetProgress(p)
            p = math.clamp(p, 0, 1)
            fill.Size = UDim2.new(p, 0, 1, 0)
            pct.Text = math.floor(p * 100 + 0.5) .. "%"
        end
        function StealBar.SetState(state)
            setState(state)
        end
        function StealBar.Reset()
            StealBar.SetProgress(0)
            setState("IDLE")
        end
        _G.StealBar = StealBar
        setState("IDLE")
    end

    mkSect(combatPage, "AUTO STEAL")

    mkToggle(combatPage, "Auto Steal", false, function(on)
        if on then S.startAutoSteal() else S.stopAutoSteal() end
    end)

    do
        local row = mkRow(combatPage, 42)
        mkLabel(row, "Steal Mode")
        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 140, 0, 30)
        holder.Position = UDim2.new(1, -150, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local slide = Instance.new("Frame", holder)
        slide.BackgroundColor3 = TA
        slide.BackgroundTransparency = 0.1
        slide.Size = UDim2.new(0.5, -3, 1, -6)
        slide.Position = UDim2.new(0, 3, 0, 3)
        slide.BorderSizePixel = 0
        Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 6)

        local lblA = Instance.new("TextLabel", holder)
        lblA.Size = UDim2.new(0.5, 0, 1, 0)
        lblA.BackgroundTransparency = 1
        lblA.Text = "V3"
        lblA.Font = Enum.Font.GothamBold
        lblA.TextSize = 10
        lblA.TextColor3 = C.TEXT

        local lblB = Instance.new("TextLabel", holder)
        lblB.Size = UDim2.new(0.5, 0, 1, 0)
        lblB.Position = UDim2.new(0.5, 0, 0, 0)
        lblB.BackgroundTransparency = 1
        lblB.Text = "SEMI"
        lblB.Font = Enum.Font.GothamBold
        lblB.TextSize = 10
        lblB.TextColor3 = C.TEXT_DIM

        local btnA = Instance.new("TextButton", holder)
        btnA.Size = UDim2.new(0.5, 0, 1, 0)
        btnA.BackgroundTransparency = 1
        btnA.Text = ""
        btnA.ZIndex = 5
        btnA.Activated:Connect(function()
            S.mode = "Auto Steal V3"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            lblA.TextColor3 = C.TEXT; lblB.TextColor3 = C.TEXT_DIM
        end)

        local btnB = Instance.new("TextButton", holder)
        btnB.Size = UDim2.new(0.5, 0, 1, 0)
        btnB.Position = UDim2.new(0.5, 0, 0, 0)
        btnB.BackgroundTransparency = 1
        btnB.Text = ""
        btnB.ZIndex = 5
        btnB.Activated:Connect(function()
            S.mode = "Semi"
            TS:Create(slide, TweenInfo.new(0.18), {Position = UDim2.new(0.5, 0, 0, 3)}):Play()
            lblA.TextColor3 = C.TEXT_DIM; lblB.TextColor3 = C.TEXT
        end)
    end

    do
        local row = mkRow(combatPage, 44)
        mkLabel(row, "Steal Radius")
        mkBox(row, S.radius, 70, 80, function(v)
            if v and v > 0 and v <= 500 then S.radius = v end
        end)
    end

    do
        local row = mkRow(combatPage, 44)
        mkLabel(row, "SEMI Range")
        mkBox(row, S.semiRadius, 70, 80, function(v)
            if v and v > 0 and v <= 500 then S.semiRadius = v end
        end)
    end

    mkToggle(combatPage, "Auto Reset On Med", false, function(on)
        if on then S.startAutoResetOnMed() else S.stopAutoResetOnMed() end
    end)

    _G.CyberHub.Steal = S
end

print("[CYBER HUB] DROP 4 - Steal loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 5 : VISUALS
-- Requires: DROP 1
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local mkBox    = H.mkBox
    local mkToggle = H.mkToggle
    local TA       = H.TA
    local C        = H.C
    local TS       = H.TS
    local LP       = H.LP
    local visPage  = H.Pages["Visual"]

    local Players    = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Lighting   = game:GetService("Lighting")

    _G.CH_Visual = _G.CH_Visual or {}
    local V = _G.CH_Visual

    V.esp = V.esp or false
    V.espConns = V.espConns or {}
    V.espData = V.espData or {}
    V.fov = V.fov or false
    V.fovValue = V.fovValue or 70
    V.fovConn = V.fovConn or nil
    V.nuke = V.nuke or false
    V.antiLag = V.antiLag or false
    V.antiLagConn = V.antiLagConn or nil
    V.sky = V.sky or "Off"

    V.startESP = function()
        if V.esp then return end
        V.esp = true

        local function cleanup(plr)
            local d = V.espData[plr]
            if not d then return end
            pcall(function() if d.hl then d.hl:Destroy() end end)
            pcall(function() if d.bb then d.bb:Destroy() end end)
            if d.conn then pcall(function() d.conn:Disconnect() end) end
            V.espData[plr] = nil
        end

        local function setup(plr, char)
            if not V.esp or plr == LP then return end
            cleanup(plr)
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            if not hrp or not head then return end

            local hl = Instance.new("Highlight")
            hl.Name = "CH_ESP"
            hl.Adornee = char
            hl.FillColor = TA
            hl.FillTransparency = 0.72
            hl.OutlineColor = TA
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = char

            local bb = Instance.new("BillboardGui")
            bb.Name = "CH_ESPTag"
            bb.Adornee = head
            bb.Size = UDim2.new(0, 170, 0, 42)
            bb.StudsOffset = Vector3.new(0, 2.8, 0)
            bb.AlwaysOnTop = true
            bb.LightInfluence = 0
            bb.Parent = head

            local box = Instance.new("Frame", bb)
            box.Size = UDim2.new(1, 0, 1, 0)
            box.BackgroundTransparency = 1

            local n = Instance.new("TextLabel", box)
            n.Size = UDim2.new(1, -8, 0, 19)
            n.Position = UDim2.new(0, 4, 0, 1)
            n.BackgroundTransparency = 1
            n.TextColor3 = Color3.fromRGB(255, 255, 255)
            n.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            n.Font = Enum.Font.GothamBlack
            n.TextSize = 13
            n.TextStrokeTransparency = 0.08

            local sub = Instance.new("TextLabel", box)
            sub.Size = UDim2.new(1, -8, 0, 17)
            sub.Position = UDim2.new(0, 4, 0, 19)
            sub.BackgroundTransparency = 1
            sub.TextColor3 = Color3.fromRGB(255, 255, 255)
            sub.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            sub.Font = Enum.Font.GothamBlack
            sub.TextSize = 11
            sub.TextStrokeTransparency = 0.08

            local conn = RunService.Heartbeat:Connect(function()
                if not V.esp or not hrp.Parent then return end
                local v = hrp.AssemblyLinearVelocity
                n.Text = string.format("Speed: %.1f", Vector3.new(v.X, 0, v.Z).Magnitude)
                sub.Text = plr.Name
            end)

            V.espData[plr] = {hl = hl, bb = bb, conn = conn}
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP then
                if plr.Character then setup(plr, plr.Character) end
                table.insert(V.espConns, plr.CharacterAdded:Connect(function(c) task.defer(setup, plr, c) end))
            end
        end
        table.insert(V.espConns, Players.PlayerAdded:Connect(function(plr)
            if plr ~= LP then
                table.insert(V.espConns, plr.CharacterAdded:Connect(function(c) task.defer(setup, plr, c) end))
            end
        end))
        table.insert(V.espConns, Players.PlayerRemoving:Connect(cleanup))
    end

    V.stopESP = function()
        V.esp = false
        for _, c in ipairs(V.espConns) do pcall(function() c:Disconnect() end) end
        V.espConns = {}
        for plr, d in pairs(V.espData) do
            pcall(function() if d.hl then d.hl:Destroy() end end)
            pcall(function() if d.bb then d.bb:Destroy() end end)
            if d.conn then pcall(function() d.conn:Disconnect() end) end
        end
        V.espData = {}
    end

    V.startFOV = function()
        V.fov = true
        if V.fovConn then V.fovConn:Disconnect() end
        V.fovConn = RunService.RenderStepped:Connect(function()
            if not V.fov then
                if V.fovConn then V.fovConn:Disconnect(); V.fovConn = nil end
                return
            end
            local cam = workspace.CurrentCamera
            if cam then cam.FieldOfView = V.fovValue end
        end)
    end

    V.stopFOV = function()
        V.fov = false
        if V.fovConn then V.fovConn:Disconnect(); V.fovConn = nil end
        local cam = workspace.CurrentCamera
        if cam then cam.FieldOfView = 70 end
    end

    V.startAntiLag = function()
        V.antiLag = true
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 1e10
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
        end)
        for _, e in ipairs(Lighting:GetChildren()) do
            pcall(function()
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
                    or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
                end
            end)
        end
        V.antiLagConn = workspace.DescendantAdded:Connect(function(obj)
            if not V.antiLag then return end
            pcall(function()
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
                    or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                end
            end)
        end)
    end

    V.stopAntiLag = function()
        V.antiLag = false
        if V.antiLagConn then V.antiLagConn:Disconnect(); V.antiLagConn = nil end
        pcall(function()
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 100000
            Lighting.EnvironmentDiffuseScale = 1
            Lighting.EnvironmentSpecularScale = 1
        end)
    end

    V.startNuke = function()
        V.nuke = true
        V.startAntiLag()
        pcall(function() if setfpscap then setfpscap(240) end end)
    end

    V.stopNuke = function()
        V.nuke = false
        V.stopAntiLag()
    end

    V.applySky = function(mode)
        V.sky = mode
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:GetAttribute("_CH_Sky") then pcall(function() c:Destroy() end) end
        end

        if mode == "Off" then
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            return
        end

        local presets = {
            Night       = {clock=22, bright=2, amb={110,100,130}, stars=4000},
            Aurora      = {clock=14, bright=3, amb={150,120,150}, stars=800},
            Sunset      = {clock=17.2, bright=2.5, amb={170,120,100}, stars=0},
            Galaxy      = {clock=0, bright=1.5, amb={70,60,100}, stars=10000},
            Cyber       = {clock=21, bright=2.2, amb={90,130,170}, stars=2000},
            Sakura      = {clock=11, bright=3.5, amb={170,150,160}, stars=300},
            BloodMoon   = {clock=22.5, bright=1.6, amb={130,40,40}, stars=1500},
            Hellscape   = {clock=18, bright=1.8, amb={200,60,30}, stars=100},
            Heaven      = {clock=12, bright=4, amb={240,235,210}, stars=0},
        }
        local p = presets[mode] or presets.Night
        Lighting.ClockTime = p.clock
        Lighting.Brightness = p.bright
        Lighting.OutdoorAmbient = Color3.fromRGB(p.amb[1], p.amb[2], p.amb[3])
        Lighting.Ambient = Color3.fromRGB(p.amb[1], p.amb[2], p.amb[3])

        local sky = Instance.new("Sky")
        sky:SetAttribute("_CH_Sky", true)
        sky.StarCount = p.stars
        sky.Parent = Lighting
    end

    mkSect(visPage, "PLAYERS")

    mkToggle(visPage, "ESP", false, function(on)
        if on then V.startESP() else V.stopESP() end
    end)

    mkSect(visPage, "CAMERA")

    mkToggle(visPage, "FOV", false, function(on)
        if on then V.startFOV() else V.stopFOV() end
    end)

    do
        local row = mkRow(visPage, 44)
        mkLabel(row, "FOV Value")
        mkBox(row, V.fovValue, 70, 80, function(v)
            if v and v >= 30 and v <= 120 then V.fovValue = v end
        end)
    end

    mkSect(visPage, "PERFORMANCE")

    mkToggle(visPage, "Anti Lag", false, function(on)
        if on then V.startAntiLag() else V.stopAntiLag() end
    end)

    mkToggle(visPage, "Nuke Optimizer", false, function(on)
        if on then V.startNuke() else V.stopNuke() end
    end)

    mkSect(visPage, "SKY THEME")

    do
        local row = mkRow(visPage, 42)
        mkLabel(row, "Sky Theme")
        local options = {"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","BloodMoon","Hellscape","Heaven"}
        local idx = 1
        for i, n in ipairs(options) do if n == V.sky then idx = i end end

        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 140, 0, 28)
        btn.Position = UDim2.new(1, -150, 0.5, -14)
        btn.BackgroundColor3 = C.INPUT
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Text = options[idx]
        btn.TextColor3 = C.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        local s = Instance.new("UIStroke", btn)
        s.Color = C.STROKE; s.Thickness = 1; s.Transparency = 0.3

        btn.Activated:Connect(function()
            idx = idx + 1
            if idx > #options then idx = 1 end
            btn.Text = options[idx]
            V.applySky(options[idx])
        end)
    end

    _G.CyberHub.Visual = V
end

print("[CYBER HUB] DROP 5 - Visual loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 6 : KEYBINDS
-- Requires: DROP 1
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local TA       = H.TA
    local C        = H.C
    local LP       = H.LP
    local UIS      = H.UIS
    local setPage  = H.Pages["Settings"]

    if not setPage then
        warn("[CYBER HUB] Settings sayfasi yok!")
        return
    end

    _G.CH_Keys = _G.CH_Keys or {}
    local K = _G.CH_Keys

    K.DEFAULT = {
        Aimbot        = Enum.KeyCode.E,
        TPBat         = Enum.KeyCode.V,
        DropBrainrot  = Enum.KeyCode.X,
        SpeedToggle   = Enum.KeyCode.Q,
        LaggerToggle  = Enum.KeyCode.R,
        AutoLeft      = Enum.KeyCode.Z,
        AutoRight     = Enum.KeyCode.C,
        TPDown        = Enum.KeyCode.F,
        ToggleUI      = Enum.KeyCode.LeftControl,
    }

    if not K.binds then
        K.binds = {}
        for k, v in pairs(K.DEFAULT) do K.binds[k] = v end
    end

    K.buttons = K.buttons or {}
    K.listening = K.listening or nil
    K.listenStart = K.listenStart or 0

    K.keyName = function(key)
        if not key then return "None" end
        local ok, name = pcall(function()
            return tostring(key):gsub("Enum.KeyCode.", "")
        end)
        if ok and name then return name end
        return "None"
    end

    K.refresh = function()
        for id, btn in pairs(K.buttons) do
            if btn and btn.Parent then
                pcall(function()
                    if K.listening == id then
                        btn.Text = "Press..."
                    else
                        btn.Text = K.keyName(K.binds[id])
                    end
                end)
            end
        end
    end

    K.makeRow = function(parent, label, id, order)
        local ok, row = pcall(function()
            return mkRow(parent, 44)
        end)
        if not ok or not row then return nil end

        row.LayoutOrder = order or 0
        pcall(function() mkLabel(row, label) end)

        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 80, 0, 26)
        btn.Position = UDim2.new(1, -90, 0.5, -13)
        btn.BackgroundColor3 = C.INPUT
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Text = K.keyName(K.binds[id])
        btn.TextColor3 = C.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        local s = Instance.new("UIStroke", btn)
        s.Color = C.STROKE; s.Thickness = 1; s.Transparency = 0.3
        K.buttons[id] = btn

        btn.Activated:Connect(function()
            K.listening = id
            K.listenStart = tick()
            pcall(K.refresh)
        end)
    end

    if not K.started then
        K.started = true

        UIS.InputBegan:Connect(function(input, gpe)
            pcall(function()
                if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

                if K.listening then
                    if tick() - K.listenStart < 0.15 then return end
                    local id = K.listening
                    if input.KeyCode == Enum.KeyCode.Escape then
                        K.listening = nil
                        K.refresh()
                        return
                    end
                    if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
                        K.binds[id] = nil
                    else
                        K.binds[id] = input.KeyCode
                    end
                    K.listening = nil
                    K.refresh()
                    return
                end

                if UIS:GetFocusedTextBox() then return end

                local CB = _G.CH_Combat
                local M  = _G.CH_Move

                if K.binds.Aimbot and input.KeyCode == K.binds.Aimbot then
                    if CB and CB.toggleAimbot then pcall(CB.toggleAimbot) end
                    return
                end

                if K.binds.TPBat and input.KeyCode == K.binds.TPBat then
                    if CB and CB.toggleTpBat then pcall(CB.toggleTpBat) end
                    return
                end

                if K.binds.DropBrainrot and input.KeyCode == K.binds.DropBrainrot then
                    local fn = _G.runDrop
                    if fn then pcall(fn) end
                    return
                end

                if K.binds.SpeedToggle and input.KeyCode == K.binds.SpeedToggle then
                    if M and M.Speed then
                        local sp = M.Speed
                        if sp.Mode == "Normal" or sp.Mode == "Lagger" then
                            sp.Mode = (sp.Mode == "Lagger") and "Lagger Carry" or "Carry"
                        else
                            sp.Mode = (sp.Mode == "Lagger Carry") and "Lagger" or "Normal"
                        end
                    end
                    return
                end

                if K.binds.LaggerToggle and input.KeyCode == K.binds.LaggerToggle then
                    if M and M.Speed then
                        local sp = M.Speed
                        if sp.Mode == "Lagger" or sp.Mode == "Lagger Carry" then
                            sp.Mode = "Normal"
                        else
                            sp.Mode = "Lagger"
                        end
                    end
                    return
                end

                if K.binds.AutoLeft and input.KeyCode == K.binds.AutoLeft then
                    if M and M.startAutoLeft then
                        local AP = M.AutoPath
                        if AP then
                            if AP.leftEnabled then
                                AP.leftEnabled = false
                                if AP.leftConn then AP.leftConn:Disconnect(); AP.leftConn = nil end
                            else
                                pcall(M.startAutoLeft)
                            end
                        end
                    end
                    return
                end

                if K.binds.AutoRight and input.KeyCode == K.binds.AutoRight then
                    if M and M.startAutoRight then
                        local AP = M.AutoPath
                        if AP then
                            if AP.rightEnabled then
                                AP.rightEnabled = false
                                if AP.rightConn then AP.rightConn:Disconnect(); AP.rightConn = nil end
                            else
                                pcall(M.startAutoRight)
                            end
                        end
                    end
                    return
                end

                if K.binds.TPDown and input.KeyCode == K.binds.TPDown then
                    if M and M.doAutoTP then pcall(M.doAutoTP, true) end
                    return
                end

                if K.binds.ToggleUI and input.KeyCode == K.binds.ToggleUI then
                    local Main = H.Main
                    if Main then Main.Visible = not Main.Visible end
                    return
                end
            end)
        end)
    end

    pcall(function() mkSect(setPage, "KEYBINDS") end)

    K.makeRow(setPage, "Aimbot Toggle", "Aimbot", 1)
    K.makeRow(setPage, "TP Bat Toggle", "TPBat", 2)
    K.makeRow(setPage, "Drop Brainrot", "DropBrainrot", 3)
    K.makeRow(setPage, "Speed Toggle", "SpeedToggle", 4)
    K.makeRow(setPage, "Lagger Toggle", "LaggerToggle", 5)
    K.makeRow(setPage, "Auto Left", "AutoLeft", 6)
    K.makeRow(setPage, "Auto Right", "AutoRight", 7)
    K.makeRow(setPage, "TP Down", "TPDown", 8)
    K.makeRow(setPage, "Toggle UI", "ToggleUI", 9)

    pcall(function() mkSect(setPage, "GUI") end)

    do
        local row = mkRow(setPage, 44)
        if row then
            row.LayoutOrder = 100
            mkLabel(row, "Reset Keybinds")
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(0, 80, 0, 28)
            btn.Position = UDim2.new(1, -90, 0.5, -14)
            btn.BackgroundColor3 = C.INPUT
            btn.BackgroundTransparency = 0.15
            btn.BorderSizePixel = 0
            btn.Text = "RESET"
            btn.TextColor3 = TA
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 11
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
            local s = Instance.new("UIStroke", btn)
            s.Color = C.STROKE; s.Thickness = 1; s.Transparency = 0.3
            btn.Activated:Connect(function()
                for k, v in pairs(K.DEFAULT) do K.binds[k] = v end
                pcall(K.refresh)
            end)
        end
    end

    _G.CyberHub.Keys = K
end

print("[CYBER HUB] DROP 6 - Keybinds loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 7 : GLUE / FINAL
-- Requires: DROP 1-6
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local LP         = H.LP
    local RunService = game:GetService("RunService")
    local Players    = game:GetService("Players")

    -- DROP BRAINROT
    if not _G.runDrop then
        _G.runDrop = function()
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local startTime = tick()
            local conn
            conn = RunService.Heartbeat:Connect(function()
                local c = LP.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if not c or not r then
                    if conn then conn:Disconnect() end
                    return
                end

                if tick() - startTime >= 0.2 then
                    if conn then conn:Disconnect() end

                    local params = RaycastParams.new()
                    params.FilterDescendantsInstances = {c}
                    params.FilterType = Enum.RaycastFilterType.Exclude

                    local res = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), params)
                    if res then
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        local off = (hum and hum.HipHeight or 2) + (r.Size.Y / 2)
                        r.CFrame = CFrame.new(r.Position.X, res.Position.Y + off, r.Position.Z)
                        r.AssemblyLinearVelocity = Vector3.zero
                        r.AssemblyAngularVelocity = Vector3.zero
                    end
                    return
                end

                local v = r.AssemblyLinearVelocity
                r.AssemblyLinearVelocity = Vector3.new(v.X, 150, v.Z)
            end)
        end
    end

    -- CHARACTER RESPAWN GLUE
    LP.CharacterAdded:Connect(function()
        task.wait(0.5)

        local CB = _G.CH_Combat
        if CB then
            if CB.antiRagdoll then
                pcall(function() CB.stopAntiRagdoll() end)
                pcall(function() CB.startAntiRagdoll() end)
            end
            if CB.antiDie then pcall(function() CB.startAntiDie() end) end
            if CB.antiVoid then
                pcall(function() CB.stopAntiVoid() end)
                pcall(function() CB.startAntiVoid() end)
            end
            if CB.medCounter then pcall(function() CB.startMedCounter() end) end
            if CB.batCounter then
                pcall(function() CB.stopBatCounter() end)
                pcall(function() CB.startBatCounter() end)
            end
            if CB.aimbotOn then
                pcall(function() CB.stopAimbot() end)
                pcall(function() CB.startAimbot() end)
            end
            if CB.bodyLock then
                pcall(function() CB.stopBodyLock() end)
                pcall(function() CB.startBodyLock() end)
            end
            if CB.tpBat then
                pcall(function() CB.stopTpBat() end)
                pcall(function() CB.startTpBat() end)
            end
        end

        local M = _G.CH_Move
        if M then
            local AP = M.AutoPath
            if AP then
                if AP.leftEnabled then pcall(function() M.startAutoLeft() end) end
                if AP.rightEnabled then pcall(function() M.startAutoRight() end) end
            end
        end
    end)

    print("[CYBER HUB] Final glue loaded 🩸")
end

print("[CYBER HUB] DROP 7 - Final glue loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 8 : OVERHEAD HUD
-- Requires: DROP 1-7
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

local LP = H.LP
local TA = H.TA
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local overheadGui = nil
local overheadSpeedLabel = nil
local ragdollCountdownLabel = nil
local ragdollCountdownConn = nil
local ragdollCountdownCharConn = nil
local ragdollCountdownEndTime = 0
local RAGDOLL_COUNTDOWN_SECONDS = 2.6
local ragdollCountdownEnabled = true

local function setupOverheadInfo(char)
    if overheadGui then
        pcall(function() overheadGui:Destroy() end)
        overheadGui = nil
        overheadSpeedLabel = nil
        ragdollCountdownLabel = nil
    end
    if not char then return end
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
    if not head then return end

    overheadGui = Instance.new("BillboardGui")
    overheadGui.Name = "CyberHubOverheadInfo"
    overheadGui.Size = UDim2.new(0, 190, 0, 74)
    overheadGui.StudsOffset = Vector3.new(0, 2.35, 0)
    overheadGui.AlwaysOnTop = true
    overheadGui.LightInfluence = 0
    overheadGui.ResetOnSpawn = false
    overheadGui.Parent = head

    local cyberTitle = Instance.new("TextLabel")
    cyberTitle.Size = UDim2.new(1, 0, 0, 16)
    cyberTitle.Position = UDim2.new(0, 0, 0, 0)
    cyberTitle.BackgroundTransparency = 1
    cyberTitle.Text = "CYBER HUB"
    cyberTitle.TextColor3 = TA
    cyberTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    cyberTitle.TextStrokeTransparency = 0.08
    cyberTitle.Font = Enum.Font.GothamBlack
    cyberTitle.TextSize = 14
    cyberTitle.TextXAlignment = Enum.TextXAlignment.Center
    cyberTitle.ZIndex = 10
    cyberTitle.Parent = overheadGui

    overheadSpeedLabel = Instance.new("TextLabel")
    overheadSpeedLabel.Size = UDim2.new(1, 0, 0, 18)
    overheadSpeedLabel.Position = UDim2.new(0, 0, 0, 16)
    overheadSpeedLabel.BackgroundTransparency = 1
    overheadSpeedLabel.Text = "0 speed"
    overheadSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    overheadSpeedLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    overheadSpeedLabel.TextStrokeTransparency = 0.08
    overheadSpeedLabel.Font = Enum.Font.GothamBlack
    overheadSpeedLabel.TextSize = 13
    overheadSpeedLabel.TextXAlignment = Enum.TextXAlignment.Center
    overheadSpeedLabel.ZIndex = 10
    overheadSpeedLabel.Parent = overheadGui

    ragdollCountdownLabel = Instance.new("TextLabel")
    ragdollCountdownLabel.Size = UDim2.new(1, 0, 0, 16)
    ragdollCountdownLabel.Position = UDim2.new(0, 0, 0, 34)
    ragdollCountdownLabel.BackgroundTransparency = 1
    ragdollCountdownLabel.Text = ""
    ragdollCountdownLabel.Visible = false
    ragdollCountdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ragdollCountdownLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    ragdollCountdownLabel.TextStrokeTransparency = 0.08
    ragdollCountdownLabel.Font = Enum.Font.GothamBlack
    ragdollCountdownLabel.TextSize = 13
    ragdollCountdownLabel.TextXAlignment = Enum.TextXAlignment.Center
    ragdollCountdownLabel.ZIndex = 10
    ragdollCountdownLabel.Parent = overheadGui
end

local function stopRagdollCountdown()
    if ragdollCountdownConn then ragdollCountdownConn:Disconnect(); ragdollCountdownConn = nil end
    if ragdollCountdownCharConn then ragdollCountdownCharConn:Disconnect(); ragdollCountdownCharConn = nil end
    if ragdollCountdownLabel then
        ragdollCountdownLabel.Visible = false
        ragdollCountdownLabel.Text = ""
    end
end

local function hookRagdollCountdown(char)
    stopRagdollCountdown()
    if not ragdollCountdownEnabled then return end
    char = char or LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 4)
    if not hum then return end

    local function beginCountdown()
        ragdollCountdownEndTime = tick() + RAGDOLL_COUNTDOWN_SECONDS
        if ragdollCountdownLabel then
            ragdollCountdownLabel.Visible = true
            ragdollCountdownLabel.Text = string.format("GET UP: %.1fs", RAGDOLL_COUNTDOWN_SECONDS)
        end
    end

    local function isRagdollState()
        local st = hum:GetState()
        return hum.PlatformStand
            or st == Enum.HumanoidStateType.Physics
            or st == Enum.HumanoidStateType.Ragdoll
            or st == Enum.HumanoidStateType.FallingDown
    end

    ragdollCountdownCharConn = hum.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Physics
            or newState == Enum.HumanoidStateType.Ragdoll
            or newState == Enum.HumanoidStateType.FallingDown then
            beginCountdown()
        end
    end)

    ragdollCountdownConn = RunService.RenderStepped:Connect(function()
        if not ragdollCountdownEnabled then stopRagdollCountdown(); return end
        if not ragdollCountdownLabel or not ragdollCountdownLabel.Parent then return end
        if isRagdollState() and ragdollCountdownEndTime < tick() then
            beginCountdown()
        end
        local left = math.max(0, ragdollCountdownEndTime - tick())
        if left > 0 and isRagdollState() then
            ragdollCountdownLabel.Visible = true
            ragdollCountdownLabel.Text = string.format("GET UP: %.1fs", left)
        else
            ragdollCountdownLabel.Visible = false
            ragdollCountdownLabel.Text = ""
        end
    end)
end

RunService.RenderStepped:Connect(function()
    if not overheadSpeedLabel then return end
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local v = hrp.AssemblyLinearVelocity
    local speedMag = Vector3.new(v.X, 0, v.Z).Magnitude
    local rounded = math.floor(speedMag * 10 + 0.5) / 10
    if math.abs(rounded - math.floor(rounded)) < 0.05 then
        overheadSpeedLabel.Text = string.format("%d speed", math.floor(rounded + 0.5))
    else
        overheadSpeedLabel.Text = string.format("%.1f speed", rounded)
    end
end)

if LP.Character then
    task.spawn(function()
        setupOverheadInfo(LP.Character)
        task.wait(0.05)
        if ragdollCountdownEnabled then hookRagdollCountdown(LP.Character) end
    end)
end

LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    setupOverheadInfo(char)
    if ragdollCountdownEnabled then hookRagdollCountdown(char) end
end)

print("[CYBER HUB] DROP 8 - Overhead HUD loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 9 : AUTO SAVE
-- Requires: DROP 1-8
-- ============================================================

local H = _G.CyberHub
if not H then
    warn("[AUTOSAVE] DROP 1 calistirilmamis!")
    return
end

print("[AUTOSAVE] Baslatiliyor...")

local _syn = rawget((getgenv and getgenv()) or _G, "syn") or rawget(_G, "syn")
local _isfile   = isfile   or (type(_syn) == "table" and _syn.isfile)   or (function(p) local ok = pcall(function() return readfile(p) end) return ok end)
local _readfile = readfile or (type(_syn) == "table" and _syn.readfile)
local _writefile = writefile or (type(_syn) == "table" and _syn.writefile)
local _delfile  = delfile  or (type(_syn) == "table" and _syn.delfile)

local canSave = (type(_readfile) == "function" and type(_writefile) == "function")
print("[AUTOSAVE] canSave =", canSave)

local CFG_FILE = "CyberHub_AutoSave.json"
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local function keyToString(key)
    if not key then return "None" end
    local ok, s = pcall(function() return tostring(key):gsub("Enum.KeyCode.", "") end)
    return (ok and s) or "None"
end
local function stringToKeyCode(v)
    if type(v) ~= "string" or v == "" or v == "None" then return nil end
    return Enum.KeyCode[v]
end
local function udim2ToTable(u)
    if not u then return nil end
    return {xs=u.X.Scale, xo=u.X.Offset, ys=u.Y.Scale, yo=u.Y.Offset}
end
local function tableToUDim2(t, fb)
    if type(t) ~= "table" then return fb end
    return UDim2.new(tonumber(t.xs) or 0, tonumber(t.xo) or 0, tonumber(t.ys) or 0, tonumber(t.yo) or 0)
end

-- UI TOGGLE SENKRONIZASYONU
local function findToggleRow(page, labelText)
    if not page then return nil end
    for _, obj in ipairs(page:GetDescendants()) do
        if obj:IsA("TextLabel") and obj.Text == labelText then
            local row = obj.Parent
            if row and row:IsA("Frame") then return row end
        end
    end
    return nil
end

local function setToggleVisual(row, on)
    if not row then return end
    local pill, dot
    for _, ch in ipairs(row:GetDescendants()) do
        if ch:IsA("Frame") then
            local sz = ch.Size
            if sz.X.Offset == 46 and sz.Y.Offset == 24 then
                pill = ch
            elseif sz.X.Offset == 18 and sz.Y.Offset == 18 then
                dot = ch
            end
        end
    end
    if pill then
        pcall(function()
            TweenService:Create(pill, TweenInfo.new(0.18), {
                BackgroundColor3 = on and H.TA or H.C.INPUT,
            }):Play()
        end)
    end
    if dot then
        pcall(function()
            TweenService:Create(dot, TweenInfo.new(0.18), {
                Position = on and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150),
            }):Play()
        end)
    end
end

local function syncAllToggles(data)
    if not data then return end
    local combatPage = H.Pages and H.Pages["Combat"]
    local movePage   = H.Pages and H.Pages["Movement"]
    local visPage    = H.Pages and H.Pages["Visual"]

    local combatToggles = {
        ["Aimbot"] = data.AimbotOn,
        ["Auto Swing"] = data.AutoSwing,
        ["TP Bat"] = data.TPBat,
        ["Body Lock"] = data.BodyLock,
        ["Bat Counter"] = data.BatCounter,
        ["Med Counter"] = data.MedCounter,
        ["Anti Ragdoll"] = data.AntiRagdoll,
        ["Anti Die"] = data.AntiDie,
        ["Anti Void"] = data.AntiVoid,
        ["No Player Collision"] = data.NoPlayerCollision,
        ["Auto Steal"] = data.AutoSteal,
        ["Auto Reset On Med"] = data.AutoResetOnMed,
    }
    for label, state in pairs(combatToggles) do
        local row = findToggleRow(combatPage, label)
        if row then setToggleVisual(row, state == true) end
    end

    local moveToggles = {
        ["Speed Enabled"] = data.SpeedEnabled,
        ["Auto TP Down"] = data.AutoTPEnabled,
        ["Infinite Jump"] = data.InfJumpEnabled,
        ["Auto Left"] = data.AutoLeftEnabled,
        ["Auto Right"] = data.AutoRightEnabled,
    }
    for label, state in pairs(moveToggles) do
        local row = findToggleRow(movePage, label)
        if row then setToggleVisual(row, state == true) end
    end

    local visToggles = {
        ["ESP"] = data.ESP,
        ["FOV"] = data.FOVEnabled,
        ["Anti Lag"] = data.AntiLag,
        ["Nuke Optimizer"] = data.NukeOptimizer,
    }
    for label, state in pairs(visToggles) do
        local row = findToggleRow(visPage, label)
        if row then setToggleVisual(row, state == true) end
    end
    print("[AUTOSAVE] UI toggle'lari senkronize edildi")
end

local AS = _G.CH_AutoSave or {}
_G.CH_AutoSave = AS
AS.canSave = canSave
AS.CONFIG_FILE = CFG_FILE

function AS.collect()
    local M  = _G.CH_Move   or {}
    local CB = _G.CH_Combat or {}
    local S  = _G.CH_Steal  or {}
    local V  = _G.CH_Visual or {}
    local K  = _G.CH_Keys   or {}
    local d  = {}

    if M.Speed then
        d.NS = M.Speed.NS; d.CS = M.Speed.CS
        d.LAGGER = M.Speed.LAGGER; d.LAGGER_CARRY = M.Speed.LAGGER_CARRY
        d.SpeedMode = M.Speed.Mode; d.SpeedEnabled = M.Speed.enabled
    end
    if M.AutoTP then d.AutoTPEnabled = M.AutoTP.enabled; d.AutoTPHeight = M.AutoTP.height end
    if M.InfJump then d.InfJumpEnabled = M.InfJump.enabled; d.InfJumpMode = M.InfJump.mode end
    if M.AutoPath then d.AutoLeftEnabled = M.AutoPath.leftEnabled; d.AutoRightEnabled = M.AutoPath.rightEnabled end

    d.AimbotOn = CB.aimbotOn; d.AimbotMode = CB.aimbotMode; d.AimbotSpeed = CB.aimbotSpeed
    d.AutoSwing = CB.autoSwing; d.TPBat = CB.tpBat
    d.BodyLock = CB.bodyLock; d.BodyLockRadius = CB.bodyLockRadius
    d.BatCounter = CB.batCounter; d.MedCounter = CB.medCounter
    d.AntiRagdoll = CB.antiRagdoll; d.AntiDie = CB.antiDie; d.AntiVoid = CB.antiVoid
    d.NoPlayerCollision = CB.noPlayerCollision

    d.AutoSteal = S.enabled; d.StealMode = S.mode
    d.StealRadius = S.radius; d.SemiRadius = S.semiRadius
    d.AutoResetOnMed = S.autoResetOnMed

    d.ESP = V.esp; d.FOVEnabled = V.fov; d.FOVValue = V.fovValue
    d.AntiLag = V.antiLag; d.NukeOptimizer = V.nuke; d.SkyTheme = V.sky

    if K.binds then
        local binds = {}
        for id, key in pairs(K.binds) do binds[id] = keyToString(key) end
        d.Keybinds = binds
    end

    if H.Main then
        d.MainSize = udim2ToTable(H.Main.Size)
        d.MainPosition = udim2ToTable(H.Main.Position)
    end
    return d
end

function AS.save(manual)
    if not canSave then return false end
    local ok, err = pcall(function()
        local data = AS.collect()
        _writefile(CFG_FILE, HttpService:JSONEncode(data))
    end)
    if not ok then
        warn("[AUTOSAVE] Save hata: "..tostring(err))
        return false
    end
    print("[AUTOSAVE] Kaydedildi -> "..CFG_FILE)
    return true
end

function AS.load()
    if not canSave then return false end
    if not _isfile(CFG_FILE) then
        print("[AUTOSAVE] Dosya yok")
        return false
    end
    local ok, data = pcall(function() return HttpService:JSONDecode(_readfile(CFG_FILE)) end)
    if not ok or type(data) ~= "table" then
        warn("[AUTOSAVE] Load hata")
        return false
    end

    local M  = _G.CH_Move   or {}
    local CB = _G.CH_Combat or {}
    local S  = _G.CH_Steal  or {}
    local V  = _G.CH_Visual or {}
    local K  = _G.CH_Keys   or {}

    -- ONCE DURDUR
    pcall(function() if CB.stopAimbot then CB.stopAimbot() end end)
    pcall(function() if CB.stopTpBat then CB.stopTpBat() end end)
    pcall(function() if CB.stopBodyLock then CB.stopBodyLock() end end)
    pcall(function() if CB.stopBatCounter then CB.stopBatCounter() end end)
    pcall(function() if CB.stopMedCounter then CB.stopMedCounter() end end)
    pcall(function() if CB.stopAntiRagdoll then CB.stopAntiRagdoll() end end)
    pcall(function() if CB.stopAntiDie then CB.stopAntiDie() end end)
    pcall(function() if CB.stopAntiVoid then CB.stopAntiVoid() end end)
    pcall(function() if CB.stopNoCollision then CB.stopNoCollision() end end)
    pcall(function() if S.stopAutoSteal then S.stopAutoSteal() end end)
    pcall(function() if S.stopAutoResetOnMed then S.stopAutoResetOnMed() end end)
    pcall(function() if M.stopAutoTP then M.stopAutoTP() end end)
    pcall(function() if M.Speed then M.Speed.enabled = false end end)
    pcall(function() if M.InfJump then M.InfJump.enabled = false end end)
    pcall(function() if M.AutoPath then
        M.AutoPath.leftEnabled = false
        M.AutoPath.rightEnabled = false
    end end)
    pcall(function() if V.stopESP then V.stopESP() end end)
    pcall(function() if V.stopFOV then V.stopFOV() end end)
    pcall(function() if V.stopAntiLag then V.stopAntiLag() end end)
    pcall(function() if V.stopNuke then V.stopNuke() end end)

    -- SIMDI YUKLE
    if M.Speed then
        if data.NS then M.Speed.NS = data.NS end
        if data.CS then M.Speed.CS = data.CS end
        if data.LAGGER then M.Speed.LAGGER = data.LAGGER end
        if data.LAGGER_CARRY then M.Speed.LAGGER_CARRY = data.LAGGER_CARRY end
        if data.SpeedMode then M.Speed.Mode = data.SpeedMode end
        if data.SpeedEnabled ~= nil then M.Speed.enabled = data.SpeedEnabled end
    end
    if M.AutoTP then
        if data.AutoTPHeight then M.AutoTP.height = data.AutoTPHeight end
        if data.AutoTPEnabled == true and M.startAutoTP then pcall(M.startAutoTP) end
    end
    if M.InfJump then
        if data.InfJumpMode then M.InfJump.mode = data.InfJumpMode end
        if data.InfJumpEnabled ~= nil then M.InfJump.enabled = data.InfJumpEnabled end
    end
    if M.AutoPath then
        if data.AutoLeftEnabled == true and M.startAutoLeft then pcall(M.startAutoLeft) end
        if data.AutoRightEnabled == true and M.startAutoRight then pcall(M.startAutoRight) end
    end

    if data.AimbotSpeed then CB.aimbotSpeed = data.AimbotSpeed end
    if data.AimbotMode then CB.aimbotMode = data.AimbotMode end
    if data.AutoSwing ~= nil then CB.autoSwing = data.AutoSwing end
    if data.BodyLockRadius then CB.bodyLockRadius = data.BodyLockRadius end
    if data.AimbotOn == true and CB.startAimbot then pcall(CB.startAimbot) end
    if data.TPBat == true and CB.startTpBat then pcall(CB.startTpBat) end
    if data.BodyLock == true and CB.startBodyLock then pcall(CB.startBodyLock) end
    if data.BatCounter == true and CB.startBatCounter then pcall(CB.startBatCounter) end
    if data.MedCounter == true and CB.startMedCounter then pcall(CB.startMedCounter) end
    if data.AntiRagdoll == true and CB.startAntiRagdoll then pcall(CB.startAntiRagdoll) end
    if data.AntiDie == true and CB.startAntiDie then pcall(CB.startAntiDie) end
    if data.AntiVoid == true and CB.startAntiVoid then pcall(CB.startAntiVoid) end
    if data.NoPlayerCollision == true and CB.startNoCollision then pcall(CB.startNoCollision) end

    if data.StealMode then S.mode = data.StealMode end
    if data.StealRadius then S.radius = data.StealRadius end
    if data.SemiRadius then S.semiRadius = data.SemiRadius end
    if data.AutoSteal == true and S.startAutoSteal then pcall(S.startAutoSteal) end
    if data.AutoResetOnMed == true and S.startAutoResetOnMed then pcall(S.startAutoResetOnMed) end

    if data.FOVValue then V.fovValue = data.FOVValue end
    if data.ESP == true and V.startESP then pcall(V.startESP) end
    if data.FOVEnabled == true and V.startFOV then pcall(V.startFOV) end
    if data.AntiLag == true and V.startAntiLag then pcall(V.startAntiLag) end
    if data.NukeOptimizer == true and V.startNuke then pcall(V.startNuke) end
    if data.SkyTheme and V.applySky then pcall(V.applySky, data.SkyTheme) end

    if type(data.Keybinds) == "table" and K.binds then
        for id, keyStr in pairs(data.Keybinds) do
            local kc = stringToKeyCode(keyStr)
            if kc then K.binds[id] = kc end
        end
        if K.refresh then pcall(K.refresh) end
    end

    if H.Main then
        if data.MainSize then H.Main.Size = tableToUDim2(data.MainSize, H.Main.Size) end
        if data.MainPosition then H.Main.Position = tableToUDim2(data.MainPosition, H.Main.Position) end
    end

    task.defer(function()
        task.wait(0.1)
        syncAllToggles(data)
    end)

    print("[AUTOSAVE] Yuklendi")
    return true
end

function AS.reset()
    if type(_delfile) ~= "function" then return false end
    pcall(function()
        if _isfile(CFG_FILE) then _delfile(CFG_FILE) end
    end)
    print("[AUTOSAVE] Dosya silindi")
    return true
end

function AS.queueSave()
    if AS._task then pcall(task.cancel, AS._task) end
    AS._task = task.delay(0.5, function()
        AS._task = nil
        AS.save()
    end)
end

AS._hookReady = false
task.delay(3, function()
    AS._hookReady = true
    print("[AUTOSAVE] Hook'lar AKTIF")
end)

local function attachHook(obj)
    if not obj then return end
    if obj:IsA("TextButton") then
        if not obj:GetAttribute("CH_AS_Hooked") then
            obj:SetAttribute("CH_AS_Hooked", true)
            obj.Activated:Connect(function()
                if AS._hookReady then AS.queueSave() end
            end)
        end
    elseif obj:IsA("TextBox") then
        if not obj:GetAttribute("CH_AS_Hooked") then
            obj:SetAttribute("CH_AS_Hooked", true)
            obj.FocusLost:Connect(function()
                if AS._hookReady then AS.queueSave() end
            end)
        end
    end
end

if not AS._hooked then
    AS._hooked = true
    task.defer(function()
        task.wait(2)
        local pages = H.Pages or {}
        for _, page in pairs(pages) do
            if page and page.Parent then
                for _, obj in ipairs(page:GetDescendants()) do attachHook(obj) end
                page.DescendantAdded:Connect(function(obj)
                    task.defer(function() attachHook(obj) end)
                end)
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(plr)
        if plr == H.LP then pcall(AS.save) end
    end)
end

do
    local TA = H.TA or Color3.fromRGB(220, 30, 60)
    local setPage = (H.Pages and H.Pages["Settings"]) or (H.Pages and H.Pages["Combat"])
    if not setPage then return end

    print("[AUTOSAVE] UI ekleniyor -> " .. setPage.Name)

    for _, c in ipairs(setPage:GetChildren()) do
        if c.Name == "CH_AS_Header" or c.Name == "CH_AS_Row" then c:Destroy() end
    end

    setPage.Visible = true
    setPage.ScrollBarThickness = 6

    local header = Instance.new("TextLabel")
    header.Name = "CH_AS_Header"
    header.Size = UDim2.new(1, -8, 0, 22)
    header.BackgroundTransparency = 1
    header.Text = "▸ AUTO SAVE"
    header.TextColor3 = TA
    header.Font = Enum.Font.GothamBlack
    header.TextSize = 12
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.LayoutOrder = -99999
    header.ZIndex = 10
    header.Parent = setPage

    local function makeRow(label, btnText, order, onClick)
        local row = Instance.new("Frame")
        row.Name = "CH_AS_Row"
        row.Size = UDim2.new(1, -4, 0, 44)
        row.BackgroundColor3 = Color3.fromRGB(24, 16, 20)
        row.BackgroundTransparency = 0.15
        row.BorderSizePixel = 0
        row.LayoutOrder = order
        row.ZIndex = 5
        row.Parent = setPage
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
        local st = Instance.new("UIStroke", row)
        st.Color = Color3.fromRGB(80, 40, 50); st.Thickness = 1; st.Transparency = 0.4

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -110, 1, 0)
        lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(240, 230, 235)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 6

        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 80, 0, 28)
        btn.Position = UDim2.new(1, -90, 0.5, -14)
        btn.BackgroundColor3 = Color3.fromRGB(14, 8, 12)
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Text = btnText
        btn.TextColor3 = TA
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        btn.ZIndex = 6
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        local bs = Instance.new("UIStroke", btn)
        bs.Color = Color3.fromRGB(80, 40, 50); bs.Thickness = 1; bs.Transparency = 0.3

        btn.Activated:Connect(function()
            if onClick then onClick(btn) end
        end)
        return btn, row
    end

    makeRow("Save Now", "SAVE", -99998, function(btn)
        local ok = AS.save(true)
        btn.Text = ok and "SAVED" or "FAILED"
        task.delay(0.8, function() if btn.Parent then btn.Text = "SAVE" end end)
    end)

    makeRow("Reload Config", "RELOAD", -99997, function(btn)
        local ok = AS.load()
        btn.Text = ok and "LOADED" or "NO FILE"
        task.delay(0.8, function() if btn.Parent then btn.Text = "RELOAD" end end)
    end)

    local resetBtn = makeRow("Reset Config", "RESET", -99996, nil)
    if resetBtn then
        local confirmed = false
        local timer = nil
        resetBtn.Activated:Connect(function()
            if not confirmed then
                confirmed = true
                resetBtn.Text = "CONFIRM?"
                if timer then task.cancel(timer) end
                timer = task.delay(3, function()
                    confirmed = false
                    if resetBtn.Parent then resetBtn.Text = "RESET" end
                end)
                return
            end
            if timer then task.cancel(timer) end
            confirmed = false
            AS.reset()
            resetBtn.Text = "DELETED"
            task.delay(0.8, function() if resetBtn.Parent then resetBtn.Text = "RESET" end end)
        end)
    end

    print("[AUTOSAVE] UI eklendi -> " .. setPage.Name)
end

task.defer(function()
    task.wait(3)
    if canSave then
        pcall(AS.load)
    end
end)

print("[AUTOSAVE] HAZIR")

-- ============================================================
-- CYBER HUB — DROP 10 v2 : BACKGROUND IMAGE PICKER
-- Requires: DROP 1-9
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local TA       = H.TA
    local Main     = H.Main
    local setPage  = H.Pages["Settings"]

    if not setPage or not Main then return end

    -- Xlu0'nun ID'leri + SENIN MEGUMI
    local BACKGROUND_IDS = {
        "90631990302263",      -- 1 = Xlu0 karanlik abstract
        "109619268613730",     -- 2 = Xlu0 kirmizi duman
        "88369503310562",      -- 3 = Xlu0 siyah kirmizi grid
        "80708025126373",      -- 4 = Xlu0 abstract kirmizi
        "102253425322931",     -- 5 = Xlu0 karanlik sehir
        "90453834580322",      -- 6 = Xlu0 kirmizi swirl
        "135181794444219",     -- 7 = Xlu0 kirmizi gradient
        "84505134265463",      -- 8 = SENIN FOTOGRAFIN (Megumi)
    }

    _G.CH_Visual = _G.CH_Visual or {}
    local V = _G.CH_Visual
    V.bgIndex = V.bgIndex or 0

    local BgImage = Main:FindFirstChild("CustomBackground")
    if not BgImage then
        BgImage = Instance.new("ImageLabel")
        BgImage.Name = "CustomBackground"
        BgImage.BackgroundTransparency = 1
        BgImage.ImageTransparency = 0.15
        BgImage.ScaleType = Enum.ScaleType.Crop
        BgImage.Size = UDim2.new(1, 0, 1, 0)
        BgImage.Position = UDim2.new(0, 0, 0, 0)
        BgImage.Visible = false
        BgImage.ZIndex = 1
        BgImage.Parent = Main
        Instance.new("UICorner", BgImage).CornerRadius = UDim.new(0, 20)
    end

    local function applyBackground(index)
        V.bgIndex = index or 0
        if V.bgIndex == 0 then
            BgImage.Visible = false
            BgImage.Image = ""
            print("[CH-BG] Arka plan KAPALI")
        else
            local id = BACKGROUND_IDS[V.bgIndex]
            if id then
                BgImage.Image = "rbxassetid://" .. id
                BgImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
                BgImage.ImageTransparency = 0.15
                BgImage.Visible = true
                print("[CH-BG] Arka plan: " .. V.bgIndex .. " (" .. id .. ")")
            end
        end
        for i, btn in pairs(_G.CH_BgButtons or {}) do
            local on = (i == V.bgIndex)
            local st = btn:FindFirstChildOfClass("UIStroke")
            if st then
                st.Transparency = on and 0 or 0.5
                st.Thickness = on and 2 or 1
                st.Color = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 40, 50)
            end
            btn.ImageTransparency = on and 0 or 0.35
        end
    end

    _G.CH_ApplyBackground = applyBackground

    mkSect(setPage, "BACKGROUND IMAGE")

    local pickerRow = mkRow(setPage, 80)
    if not pickerRow then return end
    pickerRow.Name = "CH_BgPicker"
    pickerRow.BackgroundTransparency = 1

    local scroll = Instance.new("ScrollingFrame", pickerRow)
    scroll.Name = "BgScroll"
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.X
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = TA
    scroll.ScrollingDirection = Enum.ScrollingDirection.X

    local bgList = Instance.new("UIListLayout", scroll)
    bgList.FillDirection = Enum.FillDirection.Horizontal
    bgList.Padding = UDim.new(0, 6)
    bgList.SortOrder = Enum.SortOrder.LayoutOrder
    bgList.VerticalAlignment = Enum.VerticalAlignment.Center

    local bgPad = Instance.new("UIPadding", scroll)
    bgPad.PaddingLeft = UDim.new(0, 4)
    bgPad.PaddingRight = UDim.new(0, 4)

    _G.CH_BgButtons = {}

    -- NONE butonu
    do
        local btn = Instance.new("TextButton", scroll)
        btn.Name = "BgThumb_None"
        btn.LayoutOrder = 0
        btn.Size = UDim2.new(0, 64, 0, 64)
        btn.BackgroundColor3 = Color3.fromRGB(14, 8, 12)
        btn.BorderSizePixel = 0
        btn.Text = "NONE"
        btn.TextColor3 = Color3.fromRGB(240, 230, 235)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local st = Instance.new("UIStroke", btn)
        st.Color = Color3.fromRGB(80, 40, 50); st.Thickness = 1; st.Transparency = 0.5
        btn.Activated:Connect(function() applyBackground(0) end)
        _G.CH_BgButtons[0] = btn
    end

    -- 8 arka plan
    for i = 1, #BACKGROUND_IDS do
        local btn = Instance.new("ImageButton", scroll)
        btn.Name = "BgThumb_" .. i
        btn.LayoutOrder = i
        btn.Size = UDim2.new(0, 64, 0, 64)
        btn.BackgroundColor3 = Color3.fromRGB(14, 8, 12)
        btn.BorderSizePixel = 0
        btn.Image = "rbxassetid://" .. BACKGROUND_IDS[i]
        btn.ImageTransparency = 0.35
        btn.ScaleType = Enum.ScaleType.Crop
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local st = Instance.new("UIStroke", btn)
        st.Color = Color3.fromRGB(80, 40, 50); st.Thickness = 1; st.Transparency = 0.5
        btn.Activated:Connect(function() applyBackground(i) end)
        _G.CH_BgButtons[i] = btn
    end

    task.defer(function()
        task.wait(0.2)
        applyBackground(V.bgIndex or 0)
    end)

    print("[CH-BG] Background picker v2 eklendi (8 resim)")
end

print("[CYBER HUB] DROP 10 v2 - Background picker loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 11 : ANIMATION PACKS
-- Requires: DROP 1-9
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local TA       = H.TA
    local C        = H.C
    local LP       = H.LP
    local visPage  = H.Pages["Visual"]

    local RunService = game:GetService("RunService")
    local Players    = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local HttpService = game:GetService("HttpService")

    _G.CH_Anim = _G.CH_Anim or {}
    local A = _G.CH_Anim

    -- ========================================================
    -- ANIMATION PACKS (Xlu0'dan)
    -- ========================================================
    local AnimationPacks = {
        ["Zombie"] = {
            idle = {{"rbxassetid://616158929", 1}, {"rbxassetid://616160636", 1}},
            walk = "rbxassetid://616168032", run = "rbxassetid://616163682",
            jump = "rbxassetid://616161997", fall = "rbxassetid://616157476",
            climb = "rbxassetid://616156119", swim = "rbxassetid://616165109",
            swimidle = "rbxassetid://616166655",
        },
        ["Ninja"] = {
            idle = {{"rbxassetid://656117400", 1}, {"rbxassetid://656117400", 1}},
            walk = "rbxassetid://656121766", run = "rbxassetid://656118852",
            jump = "rbxassetid://656117878", fall = "rbxassetid://656115606",
            climb = "rbxassetid://656114359",
        },
        ["Knight"] = {
            idle = {{"rbxassetid://657595757", 1}, {"rbxassetid://657595757", 1}},
            walk = "rbxassetid://657552124", run = "rbxassetid://657564596",
            jump = "rbxassetid://658409194", fall = "rbxassetid://657600338",
            climb = "rbxassetid://658360781",
        },
        ["Elder"] = {
            idle = {{"rbxassetid://845397899", 1}, {"rbxassetid://845397899", 1}},
            walk = "rbxassetid://845403856", run = "rbxassetid://845386501",
            jump = "rbxassetid://845398858", fall = "rbxassetid://845397673",
            climb = "rbxassetid://845392038",
        },
        ["Levitate"] = {
            idle = {{"rbxassetid://616006778", 1}, {"rbxassetid://616006778", 1}},
            walk = "rbxassetid://616013216", run = "rbxassetid://616013216",
            jump = "rbxassetid://616008936", fall = "rbxassetid://616005863",
            climb = "rbxassetid://616003713",
        },
        ["Astronaut"] = {
            idle = {{"rbxassetid://891621366", 1}, {"rbxassetid://891621366", 1}},
            walk = "rbxassetid://891636393", run = "rbxassetid://891636393",
            jump = "rbxassetid://891627522", fall = "rbxassetid://891617961",
            climb = "rbxassetid://891609353",
        },
        ["Pirate"] = {
            idle = {{"rbxassetid://750781874", 1}, {"rbxassetid://750781874", 1}},
            walk = "rbxassetid://750785693", run = "rbxassetid://750783738",
            jump = "rbxassetid://750782230", fall = "rbxassetid://750780242",
            climb = "rbxassetid://750779899",
        },
        ["Toy"] = {
            idle = {{"rbxassetid://782841498", 1}, {"rbxassetid://782841498", 1}},
            walk = "rbxassetid://782843345", run = "rbxassetid://782842708",
            jump = "rbxassetid://782847020", fall = "rbxassetid://782846423",
            climb = "rbxassetid://782843869",
        },
        ["Vampire"] = {
            idle = {{"rbxassetid://1083445855", 1}, {"rbxassetid://1083445855", 1}},
            walk = "rbxassetid://1083473930", run = "rbxassetid://1083462077",
            jump = "rbxassetid://1083455352", fall = "rbxassetid://1083443587",
            climb = "rbxassetid://1083439238",
        },
        ["Werewolf"] = {
            idle = {{"rbxassetid://1083195517", 1}, {"rbxassetid://1083195517", 1}},
            walk = "rbxassetid://1083178339", run = "rbxassetid://1083216690",
            jump = "rbxassetid://1083218792", fall = "rbxassetid://1083189019",
            climb = "rbxassetid://1083182000",
        },
        ["Rthro"] = {
            idle = {{"rbxassetid://2510196951", 1}, {"rbxassetid://2510196951", 1}},
            walk = "rbxassetid://2510202577", run = "rbxassetid://2510198475",
            jump = "rbxassetid://2510197830", fall = "rbxassetid://2510195892",
            climb = "rbxassetid://2510192778",
        },
        ["Stylish"] = {
            idle = {{"rbxassetid://616136790", 1}, {"rbxassetid://616136790", 1}},
            walk = "rbxassetid://616146177", run = "rbxassetid://616140816",
            jump = "rbxassetid://616139451", fall = "rbxassetid://616134815",
            climb = "rbxassetid://616133594",
        },
    }

    local AnimationPackList = {"OFF","Zombie","Ninja","Knight","Elder","Levitate","Astronaut","Pirate","Toy","Vampire","Werewolf","Rthro","Stylish"}

    A.activePack = A.activePack or "OFF"
    A.conn = A.conn or nil
    A.original = A.original or nil

    -- ========================================================
    -- YARDIMCI FONKSİYONLAR
    -- ========================================================
    local function getAnimate(char)
        char = char or LP.Character
        return char and char:FindFirstChild("Animate") or nil
    end

    local function readOriginal(char)
        if A.original then return end
        local animate = getAnimate(char)
        if not animate then return end

        local function g(obj) return obj and obj.AnimationId or nil end

        A.original = {
            idle1 = g(animate.idle and animate.idle:FindFirstChild("Animation1")),
            idle2 = g(animate.idle and animate.idle:FindFirstChild("Animation2")),
            walk = g(animate.walk and animate.walk:FindFirstChild("WalkAnim")),
            run = g(animate.run and animate.run:FindFirstChild("RunAnim")),
            jump = g(animate.jump and animate.jump:FindFirstChild("JumpAnim")),
            fall = g(animate.fall and animate.fall:FindFirstChild("FallAnim")),
            climb = g(animate.climb and animate.climb:FindFirstChild("ClimbAnim")),
            swim = g(animate.swim and animate.swim:FindFirstChild("Swim")),
            swimidle = g(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle")),
        }
    end

    local function applyPack(char, packName)
        local animate = getAnimate(char)
        local pack = AnimationPacks[packName]
        if not animate or not pack then return false end

        local function s(obj, id)
            if obj and id then obj.AnimationId = tostring(id) end
        end

        s(animate.idle and animate.idle:FindFirstChild("Animation1"), pack.idle and pack.idle[1] and pack.idle[1][1])
        s(animate.idle and animate.idle:FindFirstChild("Animation2"), pack.idle and pack.idle[2] and pack.idle[2][1])
        s(animate.walk and animate.walk:FindFirstChild("WalkAnim"), pack.walk)
        s(animate.run and animate.run:FindFirstChild("RunAnim"), pack.run)
        s(animate.jump and animate.jump:FindFirstChild("JumpAnim"), pack.jump)
        s(animate.fall and animate.fall:FindFirstChild("FallAnim"), pack.fall)
        s(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), pack.climb)
        s(animate.swim and animate.swim:FindFirstChild("Swim"), pack.swim)
        s(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle"), pack.swimidle)

        return true
    end

    local function restore(char)
        local animate = getAnimate(char)
        local o = A.original
        if not animate or not o then return end

        local function s(obj, id) if obj and id then obj.AnimationId = id end end

        s(animate.idle and animate.idle:FindFirstChild("Animation1"), o.idle1)
        s(animate.idle and animate.idle:FindFirstChild("Animation2"), o.idle2)
        s(animate.walk and animate.walk:FindFirstChild("WalkAnim"), o.walk)
        s(animate.run and animate.run:FindFirstChild("RunAnim"), o.run)
        s(animate.jump and animate.jump:FindFirstChild("JumpAnim"), o.jump)
        s(animate.fall and animate.fall:FindFirstChild("FallAnim"), o.fall)
        s(animate.climb and animate.climb:FindFirstChild("ClimbAnim"), o.climb)
        s(animate.swim and animate.swim:FindFirstChild("Swim"), o.swim)
        s(animate.swimidle and animate.swimidle:FindFirstChild("SwimIdle"), o.swimidle)
    end

    A.stopAnim = function()
        if A.conn then
            pcall(function() A.conn:Disconnect() end)
            A.conn = nil
        end
        restore(LP.Character)
        A.activePack = "OFF"
    end

    A.applyAnim = function(packName)
        if packName == "OFF" then
            A.stopAnim()
            return
        end

        if A.conn then
            pcall(function() A.conn:Disconnect() end)
            A.conn = nil
        end

        local char = LP.Character
        if not char then return end
        local pack = AnimationPacks[packName]
        if not pack then return end

        readOriginal(char)
        A.activePack = packName

        -- Preload
        task.spawn(function()
            local list = {}
            for _, v in pairs(pack) do
                if type(v) == "string" then
                    table.insert(list, v)
                elseif type(v) == "table" then
                    for _, a in ipairs(v) do
                        if type(a) == "table" and a[1] then
                            table.insert(list, tostring(a[1]))
                        end
                    end
                end
            end
            pcall(function()
                game:GetService("ContentProvider"):PreloadAsync(list)
            end)
        end)

        applyPack(char, packName)

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                pcall(function() track:Stop(0) end)
            end
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
        end

        A.conn = RunService.Heartbeat:Connect(function()
            if A.activePack == "OFF" then return end
            local c = LP.Character
            if c then applyPack(c, A.activePack) end
        end)
    end

    A.setPack = function(packName)
        A.activePack = packName or "OFF"
        if A.activePack == "OFF" then
            A.stopAnim()
        else
            A.applyAnim(A.activePack)
        end
    end

    -- Karakter respawn
    LP.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        A.original = nil
        if A.activePack and A.activePack ~= "OFF" then
            task.defer(function() A.applyAnim(A.activePack) end)
        end
    end)

    -- ========================================================
    -- UI — VISUAL SEKMESİNE ANIMATION PACK ROW
    -- ========================================================
    mkSect(visPage, "ANIMATION PACK")

    do
        local row = mkRow(visPage, 42)
        row.Name = "CH_AnimPackRow"
        mkLabel(row, "Animation Pack")

        local idx = 1
        for i, n in ipairs(AnimationPackList) do
            if n == A.activePack then idx = i end
        end

        -- Sol ok
        local left = Instance.new("TextButton", row)
        left.Name = "AnimLeft"
        left.Size = UDim2.new(0, 30, 0, 28)
        left.Position = UDim2.new(1, -200, 0.5, -14)
        left.BackgroundColor3 = C.INPUT
        left.BackgroundTransparency = 0.15
        left.BorderSizePixel = 0
        left.Text = "<"
        left.TextColor3 = C.TEXT
        left.Font = Enum.Font.GothamBold
        left.TextSize = 14
        left.AutoButtonColor = false
        Instance.new("UICorner", left).CornerRadius = UDim.new(0, 7)
        local ls = Instance.new("UIStroke", left)
        ls.Color = C.STROKE; ls.Thickness = 1; ls.Transparency = 0.3

        -- Ortadaki value
        local valBtn = Instance.new("TextButton", row)
        valBtn.Name = "AnimValue"
        valBtn.Size = UDim2.new(0, 130, 0, 28)
        valBtn.Position = UDim2.new(1, -166, 0.5, -14)
        valBtn.BackgroundColor3 = C.INPUT
        valBtn.BackgroundTransparency = 0.15
        valBtn.BorderSizePixel = 0
        valBtn.Text = AnimationPackList[idx]
        valBtn.TextColor3 = TA
        valBtn.Font = Enum.Font.GothamBold
        valBtn.TextSize = 11
        valBtn.AutoButtonColor = false
        Instance.new("UICorner", valBtn).CornerRadius = UDim.new(0, 7)
        local vs = Instance.new("UIStroke", valBtn)
        vs.Color = C.STROKE; vs.Thickness = 1; vs.Transparency = 0.3

        -- Sağ ok
        local right = Instance.new("TextButton", row)
        right.Name = "AnimRight"
        right.Size = UDim2.new(0, 30, 0, 28)
        right.Position = UDim2.new(1, -32, 0.5, -14)
        right.BackgroundColor3 = C.INPUT
        right.BackgroundTransparency = 0.15
        right.BorderSizePixel = 0
        right.Text = ">"
        right.TextColor3 = C.TEXT
        right.Font = Enum.Font.GothamBold
        right.TextSize = 14
        right.AutoButtonColor = false
        Instance.new("UICorner", right).CornerRadius = UDim.new(0, 7)
        local rs = Instance.new("UIStroke", right)
        rs.Color = C.STROKE; rs.Thickness = 1; rs.Transparency = 0.3

        local function setPack(idx2)
            if idx2 < 1 then idx2 = #AnimationPackList end
            if idx2 > #AnimationPackList then idx2 = 1 end
            idx = idx2
            local chosen = AnimationPackList[idx]
            valBtn.Text = chosen
            A.setPack(chosen)
            print("[CH-ANIM] Pack: " .. chosen)
        end

        left.Activated:Connect(function() setPack(idx - 1) end)
        right.Activated:Connect(function() setPack(idx + 1) end)
    end

    -- ========================================================
    -- UI — MORE ANIMATIONS BUTTON (Bundle Gallery)
    -- ========================================================
    do
        local row = mkRow(visPage, 42)
        row.Name = "CH_MoreAnimRow"
        mkLabel(row, "More Animations")

        local b = Instance.new("TextButton", row)
        b.Name = "MoreAnimBtn"
        b.Size = UDim2.new(0, 80, 0, 28)
        b.Position = UDim2.new(1, -90, 0.5, -14)
        b.BackgroundColor3 = C.INPUT
        b.BackgroundTransparency = 0.15
        b.BorderSizePixel = 0
        b.Text = "OPEN"
        b.TextColor3 = TA
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
        local s = Instance.new("UIStroke", b)
        s.Color = C.STROKE; s.Thickness = 1; s.Transparency = 0.3

        -- ====================================================
        -- BUNDLE GALLERY
        -- ====================================================
        local function openGallery()
            local old = LP:WaitForChild("PlayerGui"):FindFirstChild("CH_AnimGallery")
            if old then old:Destroy() end

            local sg = Instance.new("ScreenGui")
            sg.Name = "CH_AnimGallery"
            sg.ResetOnSpawn = false
            sg.IgnoreGuiInset = true
            sg.DisplayOrder = 99999
            sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            pcall(function()
                if gethui then sg.Parent = gethui() else sg.Parent = game:GetService("CoreGui") end
            end)
            if not sg.Parent then sg.Parent = LP:WaitForChild("PlayerGui") end

            local shade = Instance.new("TextButton", sg)
            shade.Text = ""
            shade.AutoButtonColor = false
            shade.BackgroundColor3 = Color3.fromRGB(0,0,0)
            shade.BackgroundTransparency = 0.25
            shade.Size = UDim2.fromScale(1,1)
            shade.ZIndex = 1

            local panel = Instance.new("Frame", sg)
            panel.AnchorPoint = Vector2.new(0.5,0.5)
            panel.Position = UDim2.fromScale(0.5,0.5)
            panel.Size = UDim2.new(0, 540, 0, 480)
            panel.BackgroundColor3 = Color3.fromRGB(10,10,15)
            panel.BorderSizePixel = 0
            panel.ZIndex = 2
            Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)
            local pst = Instance.new("UIStroke", panel)
            pst.Color = C.STROKE; pst.Thickness = 1.2; pst.Transparency = 0.15

            -- Başlık
            local title = Instance.new("TextLabel", panel)
            title.BackgroundTransparency = 1
            title.Text = "ALL ANIMATION BUNDLES"
            title.TextColor3 = C.TEXT
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Position = UDim2.new(0,16,0,10)
            title.Size = UDim2.new(1,-60,0,28)
            title.ZIndex = 3

            -- Alt başlık
            local sub = Instance.new("TextLabel", panel)
            sub.BackgroundTransparency = 1
            sub.Text = "Online + Offsale animation bundles"
            sub.TextColor3 = C.TEXT_DIM
            sub.Font = Enum.Font.GothamBold
            sub.TextSize = 11
            sub.TextXAlignment = Enum.TextXAlignment.Left
            sub.Position = UDim2.new(0,16,0,34)
            sub.Size = UDim2.new(1,-60,0,20)
            sub.ZIndex = 3

            -- Kapat
            local close = Instance.new("TextButton", panel)
            close.Text = "X"
            close.Font = Enum.Font.GothamBold
            close.TextSize = 12
            close.TextColor3 = C.TEXT
            close.BackgroundColor3 = C.INPUT
            close.Size = UDim2.fromOffset(32,32)
            close.Position = UDim2.new(1,-42,0,8)
            close.BorderSizePixel = 0
            close.ZIndex = 4
            Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
            close.MouseButton1Click:Connect(function() sg:Destroy() end)

            -- Arama
            local search = Instance.new("TextBox", panel)
            search.PlaceholderText = "Search bundle / ID..."
            search.Text = ""
            search.ClearTextOnFocus = false
            search.Font = Enum.Font.GothamBold
            search.TextSize = 12
            search.TextColor3 = C.TEXT
            search.PlaceholderColor3 = Color3.fromRGB(135,135,145)
            search.BackgroundColor3 = C.INPUT
            search.BorderSizePixel = 0
            search.Position = UDim2.new(0,14,0,60)
            search.Size = UDim2.new(1,-28,0,32)
            search.ZIndex = 3
            Instance.new("UICorner", search).CornerRadius = UDim.new(0, 9)
            local sst = Instance.new("UIStroke", search)
            sst.Color = C.STROKE; sst.Thickness = 1; sst.Transparency = 0.5

            -- Scroll
            local scroll = Instance.new("ScrollingFrame", panel)
            scroll.BackgroundTransparency = 1
            scroll.BorderSizePixel = 0
            scroll.Position = UDim2.new(0,10,0,102)
            scroll.Size = UDim2.new(1,-20,1,-116)
            scroll.ScrollBarThickness = 4
            scroll.ScrollBarImageColor3 = TA
            scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
            scroll.CanvasSize = UDim2.new(0,0,0,0)
            scroll.ZIndex = 3

            local grid = Instance.new("UIGridLayout", scroll)
            grid.CellSize = UDim2.fromOffset(122,145)
            grid.CellPadding = UDim2.fromOffset(8,8)
            grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
            grid.SortOrder = Enum.SortOrder.LayoutOrder

            -- Status
            local status = Instance.new("TextLabel", panel)
            status.BackgroundTransparency = 1
            status.Text = "Loading..."
            status.TextColor3 = C.TEXT_DIM
            status.Font = Enum.Font.GothamBold
            status.TextSize = 10
            status.TextXAlignment = Enum.TextXAlignment.Left
            status.Position = UDim2.new(0,16,1,-27)
            status.Size = UDim2.new(1,-32,0,20)
            status.ZIndex = 4

            local allAnimations = {}

            local function clearCards()
                for _, child in ipairs(scroll:GetChildren()) do
                    if child:IsA("GuiButton") then child:Destroy() end
                end
            end

            local function applyBundle(item)
                local char = LP.Character
                local animate = char and char:FindFirstChild("Animate")
                if not char or not animate then
                    status.Text = "ANIMATE NOT FOUND"
                    return
                end

                readOriginal(char)

                -- Bundle mapping
                local mappings = {}
                if type(item.bundledItems) == "table" then
                    for _, assetIds in pairs(item.bundledItems) do
                        if type(assetIds) == "table" then
                            for _, assetId in pairs(assetIds) do
                                local ok, objects = pcall(function()
                                    return game:GetObjects("rbxassetid://" .. tostring(assetId))
                                end)
                                if ok and objects then
                                    local function searchTree(parent, parentPath)
                                        for _, child in pairs(parent:GetChildren()) do
                                            if child:IsA("Animation") then
                                                local path = parentPath .. "." .. child.Name
                                                local parts = path:split(".")
                                                table.insert(mappings, {
                                                    category = parts[#parts - 1],
                                                    name = parts[#parts],
                                                    animationId = child.AnimationId
                                                })
                                            elseif #child:GetChildren() > 0 then
                                                searchTree(child, parentPath .. "." .. child.Name)
                                            end
                                        end
                                    end
                                    for _, obj in pairs(objects) do
                                        searchTree(obj, obj.Name)
                                        pcall(function() obj:Destroy() end)
                                    end
                                end
                            end
                        end
                    end
                end

                if #mappings == 0 then
                    status.Text = "ANIMATION DATA NOT FOUND"
                    return
                end

                for _, m in ipairs(mappings) do
                    local cat = tostring(m.category or ""):lower()
                    local name = tostring(m.name or "")
                    local folder = animate:FindFirstChild(cat)
                    if folder then
                        local target = folder:FindFirstChild(name)
                        if not target then
                            if cat == "walk" then target = folder:FindFirstChild("WalkAnim")
                            elseif cat == "run" then target = folder:FindFirstChild("RunAnim")
                            elseif cat == "jump" then target = folder:FindFirstChild("JumpAnim")
                            elseif cat == "fall" then target = folder:FindFirstChild("FallAnim")
                            elseif cat == "climb" then target = folder:FindFirstChild("ClimbAnim")
                            elseif cat == "swim" then target = folder:FindFirstChild("Swim")
                            elseif cat == "swimidle" then target = folder:FindFirstChild("SwimIdle")
                            elseif cat == "idle" then
                                target = folder:FindFirstChild(name) or folder:FindFirstChild("Animation1")
                            end
                        end
                        if target and m.animationId then target.AnimationId = tostring(m.animationId) end
                    end
                end

                pcall(function()
                    animate.Disabled = true
                    task.wait()
                    animate.Disabled = false
                end)

                A.activePack = "OFF"
                status.Text = "APPLIED - " .. tostring(item.name or item.id)
                print("[CH-ANIM] Bundle: " .. tostring(item.name or item.id))
            end

            local function addCard(item, order)
                local card = Instance.new("TextButton", scroll)
                card.Text = ""
                card.AutoButtonColor = false
                card.BackgroundColor3 = C.CARD
                card.BackgroundTransparency = 0.07
                card.BorderSizePixel = 0
                card.LayoutOrder = order
                card.ZIndex = 4
                Instance.new("UICorner", card).CornerRadius = UDim.new(0, 11)
                local cs = Instance.new("UIStroke", card)
                cs.Color = C.STROKE; cs.Thickness = 1; cs.Transparency = 0.55

                local img = Instance.new("ImageLabel", card)
                img.BackgroundColor3 = Color3.fromRGB(7,7,11)
                img.BackgroundTransparency = 0.12
                img.BorderSizePixel = 0
                img.Image = "rbxthumb://type=BundleThumbnail&id=" .. tostring(item.id) .. "&w=150&h=150"
                img.ScaleType = Enum.ScaleType.Fit
                img.Position = UDim2.new(0,7,0,7)
                img.Size = UDim2.new(1,-14,0,92)
                img.ZIndex = 5
                Instance.new("UICorner", img).CornerRadius = UDim.new(0, 8)

                local name = Instance.new("TextLabel", card)
                name.BackgroundTransparency = 1
                name.Text = tostring(item.name or ("Animation " .. tostring(item.id)))
                name.TextColor3 = C.TEXT
                name.Font = Enum.Font.GothamBold
                name.TextSize = 10
                name.TextWrapped = true
                name.TextYAlignment = Enum.TextYAlignment.Top
                name.Position = UDim2.new(0,6,0,104)
                name.Size = UDim2.new(1,-12,0,32)
                name.ZIndex = 5

                card.MouseButton1Click:Connect(function()
                    applyBundle(item)
                end)
            end

            local function render()
                clearCards()
                local q = (search.Text or ""):lower()
                local count = 0
                for _, item in ipairs(allAnimations) do
                    local match = q == "" or tostring(item.id) == q or tostring(item.name or ""):lower():find(q,1,true)
                    if match then
                        count += 1
                        addCard(item, count)
                    end
                end
                status.Text = tostring(count) .. " animation bundles"
            end

            search:GetPropertyChangedSignal("Text"):Connect(function()
                task.defer(render)
            end)

            -- Arka planda bundle listesini çek
            task.spawn(function()
                local seen = {}
                local urls = {
                    "https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniper.json",
                    "https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniperoffsale.json"
                }

                for _, url in ipairs(urls) do
                    local ok, body = pcall(function() return game:HttpGet(url) end)
                    if ok and body and body ~= "" then
                        local ok2, data = pcall(function() return HttpService:JSONDecode(body) end)
                        if ok2 and data then
                            for _, item in pairs(data.data or {}) do
                                local id = tonumber(item.id)
                                if id and id > 0 and not seen[id] and item.bundledItems then
                                    seen[id] = true
                                    table.insert(allAnimations, {
                                        id = id,
                                        name = item.name or ("Animation_" .. tostring(id)),
                                        bundledItems = item.bundledItems
                                    })
                                end
                            end
                        end
                    end
                end

                table.sort(allAnimations, function(a,b)
                    return tostring(a.name or ""):lower() < tostring(b.name or ""):lower()
                end)
                render()
            end)
        end

        b.Activated:Connect(openGallery)
    end

    _G.CyberHub.Anim = A
end

print("[CYBER HUB] DROP 11 - Animation Packs loaded 🩸")

-- ============================================================
-- CYBER HUB — DROP 12 : STRETCH REZ + GUI SCALE
-- Requires: DROP 1-9
-- ============================================================
local H = _G.CyberHub
if not H then warn("[CYBER HUB] DROP 1 once calistir!") return end

do
    local mkSect   = H.mkSect
    local mkRow    = H.mkRow
    local mkLabel  = H.mkLabel
    local TA       = H.TA
    local C        = H.C
    local TS       = H.TS
    local LP       = H.LP
    local Main     = H.Main
    local visPage  = H.Pages["Visual"]
    local setPage  = H.Pages["Settings"]

    local RunService = game:GetService("RunService")

    _G.CH_Visual = _G.CH_Visual or {}
    local V = _G.CH_Visual

    -- ========================================================
    -- STATE
    -- ========================================================
    V.stretchRez     = V.stretchRez     or false
    V.stretchConn    = V.stretchConn    or nil
    V.stretchValue   = V.stretchValue   or 0.70
    V.guiScaleValue  = V.guiScaleValue  or 1.00
    V.stealBarScale  = V.stealBarScale  or 1.00
    V.stretchPreset  = V.stretchPreset  or "Medium"

    V.STRETCH_PRESETS = {
        ["Light"]   = 0.85,
        ["Medium"]  = 0.70,
        ["Strong"]  = 0.55,
        ["Extreme"] = 0.40,
    }

    -- ========================================================
    -- STRETCH REZ (FPS Boost)
    -- ========================================================
    function V.startStretchRez()
        V.stretchRez = true
        if V.stretchConn then V.stretchConn:Disconnect(); V.stretchConn = nil end

        V.stretchConn = RunService.RenderStepped:Connect(function()
            if not V.stretchRez then
                if V.stretchConn then V.stretchConn:Disconnect(); V.stretchConn = nil end
                return
            end
            local cam = workspace.CurrentCamera
            if cam then
                local sv = V.stretchValue or 0.70
                cam.CFrame = cam.CFrame * CFrame.new(
                    0,0,0,
                    1,0,0,
                    0,sv,0,
                    0,0,1
                )
            end
        end)
    end

    function V.stopStretchRez()
        V.stretchRez = false
        if V.stretchConn then V.stretchConn:Disconnect(); V.stretchConn = nil end
    end

    function V.setStretchPreset(name)
        local v = V.STRETCH_PRESETS[name]
        if not v then return end
        V.stretchPreset = name
        V.stretchValue = v
        print("[CH-STRETCH] Preset: " .. name .. " = " .. v)
    end

    -- ========================================================
    -- GUI SCALE
    -- ========================================================
    local aceMainScale = Main:FindFirstChild("CH_MainScale")
    if not aceMainScale then
        aceMainScale = Instance.new("UIScale")
        aceMainScale.Name = "CH_MainScale"
        aceMainScale.Scale = V.guiScaleValue
        aceMainScale.Parent = Main
    end

    function V.applyGuiScale(v)
        v = tonumber(v) or 1.00
        v = math.clamp(v, 0.50, 1.50)
        V.guiScaleValue = v
        if aceMainScale then aceMainScale.Scale = v end
    end

    -- ========================================================
    -- STEALBAR SCALE
    -- ========================================================
    function V.applyStealBarScale(v)
        v = tonumber(v) or 1.00
        v = math.clamp(v, 0.50, 1.50)
        V.stealBarScale = v
        local sg = LP:WaitForChild("PlayerGui"):FindFirstChild("CH_StealBar")
        if sg then
            local bar = sg:FindFirstChild("StealBar")
            if bar then
                local sc = bar:FindFirstChild("CH_StealBarScale")
                if not sc then
                    sc = Instance.new("UIScale")
                    sc.Name = "CH_StealBarScale"
                    sc.Parent = bar
                end
                sc.Scale = v
            end
        end
    end

    -- ========================================================
    -- UI — STEPPER ROW (yardımcı)
    -- ========================================================
    local function makeStepper(parent, label, value, order, callback, minVal, maxVal, step)
        local row = mkRow(parent, 44)
        if not row then return nil end
        row.Name = "CH_Stepper_" .. label
        row.LayoutOrder = order or 0
        mkLabel(row, label)

        local val = value
        local minus = Instance.new("TextButton", row)
        minus.Size = UDim2.new(0, 28, 0, 26)
        minus.Position = UDim2.new(1, -140, 0.5, -13)
        minus.BackgroundColor3 = C.INPUT
        minus.BackgroundTransparency = 0.1
        minus.BorderSizePixel = 0
        minus.Text = "-"
        minus.TextColor3 = C.TEXT
        minus.Font = Enum.Font.GothamBold
        minus.TextSize = 14
        minus.AutoButtonColor = false
        Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 7)
        local ms = Instance.new("UIStroke", minus)
        ms.Color = C.STROKE; ms.Thickness = 1; ms.Transparency = 0.4

        local valueBox = Instance.new("TextLabel", row)
        valueBox.Name = "Value"
        valueBox.Size = UDim2.new(0, 48, 0, 26)
        valueBox.Position = UDim2.new(1, -108, 0.5, -13)
        valueBox.BackgroundColor3 = C.INPUT
        valueBox.BackgroundTransparency = 0.05
        valueBox.BorderSizePixel = 0
        valueBox.Text = string.format("%.2f", val)
        valueBox.TextColor3 = C.TEXT
        valueBox.Font = Enum.Font.GothamBold
        valueBox.TextSize = 12
        valueBox.TextXAlignment = Enum.TextXAlignment.Center
        Instance.new("UICorner", valueBox).CornerRadius = UDim.new(0, 7)
        local vs = Instance.new("UIStroke", valueBox)
        vs.Color = C.STROKE; vs.Thickness = 1; vs.Transparency = 0.4

        local plus = Instance.new("TextButton", row)
        plus.Size = UDim2.new(0, 28, 0, 26)
        plus.Position = UDim2.new(1, -56, 0.5, -13)
        plus.BackgroundColor3 = C.INPUT
        plus.BackgroundTransparency = 0.1
        plus.BorderSizePixel = 0
        plus.Text = "+"
        plus.TextColor3 = C.TEXT
        plus.Font = Enum.Font.GothamBold
        plus.TextSize = 14
        plus.AutoButtonColor = false
        Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 7)
        local ps = Instance.new("UIStroke", plus)
        ps.Color = C.STROKE; ps.Thickness = 1; ps.Transparency = 0.4

        local function setValue(newVal)
            val = math.clamp(newVal, minVal or 0.50, maxVal or 1.50)
            val = math.floor(val * 100 + 0.5) / 100
            valueBox.Text = string.format("%.2f", val)
            if callback then pcall(callback, val) end
        end

        minus.Activated:Connect(function() setValue(val - (step or 0.05)) end)
        plus.Activated:Connect(function() setValue(val + (step or 0.05)) end)

        return valueBox
    end

    -- ========================================================
    -- UI — VISUAL SEKMESİ: STRETCH REZ
    -- ========================================================
    mkSect(visPage, "PERFORMANCE")

    -- Stretch Rez Toggle
    do
        local row = mkRow(visPage, 44)
        row.Name = "CH_StretchRezRow"
        mkLabel(row, "Stretch Rez (FPS Boost)")

        local on = V.stretchRez
        local pill = Instance.new("Frame", row)
        pill.Size = UDim2.new(0, 46, 0, 24)
        pill.Position = UDim2.new(1, -56, 0.5, -12)
        pill.BackgroundColor3 = on and TA or C.INPUT
        pill.BorderSizePixel = 0
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

        local dot = Instance.new("Frame", pill)
        dot.Size = UDim2.new(0, 18, 0, 18)
        dot.Position = on and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        dot.BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        local btn = Instance.new("TextButton", pill)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Activated:Connect(function()
            if V.stretchRez then V.stopStretchRez() else V.startStretchRez() end
            local state = V.stretchRez
            TS:Create(pill, TweenInfo.new(0.18), {
                BackgroundColor3 = state and TA or C.INPUT,
            }):Play()
            TS:Create(dot, TweenInfo.new(0.18), {
                Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150),
            }):Play()
        end)
    end

    -- Stretch Preset Selector
    do
        local row = mkRow(visPage, 42)
        row.Name = "CH_StretchPresetRow"
        mkLabel(row, "Stretch Preset")

        local holder = Instance.new("Frame", row)
        holder.Size = UDim2.new(0, 180, 0, 30)
        holder.Position = UDim2.new(1, -190, 0.5, -15)
        holder.BackgroundColor3 = C.INPUT
        holder.BackgroundTransparency = 0.15
        holder.BorderSizePixel = 0
        Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

        local presetBtn = Instance.new("TextButton", holder)
        presetBtn.Size = UDim2.new(1, 0, 1, 0)
        presetBtn.BackgroundTransparency = 1
        presetBtn.Text = V.stretchPreset
        presetBtn.TextColor3 = C.TEXT
        presetBtn.Font = Enum.Font.GothamBold
        presetBtn.TextSize = 11
        presetBtn.AutoButtonColor = false

        local presetOrder = {"Light", "Medium", "Strong", "Extreme"}
        presetBtn.Activated:Connect(function()
            local idx = 1
            for i, n in ipairs(presetOrder) do
                if n == V.stretchPreset then idx = i end
            end
            idx = idx + 1
            if idx > #presetOrder then idx = 1 end
            local chosen = presetOrder[idx]
            presetBtn.Text = chosen
            V.setStretchPreset(chosen)
            print("[CH-STRETCH] " .. chosen .. " = " .. V.stretchValue)
        end)
    end

    -- ========================================================
    -- UI — SETTINGS SEKMESİ: GUI SCALE + STEALBAR SCALE
    -- ========================================================
    if setPage then
        mkSect(setPage, "UI SCALE")

        -- GUI Scale
        makeStepper(setPage, "GUI Scale", V.guiScaleValue, 100,
            function(v) V.applyGuiScale(v) end,
            0.50, 1.50, 0.05)

        -- StealBar Scale
        makeStepper(setPage, "Steal Bar Size", V.stealBarScale, 101,
            function(v) V.applyStealBarScale(v) end,
            0.50, 1.50, 0.05)
    end

    -- ========================================================
    -- AUTO SAVE ENTEGRASYONU
    -- ========================================================
    local AS = _G.CH_AutoSave
    if AS then
        local oldCollect = AS.collect
        if oldCollect then
            AS.collect = function()
                local d = oldCollect()
                if type(d) ~= "table" then d = {} end
                d.StretchRez      = V.stretchRez
                d.StretchValue    = V.stretchValue
                d.StretchPreset   = V.stretchPreset
                d.GuiScaleValue   = V.guiScaleValue
                d.StealBarScale   = V.stealBarScale
                return d
            end
        end

        local oldLoad = AS.load
        if oldLoad then
            AS.load = function()
                local ok = oldLoad()
                if not ok then return ok end
                if type(_readfile) == "function" and type(_isfile) == "function" and _isfile(AS.CONFIG_FILE) then
                    local ok2, data = pcall(function()
                        return game:GetService("HttpService"):JSONDecode(_readfile(AS.CONFIG_FILE))
                    end)
                    if ok2 and type(data) == "table" then
                        if data.GuiScaleValue then V.applyGuiScale(data.GuiScaleValue) end
                        if data.StealBarScale then V.applyStealBarScale(data.StealBarScale) end
                        if data.StretchValue then V.stretchValue = data.StretchValue end
                        if data.StretchPreset then V.stretchPreset = data.StretchPreset end
                        if data.StretchRez == true then pcall(V.startStretchRez) end
                    end
                end
                return ok
            end
        end
    end

    _G.CyberHub.Visual = V
end

print("[CYBER HUB] DROP 12 - Stretch Rez + GUI Scale loaded 🩸")
