

repeat
    task.wait()
until game:IsLoaded()

local vu1 = {}
local vu2 = false

vu1.currentTab = nil
vu1.flags = {}

local vu4 = setmetatable({}, {
    __index = function(_, p3)
        return game.GetService(game, p3)
    end,
})
local vu5 = vu4.Players.LocalPlayer:GetMouse()

local function vu13(p6, p7, p8, p9, p10)
    local v11 = TweenInfo.new(p7, Enum.EasingStyle[p8], Enum.EasingDirection[p9])
    local v12 = vu4.TweenService:Create(p6, v11, p10)

    v12:Play()

    return v12
end

function Tween(p14, p15, p16)
    return vu13(p14, p15[1], p15[2], p15[3], p16)
end

local function vu19(p17)
    if p17.ClipsDescendants ~= true then
        p17.ClipsDescendants = true
    end

    local v18 = Instance.new('ImageLabel')

    v18.Name = 'Ripple'
    v18.Parent = p17
    v18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v18.BackgroundTransparency = 1
    v18.ZIndex = 8
    v18.Image = 'rbxassetid://2708891598'
    v18.ImageTransparency = 0.8
    v18.ScaleType = Enum.ScaleType.Fit
    v18.ImageColor3 = Color3.fromRGB(255, 255, 255)
    v18.Position = UDim2.new((vu5.X - v18.AbsolutePosition.X) / p17.AbsoluteSize.X, 0, (vu5.Y - v18.AbsolutePosition.Y) / p17.AbsoluteSize.Y, 0)

    return v18
end

function Ripple(pu20)
    spawn(function()
        local v21 = vu19(pu20)

        Tween(v21, {
            0.3,
            'Linear',
            'InOut',
        }, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0),
        })
        Tween(pu20, {
            0.1,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(1.1, 0, 1.1, 0),
        })
        wait(0.15)
        Tween(v21, {
            0.3,
            'Linear',
            'InOut',
        }, {ImageTransparency = 1})
        Tween(pu20, {
            0.1,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(1, 0, 1, 0),
        })
        wait(0.3)
        v21:Destroy()
    end)
end

local vu22 = false
local vu23 = false

local function vu26(p24, p25)
    vu4.TweenService:Create(p24, TweenInfo.new(0.1), {ImageTransparency = p25}):Play()
    vu4.TweenService:Create(p24.TabText, TweenInfo.new(0.1), {TextTransparency = p25}):Play()
end

