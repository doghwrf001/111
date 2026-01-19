repeat
    task.wait()
until game:IsLoaded()

local u1 = {}
local u2 = false

u1.currentTab = nil
u1.flags = {}

local u4 = setmetatable({}, {
    __index = function(_, p3)
        return game.GetService(game, p3)
    end,
})
local u5 = u4.Players.LocalPlayer:GetMouse()

local function u13(p6, p7, p8, p9, p10)
    local v11 = TweenInfo.new(p7, Enum.EasingStyle[p8], Enum.EasingDirection[p9])
    local v12 = u4.TweenService:Create(p6, v11, p10)

    v12:Play()

    return v12
end

function Tween(p14, p15, p16)
    return u13(p14, p15[1], p15[2], p15[3], p16)
end

local function u19(p17)
    if p17.ClipsDescendants ~= true then
        p17.ClipsDescendants = true
    end

    local _ImageLabel = Instance.new('ImageLabel')

    _ImageLabel.Name = 'Ripple'
    _ImageLabel.Parent = p17
    _ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _ImageLabel.BackgroundTransparency = 1
    _ImageLabel.ZIndex = 8
    _ImageLabel.Image = 'rbxassetid://95828101007163'
    _ImageLabel.ImageTransparency = 0.8
    _ImageLabel.ScaleType = Enum.ScaleType.Fit
    _ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    _ImageLabel.Position = UDim2.new((u5.X - _ImageLabel.AbsolutePosition.X) / p17.AbsoluteSize.X, 0, (u5.Y - _ImageLabel.AbsolutePosition.Y) / p17.AbsoluteSize.Y, 0)

    return _ImageLabel
end

