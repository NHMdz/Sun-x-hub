local NexusLib = {}
NexusLib.__index = NexusLib

local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local Players           = game:GetService("Players")
local CoreGui           = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local LOGO_ID     = "rbxassetid://0"

local Theme = {
    Background     = Color3.fromRGB(10, 10, 16),
    Secondary      = Color3.fromRGB(16, 16, 26),
    Tertiary       = Color3.fromRGB(22, 22, 36),
    Card           = Color3.fromRGB(20, 20, 33),
    Accent         = Color3.fromRGB(99, 102, 241),
    AccentHover    = Color3.fromRGB(129, 132, 255),
    AccentDark     = Color3.fromRGB(67, 70, 180),
    Success        = Color3.fromRGB(34, 197, 94),
    Warning        = Color3.fromRGB(251, 191, 36),
    Danger         = Color3.fromRGB(239, 68, 68),
    Text           = Color3.fromRGB(235, 235, 255),
    TextDim        = Color3.fromRGB(155, 155, 195),
    TextMuted      = Color3.fromRGB(90, 90, 130),
    Border         = Color3.fromRGB(35, 35, 58),
    BorderBright   = Color3.fromRGB(65, 65, 100),
    ScrollBar      = Color3.fromRGB(55, 55, 90),
    Toggle_ON      = Color3.fromRGB(99, 102, 241),
    Toggle_OFF     = Color3.fromRGB(38, 38, 60),
    Slider_BG      = Color3.fromRGB(28, 28, 48),
    Input_BG       = Color3.fromRGB(14, 14, 24),
    Dropdown_BG    = Color3.fromRGB(14, 14, 22),
    Dropdown_Item  = Color3.fromRGB(22, 22, 36),
    Keybind_BG     = Color3.fromRGB(18, 18, 30),
    ColorPicker_BG = Color3.fromRGB(14, 14, 22),
    TabActive      = Color3.fromRGB(99, 102, 241),
    TabInactive    = Color3.fromRGB(22, 22, 36),
    TabHover       = Color3.fromRGB(30, 30, 50),
}

local function Tw(obj, props, t, style, dir)
    TweenService:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

local function Corner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 8); c.Parent = p; return c
end

local function Stroke(p, col, th, tr)
    local s = Instance.new("UIStroke"); s.Color = col or Theme.Border; s.Thickness = th or 1; s.Transparency = tr or 0; s.Parent = p; return s
end

local function Pad(p, t, b, l, r)
    local u = Instance.new("UIPadding")
    u.PaddingTop = UDim.new(0, t or 8); u.PaddingBottom = UDim.new(0, b or 8)
    u.PaddingLeft = UDim.new(0, l or 8); u.PaddingRight = UDim.new(0, r or 8)
    u.Parent = p; return u
end

local function Grad(p, keys, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(keys or {ColorSequenceKeypoint.new(0, Theme.Accent), ColorSequenceKeypoint.new(1, Theme.AccentDark)})
    g.Rotation = rot or 90; g.Parent = p; return g
end

local function Fr(parent, size, pos, col, z)
    local f = Instance.new("Frame")
    f.Size = size or UDim2.new(1,0,1,0); f.Position = pos or UDim2.new(0,0,0,0)
    f.BackgroundColor3 = col or Theme.Background; f.BorderSizePixel = 0
    f.ZIndex = z or 1; f.ClipsDescendants = false; f.Parent = parent; return f
end

local function Lbl(parent, text, sz, col, font, xa)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1; l.Text = text or ""; l.TextSize = sz or 14
    l.TextColor3 = col or Theme.Text; l.Font = font or Enum.Font.GothamBold
    l.TextXAlignment = xa or Enum.TextXAlignment.Left
    l.Size = UDim2.new(1,0,0,(sz or 14)+4); l.Parent = parent; return l
end

local function Btn(parent, text, size, pos)
    local b = Instance.new("TextButton")
    b.Size = size or UDim2.new(1,0,0,32); b.Position = pos or UDim2.new(0,0,0,0)
    b.BackgroundColor3 = Theme.Tertiary; b.TextColor3 = Theme.Text
    b.Text = text or "Button"; b.TextSize = 13; b.Font = Enum.Font.GothamBold
    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.Parent = parent; return b
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexusLibUI"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer.PlayerGui end

local VP = workspace.CurrentCamera.ViewportSize
local SW, SH = VP.X, VP.Y

local W   = math.clamp(math.floor(SW * 0.68), 660, 1080)
local H   = math.clamp(math.floor(SH * 0.72), 460, 720)
local TH  = 46
local SW2 = math.clamp(math.floor(W * 0.22), 140, 200)

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    VP = workspace.CurrentCamera.ViewportSize; SW, SH = VP.X, VP.Y
end)