function switchTab(p27)
    local vu28 = Instance.new('Frame')

    vu28.Parent = p27[1]
    vu28.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    vu28.BackgroundTransparency = 0.7
    vu28.Size = UDim2.new(0, 0, 0, 0)
    vu28.Position = UDim2.new(0.5, 0, 0.5, 0)
    vu28.AnchorPoint = Vector2.new(0.5, 0.5)
    vu28.ZIndex = 10

    game:GetService('TweenService'):Create(vu28, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()
    spawn(function()
        wait(0.5)
        vu28:Destroy()
    end)

    if vu23 then
        return
    else
        local v29 = vu1.currentTab

        if v29 == nil then
            p27[2].Visible = true
            vu1.currentTab = p27

            vu26(p27[1], 0)

            return
        elseif v29[1] ~= p27[1] then
            vu23 = true
            vu1.currentTab = p27

            vu26(v29[1], 0.2)
            vu26(p27[1], 0)

            v29[2].Visible = false
            p27[2].Visible = true

            task.wait(0.1)

            vu23 = false
        end
    end
end
function drag(pu30, p31)
    local vu32 = nil
    local vu33 = nil
    local vu34 = nil
    local vu35 = nil

    local function vu38(p36)
        local v37 = p36.Position - vu34

        pu30.Position = UDim2.new(vu35.X.Scale, vu35.X.Offset + v37.X, vu35.Y.Scale, vu35.Y.Offset + v37.Y)
    end

    (p31 or pu30).InputBegan:Connect(function(pu39)
        if pu39.UserInputType == Enum.UserInputType.MouseButton1 then
            vu32 = true
            vu34 = pu39.Position
            vu35 = pu30.Position

            pu39.Changed:Connect(function()
                if pu39.UserInputState == Enum.UserInputState.End then
                    vu32 = false
                end
            end)
        end
    end)
    pu30.InputChanged:Connect(function(p40)
        if p40.UserInputType == Enum.UserInputType.MouseMovement then
            vu33 = p40
        end
    end)
    vu4.UserInputService.InputChanged:Connect(function(p41)
        if p41 == vu33 and vu32 then
            vu38(p41)
        end
    end)
end
function vu1.new(pu42, p43, _)
    local v44 = next
    local v45, v46 = vu4.CoreGui:GetChildren()

    while true do
        local v47

        v46, v47 = v44(v45, v46)

        if v46 == nil then
            break
        end
        if v47.Name == 'Linni' then
            v47:Destroy()
        end
    end

    MainXEColor = Color3.fromRGB(20, 20, 30)
    Background = Color3.fromRGB(40, 40, 60)
    zyColor = Color3.fromRGB(30, 30, 45)
    beijingColor = Color3.fromRGB(50, 50, 70)

    local vu48 = Instance.new('ScreenGui')
    local vu49 = Instance.new('Frame')
    local v50 = Instance.new('UICorner')
    local v51 = Instance.new('Frame')
    local v52 = Instance.new('UICorner')
    local v53 = Instance.new('Frame')
    local v54 = Instance.new('UIGradient')
    local vu55 = Instance.new('ScrollingFrame')
    local vu56 = Instance.new('UIListLayout')
    local vu57 = Instance.new('TextLabel')
    local v58 = Instance.new('UIGradient')
    local vu59 = Instance.new('TextButton')
    local v60 = Instance.new('UIGradient')
    local v61 = Instance.new('Frame')
    local vu62 = Instance.new('ImageLabel')
    local v63 = Instance.new('UICorner')
    local v64 = Instance.new('UIGradient')
    local v65 = Instance.new('UIGradient')
    local v66 = Instance.new('TextLabel')

    if syn and syn.protect_gui then
        syn.protect_gui(vu48)
    end

    vu48.Name = 'Linni'
    vu48.Parent = vu4.CoreGui

    function UiDestroy()
        vu48:Destroy()
    end
    function ToggleUILib()
        if vu2 then
            vu2 = false
            vu48.Enabled = true
        else
            vu48.Enabled = false
            vu2 = true
        end
    end

    local vu67 = {
        ['zh-cn'] = {
            WelcomeUI = '\u{6b22}\u{8fce}\u{4f7f}\u{7528}\u{9716}\u{6eba}\u{811a}\u{672c}',
            OpenUI = '\u{6253}\u{5f00}UI',
            HideUI = '\u{9690}\u{85cf}UI',
            Currently = '\u{5f53}\u{524d}\u{ff1a}',
        },
    }
    local v68 = game:GetService('Players').LocalPlayer
    local v69 = game:GetService('LocalizationService'):GetCountryRegionForPlayerAsync(v68)
    local v70 = {
        CN = 'zh-cn',
    }
    local vu71 = vu67[v70[v69] ] and v70[v69] or 'zh-cn'
    local vu81 = (function(p72, p73, p74, p75, p76, p77, p78, p79)
        local v80 = Instance.new('Frame')

        v80.Name = p72
        v80.Parent = p73
        v80.AnchorPoint = p74
        v80.Position = p75
        v80.Size = p76
        v80.BackgroundColor3 = p77
        v80.ZIndex = p78
        v80.Active = true
        v80.Draggable = p79
        v80.Visible = true

        return v80
    end)('MainXE', vu48, Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), MainXEColor, 1, true)
    local v82 = vu4.Players.LocalPlayer:GetMouse().ViewSizeX

    vu81.Size = UDim2.new(0, math.clamp(v82 * 0.8, 500, 800), 0, math.clamp(v82 * 0.6, 400, 600))

    local v83 = Instance.new('Frame')

    v83.Name = 'NeonBorder'
    v83.Parent = vu81
    v83.BackgroundTransparency = 1
    v83.Size = UDim2.new(1, 10, 1, 10)
    v83.Position = UDim2.new(0, -5, 0, -5)
    v83.ZIndex = 0

    local v84 = Instance.new('UIGradient')

    v84.Parent = v83
    v84.Rotation = 45
    v84.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
    })

    game:GetService('TweenService'):Create(v84, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()

    local v85 = Instance.new('UIStroke')

    v85.Parent = vu81
    v85.Thickness = 3
    v85.Color = Color3.fromRGB(0, 255, 255)
    v85.Transparency = 0.5
    v85.LineJoinMode = Enum.LineJoinMode.Round

    local v86 = Instance.new('Frame')

    v86.Name = 'DynamicBG'
    v86.Parent = vu81
    v86.BackgroundColor3 = MainXEColor
    v86.BackgroundTransparency = 0.7
    v86.Size = UDim2.new(1, 0, 1, 0)
    v86.ZIndex = -1

    for v87 = 0, 1, 0.1 do
        local v88 = v87
        local v89 = Instance.new('Frame')

        v89.Name = 'GridLine_H_' .. v88
        v89.Parent = v86
        v89.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        v89.BorderSizePixel = 0
        v89.Size = UDim2.new(1, 0, 0, 1)
        v89.Position = UDim2.new(0, 0, v88, 0)
        v89.ZIndex = 0
    end

    local vu90 = Instance.new('Frame')

    vu90.Name = 'ScanDot'
    vu90.Parent = v86
    vu90.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    vu90.Size = UDim2.new(0, 6, 0, 6)
    vu90.Position = UDim2.new(0, 0, 0, 0)
    vu90.ZIndex = 2

    spawn(function()
        while true do
            game:GetService('TweenService'):Create(vu90, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 0, 0),
            }):Play()
            wait(2)
            game:GetService('TweenService'):Create(vu90, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 1, -6),
            }):Play()
            wait(1)
            game:GetService('TweenService'):Create(vu90, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, 0, 0, 0),
            }):Play()
            wait(1)
        end
    end)

    v66.Name = 'WelcomeLabel'
    v66.Parent = vu81
    v66.AnchorPoint = Vector2.new(0.5, 0.5)
    v66.Position = UDim2.new(0.5, 0, 0.5, 0)
    v66.Size = UDim2.new(1, 0, 1, 0)
    v66.Text = vu67[vu71].WelcomeUI
    v66.TextColor3 = Color3.fromRGB(255, 255, 255)
    v66.TextSize = 32
    v66.BackgroundTransparency = 1
    v66.TextTransparency = 1
    v66.TextStrokeTransparency = 0.5
    v66.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    v66.Font = Enum.Font.GothamBold
    v66.Visible = true
    v63.Parent = vu81
    v63.CornerRadius = UDim.new(0, 3)

    local vu91 = Instance.new('TextButton')

    vu91.Name = 'CloseButton'
    vu91.Parent = vu81
    vu91.AnchorPoint = Vector2.new(1, 0)
    vu91.Position = UDim2.new(1, -5, 0, 5)
    vu91.Size = UDim2.new(0, 25, 0, 25)
    vu91.BackgroundTransparency = 1
    vu91.Text = '\u{274c}'
    vu91.TextColor3 = Color3.fromRGB(255, 255, 255)
    vu91.TextSize = 20
    vu91.Font = Enum.Font.GothamBold
    vu91.ZIndex = 10

    vu91.MouseEnter:Connect(function()
        TweenService:Create(vu91, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 50, 50),
        }):Play()
    end)
    vu91.MouseLeave:Connect(function()
        TweenService:Create(vu91, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
    vu91.MouseButton1Click:Connect(function()
        vu48:Destroy()
    end)

    v61.Name = 'DropShadowHolder'
    v61.Parent = vu81
    v61.BackgroundTransparency = 1
    v61.BorderSizePixel = 0
    v61.Size = UDim2.new(1, 0, 1, 0)
    v61.BorderColor3 = Color3.fromRGB(255, 255, 255)
    v61.ZIndex = 0
    vu62.Name = 'DropShadow'
    vu62.Parent = v61
    vu62.AnchorPoint = Vector2.new(0.5, 0.5)
    vu62.BackgroundTransparency = 1
    vu62.BorderSizePixel = 0
    vu62.Position = UDim2.new(0.5, 0, 0.5, 0)

    vu81:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
        vu62.Size = UDim2.new(1, 50, 1, 50)
    end)

    vu62.ZIndex = 0
    vu62.Image = 'rbxassetid://6015897843'
    vu62.ImageColor3 = Color3.fromRGB(255, 255, 255)
    vu62.ImageTransparency = 0.2
    vu62.Size = UDim2.new(1, 43, 1, 43)
    vu62.ZIndex = 0
    vu62.Image = 'rbxassetid://6015897843'
    vu62.ImageColor3 = Color3.fromRGB(255, 255, 255)
    vu62.ImageTransparency = 0
    vu62.ScaleType = Enum.ScaleType.Slice
    vu62.SliceCenter = Rect.new(49, 49, 450, 450)
    v64.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })
    v64.Parent = vu62

    game:GetService('TweenService'):Create(v64, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {
        Rotation = 360,
        Offset = Vector2.new(1, 0),
    }):Play()

    function toggleui()
        vu22 = not vu22

        spawn(function()
            if vu22 then
                wait(0.3)
            end
        end)
        Tween(vu81, {
            0.3,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(0, 609, 0, vu22 and 505 or 0),
        })
    end

    vu49.Name = 'TabMainXE'
    vu49.Parent = vu81
    vu49.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vu49.BackgroundTransparency = 1
    vu49.Position = UDim2.new(0.217000037, 0, 0, 3)
    vu49.Size = UDim2.new(0, 448, 0, 353)
    vu49.Visible = false
    v50.CornerRadius = UDim.new(0, 5.5)
    v50.Name = 'MainXEC'
    v50.Parent = vu81
    v51.Name = 'SB'
    v51.Parent = vu81
    v51.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v51.BorderColor3 = MainXEColor
    v51.Size = UDim2.new(0, 0, 0, 0)
    v52.CornerRadius = UDim.new(0, 6)
    v52.Name = 'SBC'
    v52.Parent = v51
    v53.Name = 'Side'
    v53.Parent = v51
    v53.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v53.BorderColor3 = Color3.fromRGB(255, 255, 255)
    v53.BorderSizePixel = 0
    v53.ClipsDescendants = true
    v53.Position = UDim2.new(1, 0, 0, 0)
    v53.Size = UDim2.new(0, 0, 0, 0)
    v54.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, zyColor),
        ColorSequenceKeypoint.new(1, zyColor),
    })
    v54.Rotation = 90
    v54.Name = 'SideG'
    v54.Parent = v53
    vu81.Size = UDim2.new(0, 570, 0, 358)
    v53.Size = UDim2.new(0, 110, 0, 357)
    v51.Size = UDim2.new(0, 8, 0, 357)
    vu49.Visible = true
    v64.Parent = vu62
    v66.Visible = false
    vu55.Name = 'TabBtns'
    vu55.Parent = v53
    vu55.Active = true
    vu55.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vu55.BackgroundTransparency = 1
    vu55.BorderSizePixel = 0
    vu55.Position = UDim2.new(0, 0, 0.15, 0)
    vu55.Size = UDim2.new(0, 110, 0, 300)
    vu55.CanvasSize = UDim2.new(0, 0, 1, 0)
    vu55.ScrollBarThickness = 0
    vu56.Name = 'TabBtnsL'
    vu56.Parent = vu55
    vu56.SortOrder = Enum.SortOrder.LayoutOrder
    vu56.Padding = UDim.new(0, 12)

    local v92 = Instance.new('Frame')

    v92.Name = 'SearchContainer'
    v92.Parent = v53
    v92.BackgroundTransparency = 1
    v92.Size = UDim2.new(1, 0, 0, 40)
    v92.Position = UDim2.new(0, 0, 0.07, 0)

    local vu93 = Instance.new('TextBox')

    vu93.Name = 'SearchBar'
    vu93.Parent = v92
    vu93.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    vu93.BackgroundTransparency = 0.3
    vu93.Size = UDim2.new(0.75, 0, 0, 30)
    vu93.Position = UDim2.new(0.05, 0, 0, 0)
    vu93.PlaceholderText = '\u{641c}\u{7d22}\u{9009}\u{9879}\u{533a}...'
    vu93.Text = ''
    vu93.TextColor3 = Color3.fromRGB(255, 255, 255)
    vu93.Font = Enum.Font.GothamBold
    vu93.TextSize = 14
    vu93.ClearTextOnFocus = false

    local v94 = Instance.new('UICorner')

    v94.CornerRadius = UDim.new(0, 6)
    v94.Parent = vu93

    local v95 = Instance.new('UIPadding')

    v95.PaddingLeft = UDim.new(0, 10)
    v95.Parent = vu93

    local vu96 = Instance.new('ImageLabel')

    vu96.Name = 'SearchIcon'
    vu96.Parent = vu93
    vu96.Image = 'rbxassetid://3926305904'
    vu96.ImageColor3 = Color3.fromRGB(180, 180, 180)
    vu96.AnchorPoint = Vector2.new(1, 0.5)
    vu96.Position = UDim2.new(1, -8, 0.5, 0)
    vu96.Size = UDim2.new(0, 18, 0, 18)
    vu96.BackgroundTransparency = 1

    local vu97 = Instance.new('TextButton')

    vu97.Name = 'ClearButton'
    vu97.Parent = v92
    vu97.Text = '\u{d7}'
    vu97.TextColor3 = Color3.fromRGB(255, 100, 100)
    vu97.BackgroundTransparency = 1
    vu97.Font = Enum.Font.GothamBold
    vu97.TextSize = 18
    vu97.Position = UDim2.new(0.83, 0, 0, 5)
    vu97.Visible = false
    vu97.Size = UDim2.new(0, 0, 0, 0)

    game:GetService('TweenService'):Create(vu97, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 25, 0, 25),
    }):Play()

    local v98 = vu93

    vu93.GetPropertyChangedSignal(v98, 'Text'):Connect(function()
        local v99 = string.lower(vu93.Text)

        vu97.Visible = v99 ~= ''

        local v100 = vu55
        local v101, v102, v103 = ipairs(v100:GetChildren())

        while true do
            local v104

            v103, v104 = v101(v102, v103)

            if v103 == nil then
                break
            end
            if v104:IsA('ImageLabel') and v104:FindFirstChild('TabText') then
                local v105 = string.lower(v104.TabText.Text)

                v104.Visible = v99 == '' and true or string.find(v105, v99)
            end
        end
    end)
    vu97.MouseButton1Click:Connect(function()
        vu93.Text = ''
        vu97.Visible = false
    end)
    vu93.Focused:Connect(function()
        game:GetService('TweenService'):Create(vu93, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()

        vu96.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end)
    vu93.FocusLost:Connect(function()
        game:GetService('TweenService'):Create(vu93, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()

        vu96.ImageColor3 = Color3.fromRGB(180, 180, 180)
    end)

    vu57.Name = 'ScriptTitle'
    vu57.Parent = v53
    vu57.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vu57.BackgroundTransparency = 1
    vu57.Position = UDim2.new(0, 0, 0.00953488424, 0)
    vu57.Size = UDim2.new(0, 102, 0, 20)
    vu57.Font = Enum.Font.GothamBold
    vu57.Text = p43
    vu57.TextColor3 = Color3.fromRGB(255, 255, 255)
    vu57.TextSize = 14
    vu57.TextScaled = true
    vu57.TextXAlignment = Enum.TextXAlignment.Left
    v65.Parent = vu57
    vu57.TextTransparency = 0
    vu57.TextStrokeTransparency = 0.5
    vu57.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    vu57.ZIndex = 10

    coroutine.wrap(function()
        local vu106 = Instance.new('LocalScript', vu57).Parent.UIGradient
        local vu107 = game:GetService('TweenService'):Create(vu106, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(1, 0),
        })
        local vu108 = Vector2.new(-1, 0)
        local vu109 = {}
        local vu110 = ColorSequence.new
        local vu111 = ColorSequenceKeypoint.new
        local vu112 = 'down'

        vu106.Offset = vu108;

        (function()
            local v113 = 255
            local v114 = 255

            for v115 = 1, 10 do
                local v116 = v115 * 17

                table.insert(vu109, Color3.fromHSV(v116 / 255, v113 / 255, v114 / 255))
            end
        end)()

        vu106.Color = vu110({
            vu111(0, vu109[#vu109]),
            vu111(0.5, vu109[#vu109 - 1]),
            vu111(1, vu109[#vu109 - 2]),
        })

        local vu117 = #vu109

        local function vu118()
            vu107:Play()
            vu107.Completed:Wait()

            vu106.Offset = vu108
            vu106.Rotation = 180

            if vu117 ~= #vu109 - 1 or vu112 ~= 'down' then
                if vu117 ~= #vu109 or vu112 ~= 'down' then
                    if vu117 <= #vu109 - 2 and vu112 == 'down' then
                        vu106.Color = vu110({
                            vu111(0, vu106.Color.Keypoints[1].Value),
                            vu111(0.5, vu109[vu117 + 1]),
                            vu111(1, vu109[vu117 + 2]),
                        })
                        vu117 = vu117 + 2
                        vu112 = 'up'
                    end
                else
                    vu106.Color = vu110({
                        vu111(0, vu106.Color.Keypoints[1].Value),
                        vu111(0.5, vu109[1]),
                        vu111(1, vu109[2]),
                    })
                    vu117 = 2
                    vu112 = 'up'
                end
            else
                vu106.Color = vu110({
                    vu111(0, vu106.Color.Keypoints[1].Value),
                    vu111(0.5, vu109[#vu109]),
                    vu111(1, vu109[1]),
                })
                vu117 = 1
                vu112 = 'up'
            end

            vu107:Play()
            vu107.Completed:Wait()

            vu106.Offset = vu108
            vu106.Rotation = 0

            if vu117 ~= #vu109 - 1 or vu112 ~= 'up' then
                if vu117 ~= #vu109 or vu112 ~= 'up' then
                    if vu117 <= #vu109 - 2 and vu112 == 'up' then
                        vu106.Color = vu110({
                            vu111(0, vu109[vu117 + 2]),
                            vu111(0.5, vu109[vu117 + 1]),
                            vu111(1, vu106.Color.Keypoints[3].Value),
                        })
                        vu117 = vu117 + 2
                        vu112 = 'down'
                    end
                else
                    vu106.Color = vu110({
                        vu111(0, vu109[2]),
                        vu111(0.5, vu109[1]),
                        vu111(1, vu106.Color.Keypoints[3].Value),
                    })
                    vu117 = 2
                    vu112 = 'down'
                end
            else
                vu106.Color = vu110({
                    vu111(0, vu109[1]),
                    vu111(0.5, vu109[#vu109]),
                    vu111(1, vu106.Color.Keypoints[3].Value),
                })
                vu117 = 1
                vu112 = 'down'
            end

            vu118()
        end

        vu118()
    end)()

    v58.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, zyColor),
        ColorSequenceKeypoint.new(1, zyColor),
    })
    v58.Rotation = 90
    v58.Name = 'SBG'
    v58.Parent = v51

    vu56:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        vu55.CanvasSize = UDim2.new(0, 0, 0, vu56.AbsoluteContentSize.Y + 18)
    end)
    game:GetService('TweenService')

    vu59.Name = 'Open'
    vu59.Parent = vu48
    vu59.BackgroundColor3 = Color3.fromRGB(28, 33, 55)
    vu59.BackgroundTransparency = 0
    vu59.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    vu59.Size = UDim2.new(0, 61, 0, 32)
    vu59.Transparency = 0.75
    vu59.Font = Enum.Font.GothamBold
    vu59.Text = vu67[vu71].HideUI
    vu59.TextColor3 = Color3.fromRGB(255, 255, 255)
    vu59.TextTransparency = 0
    vu59.TextSize = 28
    vu59.Active = true
    vu59.Draggable = true

    local v119 = Instance.new('UIGradient')

    v119.Parent = vu59
    v119.Rotation = 90
    v119.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })

    local vu120 = game:GetService('TweenService')
    local vu121 = false

    spawn(function()
        while true do
            for _ = 0, 1, 0.01 do
                local v122 = tick() % 10 / 10

                vu59.TextColor3 = Color3.fromHSV(v122, 1, 1)

                wait(0.005)
            end
        end
    end)
    vu59.MouseButton1Click:Connect(function()
        if vu121 ~= false then
            vu59.Text = vu67[vu71].HideUI
            vu49.Position = UDim2.new(0.217000037, 0, 0, 3)
            vu81.Visible = true
            vu121 = false
        else
            vu59.Text = vu67[vu71].OpenUI
            vu49.Position = UDim2.new(0.217000037, 0, 0, 3)
            vu121 = true
            vu81.Visible = false
        end
    end)
    drag(vu81)

    v60.Parent = vu59

    return {
        Tab = function(_, p123, p124)
            local vu125 = Instance.new('ScrollingFrame')
            local vu126 = Instance.new('ImageLabel')
            local v127 = Instance.new('TextLabel')
            local vu128 = Instance.new('TextButton')

            Instance.new('UIListLayout')

            vu125.Name = 'Tab'
            vu125.Parent = vu49
            vu125.Active = true
            vu125.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            vu125.BackgroundTransparency = 1
            vu125.Size = UDim2.new(1, 0, 1, 0)
            vu125.ScrollBarThickness = 2
            vu125.Visible = false
            vu126.Name = 'TabIco'
            vu126.Parent = vu55
            vu126.BackgroundTransparency = 1
            vu126.BorderSizePixel = 0
            vu126.Size = UDim2.new(0, 24, 0, 24)
            vu126.Image = ('rbxassetid://103514147451766'):format(p124 or 4370341699)
            vu126.ImageTransparency = 0.2
            v127.Name = 'TabText'
            v127.Parent = vu126
            v127.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            v127.BackgroundTransparency = 1
            v127.Position = UDim2.new(1.41666663, 0, 0, 0)
            v127.Size = UDim2.new(0, 76, 0, 24)
            v127.Font = Enum.Font.GothamBold
            v127.Text = p123
            v127.TextColor3 = Color3.fromRGB(255, 255, 255)
            v127.TextSize = 14
            v127.TextXAlignment = Enum.TextXAlignment.Left
            v127.TextTransparency = 0.2
            vu128.Name = 'TabBtn'
            vu128.Parent = vu126
            vu128.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            vu128.BackgroundTransparency = 1
            vu128.BorderSizePixel = 0
            vu128.Size = UDim2.new(0, 110, 0, 24)
            vu128.AutoButtonColor = false
            vu128.Font = Enum.Font.GothamBold
            vu128.Text = ''
            vu128.TextColor3 = Color3.fromRGB(0, 0, 0)
            vu128.TextSize = 14

            local v129 = Instance.new('Frame')

            v129.Name = 'SectionSearchContainer'
            v129.Parent = vu125
            v129.BackgroundTransparency = 1
            v129.Size = UDim2.new(1, -10, 0, 40)
            v129.Position = UDim2.new(0, 5, 0, 5)

            local vu130 = Instance.new('TextBox')

            vu130.Name = 'SectionSearchBar'
            vu130.Parent = v129
            vu130.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            vu130.BackgroundTransparency = 0.3
            vu130.Size = UDim2.new(1, -60, 0, 30)
            vu130.PlaceholderText = '\u{641c}\u{7d22}\u{672c}\u{9875}\u{529f}\u{80fd}\u{540d}...'
            vu130.Text = ''
            vu130.TextColor3 = Color3.fromRGB(255, 255, 255)
            vu130.Font = Enum.Font.GothamBold
            vu130.TextSize = 14
            vu130.ClearTextOnFocus = false

            local v131 = Instance.new('UICorner')

            v131.CornerRadius = UDim.new(0, 6)
            v131.Parent = vu130

            local v132 = Instance.new('UIPadding')

            v132.PaddingLeft = UDim.new(0, 10)
            v132.Parent = vu130

            local vu133 = Instance.new('TextButton')

            vu133.Name = 'ClearButton'
            vu133.Parent = v129
            vu133.Text = '\u{d7}'
            vu133.TextColor3 = Color3.fromRGB(255, 100, 100)
            vu133.BackgroundTransparency = 1
            vu133.Font = Enum.Font.GothamBold
            vu133.TextSize = 18
            vu133.Size = UDim2.new(0, 25, 0, 25)
            vu133.Position = UDim2.new(1, -30, 0, 2)
            vu133.Visible = false

            local vu134 = Instance.new('TextLabel')

            vu134.Name = 'MatchCount'
            vu134.Parent = v129
            vu134.Text = '0\u{7ed3}\u{679c}'
            vu134.TextColor3 = Color3.fromRGB(180, 180, 180)
            vu134.BackgroundTransparency = 1
            vu134.Font = Enum.Font.GothamMedium
            vu134.TextSize = 12
            vu134.Size = UDim2.new(0, 50, 0, 20)
            vu134.Position = UDim2.new(1, -55, 0, 15)
            vu134.TextXAlignment = Enum.TextXAlignment.Right

            local function vu158()
                local v135 = vu130 and (string.lower(vu130.Text or '') or '') or ''

                if vu133 then
                    vu133.Visible = v135 ~= ''
                end

                local v136 = vu125
                local v137, v138, v139 = ipairs(v136:GetChildren())
                local v140 = 0

                while true do
                    local v141

                    v139, v141 = v137(v138, v139)

                    if v139 == nil then
                        break
                    end
                    if v141:IsA('Frame') and v141.Name == 'Section' then
                        local v142

                        if string.find(string.lower(v141.SectionText.Text), v135) then
                            v140 = v140 + 1
                            v142 = true
                        else
                            v142 = false
                        end

                        local v143 = 0

                        if v141.Objs then
                            local v144, v145, v146 = ipairs(v141.Objs:GetChildren())

                            while true do
                                local v147

                                v146, v147 = v144(v145, v146)

                                if v146 == nil then
                                    break
                                end
                                if v147:IsA('Frame') then
                                    local v148 = v147:FindFirstChildOfClass('TextButton')
                                    local v149 = v148 and (v148.Text and string.find(string.lower(v148.Text), v135)) and true or false
                                    local v150 = v147:FindFirstChildOfClass('TextLabel')
                                    local v151 = v150 and (v150.Text and string.find(string.lower(v150.Text), v135)) and true or v149
                                    local v152 = v147:FindFirstChildOfClass('TextBox')

                                    if v152 and (v152.Text or v152.PlaceholderText) then
                                        v151 = (string.find(string.lower(v152.Text), v135) or string.find(string.lower(v152.PlaceholderText), v135)) and true or v151
                                    end

                                    local v153 = v147:FindFirstChild('SliderValue')
                                    local v154 = v153 and (v153.Text and string.find(string.lower(v153.Text), v135)) and true or v151
                                    local v155 = v147:FindFirstChild('DropdownText')
                                    local v156 = v155 and (v155.Text and string.find(string.lower(v155.Text), v135)) and true or v154
                                    local v157 = v147.Name and string.find(string.lower(v147.Name), v135) and true or v156

                                    v147.Visible = v157 or v135 == ''

                                    if v157 then
                                        v143 = v143 + 1
                                        v140 = v140 + 1
                                    end
                                end
                            end
                        end

                        v141.Visible = v142 or (v143 > 0 or v135 == '')
                    end
                end

                vu134.Text = v135 == '' and '\u{5c31}\u{7eea}' or v140 .. '\u{4e2a}\u{7ed3}\u{679c}'
            end

            local v159 = vu130

            vu130.GetPropertyChangedSignal(v159, 'Text'):Connect(vu158)
            vu133.MouseButton1Click:Connect(function()
                vu130.Text = ''
                vu133.Visible = false

                vu158()
            end)
            vu130.Focused:Connect(function()
                game:GetService('TweenService'):Create(vu130, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()

                vu134.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
            vu130.FocusLost:Connect(function()
                game:GetService('TweenService'):Create(vu130, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()

                vu134.TextColor3 = Color3.fromRGB(180, 180, 180)
            end)

            local vu160 = Instance.new('UIListLayout')

            vu160.Name = 'TabL'
            vu160.Parent = vu125
            vu160.SortOrder = Enum.SortOrder.LayoutOrder
            vu160.Padding = UDim.new(0, 4)
            vu160.VerticalAlignment = Enum.VerticalAlignment.Top
            vu160.Padding = UDim.new(0, 8)

            vu128.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(vu128)
                end)

                local v161 = {vu126, vu125}

                switchTab(v161)
            end)

            if pu42.currentTab == nil then
                switchTab({vu126, vu125})
            end

            vu160:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                vu125.CanvasSize = UDim2.new(0, 0, 0, vu160.AbsoluteContentSize.Y + 8)
            end)

            return {
                section = function(_, p162, p163)
                    local vu164 = Instance.new('Frame')
                    local v165 = Instance.new('UICorner')
                    local v166 = Instance.new('TextLabel')
                    local vu167 = Instance.new('ImageLabel')
                    local vu168 = Instance.new('ImageLabel')
                    local v169 = Instance.new('ImageButton')
                    local vu170 = Instance.new('Frame')
                    local vu171 = Instance.new('UIListLayout')

                    vu164.Name = 'Section'
                    vu164.Parent = vu125
                    vu164.BackgroundColor3 = zyColor
                    vu164.BackgroundTransparency = 1
                    vu164.BorderSizePixel = 0
                    vu164.ClipsDescendants = true
                    vu164.Size = UDim2.new(0.981000006, 0, 0, 36)
                    v165.CornerRadius = UDim.new(0, 6)
                    v165.Name = 'SectionC'
                    v165.Parent = vu164
                    v166.Name = 'SectionText'
                    v166.Parent = vu164
                    v166.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    v166.BackgroundTransparency = 1
                    v166.Position = UDim2.new(0.0887396261, 0, 0, 0)
                    v166.Size = UDim2.new(0, 401, 0, 36)
                    v166.Font = Enum.Font.GothamBold
                    v166.Text = p162
                    v166.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v166.TextSize = 16
                    v166.TextXAlignment = Enum.TextXAlignment.Left
                    vu167.Name = 'SectionOpen'
                    vu167.Parent = v166
                    vu167.BackgroundTransparency = 1
                    vu167.BorderSizePixel = 0
                    vu167.Position = UDim2.new(0, -33, 0, 5)
                    vu167.Size = UDim2.new(0, 26, 0, 26)
                    vu167.Image = 'http://www.roblox.com/asset/?id=6031302934'
                    vu168.Name = 'SectionOpened'
                    vu168.Parent = vu167
                    vu168.BackgroundTransparency = 1
                    vu168.BorderSizePixel = 0
                    vu168.Size = UDim2.new(0, 26, 0, 26)
                    vu168.Image = 'http://www.roblox.com/asset/?id=6031302932'
                    vu168.ImageTransparency = 1
                    v169.Name = 'SectionToggle'
                    v169.Parent = vu167
                    v169.BackgroundTransparency = 1
                    v169.BorderSizePixel = 0
                    v169.Size = UDim2.new(0, 26, 0, 26)
                    vu170.Name = 'Objs'
                    vu170.Parent = vu164
                    vu170.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    vu170.BackgroundTransparency = 1
                    vu170.BorderSizePixel = 0
                    vu170.Position = UDim2.new(0, 6, 0, 36)
                    vu170.Size = UDim2.new(0.986347735, 0, 0, 0)
                    vu171.Name = 'ObjsL'
                    vu171.Parent = vu170
                    vu171.SortOrder = Enum.SortOrder.LayoutOrder
                    vu171.Padding = UDim.new(0, 8)

                    local vu172 = p163

                    if p163 ~= false then
                        vu164.Size = UDim2.new(0.981000006, 0, 0, vu172 and (36 + vu171.AbsoluteContentSize.Y + 8 or 36) or 36)
                        vu168.ImageTransparency = vu172 and 0 or 1
                        vu167.ImageTransparency = vu172 and 1 or 0
                    end

                    v169.MouseButton1Click:Connect(function()
                        vu172 = not vu172
                        vu164.Size = UDim2.new(0.981000006, 0, 0, vu172 and 36 + vu171.AbsoluteContentSize.Y + 8 or 36)
                        vu168.ImageTransparency = vu172 and 0 or 1
                        vu167.ImageTransparency = vu172 and 1 or 0
                    end)
                    vu171:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                        if vu172 then
                            vu164.Size = UDim2.new(0.981000006, 0, 0, 36 + vu171.AbsoluteContentSize.Y + 8)
                        end
                    end)

                    return {
                        Button = function(_, p173, p174)
                            local vu175 = p174 or function() end
                            local v176 = Instance.new('Frame')
                            local vu177 = Instance.new('TextButton')
                            local v178 = Instance.new('UICorner')

                            v176.Name = 'BtnModule'
                            v176.Parent = vu170
                            v176.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v176.BackgroundTransparency = 0.2
                            v176.BorderSizePixel = 0
                            v176.Position = UDim2.new(0, 0, 0, 0)
                            v176.Size = UDim2.new(0, 428, 0, 38)
                            vu177.Name = 'Btn'
                            vu177.Parent = v176
                            vu177.BackgroundColor3 = zyColor
                            vu177.BorderSizePixel = 0
                            vu177.Size = UDim2.new(0, 428, 0, 38)
                            vu177.AutoButtonColor = false
                            vu177.Font = Enum.Font.GothamBold
                            vu177.Text = '   ' .. p173
                            vu177.TextColor3 = Color3.fromRGB(0, 255, 255)
                            vu177.TextSize = 16
                            vu177.TextXAlignment = Enum.TextXAlignment.Left
                            v178.CornerRadius = UDim.new(0, 6)
                            v178.Name = 'BtnC'
                            v178.Parent = vu177

                            vu177.MouseEnter:Connect(function()
                                game:GetService('TweenService'):Create(vu177, TweenInfo.new(0.2), {
                                    Size = UDim2.new(0, 438, 0, 42),
                                }):Play()
                            end)
                            vu177.MouseLeave:Connect(function()
                                game:GetService('TweenService'):Create(vu177, TweenInfo.new(0.2), {
                                    Size = UDim2.new(0, 428, 0, 38),
                                }):Play()
                            end)
                            vu177.MouseButton1Click:Connect(function()
                                spawn(function()
                                    Ripple(vu177)
                                end)
                                Tween(vu177, {
                                    0.1,
                                    'Sine',
                                    'InOut',
                                }, {
                                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                                })
                                wait(0.1)
                                Tween(vu177, {
                                    0.1,
                                    'Sine',
                                    'InOut',
                                }, {BackgroundColor3 = zyColor})
                                spawn(vu175)
                            end)
                        end,
                        LabelTransparency = function(_, _)
                            local v179 = Instance.new('Frame')

                            Instance.new('TextLabel')
                            Instance.new('UICorner')

                            v179.Name = 'LabelModuleE'
                            v179.Parent = vu170
                            v179.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v179.BackgroundTransparency = 1
                            v179.BorderSizePixel = 0
                            v179.Position = UDim2.new(0, 0, NAN, 0)
                            v179.Size = UDim2.new(0, 428, 0, 19)
                            TextLabel.Parent = v179
                            TextLabel.BackgroundColor3 = zyColor
                            TextLabel.Size = UDim2.new(0, 428, 0, 22)
                            TextLabel.Font = Enum.Font.GothamBold
                            TextLabel.Transparency = 0
                            TextLabel.Text = '   ' .. textAT
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel.TextSize = 14
                            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                            LabelC.CornerRadius = UDim.new(0, 6)
                            LabelC.Name = 'LabelC'
                            LabelC.Parent = TextLabel

                            return TextLabel
                        end,
                        Label = function(_, p180)
                            local vu181 = Instance.new('Frame')

                            vu181.Parent = TextLabelE
                            vu181.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                            vu181.Size = UDim2.new(0, 0, 1, 2)
                            vu181.Position = UDim2.new(0, 0, 0, -1)
                            vu181.ZIndex = -1

                            spawn(function()
                                while wait(1) do
                                    vu181:TweenPosition(UDim2.new(1, 0, 0, -1), 'Out', 'Linear', 0.5)
                                    wait(0.5)

                                    vu181.Position = UDim2.new(0, 0, 0, -1)
                                end
                            end)

                            local v182 = Instance.new('Frame')
                            local v183 = Instance.new('TextLabel')
                            local v184 = Instance.new('UICorner')

                            v182.Name = 'LabelModule'
                            v182.Parent = vu170
                            v182.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v182.BackgroundTransparency = 1
                            v182.BorderSizePixel = 0
                            v182.Position = UDim2.new(0, 0, NAN, 0)
                            v182.Size = UDim2.new(0, 428, 0, 19)
                            v183.Parent = v182
                            v183.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            v183.Size = UDim2.new(0, 428, 0, 22)
                            v183.Font = Enum.Font.GothamBold
                            v183.Text = '   ' .. p180
                            v183.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v183.TextSize = 14
                            v183.TextXAlignment = Enum.TextXAlignment.Left
                            v184.CornerRadius = UDim.new(0, 6)
                            v184.Name = 'LabelCE'
                            v184.Parent = v183

                            return v183
                        end,
                        Toggle = function(_, p185, pu186, p187, p188)
                            local vu189 = p188 or function() end
                            local v190 = p187 or false

                            assert(p185, 'No text provided')
                            assert(pu186, 'No flag provided')

                            pu42.flags[pu186] = v190

                            local v191 = Instance.new('Frame')
                            local v192 = Instance.new('TextButton')
                            local v193 = Instance.new('UICorner')
                            local v194 = Instance.new('Frame')
                            local vu195 = Instance.new('Frame')
                            local v196 = Instance.new('UICorner')
                            local v197 = Instance.new('UICorner')

                            v191.Name = 'ToggleModule'
                            v191.Parent = vu170
                            v191.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v191.BackgroundTransparency = 1
                            v191.BorderSizePixel = 0
                            v191.Position = UDim2.new(0, 0, 0, 0)
                            v191.Size = UDim2.new(0, 428, 0, 38)
                            v192.Name = 'ToggleBtn'
                            v192.Parent = v191
                            v192.BackgroundColor3 = zyColor
                            v192.BorderSizePixel = 0
                            v192.Size = UDim2.new(0, 428, 0, 38)
                            v192.AutoButtonColor = false
                            v192.Font = Enum.Font.GothamBold
                            v192.Text = '   ' .. p185
                            v192.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v192.TextSize = 16
                            v192.TextXAlignment = Enum.TextXAlignment.Left
                            v193.CornerRadius = UDim.new(0, 6)
                            v193.Name = 'ToggleBtnC'
                            v193.Parent = v192
                            v194.Name = 'ToggleDisable'
                            v194.Parent = v192
                            v194.BackgroundColor3 = Background
                            v194.BorderSizePixel = 0
                            v194.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                            v194.Size = UDim2.new(0, 36, 0, 22)
                            vu195.Name = 'ToggleSwitch'
                            vu195.Parent = v194

                            local v198 = Instance.new('UIGradient')

                            v198.Parent = vu195
                            v198.Rotation = 90
                            v198.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
                            })

                            spawn(function()
                                while wait(0.5) do
                                    game:GetService('TweenService'):Create(vu195, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.new(0, 26, 0, 22),
                                    }):Play()
                                    wait(0.3)
                                    game:GetService('TweenService'):Create(vu195, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.new(0, 24, 0, 22),
                                    }):Play()
                                end
                            end)

                            vu195.Size = UDim2.new(0, 24, 0, 22)
                            v196.CornerRadius = UDim.new(0, 6)
                            v196.Name = 'ToggleSwitchC'
                            v196.Parent = vu195
                            v197.CornerRadius = UDim.new(0, 6)
                            v197.Name = 'ToggleDisableC'
                            v197.Parent = v194

                            local vu200 = {
                                SetState = function(_, p199)
                                    if p199 == nil then
                                        p199 = not pu42.flags[pu186]
                                    end
                                    if pu42.flags[pu186] ~= p199 then
                                        vu4.TweenService:Create(vu195, TweenInfo.new(0.2), {
                                            Position = UDim2.new(0, p199 and vu195.Size.X.Offset / 2 or 0, 0, 0),
                                            BackgroundColor3 = p199 and Color3.fromRGB(255, 255, 255) or beijingColor,
                                        }):Play()

                                        pu42.flags[pu186] = p199

                                        vu189(p199)
                                    end
                                end,
                                Module = v191,
                            }

                            if v190 ~= false then
                                vu200:SetState(pu186, true)
                            end

                            local v201 = Instance.new('UIGradient')

                            v201.Parent = parent
                            v201.Rotation = 90
                            v201.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local v202 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)

                            vu120:Create(v201, v202, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()

                            local v203 = Instance.new('UIStroke')

                            v203.Parent = v192
                            v203.Thickness = 2
                            v203.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                            local v204 = Instance.new('UIGradient')

                            v204.Parent = v203
                            v204.Rotation = 90
                            v204.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                            })

                            vu120:Create(v204, v202, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()
                            v192.MouseButton1Click:Connect(function()
                                vu200:SetState()
                            end)

                            return vu200
                        end,
                        Keybind = function(_, p205, pu206, p207)
                            local vu208 = p207 or function() end

                            assert(p205, 'No text provided')
                            assert(pu206, 'No default key provided')

                            if typeof(pu206) == 'string' then
                                pu206 = Enum.KeyCode[pu206] or pu206
                            end

                            local vu209 = {
                                Return = true,
                                Space = true,
                                Tab = true,
                                Backquote = true,
                                CapsLock = true,
                                Escape = true,
                                Unknown = true,
                            }
                            local vu210 = {
                                RightControl = 'Right Ctrl',
                                LeftControl = 'Left Ctrl',
                                LeftShift = 'Left Shift',
                                RightShift = 'Right Shift',
                                Semicolon = ';',
                                Quote = '"',
                                LeftBracket = '[',
                                RightBracket = ']',
                                Equals = '=',
                                Minus = '-',
                                RightAlt = 'Right Alt',
                                LeftAlt = 'Left Alt',
                            }
                            local vu211 = not pu206 or vu210[pu206.Name] or (pu206.Name or 'None')
                            local v212 = Instance.new('Frame')
                            local v213 = Instance.new('TextButton')
                            local v214 = Instance.new('UICorner')
                            local vu215 = Instance.new('TextButton')
                            local v216 = Instance.new('UICorner')
                            local v217 = Instance.new('UIListLayout')
                            local v218 = Instance.new('UIPadding')

                            v212.Name = 'KeybindModule'
                            v212.Parent = vu170
                            v212.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v212.BackgroundTransparency = 1
                            v212.BorderSizePixel = 0
                            v212.Position = UDim2.new(0, 0, 0, 0)
                            v212.Size = UDim2.new(0, 428, 0, 38)
                            v213.Name = 'KeybindBtn'
                            v213.Parent = v212
                            v213.BackgroundColor3 = zyColor
                            v213.BorderSizePixel = 0
                            v213.Size = UDim2.new(0, 428, 0, 38)
                            v213.AutoButtonColor = false
                            v213.Font = Enum.Font.GothamBold
                            v213.Text = '   ' .. p205
                            v213.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v213.TextSize = 16
                            v213.TextXAlignment = Enum.TextXAlignment.Left
                            v214.CornerRadius = UDim.new(0, 6)
                            v214.Name = 'KeybindBtnC'
                            v214.Parent = v213
                            vu215.Name = 'KeybindValue'
                            vu215.Parent = v213
                            vu215.BackgroundColor3 = Background
                            vu215.BorderSizePixel = 0
                            vu215.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            vu215.Size = UDim2.new(0, 100, 0, 28)
                            vu215.AutoButtonColor = false
                            vu215.Font = Enum.Font.GothamBold
                            vu215.Text = vu211
                            vu215.TextColor3 = Color3.fromRGB(255, 255, 255)
                            vu215.TextSize = 14
                            v216.CornerRadius = UDim.new(0, 6)
                            v216.Name = 'KeybindValueC'
                            v216.Parent = vu215
                            v217.Name = 'KeybindL'
                            v217.Parent = v213
                            v217.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            v217.SortOrder = Enum.SortOrder.LayoutOrder
                            v217.VerticalAlignment = Enum.VerticalAlignment.Center
                            v218.Parent = v213
                            v218.PaddingRight = UDim.new(0, 6)

                            vu4.UserInputService.InputBegan:Connect(function(p219, p220)
                                if p220 then
                                    return
                                elseif p219.UserInputType == Enum.UserInputType.Keyboard then
                                    if p219.KeyCode == pu206 then
                                        vu208(pu206.Name)
                                    end
                                else
                                    return
                                end
                            end)
                            vu215.MouseButton1Click:Connect(function()
                                vu215.Text = '...'

                                wait()

                                local v221, _ = vu4.UserInputService.InputEnded:Wait()
                                local v222 = tostring(v221.KeyCode.Name)

                                if v221.UserInputType == Enum.UserInputType.Keyboard then
                                    if vu209[v222] then
                                        vu215.Text = vu211
                                    else
                                        wait()

                                        pu206 = Enum.KeyCode[v222]
                                        vu215.Text = vu210[v222] or v222
                                    end
                                else
                                    vu215.Text = vu211

                                    return
                                end
                            end)

                            local v223 = vu215

                            vu215.GetPropertyChangedSignal(v223, 'TextBounds'):Connect(function()
                                vu215.Size = UDim2.new(0, vu215.TextBounds.X + 30, 0, 28)
                            end)

                            vu215.Size = UDim2.new(0, vu215.TextBounds.X + 30, 0, 28)
                        end,
                        Textbox = function(_, p224, pu225, pu226, p227)
                            local vu228 = p227 or function() end

                            assert(p224, 'No text provided')
                            assert(pu225, 'No flag provided')
                            assert(pu226, 'No default text provided')

                            pu42.flags[pu225] = pu226

                            local v229 = Instance.new('Frame')
                            local v230 = Instance.new('TextButton')
                            local v231 = Instance.new('UICorner')
                            local vu232 = Instance.new('TextButton')
                            local v233 = Instance.new('UICorner')
                            local vu234 = Instance.new('TextBox')
                            local v235 = Instance.new('UIListLayout')
                            local v236 = Instance.new('UIPadding')

                            v229.Name = 'TextboxModule'
                            v229.Parent = vu170
                            v229.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v229.BackgroundTransparency = 1
                            v229.BorderSizePixel = 0
                            v229.Position = UDim2.new(0, 0, 0, 0)
                            v229.Size = UDim2.new(0, 428, 0, 38)
                            v230.Name = 'TextboxBack'
                            v230.Parent = v229
                            v230.BackgroundColor3 = zyColor
                            v230.BorderSizePixel = 0
                            v230.Size = UDim2.new(0, 428, 0, 38)
                            v230.AutoButtonColor = false
                            v230.Font = Enum.Font.GothamBold
                            v230.Text = '   ' .. p224
                            v230.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v230.TextSize = 16
                            v230.TextXAlignment = Enum.TextXAlignment.Left
                            v231.CornerRadius = UDim.new(0, 6)
                            v231.Name = 'TextboxBackC'
                            v231.Parent = v230
                            vu232.Name = 'BoxBG'
                            vu232.Parent = v230

                            local vu237 = Instance.new('UIGradient')

                            vu237.Parent = vu232
                            vu237.Rotation = 90
                            vu237.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120)),
                            })

                            vu234.Focused:Connect(function()
                                game:GetService('TweenService'):Create(vu237, TweenInfo.new(0.3), {
                                    Rotation = 180,
                                    Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 200)),
                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 250)),
                                    }),
                                }):Play()
                            end)
                            vu234.FocusLost:Connect(function()
                                game:GetService('TweenService'):Create(vu237, TweenInfo.new(0.3), {
                                    Rotation = 90,
                                    Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120)),
                                    }),
                                }):Play()
                            end)

                            vu232.BorderSizePixel = 0
                            vu232.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            vu232.Size = UDim2.new(0, 100, 0, 28)
                            vu232.AutoButtonColor = false
                            vu232.Font = Enum.Font.GothamBold
                            vu232.Text = ''
                            vu232.TextColor3 = Color3.fromRGB(255, 255, 255)
                            vu232.TextSize = 14
                            v233.CornerRadius = UDim.new(0, 6)
                            v233.Name = 'BoxBGC'
                            v233.Parent = vu232
                            vu234.Parent = vu232
                            vu234.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu234.BackgroundTransparency = 1
                            vu234.BorderSizePixel = 0
                            vu234.Size = UDim2.new(1, 0, 1, 0)
                            vu234.Font = Enum.Font.GothamBold
                            vu234.Text = pu226
                            vu234.TextColor3 = Color3.fromRGB(255, 255, 255)
                            vu234.TextSize = 14
                            vu234.TextXAlignment = Enum.TextXAlignment.Left
                            v235.Name = 'TextboxBackL'
                            v235.Parent = v230
                            v235.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            v235.SortOrder = Enum.SortOrder.LayoutOrder
                            v235.VerticalAlignment = Enum.VerticalAlignment.Center
                            v236.Name = 'TextboxBackP'
                            v236.Parent = v230
                            v236.PaddingRight = UDim.new(0, 6)

                            vu234.FocusLost:Connect(function()
                                if vu234.Text == '' then
                                    vu234.Text = pu226
                                end

                                pu42.flags[pu225] = vu234.Text

                                vu228(vu234.Text)
                            end)

                            local v238 = vu234

                            vu234.GetPropertyChangedSignal(v238, 'TextBounds'):Connect(function()
                                local v239 = vu234.TextBounds.X + 30

                                vu232.Size = UDim2.new(0, math.clamp(v239, 100, 325), 0, 28)
                                vu234.TextXAlignment = Enum.TextXAlignment.Left
                            end)

                            vu232.Size = UDim2.new(0, math.clamp(vu234.TextBounds.X + 30, 100, 325), 0, 28)
                        end,
                        Slider = function(_, p240, pu241, p242, p243, p244, p245, p246)
                            local vu247 = p246 or function() end
                            local vu248 = p243 or 1
                            local vu249 = p244 or 10
                            local vu250 = p242 or vu248
                            local vu251 = p245 or false

                            pu42.flags[pu241] = vu250

                            assert(p240, 'No text provided')
                            assert(pu241, 'No flag provided')
                            assert(vu250, 'No default value provided')

                            local v252 = Instance.new('Frame')
                            local v253 = Instance.new('TextButton')
                            local v254 = Instance.new('UICorner')
                            local vu255 = Instance.new('Frame')
                            local v256 = Instance.new('UICorner')
                            local vu257 = Instance.new('Frame')
                            local v258 = Instance.new('UICorner')
                            local v259 = Instance.new('TextButton')
                            local v260 = Instance.new('UICorner')
                            local vu261 = Instance.new('TextBox')
                            local v262 = Instance.new('TextButton')
                            local v263 = Instance.new('TextButton')

                            v252.Name = 'SliderModule'
                            v252.Parent = vu170
                            v252.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v252.BackgroundTransparency = 1
                            v252.BorderSizePixel = 0
                            v252.Position = UDim2.new(0, 0, 0, 0)
                            v252.Size = UDim2.new(0, 428, 0, 38)
                            v253.Name = 'SliderBack'
                            v253.Parent = v252
                            v253.BackgroundColor3 = zyColor
                            v253.BorderSizePixel = 0
                            v253.Size = UDim2.new(0, 428, 0, 38)
                            v253.AutoButtonColor = false
                            v253.Font = Enum.Font.GothamBold
                            v253.Text = '   ' .. p240
                            v253.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v253.TextSize = 16
                            v253.TextXAlignment = Enum.TextXAlignment.Left
                            v254.CornerRadius = UDim.new(0, 6)
                            v254.Name = 'SliderBackC'
                            v254.Parent = v253
                            vu255.Name = 'SliderBar'
                            vu255.Parent = v253
                            vu255.AnchorPoint = Vector2.new(0, 0.5)
                            vu255.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
                            vu255.BorderSizePixel = 0
                            vu255.Position = UDim2.new(0.35, 0, 0.5, 0)
                            vu255.Size = UDim2.new(0, 180, 0, 6)

                            local v264 = Instance.new('UIStroke')

                            v264.Parent = vu255
                            v264.Color = Color3.fromRGB(0, 200, 255)
                            v264.Thickness = 1
                            v264.Transparency = 0.7
                            v256.CornerRadius = UDim.new(1, 0)
                            v256.Name = 'SliderBarC'
                            v256.Parent = vu255
                            vu257.Name = 'SliderPart'
                            vu257.Parent = vu255
                            vu257.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                            vu257.BorderSizePixel = 0
                            vu257.Size = UDim2.new(0, 0, 1, 0)

                            local v265 = Instance.new('UIGradient')

                            v265.Parent = vu257
                            v265.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255)),
                            })
                            v265.Rotation = 0

                            local vu266 = Instance.new('Frame')

                            vu266.Name = 'SliderHandle'
                            vu266.Parent = vu257
                            vu266.AnchorPoint = Vector2.new(0.5, 0.5)
                            vu266.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu266.BorderSizePixel = 0
                            vu266.Position = UDim2.new(1, 0, 0.5, 0)
                            vu266.Size = UDim2.new(0, 12, 0, 12)

                            local v267 = Instance.new('UICorner')

                            v267.CornerRadius = UDim.new(1, 0)
                            v267.Parent = vu266

                            local v268 = Instance.new('UIStroke')

                            v268.Parent = vu266
                            v268.Color = Color3.fromRGB(0, 255, 255)
                            v268.Thickness = 2
                            v268.Transparency = 0.5
                            v258.CornerRadius = UDim.new(0, 4)
                            v258.Name = 'SliderPartC'
                            v258.Parent = vu257
                            v259.Name = 'SliderValBG'
                            v259.Parent = v253
                            v259.BackgroundColor3 = Background
                            v259.BorderSizePixel = 0
                            v259.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                            v259.Size = UDim2.new(0, 44, 0, 28)
                            v259.AutoButtonColor = false
                            v259.Font = Enum.Font.GothamBold
                            v259.Text = ''
                            v259.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v259.TextSize = 14
                            v260.CornerRadius = UDim.new(0, 6)
                            v260.Name = 'SliderValBGC'
                            v260.Parent = v259
                            vu261.Name = 'SliderValue'
                            vu261.Parent = v259
                            vu261.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu261.BackgroundTransparency = 1
                            vu261.BorderSizePixel = 0
                            vu261.Size = UDim2.new(1, 0, 1, 0)
                            vu261.Font = Enum.Font.GothamBold
                            vu261.Text = '1000'
                            vu261.TextColor3 = Color3.fromRGB(255, 0, 0)
                            vu261.TextSize = 14
                            v262.Name = 'MinSlider'
                            v262.Parent = v252
                            v262.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v262.BackgroundTransparency = 1
                            v262.BorderSizePixel = 0
                            v262.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                            v262.Size = UDim2.new(0, 20, 0, 20)
                            v262.Font = Enum.Font.GothamBold
                            v262.Text = ''
                            v262.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v262.TextSize = 24
                            v262.TextWrapped = true
                            v263.Name = 'AddSlider'
                            v263.Parent = v252
                            v263.AnchorPoint = Vector2.new(0, 0.5)
                            v263.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v263.BackgroundTransparency = 1
                            v263.BorderSizePixel = 0
                            v263.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                            v263.Size = UDim2.new(0, 20, 0, 20)
                            v263.Font = Enum.Font.GothamBold
                            v263.Text = ''
                            v263.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v263.TextSize = 24
                            v263.TextWrapped = true

                            local vu273 = {
                                SetValue = function(_, p269)
                                    local v270 = (vu5.X - vu255.AbsolutePosition.X) / vu255.AbsoluteSize.X

                                    if p269 then
                                        v270 = (p269 - vu248) / (vu249 - vu248)
                                    end

                                    local v271 = math.clamp(v270, 0, 1)
                                    local v272

                                    if vu251 then
                                        v272 = p269 or tonumber(string.format('%.1f', tostring(vu248 + (vu249 - vu248) * v271)))
                                    else
                                        v272 = p269 or math.floor(vu248 + (vu249 - vu248) * v271)
                                    end

                                    pu42.flags[pu241] = tonumber(v272)
                                    vu261.Text = tostring(v272)
                                    vu257.Size = UDim2.new(v271, 0, 1, 0)

                                    game:GetService('TweenService'):Create(vu266, TweenInfo.new(0.1), {
                                        Position = UDim2.new(v271, 0, 0.5, 0),
                                    }):Play()
                                    vu247(tonumber(v272))
                                end,
                            }

                            v262.MouseButton1Click:Connect(function()
                                local v274 = pu42.flags[pu241]

                                vu273:SetValue((math.clamp(v274 - 1, vu248, vu249)))
                            end)
                            v263.MouseButton1Click:Connect(function()
                                local v275 = pu42.flags[pu241]

                                vu273:SetValue((math.clamp(v275 + 1, vu248, vu249)))
                            end)

                            local v276 = vu273

                            vu273.SetValue(v276, vu250)

                            local vu277 = false
                            local vu278 = false
                            local vu279 = {
                                [''] = true,
                                ['-'] = true,
                            }

                            vu255.InputBegan:Connect(function(p280)
                                if p280.UserInputType == Enum.UserInputType.MouseButton1 then
                                    vu273:SetValue()

                                    vu277 = true
                                end
                            end)
                            vu4.UserInputService.InputEnded:Connect(function(p281)
                                if vu277 and p281.UserInputType == Enum.UserInputType.MouseButton1 then
                                    vu277 = false
                                end
                            end)
                            vu4.UserInputService.InputChanged:Connect(function(p282)
                                if vu277 and p282.UserInputType == Enum.UserInputType.MouseMovement then
                                    vu273:SetValue()
                                end
                            end)
                            vu255.InputBegan:Connect(function(p283)
                                if p283.UserInputType == Enum.UserInputType.Touch then
                                    vu273:SetValue()

                                    vu277 = true
                                end
                            end)
                            vu4.UserInputService.InputEnded:Connect(function(p284)
                                if vu277 and p284.UserInputType == Enum.UserInputType.Touch then
                                    vu277 = false
                                end
                            end)
                            vu4.UserInputService.InputChanged:Connect(function(p285)
                                if vu277 and p285.UserInputType == Enum.UserInputType.Touch then
                                    vu273:SetValue()
                                end
                            end)
                            vu261.Focused:Connect(function()
                                vu278 = true
                            end)
                            vu261.FocusLost:Connect(function()
                                vu278 = false

                                if vu261.Text == '' then
                                    vu273:SetValue(vu250)
                                end
                            end)

                            local v286 = vu261

                            vu261.GetPropertyChangedSignal(v286, 'Text'):Connect(function()
                                if vu278 then
                                    vu261.Text = vu261.Text:gsub('%D+', '')

                                    local v287 = vu261.Text

                                    if tonumber(v287) then
                                        if not vu279[v287] then
                                            if vu249 < tonumber(v287) then
                                                v287 = vu249
                                                vu261.Text = tostring(vu249)
                                            end

                                            vu273:SetValue(tonumber(v287))
                                        end
                                    else
                                        vu261.Text = vu261.Text:gsub('%D+', '')
                                    end
                                end
                            end)

                            return vu273
                        end,
                        Dropdown = function(_, pu288, pu289, p290, p291)
                            local vu292 = p291 or function() end

                            assert(pu288, 'No text provided')
                            assert(pu289, 'No flag provided')

                            pu42.flags[pu289] = nil

                            local vu293 = Instance.new('Frame')
                            local v294 = Instance.new('TextButton')
                            local v295 = Instance.new('UICorner')
                            local vu296 = Instance.new('TextButton')
                            local vu297 = Instance.new('TextBox')
                            local vu298 = Instance.new('UIListLayout')

                            Instance.new('TextButton')
                            Instance.new('UICorner')

                            vu293.Name = 'DropdownModule'
                            vu293.Parent = vu170
                            vu293.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu293.BackgroundTransparency = 1
                            vu293.BorderSizePixel = 0
                            vu293.ClipsDescendants = true
                            vu293.Position = UDim2.new(0, 0, 0, 0)
                            vu293.Size = UDim2.new(0, 428, 0, 38)

                            local vu299 = Instance.new('Frame')

                            vu299.Parent = vu293
                            vu299.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                            vu299.Size = UDim2.new(1, -20, 0, 2)
                            vu299.Position = UDim2.new(0, 10, 1, -5)
                            vu299.Visible = false

                            vu296.MouseEnter:Connect(function()
                                vu299.Visible = true

                                game:GetService('TweenService'):Create(vu299, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                            end)

                            v294.Name = 'DropdownTop'
                            v294.Parent = vu293

                            local v300 = Instance.new('UIGradient')

                            v300.Parent = v294
                            v300.Rotation = 90
                            v300.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local vu301 = Instance.new('UIStroke')

                            vu301.Parent = v294
                            vu301.Thickness = 2
                            vu301.Color = Color3.fromRGB(255, 255, 255)
                            vu301.Transparency = 0.5

                            spawn(function()
                                while wait(0.1) do
                                    vu301.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                                end
                            end)

                            v294.BorderSizePixel = 0
                            v294.Size = UDim2.new(0, 428, 0, 38)
                            v294.AutoButtonColor = false
                            v294.Font = Enum.Font.GothamBold
                            v294.Text = ''
                            v294.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v294.TextSize = 16
                            v294.TextXAlignment = Enum.TextXAlignment.Left
                            v295.CornerRadius = UDim.new(0, 6)
                            v295.Name = 'DropdownTopC'
                            v295.Parent = v294
                            vu296.Name = 'DropdownOpen'
                            vu296.Parent = v294
                            vu296.AnchorPoint = Vector2.new(0, 0.5)
                            vu296.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu296.BackgroundTransparency = 1
                            vu296.BorderSizePixel = 0
                            vu296.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                            vu296.Size = UDim2.new(0, 20, 0, 20)
                            vu296.Font = Enum.Font.GothamBold
                            vu296.Text = '+'
                            vu296.TextColor3 = Color3.fromRGB(255, 255, 255)
                            vu296.TextSize = 24
                            vu296.TextWrapped = true
                            vu297.Name = 'DropdownText'
                            vu297.Parent = v294
                            vu297.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            vu297.BackgroundTransparency = 1
                            vu297.BorderSizePixel = 0
                            vu297.Position = UDim2.new(0.0373831764, 0, 0, 0)
                            vu297.Size = UDim2.new(0, 184, 0, 38)
                            vu297.Font = Enum.Font.GothamBold
                            vu297.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                            vu297.PlaceholderText = pu288
                            vu297.Text = pu288 .. '\u{ff5c}' .. vu67[vu71].Currently
                            vu297.TextColor3 = Color3.fromRGB(255, 255, 255)
                            vu297.TextSize = 16
                            vu297.TextXAlignment = Enum.TextXAlignment.Left
                            vu298.Name = 'DropdownModuleL'
                            vu298.Parent = vu293
                            vu298.SortOrder = Enum.SortOrder.LayoutOrder
                            vu298.Padding = UDim.new(0, 4)

                            local function vu305()
                                local v302 = vu293:GetChildren()

                                for v303 = 1, #v302 do
                                    local v304 = v302[v303]

                                    if v304:IsA('TextButton') then
                                        if v304.Name:match('Option_') then
                                            v304.Visible = true
                                        end
                                    end
                                end
                            end
                            local function vu310(p306)
                                local v307 = vu293:GetChildren()

                                for v308 = 1, #v307 do
                                    local v309 = v307[v308]

                                    if p306 == '' then
                                        vu305()
                                    elseif v309:IsA('TextButton') then
                                        if v309.Name:match('Option_') then
                                            if v309.Text:lower():match(p306:lower()) then
                                                v309.Visible = true
                                            else
                                                v309.Visible = false
                                            end
                                        end
                                    end
                                end
                            end

                            local vu311 = false

                            local function vu312()
                                vu311 = not vu311

                                if vu311 then
                                    vu305()
                                end

                                vu296.Text = vu311 and '-' or '+'
                                vu293.Size = UDim2.new(0, 428, 0, vu311 and vu298.AbsoluteContentSize.Y + 4 or 38)
                            end

                            local v313 = Instance.new('UIGradient')

                            v313.Parent = parent
                            v313.Rotation = 90
                            v313.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local v314 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)

                            vu120:Create(v313, v314, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()

                            local v315 = Instance.new('UIStroke')

                            v315.Parent = v294
                            v315.Thickness = 2
                            v315.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                            local v316 = Instance.new('UIGradient')

                            v316.Parent = v315
                            v316.Rotation = 90
                            v316.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                            })

                            vu120:Create(v316, v314, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()
                            vu296.MouseButton1Click:Connect(vu312)
                            vu297.Focused:Connect(function()
                                if not vu311 then
                                    vu312()
                                end
                            end)

                            local v317 = vu297

                            vu297.GetPropertyChangedSignal(v317, 'Text'):Connect(function()
                                if vu311 then
                                    vu310(vu297.Text)
                                end
                            end)

                            local v318 = vu298

                            vu298.GetPropertyChangedSignal(v318, 'AbsoluteContentSize'):Connect(function()
                                if vu311 then
                                    vu293.Size = UDim2.new(0, 428, 0, vu298.AbsoluteContentSize.Y + 4)
                                end
                            end)

                            local vu332 = {
                                AddOption = function(_, p319)
                                    local vu320 = Instance.new('TextButton')
                                    local v321 = Instance.new('UICorner')

                                    vu320.Name = 'Option_' .. p319
                                    vu320.Parent = vu293
                                    vu320.BackgroundColor3 = zyColor
                                    vu320.BorderSizePixel = 0
                                    vu320.Position = UDim2.new(0, 0, 0.328125, 0)
                                    vu320.Size = UDim2.new(0, 428, 0, 26)
                                    vu320.AutoButtonColor = false
                                    vu320.Font = Enum.Font.GothamBold
                                    vu320.Text = p319
                                    vu320.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    vu320.TextSize = 14
                                    v321.CornerRadius = UDim.new(0, 6)
                                    v321.Name = 'OptionC'
                                    v321.Parent = vu320

                                    vu320.MouseButton1Click:Connect(function()
                                        vu312()
                                        vu292(vu320.Text)

                                        vu297.Text = pu288 .. '\u{ff5c}' .. vu67[vu71].Currently .. '' .. vu320.Text
                                        pu42.flags[pu289] = vu320.Text
                                    end)
                                end,
                                RemoveOption = function(_, p322)
                                    local v323 = vu293:FindFirstChild('Option_' .. p322)

                                    if v323 then
                                        v323:Destroy()
                                    end
                                end,
                                SetOptions = function(_, p324)
                                    local v325 = next
                                    local v326, v327 = vu293:GetChildren()

                                    while true do
                                        local v328

                                        v327, v328 = v325(v326, v327)

                                        if v327 == nil then
                                            break
                                        end
                                        if v328.Name:match('Option_') then
                                            v328:Destroy()
                                        end
                                    end

                                    local v329 = next
                                    local v330 = nil

                                    while true do
                                        local v331

                                        v330, v331 = v329(p324, v330)

                                        if v330 == nil then
                                            break
                                        end

                                        vu332:AddOption(v331)
                                    end
                                end,
                            }
                            local v333 = vu332

                            vu332.SetOptions(v333, p290 or {})

                            return vu332
                        end,
                    }
                end,
            }
        end,
    }
end

local vu334 = {
    'loadstring',
    '00z7n',
    'print',
    'hook',
}

local function vu340(p335)
    local v336, v337, v338 = ipairs(vu334)

    while true do
        local v339

        v338, v339 = v336(v337, v338)

        if v338 == nil then
            break
        end
        if p335.Name:lower() == v339:lower() then
            return true
        end
    end

    return false
end
local function v345()
    local v341, v342, v343 = ipairs(game:GetService('Players'):GetPlayers())

    while true do
        local vu344

        v343, vu344 = v341(v342, v343)

        if v343 == nil then
            break
        end
        if vu340(vu344) then
            pcall(function()
                vu344:Kick('\u{26a0}\u{fe0f} \u{4f60}\u{5df2}\u{88ab}\u{5217}\u{5165}\u{9ed1}\u{540d}\u{5355}')
            end)
        end
    end
end

game:GetService('Players').PlayerAdded:Connect(function(pu346)
    if vu340(pu346) then
        pcall(function()
            pu346:Kick('\u{26a0}\u{fe0f} \u{4f60}\u{5df2}\u{88ab}\u{5217}\u{5165}\u{9ed1}\u{540d}\u{5355}')
        end)
    end
end)
v345()

return vu1