function Ripple(p20)
    spawn(function()
        local v21 = u19(p20)

        Tween(v21, {
            0.3,
            'Linear',
            'InOut',
        }, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0),
        })
        Tween(p20, {
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
        Tween(p20, {
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

local u22 = false
local u23 = false

local function u26(p24, p25)
    u4.TweenService:Create(p24, TweenInfo.new(0.1), {ImageTransparency = p25}):Play()
    u4.TweenService:Create(p24.TabText, TweenInfo.new(0.1), {TextTransparency = p25}):Play()
end

function switchTab(p27)
    local _Frame = Instance.new('Frame')

    _Frame.Parent = p27[1]
    _Frame.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    _Frame.BackgroundTransparency = 0.7
    _Frame.Size = UDim2.new(0, 0, 0, 0)
    _Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    _Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    _Frame.ZIndex = 10

    game:GetService('TweenService'):Create(_Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()
    spawn(function()
        wait(0.5)
        _Frame:Destroy()
    end)

    if u23 then
        return
    else
        local _currentTab = u1.currentTab

        if _currentTab == nil then
            p27[2].Visible = true
            u1.currentTab = p27

            u26(p27[1], 0)

            return
        elseif _currentTab[1] ~= p27[1] then
            u23 = true
            u1.currentTab = p27

            u26(_currentTab[1], 0.2)
            u26(p27[1], 0)

            _currentTab[2].Visible = false
            p27[2].Visible = true

            task.wait(0.1)

            u23 = false
        end
    end
end
function drag(p30, p31)
    local u32 = nil
    local u33 = nil
    local u34 = nil
    local u35 = nil

    local function u38(p36)
        local v37 = p36.Position - u34

        p30.Position = UDim2.new(u35.X.Scale, u35.X.Offset + v37.X, u35.Y.Scale, u35.Y.Offset + v37.Y)
    end

    (p31 or p30).InputBegan:Connect(function(p39)
        if p39.UserInputType == Enum.UserInputType.MouseButton1 then
            u32 = true
            u34 = p39.Position
            u35 = p30.Position

            p39.Changed:Connect(function()
                if p39.UserInputState == Enum.UserInputState.End then
                    u32 = false
                end
            end)
        end
    end)
    p30.InputChanged:Connect(function(p40)
        if p40.UserInputType == Enum.UserInputType.MouseMovement then
            u33 = p40
        end
    end)
    u4.UserInputService.InputChanged:Connect(function(p41)
        if p41 == u33 and u32 then
            u38(p41)
        end
    end)
end
function u1.new(p42, p43, _)
    local v44 = next
    local v45, v46 = u4.CoreGui:GetChildren()

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

    local _ScreenGui = Instance.new('ScreenGui')
    local _Frame2 = Instance.new('Frame')
    local _UICorner = Instance.new('UICorner')
    local _Frame3 = Instance.new('Frame')
    local _UICorner2 = Instance.new('UICorner')
    local _Frame4 = Instance.new('Frame')
    local _UIGradient = Instance.new('UIGradient')
    local _ScrollingFrame = Instance.new('ScrollingFrame')
    local _UIListLayout = Instance.new('UIListLayout')
    local _TextLabel = Instance.new('TextLabel')
    local _UIGradient2 = Instance.new('UIGradient')
    local _TextButton = Instance.new('TextButton')
    local _UIGradient3 = Instance.new('UIGradient')
    local _Frame5 = Instance.new('Frame')
    local _ImageLabel2 = Instance.new('ImageLabel')
    local _UICorner3 = Instance.new('UICorner')
    local _UIGradient4 = Instance.new('UIGradient')
    local _UIGradient5 = Instance.new('UIGradient')
    local _TextLabel2 = Instance.new('TextLabel')

    if syn and syn.protect_gui then
        syn.protect_gui(_ScreenGui)
    end

    _ScreenGui.Name = 'Linni'
    _ScreenGui.Parent = u4.CoreGui

    function UiDestroy()
        _ScreenGui:Destroy()
    end
    function ToggleUILib()
        if u2 then
            u2 = false
            _ScreenGui.Enabled = true
        else
            _ScreenGui.Enabled = false
            u2 = true
        end
    end

    local u67 = {
        ['zh-cn'] = {
            WelcomeUI = '欢迎使用MR-S',
            OpenUI = '打开UI',
            HideUI = '隐藏UI',
            Currently = '当前：',
        },
    }
    local _LocalPlayer = game:GetService('Players').LocalPlayer
    local v69 = game:GetService('LocalizationService'):GetCountryRegionForPlayerAsync(_LocalPlayer)
    local v70 = {
        CN = 'zh-cn',
    }
    local u71 = u67[v70[v69] ] and v70[v69] or 'zh-cn'
    local _MainXE = (function(p72, p73, p74, p75, p76, p77, p78, p79)
        local _Frame6 = Instance.new('Frame')

        _Frame6.Name = p72
        _Frame6.Parent = p73
        _Frame6.AnchorPoint = p74
        _Frame6.Position = p75
        _Frame6.Size = p76
        _Frame6.BackgroundColor3 = p77
        _Frame6.ZIndex = p78
        _Frame6.Active = true
        _Frame6.Draggable = p79
        _Frame6.Visible = true

        return _Frame6
    end)('MainXE', _ScreenGui, Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), MainXEColor, 1, true)
    local _ViewSizeX = u4.Players.LocalPlayer:GetMouse().ViewSizeX

    _MainXE.Size = UDim2.new(0, math.clamp(_ViewSizeX * 0.8, 500, 800), 0, math.clamp(_ViewSizeX * 0.6, 400, 600))

    local _Frame7 = Instance.new('Frame')

    _Frame7.Name = 'NeonBorder'
    _Frame7.Parent = _MainXE
    _Frame7.BackgroundTransparency = 1
    _Frame7.Size = UDim2.new(1, 10, 1, 10)
    _Frame7.Position = UDim2.new(0, -5, 0, -5)
    _Frame7.ZIndex = 0

    local _UIGradient6 = Instance.new('UIGradient')

    _UIGradient6.Parent = _Frame7
    _UIGradient6.Rotation = 45
    _UIGradient6.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
    })

    game:GetService('TweenService'):Create(_UIGradient6, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()

    local _UIStroke = Instance.new('UIStroke')

    _UIStroke.Parent = _MainXE
    _UIStroke.Thickness = 3
    _UIStroke.Color = Color3.fromRGB(0, 255, 255)
    _UIStroke.Transparency = 0.5
    _UIStroke.LineJoinMode = Enum.LineJoinMode.Round

    local _Frame8 = Instance.new('Frame')

    _Frame8.Name = 'DynamicBG'
    _Frame8.Parent = _MainXE
    _Frame8.BackgroundColor3 = MainXEColor
    _Frame8.BackgroundTransparency = 0.7
    _Frame8.Size = UDim2.new(1, 0, 1, 0)
    _Frame8.ZIndex = -1

    for v87 = 0, 1, 0.1 do
        local v88 = v87
        local _Frame9 = Instance.new('Frame')

        _Frame9.Name = 'GridLine_H_' .. v88
        _Frame9.Parent = _Frame8
        _Frame9.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        _Frame9.BorderSizePixel = 0
        _Frame9.Size = UDim2.new(1, 0, 0, 1)
        _Frame9.Position = UDim2.new(0, 0, v88, 0)
        _Frame9.ZIndex = 0
    end

    local _Frame10 = Instance.new('Frame')

    _Frame10.Name = 'ScanDot'
    _Frame10.Parent = _Frame8
    _Frame10.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    _Frame10.Size = UDim2.new(0, 6, 0, 6)
    _Frame10.Position = UDim2.new(0, 0, 0, 0)
    _Frame10.ZIndex = 2

    spawn(function()
        while true do
            game:GetService('TweenService'):Create(_Frame10, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 0, 0),
            }):Play()
            wait(2)
            game:GetService('TweenService'):Create(_Frame10, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 1, -6),
            }):Play()
            wait(1)
            game:GetService('TweenService'):Create(_Frame10, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, 0, 0, 0),
            }):Play()
            wait(1)
        end
    end)

    _TextLabel2.Name = 'WelcomeLabel'
    _TextLabel2.Parent = _MainXE
    _TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
    _TextLabel2.Position = UDim2.new(0.5, 0, 0.5, 0)
    _TextLabel2.Size = UDim2.new(1, 0, 1, 0)
    _TextLabel2.Text = u67[u71].WelcomeUI
    _TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextLabel2.TextSize = 32
    _TextLabel2.BackgroundTransparency = 1
    _TextLabel2.TextTransparency = 1
    _TextLabel2.TextStrokeTransparency = 0.5
    _TextLabel2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    _TextLabel2.Font = Enum.Font.GothamBold
    _TextLabel2.Visible = true
    _UICorner3.Parent = _MainXE
    _UICorner3.CornerRadius = UDim.new(0, 3)

    local _TextButton2 = Instance.new('TextButton')

    _TextButton2.Name = 'CloseButton'
    _TextButton2.Parent = _MainXE
    _TextButton2.AnchorPoint = Vector2.new(1, 0)
    _TextButton2.Position = UDim2.new(1, -5, 0, 5)
    _TextButton2.Size = UDim2.new(0, 25, 0, 25)
    _TextButton2.BackgroundTransparency = 1
    _TextButton2.Text = '❌'
    _TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextButton2.TextSize = 20
    _TextButton2.Font = Enum.Font.GothamBold
    _TextButton2.ZIndex = 10

    _TextButton2.MouseEnter:Connect(function()
        TweenService:Create(_TextButton2, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 50, 50),
        }):Play()
    end)
    _TextButton2.MouseLeave:Connect(function()
        TweenService:Create(_TextButton2, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
    _TextButton2.MouseButton1Click:Connect(function()
        _ScreenGui:Destroy()
    end)

    _Frame5.Name = 'DropShadowHolder'
    _Frame5.Parent = _MainXE
    _Frame5.BackgroundTransparency = 1
    _Frame5.BorderSizePixel = 0
    _Frame5.Size = UDim2.new(1, 0, 1, 0)
    _Frame5.BorderColor3 = Color3.fromRGB(255, 255, 255)
    _Frame5.ZIndex = 0
    _ImageLabel2.Name = 'DropShadow'
    _ImageLabel2.Parent = _Frame5
    _ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
    _ImageLabel2.BackgroundTransparency = 1
    _ImageLabel2.BorderSizePixel = 0
    _ImageLabel2.Position = UDim2.new(0.5, 0, 0.5, 0)

    _MainXE:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
        _ImageLabel2.Size = UDim2.new(1, 50, 1, 50)
    end)

    _ImageLabel2.ZIndex = 0
    _ImageLabel2.Image = 'rbxassetid://95828101007163'
    _ImageLabel2.ImageColor3 = Color3.fromRGB(255, 255, 255)
    _ImageLabel2.ImageTransparency = 0.2
    _ImageLabel2.Size = UDim2.new(1, 43, 1, 43)
    _ImageLabel2.ZIndex = 0
    _ImageLabel2.Image = 'rbxassetid://95828101007163'
    _ImageLabel2.ImageColor3 = Color3.fromRGB(255, 255, 255)
    _ImageLabel2.ImageTransparency = 0
    _ImageLabel2.ScaleType = Enum.ScaleType.Slice
    _ImageLabel2.SliceCenter = Rect.new(49, 49, 450, 450)
    _UIGradient4.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })
    _UIGradient4.Parent = _ImageLabel2

    game:GetService('TweenService'):Create(_UIGradient4, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {
        Rotation = 360,
        Offset = Vector2.new(1, 0),
    }):Play()

    function toggleui()
        u22 = not u22

        spawn(function()
            if u22 then
                wait(0.3)
            end
        end)
        Tween(_MainXE, {
            0.3,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(0, 609, 0, u22 and 505 or 0),
        })
    end

    _Frame2.Name = 'TabMainXE'
    _Frame2.Parent = _MainXE
    _Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _Frame2.BackgroundTransparency = 1
    _Frame2.Position = UDim2.new(0.217000037, 0, 0, 3)
    _Frame2.Size = UDim2.new(0, 448, 0, 353)
    _Frame2.Visible = false
    _UICorner.CornerRadius = UDim.new(0, 5.5)
    _UICorner.Name = 'MainXEC'
    _UICorner.Parent = _MainXE
    _Frame3.Name = 'SB'
    _Frame3.Parent = _MainXE
    _Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _Frame3.BorderColor3 = MainXEColor
    _Frame3.Size = UDim2.new(0, 0, 0, 0)
    _UICorner2.CornerRadius = UDim.new(0, 6)
    _UICorner2.Name = 'SBC'
    _UICorner2.Parent = _Frame3
    _Frame4.Name = 'Side'
    _Frame4.Parent = _Frame3
    _Frame4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _Frame4.BorderColor3 = Color3.fromRGB(255, 255, 255)
    _Frame4.BorderSizePixel = 0
    _Frame4.ClipsDescendants = true
    _Frame4.Position = UDim2.new(1, 0, 0, 0)
    _Frame4.Size = UDim2.new(0, 0, 0, 0)
    _UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, zyColor),
        ColorSequenceKeypoint.new(1, zyColor),
    })
    _UIGradient.Rotation = 90
    _UIGradient.Name = 'SideG'
    _UIGradient.Parent = _Frame4
    _MainXE.Size = UDim2.new(0, 570, 0, 358)
    _Frame4.Size = UDim2.new(0, 110, 0, 357)
    _Frame3.Size = UDim2.new(0, 8, 0, 357)
    _Frame2.Visible = true
    _UIGradient4.Parent = _ImageLabel2
    _TextLabel2.Visible = false
    _ScrollingFrame.Name = 'TabBtns'
    _ScrollingFrame.Parent = _Frame4
    _ScrollingFrame.Active = true
    _ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _ScrollingFrame.BackgroundTransparency = 1
    _ScrollingFrame.BorderSizePixel = 0
    _ScrollingFrame.Position = UDim2.new(0, 0, 0.15, 0)
    _ScrollingFrame.Size = UDim2.new(0, 110, 0, 300)
    _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
    _ScrollingFrame.ScrollBarThickness = 0
    _UIListLayout.Name = 'TabBtnsL'
    _UIListLayout.Parent = _ScrollingFrame
    _UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    _UIListLayout.Padding = UDim.new(0, 12)

    local _Frame11 = Instance.new('Frame')

    _Frame11.Name = 'SearchContainer'
    _Frame11.Parent = _Frame4
    _Frame11.BackgroundTransparency = 1
    _Frame11.Size = UDim2.new(1, 0, 0, 40)
    _Frame11.Position = UDim2.new(0, 0, 0.07, 0)

    local _TextBox = Instance.new('TextBox')

    _TextBox.Name = 'SearchBar'
    _TextBox.Parent = _Frame11
    _TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    _TextBox.BackgroundTransparency = 0.3
    _TextBox.Size = UDim2.new(0.75, 0, 0, 30)
    _TextBox.Position = UDim2.new(0.05, 0, 0, 0)
    _TextBox.PlaceholderText = '搜索选项区...'
    _TextBox.Text = ''
    _TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextBox.Font = Enum.Font.GothamBold
    _TextBox.TextSize = 14
    _TextBox.ClearTextOnFocus = false

    local _UICorner4 = Instance.new('UICorner')

    _UICorner4.CornerRadius = UDim.new(0, 6)
    _UICorner4.Parent = _TextBox

    local _UIPadding = Instance.new('UIPadding')

    _UIPadding.PaddingLeft = UDim.new(0, 10)
    _UIPadding.Parent = _TextBox

    local _ImageLabel3 = Instance.new('ImageLabel')

    _ImageLabel3.Name = 'SearchIcon'
    _ImageLabel3.Parent = _TextBox
    _ImageLabel3.Image = 'rbxassetid://95828101007163'
    _ImageLabel3.ImageColor3 = Color3.fromRGB(180, 180, 180)
    _ImageLabel3.AnchorPoint = Vector2.new(1, 0.5)
    _ImageLabel3.Position = UDim2.new(1, -8, 0.5, 0)
    _ImageLabel3.Size = UDim2.new(0, 18, 0, 18)
    _ImageLabel3.BackgroundTransparency = 1

    local _TextButton3 = Instance.new('TextButton')

    _TextButton3.Name = 'ClearButton'
    _TextButton3.Parent = _Frame11
    _TextButton3.Text = 'X'
    _TextButton3.TextColor3 = Color3.fromRGB(255, 100, 100)
    _TextButton3.BackgroundTransparency = 1
    _TextButton3.Font = Enum.Font.GothamBold
    _TextButton3.TextSize = 18
    _TextButton3.Position = UDim2.new(0.83, 0, 0, 5)
    _TextButton3.Visible = false
    _TextButton3.Size = UDim2.new(0, 0, 0, 0)

    game:GetService('TweenService'):Create(_TextButton3, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 25, 0, 25),
    }):Play()

    local v98 = _TextBox

    _TextBox.GetPropertyChangedSignal(v98, 'Text'):Connect(function()
        local v99 = string.lower(_TextBox.Text)

        _TextButton3.Visible = v99 ~= ''

        local v100 = _ScrollingFrame
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
    _TextButton3.MouseButton1Click:Connect(function()
        _TextBox.Text = ''
        _TextButton3.Visible = false
    end)
    _TextBox.Focused:Connect(function()
        game:GetService('TweenService'):Create(_TextBox, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()

        _ImageLabel3.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end)
    _TextBox.FocusLost:Connect(function()
        game:GetService('TweenService'):Create(_TextBox, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()

        _ImageLabel3.ImageColor3 = Color3.fromRGB(180, 180, 180)
    end)

    _TextLabel.Name = 'ScriptTitle'
    _TextLabel.Parent = _Frame4
    _TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _TextLabel.BackgroundTransparency = 1
    _TextLabel.Position = UDim2.new(0, 0, 0.00953488424, 0)
    _TextLabel.Size = UDim2.new(0, 102, 0, 20)
    _TextLabel.Font = Enum.Font.GothamBold
    _TextLabel.Text = p43
    _TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextLabel.TextSize = 14
    _TextLabel.TextScaled = true
    _TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    _UIGradient5.Parent = _TextLabel
    _TextLabel.TextTransparency = 0
    _TextLabel.TextStrokeTransparency = 0.5
    _TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    _TextLabel.ZIndex = 10

    coroutine.wrap(function()
        local _UIGradient7 = Instance.new('LocalScript', _TextLabel).Parent.UIGradient
        local u107 = game:GetService('TweenService'):Create(_UIGradient7, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(1, 0),
        })
        local u108 = Vector2.new(-1, 0)
        local u109 = {}
        local _new = ColorSequence.new
        local _new2 = ColorSequenceKeypoint.new
        local u112 = 'down'

        _UIGradient7.Offset = u108;

        (function()
            local v113 = 255
            local v114 = 255

            for v115 = 1, 10 do
                local v116 = v115 * 17

                table.insert(u109, Color3.fromHSV(v116 / 255, v113 / 255, v114 / 255))
            end
        end)()

        _UIGradient7.Color = _new({
            _new2(0, u109[#u109]),
            _new2(0.5, u109[#u109 - 1]),
            _new2(1, u109[#u109 - 2]),
        })

        local u117 = #u109

        local function u118()
            u107:Play()
            u107.Completed:Wait()

            _UIGradient7.Offset = u108
            _UIGradient7.Rotation = 180

            if u117 ~= #u109 - 1 or u112 ~= 'down' then
                if u117 ~= #u109 or u112 ~= 'down' then
                    if u117 <= #u109 - 2 and u112 == 'down' then
                        _UIGradient7.Color = _new({
                            _new2(0, _UIGradient7.Color.Keypoints[1].Value),
                            _new2(0.5, u109[u117 + 1]),
                            _new2(1, u109[u117 + 2]),
                        })
                        u117 = u117 + 2
                        u112 = 'up'
                    end
                else
                    _UIGradient7.Color = _new({
                        _new2(0, _UIGradient7.Color.Keypoints[1].Value),
                        _new2(0.5, u109[1]),
                        _new2(1, u109[2]),
                    })
                    u117 = 2
                    u112 = 'up'
                end
            else
                _UIGradient7.Color = _new({
                    _new2(0, _UIGradient7.Color.Keypoints[1].Value),
                    _new2(0.5, u109[#u109]),
                    _new2(1, u109[1]),
                })
                u117 = 1
                u112 = 'up'
            end

            u107:Play()
            u107.Completed:Wait()

            _UIGradient7.Offset = u108
            _UIGradient7.Rotation = 0

            if u117 ~= #u109 - 1 or u112 ~= 'up' then
                if u117 ~= #u109 or u112 ~= 'up' then
                    if u117 <= #u109 - 2 and u112 == 'up' then
                        _UIGradient7.Color = _new({
                            _new2(0, u109[u117 + 2]),
                            _new2(0.5, u109[u117 + 1]),
                            _new2(1, _UIGradient7.Color.Keypoints[3].Value),
                        })
                        u117 = u117 + 2
                        u112 = 'down'
                    end
                else
                    _UIGradient7.Color = _new({
                        _new2(0, u109[2]),
                        _new2(0.5, u109[1]),
                        _new2(1, _UIGradient7.Color.Keypoints[3].Value),
                    })
                    u117 = 2
                    u112 = 'down'
                end
            else
                _UIGradient7.Color = _new({
                    _new2(0, u109[1]),
                    _new2(0.5, u109[#u109]),
                    _new2(1, _UIGradient7.Color.Keypoints[3].Value),
                })
                u117 = 1
                u112 = 'down'
            end

            u118()
        end

        u118()
    end)()

    _UIGradient2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, zyColor),
        ColorSequenceKeypoint.new(1, zyColor),
    })
    _UIGradient2.Rotation = 90
    _UIGradient2.Name = 'SBG'
    _UIGradient2.Parent = _Frame3

    _UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout.AbsoluteContentSize.Y + 18)
    end)
    game:GetService('TweenService')

    _TextButton.Name = 'Open'
    _TextButton.Parent = _ScreenGui
    _TextButton.BackgroundColor3 = Color3.fromRGB(28, 33, 55)
    _TextButton.BackgroundTransparency = 0
    _TextButton.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    _TextButton.Size = UDim2.new(0, 61, 0, 32)
    _TextButton.Transparency = 0.75
    _TextButton.Font = Enum.Font.GothamBold
    _TextButton.Text = u67[u71].HideUI
    _TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextButton.TextTransparency = 0
    _TextButton.TextSize = 28
    _TextButton.Active = true
    _TextButton.Draggable = true

    local _UIGradient8 = Instance.new('UIGradient')

    _UIGradient8.Parent = _TextButton
    _UIGradient8.Rotation = 90
    _UIGradient8.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })

    local _TweenService = game:GetService('TweenService')
    local u121 = false

    spawn(function()
        while true do
            for _ = 0, 1, 0.01 do
                local v122 = tick() % 10 / 10

                _TextButton.TextColor3 = Color3.fromHSV(v122, 1, 1)

                wait(0.005)
            end
        end
    end)
    _TextButton.MouseButton1Click:Connect(function()
        if u121 ~= false then
            _TextButton.Text = u67[u71].HideUI
            _Frame2.Position = UDim2.new(0.217000037, 0, 0, 3)
            _MainXE.Visible = true
            u121 = false
        else
            _TextButton.Text = u67[u71].OpenUI
            _Frame2.Position = UDim2.new(0.217000037, 0, 0, 3)
            u121 = true
            _MainXE.Visible = false
        end
    end)
    drag(_MainXE)

    _UIGradient3.Parent = _TextButton

    return {
        Tab = function(_, p123, p124)
            local _ScrollingFrame2 = Instance.new('ScrollingFrame')
            local _ImageLabel4 = Instance.new('ImageLabel')
            local _TextLabel3 = Instance.new('TextLabel')
            local _TextButton4 = Instance.new('TextButton')

            Instance.new('UIListLayout')

            _ScrollingFrame2.Name = 'Tab'
            _ScrollingFrame2.Parent = _Frame2
            _ScrollingFrame2.Active = true
            _ScrollingFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            _ScrollingFrame2.BackgroundTransparency = 1
            _ScrollingFrame2.Size = UDim2.new(1, 0, 1, 0)
            _ScrollingFrame2.ScrollBarThickness = 2
            _ScrollingFrame2.Visible = false
            _ImageLabel4.Name = 'TabIco'
            _ImageLabel4.Parent = _ScrollingFrame
            _ImageLabel4.BackgroundTransparency = 1
            _ImageLabel4.BorderSizePixel = 0
            _ImageLabel4.Size = UDim2.new(0, 24, 0, 24)
            _ImageLabel4.Image = ('rbxassetid://95828101007163'):format(p124 or 4370341699)
            _ImageLabel4.ImageTransparency = 0.2
            _TextLabel3.Name = 'TabText'
            _TextLabel3.Parent = _ImageLabel4
            _TextLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            _TextLabel3.BackgroundTransparency = 1
            _TextLabel3.Position = UDim2.new(1.41666663, 0, 0, 0)
            _TextLabel3.Size = UDim2.new(0, 76, 0, 24)
            _TextLabel3.Font = Enum.Font.GothamBold
            _TextLabel3.Text = p123
            _TextLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
            _TextLabel3.TextSize = 14
            _TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
            _TextLabel3.TextTransparency = 0.2
            _TextButton4.Name = 'TabBtn'
            _TextButton4.Parent = _ImageLabel4
            _TextButton4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            _TextButton4.BackgroundTransparency = 1
            _TextButton4.BorderSizePixel = 0
            _TextButton4.Size = UDim2.new(0, 110, 0, 24)
            _TextButton4.AutoButtonColor = false
            _TextButton4.Font = Enum.Font.GothamBold
            _TextButton4.Text = ''
            _TextButton4.TextColor3 = Color3.fromRGB(0, 0, 0)
            _TextButton4.TextSize = 14

            local _Frame12 = Instance.new('Frame')

            _Frame12.Name = 'SectionSearchContainer'
            _Frame12.Parent = _ScrollingFrame2
            _Frame12.BackgroundTransparency = 1
            _Frame12.Size = UDim2.new(1, -10, 0, 40)
            _Frame12.Position = UDim2.new(0, 5, 0, 5)

            local _TextBox2 = Instance.new('TextBox')

            _TextBox2.Name = 'SectionSearchBar'
            _TextBox2.Parent = _Frame12
            _TextBox2.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            _TextBox2.BackgroundTransparency = 0.3
            _TextBox2.Size = UDim2.new(1, -60, 0, 30)
            _TextBox2.PlaceholderText = '搜索本页功能名...'
            _TextBox2.Text = ''
            _TextBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
            _TextBox2.Font = Enum.Font.GothamBold
            _TextBox2.TextSize = 14
            _TextBox2.ClearTextOnFocus = false

            local _UICorner5 = Instance.new('UICorner')

            _UICorner5.CornerRadius = UDim.new(0, 6)
            _UICorner5.Parent = _TextBox2

            local _UIPadding2 = Instance.new('UIPadding')

            _UIPadding2.PaddingLeft = UDim.new(0, 10)
            _UIPadding2.Parent = _TextBox2

            local _TextButton5 = Instance.new('TextButton')

            _TextButton5.Name = 'ClearButton'
            _TextButton5.Parent = _Frame12
            _TextButton5.Text = 'X'
            _TextButton5.TextColor3 = Color3.fromRGB(255, 100, 100)
            _TextButton5.BackgroundTransparency = 1
            _TextButton5.Font = Enum.Font.GothamBold
            _TextButton5.TextSize = 18
            _TextButton5.Size = UDim2.new(0, 25, 0, 25)
            _TextButton5.Position = UDim2.new(1, -30, 0, 2)
            _TextButton5.Visible = false

            local _TextLabel4 = Instance.new('TextLabel')

            _TextLabel4.Name = 'MatchCount'
            _TextLabel4.Parent = _Frame12
            _TextLabel4.Text = '0结果'
            _TextLabel4.TextColor3 = Color3.fromRGB(180, 180, 180)
            _TextLabel4.BackgroundTransparency = 1
            _TextLabel4.Font = Enum.Font.GothamMedium
            _TextLabel4.TextSize = 12
            _TextLabel4.Size = UDim2.new(0, 50, 0, 20)
            _TextLabel4.Position = UDim2.new(1, -55, 0, 15)
            _TextLabel4.TextXAlignment = Enum.TextXAlignment.Right

            local function u158()
                local v135 = _TextBox2 and (string.lower(_TextBox2.Text or '') or '') or ''

                if _TextButton5 then
                    _TextButton5.Visible = v135 ~= ''
                end

                local v136 = _ScrollingFrame2
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
                                    local _TextButton6 = v147:FindFirstChildOfClass('TextButton')
                                    local v149 = _TextButton6 and (_TextButton6.Text and string.find(string.lower(_TextButton6.Text), v135)) and true or false
                                    local _TextLabel5 = v147:FindFirstChildOfClass('TextLabel')
                                    local v151 = _TextLabel5 and (_TextLabel5.Text and string.find(string.lower(_TextLabel5.Text), v135)) and true or v149
                                    local _TextBox3 = v147:FindFirstChildOfClass('TextBox')

                                    if _TextBox3 and (_TextBox3.Text or _TextBox3.PlaceholderText) then
                                        v151 = (string.find(string.lower(_TextBox3.Text), v135) or string.find(string.lower(_TextBox3.PlaceholderText), v135)) and true or v151
                                    end

                                    local _SliderValue = v147:FindFirstChild('SliderValue')
                                    local v154 = _SliderValue and (_SliderValue.Text and string.find(string.lower(_SliderValue.Text), v135)) and true or v151
                                    local _DropdownText = v147:FindFirstChild('DropdownText')
                                    local v156 = _DropdownText and (_DropdownText.Text and string.find(string.lower(_DropdownText.Text), v135)) and true or v154
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

                _TextLabel4.Text = v135 == '' and '准备完毕' or v140 .. '个结果'
            end

            local v159 = _TextBox2

            _TextBox2.GetPropertyChangedSignal(v159, 'Text'):Connect(u158)
            _TextButton5.MouseButton1Click:Connect(function()
                _TextBox2.Text = ''
                _TextButton5.Visible = false

                u158()
            end)
            _TextBox2.Focused:Connect(function()
                game:GetService('TweenService'):Create(_TextBox2, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()

                _TextLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
            _TextBox2.FocusLost:Connect(function()
                game:GetService('TweenService'):Create(_TextBox2, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()

                _TextLabel4.TextColor3 = Color3.fromRGB(180, 180, 180)
            end)

            local _UIListLayout2 = Instance.new('UIListLayout')

            _UIListLayout2.Name = 'TabL'
            _UIListLayout2.Parent = _ScrollingFrame2
            _UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
            _UIListLayout2.Padding = UDim.new(0, 4)
            _UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Top
            _UIListLayout2.Padding = UDim.new(0, 8)

            _TextButton4.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(_TextButton4)
                end)

                local v161 = {_ImageLabel4, _ScrollingFrame2}

                switchTab(v161)
            end)

            if p42.currentTab == nil then
                switchTab({_ImageLabel4, _ScrollingFrame2})
            end

            _UIListLayout2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                _ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout2.AbsoluteContentSize.Y + 8)
            end)

            return {
                section = function(_, p162, p163)
                    local _Frame13 = Instance.new('Frame')
                    local _UICorner6 = Instance.new('UICorner')
                    local _TextLabel6 = Instance.new('TextLabel')
                    local _ImageLabel5 = Instance.new('ImageLabel')
                    local _ImageLabel6 = Instance.new('ImageLabel')
                    local _ImageButton = Instance.new('ImageButton')
                    local _Frame14 = Instance.new('Frame')
                    local _UIListLayout3 = Instance.new('UIListLayout')

                    _Frame13.Name = 'Section'
                    _Frame13.Parent = _ScrollingFrame2
                    _Frame13.BackgroundColor3 = zyColor
                    _Frame13.BackgroundTransparency = 1
                    _Frame13.BorderSizePixel = 0
                    _Frame13.ClipsDescendants = true
                    _Frame13.Size = UDim2.new(0.981000006, 0, 0, 36)
                    _UICorner6.CornerRadius = UDim.new(0, 6)
                    _UICorner6.Name = 'SectionC'
                    _UICorner6.Parent = _Frame13
                    _TextLabel6.Name = 'SectionText'
                    _TextLabel6.Parent = _Frame13
                    _TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    _TextLabel6.BackgroundTransparency = 1
                    _TextLabel6.Position = UDim2.new(0.0887396261, 0, 0, 0)
                    _TextLabel6.Size = UDim2.new(0, 401, 0, 36)
                    _TextLabel6.Font = Enum.Font.GothamBold
                    _TextLabel6.Text = p162
                    _TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _TextLabel6.TextSize = 16
                    _TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
                    _ImageLabel5.Name = 'SectionOpen'
                    _ImageLabel5.Parent = _TextLabel6
                    _ImageLabel5.BackgroundTransparency = 1
                    _ImageLabel5.BorderSizePixel = 0
                    _ImageLabel5.Position = UDim2.new(0, -33, 0, 5)
                    _ImageLabel5.Size = UDim2.new(0, 26, 0, 26)
                    _ImageLabel5.Image = 'http://www.roblox.com/asset/?id=6031302934'
                    _ImageLabel6.Name = 'SectionOpened'
                    _ImageLabel6.Parent = _ImageLabel5
                    _ImageLabel6.BackgroundTransparency = 1
                    _ImageLabel6.BorderSizePixel = 0
                    _ImageLabel6.Size = UDim2.new(0, 26, 0, 26)
                    _ImageLabel6.Image = 'http://www.roblox.com/asset/?id=6031302932'
                    _ImageLabel6.ImageTransparency = 1
                    _ImageButton.Name = 'SectionToggle'
                    _ImageButton.Parent = _ImageLabel5
                    _ImageButton.BackgroundTransparency = 1
                    _ImageButton.BorderSizePixel = 0
                    _ImageButton.Size = UDim2.new(0, 26, 0, 26)
                    _Frame14.Name = 'Objs'
                    _Frame14.Parent = _Frame13
                    _Frame14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    _Frame14.BackgroundTransparency = 1
                    _Frame14.BorderSizePixel = 0
                    _Frame14.Position = UDim2.new(0, 6, 0, 36)
                    _Frame14.Size = UDim2.new(0.986347735, 0, 0, 0)
                    _UIListLayout3.Name = 'ObjsL'
                    _UIListLayout3.Parent = _Frame14
                    _UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
                    _UIListLayout3.Padding = UDim.new(0, 8)

                    local u172 = p163

                    if p163 ~= false then
                        _Frame13.Size = UDim2.new(0.981000006, 0, 0, u172 and (36 + _UIListLayout3.AbsoluteContentSize.Y + 8 or 36) or 36)
                        _ImageLabel6.ImageTransparency = u172 and 0 or 1
                        _ImageLabel5.ImageTransparency = u172 and 1 or 0
                    end

                    _ImageButton.MouseButton1Click:Connect(function()
                        u172 = not u172
                        _Frame13.Size = UDim2.new(0.981000006, 0, 0, u172 and 36 + _UIListLayout3.AbsoluteContentSize.Y + 8 or 36)
                        _ImageLabel6.ImageTransparency = u172 and 0 or 1
                        _ImageLabel5.ImageTransparency = u172 and 1 or 0
                    end)
                    _UIListLayout3:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                        if u172 then
                            _Frame13.Size = UDim2.new(0.981000006, 0, 0, 36 + _UIListLayout3.AbsoluteContentSize.Y + 8)
                        end
                    end)

                    return {
                        Button = function(_, p173, p174)
                            local u175 = p174 or function() end
                            local _Frame15 = Instance.new('Frame')
                            local _TextButton7 = Instance.new('TextButton')
                            local _UICorner7 = Instance.new('UICorner')

                            _Frame15.Name = 'BtnModule'
                            _Frame15.Parent = _Frame14
                            _Frame15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame15.BackgroundTransparency = 0.2
                            _Frame15.BorderSizePixel = 0
                            _Frame15.Position = UDim2.new(0, 0, 0, 0)
                            _Frame15.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton7.Name = 'Btn'
                            _TextButton7.Parent = _Frame15
                            _TextButton7.BackgroundColor3 = zyColor
                            _TextButton7.BorderSizePixel = 0
                            _TextButton7.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton7.AutoButtonColor = false
                            _TextButton7.Font = Enum.Font.GothamBold
                            _TextButton7.Text = '   ' .. p173
                            _TextButton7.TextColor3 = Color3.fromRGB(0, 255, 255)
                            _TextButton7.TextSize = 16
                            _TextButton7.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner7.CornerRadius = UDim.new(0, 6)
                            _UICorner7.Name = 'BtnC'
                            _UICorner7.Parent = _TextButton7

                            _TextButton7.MouseEnter:Connect(function()
                                game:GetService('TweenService'):Create(_TextButton7, TweenInfo.new(0.2), {
                                    Size = UDim2.new(0, 438, 0, 42),
                                }):Play()
                            end)
                            _TextButton7.MouseLeave:Connect(function()
                                game:GetService('TweenService'):Create(_TextButton7, TweenInfo.new(0.2), {
                                    Size = UDim2.new(0, 428, 0, 38),
                                }):Play()
                            end)
                            _TextButton7.MouseButton1Click:Connect(function()
                                spawn(function()
                                    Ripple(_TextButton7)
                                end)
                                Tween(_TextButton7, {
                                    0.1,
                                    'Sine',
                                    'InOut',
                                }, {
                                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                                })
                                wait(0.1)
                                Tween(_TextButton7, {
                                    0.1,
                                    'Sine',
                                    'InOut',
                                }, {BackgroundColor3 = zyColor})
                                spawn(u175)
                            end)
                        end,
                        LabelTransparency = function(_, _)
                            local _Frame16 = Instance.new('Frame')

                            Instance.new('TextLabel')
                            Instance.new('UICorner')

                            _Frame16.Name = 'LabelModuleE'
                            _Frame16.Parent = _Frame14
                            _Frame16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame16.BackgroundTransparency = 1
                            _Frame16.BorderSizePixel = 0
                            _Frame16.Position = UDim2.new(0, 0, NAN, 0)
                            _Frame16.Size = UDim2.new(0, 428, 0, 19)
                            TextLabel.Parent = _Frame16
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
                            local _Frame17 = Instance.new('Frame')

                            _Frame17.Parent = TextLabelE
                            _Frame17.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                            _Frame17.Size = UDim2.new(0, 0, 1, 2)
                            _Frame17.Position = UDim2.new(0, 0, 0, -1)
                            _Frame17.ZIndex = -1

                            spawn(function()
                                while wait(1) do
                                    _Frame17:TweenPosition(UDim2.new(1, 0, 0, -1), 'Out', 'Linear', 0.5)
                                    wait(0.5)

                                    _Frame17.Position = UDim2.new(0, 0, 0, -1)
                                end
                            end)

                            local _Frame18 = Instance.new('Frame')
                            local _TextLabel7 = Instance.new('TextLabel')
                            local _UICorner8 = Instance.new('UICorner')

                            _Frame18.Name = 'LabelModule'
                            _Frame18.Parent = _Frame14
                            _Frame18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame18.BackgroundTransparency = 1
                            _Frame18.BorderSizePixel = 0
                            _Frame18.Position = UDim2.new(0, 0, NAN, 0)
                            _Frame18.Size = UDim2.new(0, 428, 0, 19)
                            _TextLabel7.Parent = _Frame18
                            _TextLabel7.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            _TextLabel7.Size = UDim2.new(0, 428, 0, 22)
                            _TextLabel7.Font = Enum.Font.GothamBold
                            _TextLabel7.Text = '   ' .. p180
                            _TextLabel7.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextLabel7.TextSize = 14
                            _TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner8.CornerRadius = UDim.new(0, 6)
                            _UICorner8.Name = 'LabelCE'
                            _UICorner8.Parent = _TextLabel7

                            return _TextLabel7
                        end,
                        Toggle = function(_, p185, p186, p187, p188)
                            local u189 = p188 or function() end
                            local v190 = p187 or false

                            assert(p185, 'No text provided')
                            assert(p186, 'No flag provided')

                            p42.flags[p186] = v190

                            local _Frame19 = Instance.new('Frame')
                            local _TextButton8 = Instance.new('TextButton')
                            local _UICorner9 = Instance.new('UICorner')
                            local _Frame20 = Instance.new('Frame')
                            local _Frame21 = Instance.new('Frame')
                            local _UICorner10 = Instance.new('UICorner')
                            local _UICorner11 = Instance.new('UICorner')

                            _Frame19.Name = 'ToggleModule'
                            _Frame19.Parent = _Frame14
                            _Frame19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame19.BackgroundTransparency = 1
                            _Frame19.BorderSizePixel = 0
                            _Frame19.Position = UDim2.new(0, 0, 0, 0)
                            _Frame19.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton8.Name = 'ToggleBtn'
                            _TextButton8.Parent = _Frame19
                            _TextButton8.BackgroundColor3 = zyColor
                            _TextButton8.BorderSizePixel = 0
                            _TextButton8.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton8.AutoButtonColor = false
                            _TextButton8.Font = Enum.Font.GothamBold
                            _TextButton8.Text = '   ' .. p185
                            _TextButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton8.TextSize = 16
                            _TextButton8.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner9.CornerRadius = UDim.new(0, 6)
                            _UICorner9.Name = 'ToggleBtnC'
                            _UICorner9.Parent = _TextButton8
                            _Frame20.Name = 'ToggleDisable'
                            _Frame20.Parent = _TextButton8
                            _Frame20.BackgroundColor3 = Background
                            _Frame20.BorderSizePixel = 0
                            _Frame20.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                            _Frame20.Size = UDim2.new(0, 36, 0, 22)
                            _Frame21.Name = 'ToggleSwitch'
                            _Frame21.Parent = _Frame20

                            local _UIGradient9 = Instance.new('UIGradient')

                            _UIGradient9.Parent = _Frame21
                            _UIGradient9.Rotation = 90
                            _UIGradient9.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
                            })

                            spawn(function()
                                while wait(0.5) do
                                    game:GetService('TweenService'):Create(_Frame21, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.new(0, 26, 0, 22),
                                    }):Play()
                                    wait(0.3)
                                    game:GetService('TweenService'):Create(_Frame21, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Size = UDim2.new(0, 24, 0, 22),
                                    }):Play()
                                end
                            end)

                            _Frame21.Size = UDim2.new(0, 24, 0, 22)
                            _UICorner10.CornerRadius = UDim.new(0, 6)
                            _UICorner10.Name = 'ToggleSwitchC'
                            _UICorner10.Parent = _Frame21
                            _UICorner11.CornerRadius = UDim.new(0, 6)
                            _UICorner11.Name = 'ToggleDisableC'
                            _UICorner11.Parent = _Frame20

                            local u200 = {
                                SetState = function(_, p199)
                                    if p199 == nil then
                                        p199 = not p42.flags[p186]
                                    end
                                    if p42.flags[p186] ~= p199 then
                                        u4.TweenService:Create(_Frame21, TweenInfo.new(0.2), {
                                            Position = UDim2.new(0, p199 and _Frame21.Size.X.Offset / 2 or 0, 0, 0),
                                            BackgroundColor3 = p199 and Color3.fromRGB(255, 255, 255) or beijingColor,
                                        }):Play()

                                        p42.flags[p186] = p199

                                        u189(p199)
                                    end
                                end,
                                Module = _Frame19,
                            }

                            if v190 ~= false then
                                u200:SetState(p186, true)
                            end

                            local _UIGradient10 = Instance.new('UIGradient')

                            _UIGradient10.Parent = parent
                            _UIGradient10.Rotation = 90
                            _UIGradient10.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local v202 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)

                            _TweenService:Create(_UIGradient10, v202, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()

                            local _UIStroke2 = Instance.new('UIStroke')

                            _UIStroke2.Parent = _TextButton8
                            _UIStroke2.Thickness = 2
                            _UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                            local _UIGradient11 = Instance.new('UIGradient')

                            _UIGradient11.Parent = _UIStroke2
                            _UIGradient11.Rotation = 90
                            _UIGradient11.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                            })

                            _TweenService:Create(_UIGradient11, v202, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()
                            _TextButton8.MouseButton1Click:Connect(function()
                                u200:SetState()
                            end)

                            return u200
                        end,
                        Keybind = function(_, p205, p206, p207)
                            local u208 = p207 or function() end

                            assert(p205, 'No text provided')
                            assert(p206, 'No default key provided')

                            if typeof(p206) == 'string' then
                                p206 = Enum.KeyCode[p206] or p206
                            end

                            local u209 = {
                                Return = true,
                                Space = true,
                                Tab = true,
                                Backquote = true,
                                CapsLock = true,
                                Escape = true,
                                Unknown = true,
                            }
                            local u210 = {
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
                            local u211 = not p206 or u210[p206.Name] or (p206.Name or 'None')
                            local _Frame22 = Instance.new('Frame')
                            local _TextButton9 = Instance.new('TextButton')
                            local _UICorner12 = Instance.new('UICorner')
                            local _TextButton10 = Instance.new('TextButton')
                            local _UICorner13 = Instance.new('UICorner')
                            local _UIListLayout4 = Instance.new('UIListLayout')
                            local _UIPadding3 = Instance.new('UIPadding')

                            _Frame22.Name = 'KeybindModule'
                            _Frame22.Parent = _Frame14
                            _Frame22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame22.BackgroundTransparency = 1
                            _Frame22.BorderSizePixel = 0
                            _Frame22.Position = UDim2.new(0, 0, 0, 0)
                            _Frame22.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton9.Name = 'KeybindBtn'
                            _TextButton9.Parent = _Frame22
                            _TextButton9.BackgroundColor3 = zyColor
                            _TextButton9.BorderSizePixel = 0
                            _TextButton9.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton9.AutoButtonColor = false
                            _TextButton9.Font = Enum.Font.GothamBold
                            _TextButton9.Text = '   ' .. p205
                            _TextButton9.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton9.TextSize = 16
                            _TextButton9.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner12.CornerRadius = UDim.new(0, 6)
                            _UICorner12.Name = 'KeybindBtnC'
                            _UICorner12.Parent = _TextButton9
                            _TextButton10.Name = 'KeybindValue'
                            _TextButton10.Parent = _TextButton9
                            _TextButton10.BackgroundColor3 = Background
                            _TextButton10.BorderSizePixel = 0
                            _TextButton10.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            _TextButton10.Size = UDim2.new(0, 100, 0, 28)
                            _TextButton10.AutoButtonColor = false
                            _TextButton10.Font = Enum.Font.GothamBold
                            _TextButton10.Text = u211
                            _TextButton10.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton10.TextSize = 14
                            _UICorner13.CornerRadius = UDim.new(0, 6)
                            _UICorner13.Name = 'KeybindValueC'
                            _UICorner13.Parent = _TextButton10
                            _UIListLayout4.Name = 'KeybindL'
                            _UIListLayout4.Parent = _TextButton9
                            _UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            _UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
                            _UIListLayout4.VerticalAlignment = Enum.VerticalAlignment.Center
                            _UIPadding3.Parent = _TextButton9
                            _UIPadding3.PaddingRight = UDim.new(0, 6)

                            u4.UserInputService.InputBegan:Connect(function(p219, p220)
                                if p220 then
                                    return
                                elseif p219.UserInputType == Enum.UserInputType.Keyboard then
                                    if p219.KeyCode == p206 then
                                        u208(p206.Name)
                                    end
                                else
                                    return
                                end
                            end)
                            _TextButton10.MouseButton1Click:Connect(function()
                                _TextButton10.Text = '...'

                                wait()

                                local v221, _ = u4.UserInputService.InputEnded:Wait()
                                local v222 = tostring(v221.KeyCode.Name)

                                if v221.UserInputType == Enum.UserInputType.Keyboard then
                                    if u209[v222] then
                                        _TextButton10.Text = u211
                                    else
                                        wait()

                                        p206 = Enum.KeyCode[v222]
                                        _TextButton10.Text = u210[v222] or v222
                                    end
                                else
                                    _TextButton10.Text = u211

                                    return
                                end
                            end)

                            local v223 = _TextButton10

                            _TextButton10.GetPropertyChangedSignal(v223, 'TextBounds'):Connect(function()
                                _TextButton10.Size = UDim2.new(0, _TextButton10.TextBounds.X + 30, 0, 28)
                            end)

                            _TextButton10.Size = UDim2.new(0, _TextButton10.TextBounds.X + 30, 0, 28)
                        end,
                        Textbox = function(_, p224, p225, p226, p227)
                            local u228 = p227 or function() end

                            assert(p224, 'No text provided')
                            assert(p225, 'No flag provided')
                            assert(p226, 'No default text provided')

                            p42.flags[p225] = p226

                            local _Frame23 = Instance.new('Frame')
                            local _TextButton11 = Instance.new('TextButton')
                            local _UICorner14 = Instance.new('UICorner')
                            local _TextButton12 = Instance.new('TextButton')
                            local _UICorner15 = Instance.new('UICorner')
                            local _TextBox4 = Instance.new('TextBox')
                            local _UIListLayout5 = Instance.new('UIListLayout')
                            local _UIPadding4 = Instance.new('UIPadding')

                            _Frame23.Name = 'TextboxModule'
                            _Frame23.Parent = _Frame14
                            _Frame23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame23.BackgroundTransparency = 1
                            _Frame23.BorderSizePixel = 0
                            _Frame23.Position = UDim2.new(0, 0, 0, 0)
                            _Frame23.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton11.Name = 'TextboxBack'
                            _TextButton11.Parent = _Frame23
                            _TextButton11.BackgroundColor3 = zyColor
                            _TextButton11.BorderSizePixel = 0
                            _TextButton11.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton11.AutoButtonColor = false
                            _TextButton11.Font = Enum.Font.GothamBold
                            _TextButton11.Text = '   ' .. p224
                            _TextButton11.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton11.TextSize = 16
                            _TextButton11.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner14.CornerRadius = UDim.new(0, 6)
                            _UICorner14.Name = 'TextboxBackC'
                            _UICorner14.Parent = _TextButton11
                            _TextButton12.Name = 'BoxBG'
                            _TextButton12.Parent = _TextButton11

                            local _UIGradient12 = Instance.new('UIGradient')

                            _UIGradient12.Parent = _TextButton12
                            _UIGradient12.Rotation = 90
                            _UIGradient12.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120)),
                            })

                            _TextBox4.Focused:Connect(function()
                                game:GetService('TweenService'):Create(_UIGradient12, TweenInfo.new(0.3), {
                                    Rotation = 180,
                                    Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 200)),
                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 250)),
                                    }),
                                }):Play()
                            end)
                            _TextBox4.FocusLost:Connect(function()
                                game:GetService('TweenService'):Create(_UIGradient12, TweenInfo.new(0.3), {
                                    Rotation = 90,
                                    Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 100)),
                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 120)),
                                    }),
                                }):Play()
                            end)

                            _TextButton12.BorderSizePixel = 0
                            _TextButton12.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            _TextButton12.Size = UDim2.new(0, 100, 0, 28)
                            _TextButton12.AutoButtonColor = false
                            _TextButton12.Font = Enum.Font.GothamBold
                            _TextButton12.Text = ''
                            _TextButton12.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton12.TextSize = 14
                            _UICorner15.CornerRadius = UDim.new(0, 6)
                            _UICorner15.Name = 'BoxBGC'
                            _UICorner15.Parent = _TextButton12
                            _TextBox4.Parent = _TextButton12
                            _TextBox4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox4.BackgroundTransparency = 1
                            _TextBox4.BorderSizePixel = 0
                            _TextBox4.Size = UDim2.new(1, 0, 1, 0)
                            _TextBox4.Font = Enum.Font.GothamBold
                            _TextBox4.Text = p226
                            _TextBox4.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox4.TextSize = 14
                            _TextBox4.TextXAlignment = Enum.TextXAlignment.Left
                            _UIListLayout5.Name = 'TextboxBackL'
                            _UIListLayout5.Parent = _TextButton11
                            _UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            _UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
                            _UIListLayout5.VerticalAlignment = Enum.VerticalAlignment.Center
                            _UIPadding4.Name = 'TextboxBackP'
                            _UIPadding4.Parent = _TextButton11
                            _UIPadding4.PaddingRight = UDim.new(0, 6)

                            _TextBox4.FocusLost:Connect(function()
                                if _TextBox4.Text == '' then
                                    _TextBox4.Text = p226
                                end

                                p42.flags[p225] = _TextBox4.Text

                                u228(_TextBox4.Text)
                            end)

                            local v238 = _TextBox4

                            _TextBox4.GetPropertyChangedSignal(v238, 'TextBounds'):Connect(function()
                                local v239 = _TextBox4.TextBounds.X + 30

                                _TextButton12.Size = UDim2.new(0, math.clamp(v239, 100, 325), 0, 28)
                                _TextBox4.TextXAlignment = Enum.TextXAlignment.Left
                            end)

                            _TextButton12.Size = UDim2.new(0, math.clamp(_TextBox4.TextBounds.X + 30, 100, 325), 0, 28)
                        end,
                        Slider = function(_, p240, p241, p242, p243, p244, p245, p246)
                            local u247 = p246 or function() end
                            local u248 = p243 or 1
                            local u249 = p244 or 10
                            local u250 = p242 or u248
                            local u251 = p245 or false

                            p42.flags[p241] = u250

                            assert(p240, 'No text provided')
                            assert(p241, 'No flag provided')
                            assert(u250, 'No default value provided')

                            local _Frame24 = Instance.new('Frame')
                            local _TextButton13 = Instance.new('TextButton')
                            local _UICorner16 = Instance.new('UICorner')
                            local _Frame25 = Instance.new('Frame')
                            local _UICorner17 = Instance.new('UICorner')
                            local _Frame26 = Instance.new('Frame')
                            local _UICorner18 = Instance.new('UICorner')
                            local _TextButton14 = Instance.new('TextButton')
                            local _UICorner19 = Instance.new('UICorner')
                            local _TextBox5 = Instance.new('TextBox')
                            local _TextButton15 = Instance.new('TextButton')
                            local _TextButton16 = Instance.new('TextButton')

                            _Frame24.Name = 'SliderModule'
                            _Frame24.Parent = _Frame14
                            _Frame24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame24.BackgroundTransparency = 1
                            _Frame24.BorderSizePixel = 0
                            _Frame24.Position = UDim2.new(0, 0, 0, 0)
                            _Frame24.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton13.Name = 'SliderBack'
                            _TextButton13.Parent = _Frame24
                            _TextButton13.BackgroundColor3 = zyColor
                            _TextButton13.BorderSizePixel = 0
                            _TextButton13.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton13.AutoButtonColor = false
                            _TextButton13.Font = Enum.Font.GothamBold
                            _TextButton13.Text = '   ' .. p240
                            _TextButton13.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton13.TextSize = 16
                            _TextButton13.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner16.CornerRadius = UDim.new(0, 6)
                            _UICorner16.Name = 'SliderBackC'
                            _UICorner16.Parent = _TextButton13
                            _Frame25.Name = 'SliderBar'
                            _Frame25.Parent = _TextButton13
                            _Frame25.AnchorPoint = Vector2.new(0, 0.5)
                            _Frame25.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
                            _Frame25.BorderSizePixel = 0
                            _Frame25.Position = UDim2.new(0.35, 0, 0.5, 0)
                            _Frame25.Size = UDim2.new(0, 180, 0, 6)

                            local _UIStroke3 = Instance.new('UIStroke')

                            _UIStroke3.Parent = _Frame25
                            _UIStroke3.Color = Color3.fromRGB(0, 200, 255)
                            _UIStroke3.Thickness = 1
                            _UIStroke3.Transparency = 0.7
                            _UICorner17.CornerRadius = UDim.new(1, 0)
                            _UICorner17.Name = 'SliderBarC'
                            _UICorner17.Parent = _Frame25
                            _Frame26.Name = 'SliderPart'
                            _Frame26.Parent = _Frame25
                            _Frame26.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                            _Frame26.BorderSizePixel = 0
                            _Frame26.Size = UDim2.new(0, 0, 1, 0)

                            local _UIGradient13 = Instance.new('UIGradient')

                            _UIGradient13.Parent = _Frame26
                            _UIGradient13.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255)),
                            })
                            _UIGradient13.Rotation = 0

                            local _Frame27 = Instance.new('Frame')

                            _Frame27.Name = 'SliderHandle'
                            _Frame27.Parent = _Frame26
                            _Frame27.AnchorPoint = Vector2.new(0.5, 0.5)
                            _Frame27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame27.BorderSizePixel = 0
                            _Frame27.Position = UDim2.new(1, 0, 0.5, 0)
                            _Frame27.Size = UDim2.new(0, 12, 0, 12)

                            local _UICorner20 = Instance.new('UICorner')

                            _UICorner20.CornerRadius = UDim.new(1, 0)
                            _UICorner20.Parent = _Frame27

                            local _UIStroke4 = Instance.new('UIStroke')

                            _UIStroke4.Parent = _Frame27
                            _UIStroke4.Color = Color3.fromRGB(0, 255, 255)
                            _UIStroke4.Thickness = 2
                            _UIStroke4.Transparency = 0.5
                            _UICorner18.CornerRadius = UDim.new(0, 4)
                            _UICorner18.Name = 'SliderPartC'
                            _UICorner18.Parent = _Frame26
                            _TextButton14.Name = 'SliderValBG'
                            _TextButton14.Parent = _TextButton13
                            _TextButton14.BackgroundColor3 = Background
                            _TextButton14.BorderSizePixel = 0
                            _TextButton14.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                            _TextButton14.Size = UDim2.new(0, 44, 0, 28)
                            _TextButton14.AutoButtonColor = false
                            _TextButton14.Font = Enum.Font.GothamBold
                            _TextButton14.Text = ''
                            _TextButton14.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton14.TextSize = 14
                            _UICorner19.CornerRadius = UDim.new(0, 6)
                            _UICorner19.Name = 'SliderValBGC'
                            _UICorner19.Parent = _TextButton14
                            _TextBox5.Name = 'SliderValue'
                            _TextBox5.Parent = _TextButton14
                            _TextBox5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox5.BackgroundTransparency = 1
                            _TextBox5.BorderSizePixel = 0
                            _TextBox5.Size = UDim2.new(1, 0, 1, 0)
                            _TextBox5.Font = Enum.Font.GothamBold
                            _TextBox5.Text = '1000'
                            _TextBox5.TextColor3 = Color3.fromRGB(255, 0, 0)
                            _TextBox5.TextSize = 14
                            _TextButton15.Name = 'MinSlider'
                            _TextButton15.Parent = _Frame24
                            _TextButton15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton15.BackgroundTransparency = 1
                            _TextButton15.BorderSizePixel = 0
                            _TextButton15.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                            _TextButton15.Size = UDim2.new(0, 20, 0, 20)
                            _TextButton15.Font = Enum.Font.GothamBold
                            _TextButton15.Text = ''
                            _TextButton15.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton15.TextSize = 24
                            _TextButton15.TextWrapped = true
                            _TextButton16.Name = 'AddSlider'
                            _TextButton16.Parent = _Frame24
                            _TextButton16.AnchorPoint = Vector2.new(0, 0.5)
                            _TextButton16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton16.BackgroundTransparency = 1
                            _TextButton16.BorderSizePixel = 0
                            _TextButton16.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                            _TextButton16.Size = UDim2.new(0, 20, 0, 20)
                            _TextButton16.Font = Enum.Font.GothamBold
                            _TextButton16.Text = ''
                            _TextButton16.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton16.TextSize = 24
                            _TextButton16.TextWrapped = true

                            local u273 = {
                                SetValue = function(_, p269)
                                    local v270 = (u5.X - _Frame25.AbsolutePosition.X) / _Frame25.AbsoluteSize.X

                                    if p269 then
                                        v270 = (p269 - u248) / (u249 - u248)
                                    end

                                    local v271 = math.clamp(v270, 0, 1)
                                    local v272

                                    if u251 then
                                        v272 = p269 or tonumber(string.format('%.1f', tostring(u248 + (u249 - u248) * v271)))
                                    else
                                        v272 = p269 or math.floor(u248 + (u249 - u248) * v271)
                                    end

                                    p42.flags[p241] = tonumber(v272)
                                    _TextBox5.Text = tostring(v272)
                                    _Frame26.Size = UDim2.new(v271, 0, 1, 0)

                                    game:GetService('TweenService'):Create(_Frame27, TweenInfo.new(0.1), {
                                        Position = UDim2.new(v271, 0, 0.5, 0),
                                    }):Play()
                                    u247(tonumber(v272))
                                end,
                            }

                            _TextButton15.MouseButton1Click:Connect(function()
                                local v274 = p42.flags[p241]

                                u273:SetValue((math.clamp(v274 - 1, u248, u249)))
                            end)
                            _TextButton16.MouseButton1Click:Connect(function()
                                local v275 = p42.flags[p241]

                                u273:SetValue((math.clamp(v275 + 1, u248, u249)))
                            end)

                            local v276 = u273

                            u273.SetValue(v276, u250)

                            local u277 = false
                            local u278 = false
                            local u279 = {
                                [''] = true,
                                ['-'] = true,
                            }

                            _Frame25.InputBegan:Connect(function(p280)
                                if p280.UserInputType == Enum.UserInputType.MouseButton1 then
                                    u273:SetValue()

                                    u277 = true
                                end
                            end)
                            u4.UserInputService.InputEnded:Connect(function(p281)
                                if u277 and p281.UserInputType == Enum.UserInputType.MouseButton1 then
                                    u277 = false
                                end
                            end)
                            u4.UserInputService.InputChanged:Connect(function(p282)
                                if u277 and p282.UserInputType == Enum.UserInputType.MouseMovement then
                                    u273:SetValue()
                                end
                            end)
                            _Frame25.InputBegan:Connect(function(p283)
                                if p283.UserInputType == Enum.UserInputType.Touch then
                                    u273:SetValue()

                                    u277 = true
                                end
                            end)
                            u4.UserInputService.InputEnded:Connect(function(p284)
                                if u277 and p284.UserInputType == Enum.UserInputType.Touch then
                                    u277 = false
                                end
                            end)
                            u4.UserInputService.InputChanged:Connect(function(p285)
                                if u277 and p285.UserInputType == Enum.UserInputType.Touch then
                                    u273:SetValue()
                                end
                            end)
                            _TextBox5.Focused:Connect(function()
                                u278 = true
                            end)
                            _TextBox5.FocusLost:Connect(function()
                                u278 = false

                                if _TextBox5.Text == '' then
                                    u273:SetValue(u250)
                                end
                            end)

                            local v286 = _TextBox5

                            _TextBox5.GetPropertyChangedSignal(v286, 'Text'):Connect(function()
                                if u278 then
                                    _TextBox5.Text = _TextBox5.Text:gsub('%D+', '')

                                    local _Text = _TextBox5.Text

                                    if tonumber(_Text) then
                                        if not u279[_Text] then
                                            if u249 < tonumber(_Text) then
                                                _Text = u249
                                                _TextBox5.Text = tostring(u249)
                                            end

                                            u273:SetValue(tonumber(_Text))
                                        end
                                    else
                                        _TextBox5.Text = _TextBox5.Text:gsub('%D+', '')
                                    end
                                end
                            end)

                            return u273
                        end,
                        Dropdown = function(_, p288, p289, p290, p291)
                            local u292 = p291 or function() end

                            assert(p288, 'No text provided')
                            assert(p289, 'No flag provided')

                            p42.flags[p289] = nil

                            local _Frame28 = Instance.new('Frame')
                            local _TextButton17 = Instance.new('TextButton')
                            local _UICorner21 = Instance.new('UICorner')
                            local _TextButton18 = Instance.new('TextButton')
                            local _TextBox6 = Instance.new('TextBox')
                            local _UIListLayout6 = Instance.new('UIListLayout')

                            Instance.new('TextButton')
                            Instance.new('UICorner')

                            _Frame28.Name = 'DropdownModule'
                            _Frame28.Parent = _Frame14
                            _Frame28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _Frame28.BackgroundTransparency = 1
                            _Frame28.BorderSizePixel = 0
                            _Frame28.ClipsDescendants = true
                            _Frame28.Position = UDim2.new(0, 0, 0, 0)
                            _Frame28.Size = UDim2.new(0, 428, 0, 38)

                            local _Frame29 = Instance.new('Frame')

                            _Frame29.Parent = _Frame28
                            _Frame29.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                            _Frame29.Size = UDim2.new(1, -20, 0, 2)
                            _Frame29.Position = UDim2.new(0, 10, 1, -5)
                            _Frame29.Visible = false

                            _TextButton18.MouseEnter:Connect(function()
                                _Frame29.Visible = true

                                game:GetService('TweenService'):Create(_Frame29, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                            end)

                            _TextButton17.Name = 'DropdownTop'
                            _TextButton17.Parent = _Frame28

                            local _UIGradient14 = Instance.new('UIGradient')

                            _UIGradient14.Parent = _TextButton17
                            _UIGradient14.Rotation = 90
                            _UIGradient14.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local _UIStroke5 = Instance.new('UIStroke')

                            _UIStroke5.Parent = _TextButton17
                            _UIStroke5.Thickness = 2
                            _UIStroke5.Color = Color3.fromRGB(255, 255, 255)
                            _UIStroke5.Transparency = 0.5

                            spawn(function()
                                while wait(0.1) do
                                    _UIStroke5.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                                end
                            end)

                            _TextButton17.BorderSizePixel = 0
                            _TextButton17.Size = UDim2.new(0, 428, 0, 38)
                            _TextButton17.AutoButtonColor = false
                            _TextButton17.Font = Enum.Font.GothamBold
                            _TextButton17.Text = ''
                            _TextButton17.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton17.TextSize = 16
                            _TextButton17.TextXAlignment = Enum.TextXAlignment.Left
                            _UICorner21.CornerRadius = UDim.new(0, 6)
                            _UICorner21.Name = 'DropdownTopC'
                            _UICorner21.Parent = _TextButton17
                            _TextButton18.Name = 'DropdownOpen'
                            _TextButton18.Parent = _TextButton17
                            _TextButton18.AnchorPoint = Vector2.new(0, 0.5)
                            _TextButton18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton18.BackgroundTransparency = 1
                            _TextButton18.BorderSizePixel = 0
                            _TextButton18.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                            _TextButton18.Size = UDim2.new(0, 20, 0, 20)
                            _TextButton18.Font = Enum.Font.GothamBold
                            _TextButton18.Text = '+'
                            _TextButton18.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextButton18.TextSize = 24
                            _TextButton18.TextWrapped = true
                            _TextBox6.Name = 'DropdownText'
                            _TextBox6.Parent = _TextButton17
                            _TextBox6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox6.BackgroundTransparency = 1
                            _TextBox6.BorderSizePixel = 0
                            _TextBox6.Position = UDim2.new(0.0373831764, 0, 0, 0)
                            _TextBox6.Size = UDim2.new(0, 184, 0, 38)
                            _TextBox6.Font = Enum.Font.GothamBold
                            _TextBox6.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox6.PlaceholderText = p288
                            _TextBox6.Text = p288 .. '|' .. u67[u71].Currently
                            _TextBox6.TextColor3 = Color3.fromRGB(255, 255, 255)
                            _TextBox6.TextSize = 16
                            _TextBox6.TextXAlignment = Enum.TextXAlignment.Left
                            _UIListLayout6.Name = 'DropdownModuleL'
                            _UIListLayout6.Parent = _Frame28
                            _UIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
                            _UIListLayout6.Padding = UDim.new(0, 4)

                            local function u305()
                                local v302 = _Frame28:GetChildren()

                                for v303 = 1, #v302 do
                                    local v304 = v302[v303]

                                    if v304:IsA('TextButton') then
                                        if v304.Name:match('Option_') then
                                            v304.Visible = true
                                        end
                                    end
                                end
                            end
                            local function u310(p306)
                                local v307 = _Frame28:GetChildren()

                                for v308 = 1, #v307 do
                                    local v309 = v307[v308]

                                    if p306 == '' then
                                        u305()
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

                            local u311 = false

                            local function u312()
                                u311 = not u311

                                if u311 then
                                    u305()
                                end

                                _TextButton18.Text = u311 and '-' or '+'
                                _Frame28.Size = UDim2.new(0, 428, 0, u311 and _UIListLayout6.AbsoluteContentSize.Y + 4 or 38)
                            end

                            local _UIGradient15 = Instance.new('UIGradient')

                            _UIGradient15.Parent = parent
                            _UIGradient15.Rotation = 90
                            _UIGradient15.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
                            })

                            local v314 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1)

                            _TweenService:Create(_UIGradient15, v314, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()

                            local _UIStroke6 = Instance.new('UIStroke')

                            _UIStroke6.Parent = _TextButton17
                            _UIStroke6.Thickness = 2
                            _UIStroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                            local _UIGradient16 = Instance.new('UIGradient')

                            _UIGradient16.Parent = _UIStroke6
                            _UIGradient16.Rotation = 90
                            _UIGradient16.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                            })

                            _TweenService:Create(_UIGradient16, v314, {
                                Rotation = 360,
                                Offset = Vector2.new(1, 0),
                            }):Play()
                            _TextButton18.MouseButton1Click:Connect(u312)
                            _TextBox6.Focused:Connect(function()
                                if not u311 then
                                    u312()
                                end
                            end)

                            local v317 = _TextBox6

                            _TextBox6.GetPropertyChangedSignal(v317, 'Text'):Connect(function()
                                if u311 then
                                    u310(_TextBox6.Text)
                                end
                            end)

                            local v318 = _UIListLayout6

                            _UIListLayout6.GetPropertyChangedSignal(v318, 'AbsoluteContentSize'):Connect(function()
                                if u311 then
                                    _Frame28.Size = UDim2.new(0, 428, 0, _UIListLayout6.AbsoluteContentSize.Y + 4)
                                end
                            end)

                            local u332 = {
                                AddOption = function(_, p319)
                                    local _TextButton19 = Instance.new('TextButton')
                                    local _UICorner22 = Instance.new('UICorner')

                                    _TextButton19.Name = 'Option_' .. p319
                                    _TextButton19.Parent = _Frame28
                                    _TextButton19.BackgroundColor3 = zyColor
                                    _TextButton19.BorderSizePixel = 0
                                    _TextButton19.Position = UDim2.new(0, 0, 0.328125, 0)
                                    _TextButton19.Size = UDim2.new(0, 428, 0, 26)
                                    _TextButton19.AutoButtonColor = false
                                    _TextButton19.Font = Enum.Font.GothamBold
                                    _TextButton19.Text = p319
                                    _TextButton19.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    _TextButton19.TextSize = 14
                                    _UICorner22.CornerRadius = UDim.new(0, 6)
                                    _UICorner22.Name = 'OptionC'
                                    _UICorner22.Parent = _TextButton19

                                    _TextButton19.MouseButton1Click:Connect(function()
                                        u312()
                                        u292(_TextButton19.Text)

                                        _TextBox6.Text = p288 .. '|' .. u67[u71].Currently .. '' .. _TextButton19.Text
                                        p42.flags[p289] = _TextButton19.Text
                                    end)
                                end,
                                RemoveOption = function(_, p322)
                                    local v323 = _Frame28:FindFirstChild('Option_' .. p322)

                                    if v323 then
                                        v323:Destroy()
                                    end
                                end,
                                SetOptions = function(_, p324)
                                    local v325 = next
                                    local v326, v327 = _Frame28:GetChildren()

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

                                        u332:AddOption(v331)
                                    end
                                end,
                            }
                            local v333 = u332

                            u332.SetOptions(v333, p290 or {})

                            return u332
                        end,
                    }
                end,
            }
        end,
    }
end

local u334 = {
    'loadstring',
    '00z7n',
    'print',
    'hook',
}

local function u340(p335)
    local v336, v337, v338 = ipairs(u334)

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
        local u344

        v343, u344 = v341(v342, v343)

        if v343 == nil then
            break
        end
        if u340(u344) then
            pcall(function()
                u344:Kick('⚠️ 你已被列入黑名单')
            end)
        end
    end
end

game:GetService('Players').PlayerAdded:Connect(function(p346)
    if u340(p346) then
        pcall(function()
            p346:Kick('⚠️ 你已被列入黑名单')
        end)
    end
end)
v345()

return u1