local SplashHolder = Fr(ScreenGui, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Color3.new(0,0,0))
SplashHolder.BackgroundTransparency = 1; SplashHolder.ZIndex = 100

local SplashFrame = Fr(SplashHolder, UDim2.new(0,230,0,72), UDim2.new(0.5,-115,0,-90), Theme.Background, 110)
SplashFrame.ClipsDescendants = false
Corner(SplashFrame, 14); Stroke(SplashFrame, Theme.Accent, 1.5)
Grad(SplashFrame, {ColorSequenceKeypoint.new(0, Theme.Secondary), ColorSequenceKeypoint.new(1, Theme.Background)}, 135)

local SplashLogo = Instance.new("ImageLabel")
SplashLogo.Size = UDim2.new(0,44,0,44); SplashLogo.Position = UDim2.new(0,14,0.5,-22)
SplashLogo.BackgroundTransparency = 1; SplashLogo.Image = LOGO_ID; SplashLogo.ZIndex = 111; SplashLogo.Parent = SplashFrame

local SplashTitle = Lbl(SplashFrame, "NEXUS", 22, Theme.Text, Enum.Font.GothamBold, Enum.TextXAlignment.Left)
SplashTitle.Position = UDim2.new(0,68,0,9); SplashTitle.Size = UDim2.new(0,140,0,26); SplashTitle.ZIndex = 111

local SplashSub = Lbl(SplashFrame, "UI Library", 12, Theme.TextDim, Enum.Font.Gotham, Enum.TextXAlignment.Left)
SplashSub.Position = UDim2.new(0,69,0,37); SplashSub.Size = UDim2.new(0,140,0,18); SplashSub.ZIndex = 111

local SplashLine = Fr(SplashFrame, UDim2.new(0,0,0,2), UDim2.new(0,0,1,-2), Theme.Accent, 115)
Grad(SplashLine, {ColorSequenceKeypoint.new(0,Theme.Accent), ColorSequenceKeypoint.new(0.5,Theme.AccentHover), ColorSequenceKeypoint.new(1,Theme.Accent)}, 0)

local MainFrame = Fr(ScreenGui, UDim2.new(0,W,0,H), UDim2.new(0.5,-W/2,0.5,-H/2), Theme.Background)
MainFrame.Visible = false; MainFrame.ClipsDescendants = true
Corner(MainFrame, 12); Stroke(MainFrame, Theme.Border, 1)

local TitleBar = Fr(MainFrame, UDim2.new(1,0,0,TH), UDim2.new(0,0,0,0), Theme.Secondary, 5)
TitleBar.ClipsDescendants = false
Corner(TitleBar, 12)
local TitleBarFix = Fr(TitleBar, UDim2.new(1,0,0,12), UDim2.new(0,0,1,-12), Theme.Secondary, 5)
Grad(TitleBar, {ColorSequenceKeypoint.new(0,Theme.Tertiary), ColorSequenceKeypoint.new(1,Theme.Secondary)}, 90)

local TitleLogo = Instance.new("ImageLabel")
TitleLogo.Size = UDim2.new(0,28,0,28); TitleLogo.Position = UDim2.new(0,14,0.5,-14)
TitleLogo.BackgroundTransparency = 1; TitleLogo.Image = LOGO_ID; TitleLogo.ZIndex = 6; TitleLogo.Parent = TitleBar

local TitleText = Lbl(TitleBar, "NEXUS", 16, Theme.Text, Enum.Font.GothamBold)
TitleText.Position = UDim2.new(0,48,0.5,-10); TitleText.Size = UDim2.new(0,90,0,20); TitleText.ZIndex = 6

local TitleDot = Fr(TitleBar, UDim2.new(0,5,0,5), UDim2.new(0,142,0.5,-2), Theme.Accent, 6)
Corner(TitleDot, 3)

local TitleSub = Lbl(TitleBar, "UI Library", 11, Theme.TextMuted, Enum.Font.Gotham)
TitleSub.Position = UDim2.new(0,153,0.5,-7); TitleSub.Size = UDim2.new(0,80,0,14); TitleSub.ZIndex = 6

local WinBtns = Fr(TitleBar, UDim2.new(0,112,0,TH), UDim2.new(1,-118,0,0), Theme.Secondary, 6)
WinBtns.BackgroundTransparency = 1

local function WinBtn(x, icon, col)
    local b = Btn(WinBtns, icon, UDim2.new(0,32,0,28), UDim2.new(0,x,0.5,-14))
    b.BackgroundColor3 = col; b.TextSize = 14; b.ZIndex = 7; Corner(b, 7); return b
end

local ToggleBtn = WinBtn(0,  "◉", Theme.Tertiary)
local MinBtn    = WinBtn(38, "—", Theme.Tertiary)
local CloseBtn  = WinBtn(76, "✕", Color3.fromRGB(55,25,25))
ToggleBtn.TextColor3 = Theme.Accent
MinBtn.TextColor3    = Theme.TextDim
CloseBtn.TextColor3  = Theme.Danger

local TitleLine = Fr(MainFrame, UDim2.new(1,0,0,1), UDim2.new(0,0,0,TH), Theme.Border, 5)

local Sidebar = Fr(MainFrame, UDim2.new(0,SW2,1,-TH-1), UDim2.new(0,0,0,TH+1), Theme.Secondary, 4)
Grad(Sidebar, {ColorSequenceKeypoint.new(0,Theme.Tertiary), ColorSequenceKeypoint.new(1,Theme.Secondary)}, 180)

local SideVLine = Fr(MainFrame, UDim2.new(0,1,1,-TH-1), UDim2.new(0,SW2,0,TH+1), Theme.Border, 5)

local TabListScroll = Instance.new("ScrollingFrame")
TabListScroll.Size = UDim2.new(1,-10,1,-48); TabListScroll.Position = UDim2.new(0,5,0,8)
TabListScroll.BackgroundTransparency = 1; TabListScroll.BorderSizePixel = 0
TabListScroll.ScrollBarThickness = 0; TabListScroll.CanvasSize = UDim2.new(0,0,0,0)
TabListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; TabListScroll.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder; TabListLayout.Padding = UDim.new(0,3)
TabListLayout.Parent = TabListScroll

local SideFooter = Fr(Sidebar, UDim2.new(1,-12,0,26), UDim2.new(0,6,1,-32), Theme.Tertiary)
Corner(SideFooter, 6)
local VerLbl = Lbl(SideFooter, "v2.1  •  Nexus", 10, Theme.TextMuted, Enum.Font.Gotham, Enum.TextXAlignment.Center)
VerLbl.Size = UDim2.new(1,0,1,0); VerLbl.Position = UDim2.new(0,0,0,0)

local ContentArea = Fr(MainFrame, UDim2.new(1,-SW2-1,1,-TH-1), UDim2.new(0,SW2+1,0,TH+1), Theme.Background)
ContentArea.ClipsDescendants = true

local Pages      = {}
local TabButtons = {}
local ActivePage = nil

local function SetPage(page)
    for _, p in pairs(Pages) do p.Visible = false end
    for btn, pg in pairs(TabButtons) do
        local isActive = (pg == page)
        Tw(btn, {BackgroundColor3 = isActive and Theme.TabActive or Theme.TabInactive}, 0.16)
        btn.TextColor3 = isActive and Theme.Text or Theme.TextDim
        local ind = btn:FindFirstChild("Indicator")
        if ind then ind.Visible = isActive end
    end
    page.Visible = true
    ActivePage = page
end

local function NewPage()
    local s = Instance.new("ScrollingFrame")
    s.Size = UDim2.new(1,0,1,0); s.BackgroundTransparency = 1; s.BorderSizePixel = 0
    s.ScrollBarThickness = 4; s.ScrollBarImageColor3 = Theme.ScrollBar
    s.CanvasSize = UDim2.new(0,0,0,0); s.AutomaticCanvasSize = Enum.AutomaticSize.Y
    s.Visible = false; s.Parent = ContentArea
    local ll = Instance.new("UIListLayout"); ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Padding = UDim.new(0,7); ll.Parent = s
    Pad(s, 14, 14, 16, 16)
    return s
end

local function AddTab(name, icon)
    local page = NewPage()
    table.insert(Pages, page)

    local tabBtn = Btn(TabListScroll, "", UDim2.new(1,0,0,38))
    tabBtn.BackgroundColor3 = Theme.TabInactive; tabBtn.ZIndex = 5
    tabBtn.AutoButtonColor = false
    Corner(tabBtn, 8)

    local Indicator = Fr(tabBtn, UDim2.new(0,3,0,20), UDim2.new(0,0,0.5,-10), Theme.Accent, 6)
    Indicator.Name = "Indicator"; Corner(Indicator, 2); Indicator.Visible = false

    local iconLbl = Lbl(tabBtn, icon or "◈", 14, Theme.TextDim, Enum.Font.GothamBold)
    iconLbl.Position = UDim2.new(0,16,0.5,-9); iconLbl.Size = UDim2.new(0,20,0,18); iconLbl.ZIndex = 6
    iconLbl.TextXAlignment = Enum.TextXAlignment.Center

    local nameLbl = Lbl(tabBtn, name, 13, Theme.TextDim, Enum.Font.GothamBold)
    nameLbl.Position = UDim2.new(0,42,0.5,-8); nameLbl.Size = UDim2.new(1,-50,0,16); nameLbl.ZIndex = 6

    TabButtons[tabBtn] = page

    tabBtn.MouseButton1Click:Connect(function()
        SetPage(page)
    end)

    tabBtn.MouseEnter:Connect(function()
        if ActivePage ~= page then Tw(tabBtn, {BackgroundColor3 = Theme.TabHover}, 0.12) end
    end)
    tabBtn.MouseLeave:Connect(function()
        if ActivePage ~= page then Tw(tabBtn, {BackgroundColor3 = Theme.TabInactive}, 0.12) end
    end)

    if #Pages == 1 then SetPage(page) end

    local Tab = {}

    function Tab:Section(title)
        local section = {}

        local wrapper = Fr(page, UDim2.new(1,0,0,0), UDim2.new(0,0,0,0), Theme.Card)
        wrapper.AutomaticSize = Enum.AutomaticSize.Y
        Corner(wrapper, 10); Stroke(wrapper, Theme.Border, 1)

        local inner = Fr(wrapper, UDim2.new(1,0,0,0), UDim2.new(0,0,0,0), Color3.new(0,0,0))
        inner.BackgroundTransparency = 1; inner.AutomaticSize = Enum.AutomaticSize.Y
        local ll = Instance.new("UIListLayout"); ll.SortOrder = Enum.SortOrder.LayoutOrder
        ll.Padding = UDim.new(0,2); ll.Parent = inner
        Pad(inner, 6, 10, 10, 10)
        inner.Parent = wrapper

        if title then
            local head = Fr(inner, UDim2.new(1,0,0,30), UDim2.new(0,0,0,0), Theme.Tertiary)
            head.AutomaticSize = Enum.AutomaticSize.None; Corner(head, 7)
            local hl = Lbl(head, title, 11, Theme.Accent, Enum.Font.GothamBold)
            hl.Position = UDim2.new(0,10,0.5,-7); hl.Size = UDim2.new(1,-20,0,14)
            local hline = Fr(head, UDim2.new(0,0,0,2), UDim2.new(0,0,1,-2), Theme.Accent)
            Grad(hline, {ColorSequenceKeypoint.new(0,Theme.Accent), ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}, 0)
            hline.BackgroundTransparency = 0.5
        end

        local function Row(h)
            local r = Fr(inner, UDim2.new(1,0,0,h or 38), UDim2.new(0,0,0,0), Theme.Tertiary)
            r.AutomaticSize = Enum.AutomaticSize.None; Corner(r, 8); return r
        end

        function section:Button(c)
            c = c or {}
            local row = Row(38)
            local nl = Lbl(row, c.Name or "Button", 13, Theme.Text, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0.5,-8); nl.Size = UDim2.new(0.55,0,0,16); nl.TextYAlignment = Enum.TextYAlignment.Center

            local eb = Btn(row, c.Label or "Run", UDim2.new(0,76,0,26), UDim2.new(1,-86,0.5,-13))
            eb.BackgroundColor3 = Theme.Accent; Corner(eb, 7)
            eb.MouseEnter:Connect(function() Tw(eb, {BackgroundColor3 = Theme.AccentHover}, 0.1) end)
            eb.MouseLeave:Connect(function() Tw(eb, {BackgroundColor3 = Theme.Accent}, 0.1) end)
            eb.MouseButton1Click:Connect(function()
                Tw(eb, {BackgroundColor3 = Theme.AccentDark}, 0.06)
                task.delay(0.1, function() Tw(eb, {BackgroundColor3 = Theme.Accent}, 0.1) end)
                if c.Callback then c.Callback() end
            end)
        end

        function section:Toggle(c)
            c = c or {}
            local val = c.Default or false
            local row = Row(38)
            local nl = Lbl(row, c.Name or "Toggle", 13, Theme.Text, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0.5,-8); nl.Size = UDim2.new(0.65,0,0,16); nl.TextYAlignment = Enum.TextYAlignment.Center

            local track = Fr(row, UDim2.new(0,44,0,24), UDim2.new(1,-56,0.5,-12), val and Theme.Toggle_ON or Theme.Toggle_OFF)
            Corner(track, 12)
            local knob = Fr(track, UDim2.new(0,18,0,18), UDim2.new(0,val and 23 or 3,0.5,-9), Color3.new(1,1,1))
            Corner(knob, 9)

            local function Set(v)
                val = v
                Tw(track, {BackgroundColor3 = v and Theme.Toggle_ON or Theme.Toggle_OFF}, 0.18)
                Tw(knob,  {Position = UDim2.new(0, v and 23 or 3, 0.5, -9)}, 0.18)
                if c.Callback then c.Callback(v) end
            end

            track.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Set(not val) end end)
            row.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Set(not val) end end)

            local ctrl = {}; function ctrl:Set(v) Set(v) end; function ctrl:Get() return val end; return ctrl
        end

        function section:Slider(c)
            c = c or {}
            local min, max, val = c.Min or 0, c.Max or 100, c.Default or (c.Min or 0)
            local suf = c.Suffix or ""

            local wrapper2 = Fr(inner, UDim2.new(1,0,0,58), UDim2.new(0,0,0,0), Theme.Tertiary)
            wrapper2.AutomaticSize = Enum.AutomaticSize.None; Corner(wrapper2, 8)

            local top = Fr(wrapper2, UDim2.new(1,-24,0,20), UDim2.new(0,12,0,7), Color3.new(0,0,0))
            top.BackgroundTransparency = 1
            local nl = Lbl(top, c.Name or "Slider", 13, Theme.Text, Enum.Font.GothamBold); nl.Size = UDim2.new(0.7,0,1,0)
            local vl = Lbl(top, tostring(val)..suf, 12, Theme.Accent, Enum.Font.GothamBold, Enum.TextXAlignment.Right)
            vl.Size = UDim2.new(0.3,0,1,0); vl.Position = UDim2.new(0.7,0,0,0)

            local track = Fr(wrapper2, UDim2.new(1,-24,0,6), UDim2.new(0,12,0,38), Theme.Slider_BG)
            Corner(track, 3)
            local fill = Fr(track, UDim2.new((val-min)/(max-min),0,1,0), UDim2.new(0,0,0,0), Theme.Accent)
            Corner(fill, 3)
            Grad(fill, {ColorSequenceKeypoint.new(0,Theme.Accent), ColorSequenceKeypoint.new(1,Theme.AccentHover)}, 0)
            local knob = Fr(fill, UDim2.new(0,14,0,14), UDim2.new(1,-7,0.5,-7), Color3.new(1,1,1))
            Corner(knob, 7); Stroke(knob, Theme.Accent, 2)

            local drag = false
            local function Upd(x)
                local r = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                val = math.floor(min + (max-min)*r)
                Tw(fill, {Size = UDim2.new(r,0,1,0)}, 0.05)
                vl.Text = tostring(val)..suf
                if c.Callback then c.Callback(val) end
            end

            track.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true; Upd(i.Position.X) end end)
            UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then Upd(i.Position.X) end end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)

            local ctrl = {}; function ctrl:Get() return val end; function ctrl:Set(v) Upd(track.AbsolutePosition.X + (v-min)/(max-min)*track.AbsoluteSize.X) end; return ctrl
        end

        function section:Dropdown(c)
            c = c or {}
            local items, sel, open = c.Items or {}, c.Default or (c.Items and c.Items[1] or "Select..."), false

            local row = Row(38)
            row.ClipsDescendants = false
            local nl = Lbl(row, c.Name or "Dropdown", 13, Theme.Text, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0.5,-8); nl.Size = UDim2.new(0.48,0,0,16); nl.TextYAlignment = Enum.TextYAlignment.Center

            local selBtn = Btn(row, sel.." ▾", UDim2.new(0,148,0,28), UDim2.new(1,-158,0.5,-14))
            selBtn.BackgroundColor3 = Theme.Dropdown_BG; selBtn.TextSize = 12; selBtn.ZIndex = 8
            selBtn.TextXAlignment = Enum.TextXAlignment.Center; Corner(selBtn, 7); Stroke(selBtn, Theme.Border)

            local dList = Fr(row, UDim2.new(0,148,0,0), UDim2.new(1,-158,1,4), Theme.Dropdown_BG)
            dList.ClipsDescendants = true; dList.ZIndex = 30; Corner(dList, 7); Stroke(dList, Theme.Border)
            local dll = Instance.new("UIListLayout"); dll.SortOrder = Enum.SortOrder.LayoutOrder; dll.Padding = UDim.new(0,2); dll.Parent = dList
            Pad(dList, 4, 4, 4, 4)

            local function Rebuild()
                for _, ch in ipairs(dList:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
                for _, item in ipairs(items) do
                    local ib = Btn(dList, item, UDim2.new(1,0,0,28))
                    ib.BackgroundColor3 = Theme.Dropdown_Item; ib.TextSize = 12; ib.ZIndex = 31
                    ib.TextXAlignment = Enum.TextXAlignment.Left; Corner(ib, 6); Pad(ib,0,0,8,4)
                    ib.MouseEnter:Connect(function() Tw(ib,{BackgroundColor3=Theme.Tertiary},0.1) end)
                    ib.MouseLeave:Connect(function() Tw(ib,{BackgroundColor3=Theme.Dropdown_Item},0.1) end)
                    ib.MouseButton1Click:Connect(function()
                        sel = item; selBtn.Text = sel.." ▾"; open = false
                        Tw(dList, {Size = UDim2.new(0,148,0,0)}, 0.14)
                        if c.Callback then c.Callback(sel) end
                    end)
                end
            end
            Rebuild()

            selBtn.MouseButton1Click:Connect(function()
                open = not open
                Tw(dList, {Size = UDim2.new(0,148,0, open and math.min(#items*34+8,172) or 0)}, 0.18)
            end)

            local ctrl = {}
            function ctrl:Get() return sel end
            function ctrl:Set(v) sel = v; selBtn.Text = v.." ▾" end
            function ctrl:Refresh(ni) items = ni; Rebuild() end
            return ctrl
        end

        function section:Input(c)
            c = c or {}
            local val = c.Default or ""

            local wrapper2 = Fr(inner, UDim2.new(1,0,0,58), UDim2.new(0,0,0,0), Theme.Tertiary)
            wrapper2.AutomaticSize = Enum.AutomaticSize.None; Corner(wrapper2, 8)

            local nl = Lbl(wrapper2, c.Name or "Input", 12, Theme.TextDim, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0,5); nl.Size = UDim2.new(1,-24,0,14)

            local box = Instance.new("TextBox")
            box.Size = UDim2.new(1,-24,0,28); box.Position = UDim2.new(0,12,0,24)
            box.BackgroundColor3 = Theme.Input_BG; box.TextColor3 = Theme.Text
            box.PlaceholderText = c.Placeholder or "Type here..."; box.PlaceholderColor3 = Theme.TextMuted
            box.Text = val; box.TextSize = 13; box.Font = Enum.Font.Gotham; box.BorderSizePixel = 0
            box.ClearTextOnFocus = c.ClearOnFocus or false; box.Parent = wrapper2
            Corner(box, 7); local bstroke = Stroke(box, Theme.Border); Pad(box,0,0,10,8)

            box.Focused:Connect(function() bstroke.Color = Theme.Accent end)
            box.FocusLost:Connect(function(enter)
                bstroke.Color = Theme.Border; val = box.Text
                if c.Callback then c.Callback(val, enter) end
            end)

            local ctrl = {}; function ctrl:Get() return box.Text end; function ctrl:Set(v) box.Text = v end; return ctrl
        end

        function section:ColorPicker(c)
            c = c or {}
            local val = c.Default or Color3.fromRGB(255,255,255)
            local h, s, v2 = Color3.toHSV(val)
            local open = false

            local row = Row(38); row.ClipsDescendants = false
            local nl = Lbl(row, c.Name or "Color", 13, Theme.Text, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0.5,-8); nl.Size = UDim2.new(0.65,0,0,16); nl.TextYAlignment = Enum.TextYAlignment.Center

            local preview = Fr(row, UDim2.new(0,28,0,28), UDim2.new(1,-40,0.5,-14), val)
            Corner(preview, 7); Stroke(preview, Theme.Border)

            local picker = Fr(row, UDim2.new(0,210,0,0), UDim2.new(1,-220,1,4), Theme.ColorPicker_BG)
            picker.ClipsDescendants = true; picker.ZIndex = 30; Corner(picker, 8); Stroke(picker, Theme.Border)

            local function UpdColor()
                val = Color3.fromHSV(h, s, v2); preview.BackgroundColor3 = val
                if c.Callback then c.Callback(val) end
            end

            local hBar = Fr(picker, UDim2.new(1,-16,0,14), UDim2.new(0,8,0,8), Color3.new(1,1,1))
            hBar.ZIndex = 31; Corner(hBar, 3)
            Grad(hBar, {
                ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)), ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),
                ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)), ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,255,255)),
                ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)), ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),
                ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))
            }, 0)
            local hKnob = Fr(hBar, UDim2.new(0,4,1,6), UDim2.new(h,-2,0,-3), Color3.new(1,1,1))
            hKnob.ZIndex = 32; Corner(hKnob, 2); Stroke(hKnob, Theme.Background, 1)

            local svF = Fr(picker, UDim2.new(1,-16,0,82), UDim2.new(0,8,0,28), Color3.fromHSV(h,1,1))
            svF.ZIndex = 31; Corner(svF, 5)
            local svK = Fr(svF, UDim2.new(0,12,0,12), UDim2.new(s,-6,1-v2,-6), Color3.new(1,1,1))
            svK.ZIndex = 32; Corner(svK, 6); Stroke(svK, Theme.Background, 1)

            local dragH, dragS = false, false
            hBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragH = true; h = math.clamp((i.Position.X-hBar.AbsolutePosition.X)/hBar.AbsoluteSize.X,0,1); hKnob.Position = UDim2.new(h,-2,0,-3); svF.BackgroundColor3 = Color3.fromHSV(h,1,1); UpdColor() end end)
            svF.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragS = true; s = math.clamp((i.Position.X-svF.AbsolutePosition.X)/svF.AbsoluteSize.X,0,1); v2 = 1-math.clamp((i.Position.Y-svF.AbsolutePosition.Y)/svF.AbsoluteSize.Y,0,1); svK.Position = UDim2.new(s,-6,1-v2,-6); UpdColor() end end)
            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType ~= Enum.UserInputType.MouseMovement then return end
                if dragH then h = math.clamp((i.Position.X-hBar.AbsolutePosition.X)/hBar.AbsoluteSize.X,0,1); hKnob.Position = UDim2.new(h,-2,0,-3); svF.BackgroundColor3 = Color3.fromHSV(h,1,1); UpdColor() end
                if dragS then s = math.clamp((i.Position.X-svF.AbsolutePosition.X)/svF.AbsoluteSize.X,0,1); v2 = 1-math.clamp((i.Position.Y-svF.AbsolutePosition.Y)/svF.AbsoluteSize.Y,0,1); svK.Position = UDim2.new(s,-6,1-v2,-6); UpdColor() end
            end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragH = false; dragS = false end end)

            preview.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    open = not open; Tw(picker, {Size = UDim2.new(0,210,0,open and 122 or 0)}, 0.18)
                end
            end)

            local ctrl = {}; function ctrl:Get() return val end; function ctrl:Set(col) val = col; h,s,v2 = Color3.toHSV(col); preview.BackgroundColor3 = col end; return ctrl
        end

        function section:Keybind(c)
            c = c or {}
            local key, listen = c.Default or Enum.KeyCode.Unknown, false

            local row = Row(38)
            local nl = Lbl(row, c.Name or "Keybind", 13, Theme.Text, Enum.Font.GothamBold)
            nl.Position = UDim2.new(0,12,0.5,-8); nl.Size = UDim2.new(0.55,0,0,16); nl.TextYAlignment = Enum.TextYAlignment.Center

            local kb = Btn(row, key.Name, UDim2.new(0,96,0,26), UDim2.new(1,-106,0.5,-13))
            kb.BackgroundColor3 = Theme.Keybind_BG; kb.TextSize = 12; kb.Font = Enum.Font.GothamBold
            Corner(kb, 7); Stroke(kb, Theme.Border)

            kb.MouseButton1Click:Connect(function() listen = true; kb.Text = "..."; kb.TextColor3 = Theme.Accent end)
            UserInputService.InputBegan:Connect(function(i, gpe)
                if gpe then return end
                if listen and i.UserInputType == Enum.UserInputType.Keyboard then
                    key = i.KeyCode; kb.Text = key.Name; kb.TextColor3 = Theme.Text; listen = false
                    if c.Callback then c.Callback(key) end
                end
            end)

            local ctrl = {}; function ctrl:Get() return key end; function ctrl:Set(k) key = k; kb.Text = k.Name end; return ctrl
        end

        function section:Label(c)
            c = c or {}
            local r = Fr(inner, UDim2.new(1,0,0,28), UDim2.new(0,0,0,0), Color3.new(0,0,0))
            r.BackgroundTransparency = 1
            local l = Lbl(r, c.Text or "Label", c.Size or 12, c.Color or Theme.TextDim, Enum.Font.Gotham)
            l.Position = UDim2.new(0,8,0.5,-8); l.Size = UDim2.new(1,-16,0,16); l.TextYAlignment = Enum.TextYAlignment.Center
            local ctrl = {}; function ctrl:Set(t) l.Text = t end; function ctrl:Get() return l.Text end; return ctrl
        end

        function section:Separator()
            local r = Fr(inner, UDim2.new(1,0,0,10), UDim2.new(0,0,0,0), Color3.new(0,0,0))
            r.BackgroundTransparency = 1
            Fr(r, UDim2.new(1,-20,0,1), UDim2.new(0,10,0.5,0), Theme.Border)
        end

        return section
    end

    return Tab
end

local function Notify(text, ntype)
    local colors = {info=Theme.Accent, success=Theme.Success, warning=Theme.Warning, error=Theme.Danger}
    local col = colors[ntype or "info"] or Theme.Accent

    local n = Fr(ScreenGui, UDim2.new(0,270,0,54), UDim2.new(1,-280,1,64), Theme.Secondary)
    n.ZIndex = 200; Corner(n, 10); Stroke(n, col, 1.5)

    local bar = Fr(n, UDim2.new(0,3,1,0), UDim2.new(0,0,0,0), col)
    bar.ZIndex = 201; Corner(bar, 3)

    local msg = Lbl(n, text or "", 13, Theme.Text, Enum.Font.GothamBold)
    msg.Position = UDim2.new(0,14,0.5,-9); msg.Size = UDim2.new(1,-20,0,18)
    msg.TextYAlignment = Enum.TextYAlignment.Center; msg.ZIndex = 202; msg.TextWrapped = true

    Tw(n, {Position = UDim2.new(1,-280,1,-66)}, 0.28, Enum.EasingStyle.Back)
    task.delay(3.2, function()
        Tw(n, {Position = UDim2.new(1,10,1,-66)}, 0.24)
        task.delay(0.28, function() n:Destroy() end)
    end)
end

NexusLib.Notify = Notify

local dragging, dragPos, dragFrame = false, nil, nil
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragPos = i.Position; dragFrame = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragPos
        MainFrame.Position = UDim2.new(dragFrame.X.Scale, dragFrame.X.Offset+d.X, dragFrame.Y.Scale, dragFrame.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local minimized = false
local savedH    = H

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        savedH = MainFrame.AbsoluteSize.Y
        ContentArea.Visible = false; Sidebar.Visible = false
        SideVLine.Visible = false; TitleLine.Visible = false
        Tw(MainFrame, {Size = UDim2.new(0, W, 0, TH)}, 0.22, Enum.EasingStyle.Quart)
        MinBtn.Text = "▢"
    else
        Tw(MainFrame, {Size = UDim2.new(0, W, 0, savedH)}, 0.28, Enum.EasingStyle.Back)
        task.delay(0.18, function()
            ContentArea.Visible = true; Sidebar.Visible = true
            SideVLine.Visible = true; TitleLine.Visible = true
        end)
        MinBtn.Text = "—"
    end
end)

local uiVisible = true
ToggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    if uiVisible then
        MainFrame.Visible = true
        Tw(MainFrame, {Size = UDim2.new(0,W,0,minimized and TH or savedH)}, 0.28, Enum.EasingStyle.Back)
        ToggleBtn.TextColor3 = Theme.Accent
    else
        local curH = MainFrame.AbsoluteSize.Y
        savedH = minimized and savedH or curH
        Tw(MainFrame, {Size = UDim2.new(0,W,0,0)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.delay(0.24, function() MainFrame.Visible = false end)
        ToggleBtn.TextColor3 = Theme.TextMuted
    end
end)

CloseBtn.MouseEnter:Connect(function() Tw(CloseBtn, {BackgroundColor3 = Color3.fromRGB(80,25,25)}, 0.1) end)
CloseBtn.MouseLeave:Connect(function() Tw(CloseBtn, {BackgroundColor3 = Color3.fromRGB(55,25,25)}, 0.1) end)
CloseBtn.MouseButton1Click:Connect(function()
    Tw(MainFrame, {Size = UDim2.new(0,W,0,0)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    task.delay(0.26, function() ScreenGui:Destroy() end)
end)

UserInputService.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.KeyCode == Enum.KeyCode.RightControl then
        ToggleBtn.MouseButton1Click:Fire()
    end
end)

local function PlayIntro()
    Tw(SplashFrame, {Position = UDim2.new(0.5,-115,0.5,-36)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    task.delay(0.55, function() Tw(SplashLine, {Size = UDim2.new(1,0,0,2)}, 0.4) end)

    task.delay(2.1, function()
        local lf = Fr(SplashHolder, UDim2.new(0,230,0,72), UDim2.new(0.5,-115,0.5,-36), Theme.Background)
        lf.ZIndex = 112; Corner(lf,14); Stroke(lf,Theme.Accent,1.5)
        local rf = Fr(SplashHolder, UDim2.new(0,0,0,72), UDim2.new(0.5,-115,0.5,-36), Theme.Background)
        rf.ZIndex = 112; Corner(rf,14); Stroke(rf,Theme.Accent,1.5)

        SplashFrame.BackgroundTransparency = 1
        SplashLogo.Parent = nil; SplashTitle.Parent = nil; SplashSub.Parent = nil; SplashLine.Parent = nil

        Tw(lf, {Position = UDim2.new(0.5,-420,0.5,-36), Size = UDim2.new(0,270,0,72)}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        Tw(rf, {Position = UDim2.new(0.5,120, 0.5,-36), Size = UDim2.new(0,270,0,72)}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In)

        task.delay(0.5, function()
            SplashHolder:Destroy()
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0,W,0,0)
            Tw(MainFrame, {Size = UDim2.new(0,W,0,H)}, 0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end)
    end)
end

PlayIntro()

NexusLib.AddTab   = AddTab
NexusLib.Notify   = Notify
NexusLib.Destroy  = function() ScreenGui:Destroy() end
NexusLib.Toggle   = function() ToggleBtn.MouseButton1Click:Fire() end
NexusLib.SetTitle = function(t) TitleText.Text = t end
NexusLib.SetLogo  = function(id) TitleLogo.Image = id; SplashLogo.Image = id end
NexusLib.SetTheme = function(t) for k,v in pairs(t) do if Theme[k] then Theme[k]=v end end end
NexusLib.GetTheme = function() return Theme end

return NexusLib
