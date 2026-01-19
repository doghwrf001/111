repeat
    task.wait()
until game:IsLoaded()

local Library = {}
local isHidden = false

Library.currentTab = nil
Library.flags = {}

local Services = setmetatable({}, {
    __index = function(_, serviceName)
        return game.GetService(game, serviceName)
    end,
})
local Mouse = Services.Players.LocalPlayer:GetMouse()

local function CreateTween(instance, duration, easingStyle, easingDirection, properties)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[easingStyle], Enum.EasingDirection[easingDirection])
    local tween = Services.TweenService:Create(instance, tweenInfo, properties)

    tween:Play()

    return tween
end

function Tween(instance, tweenParams, properties)
    return CreateTween(instance, tweenParams[1], tweenParams[2], tweenParams[3], properties)
end

local function CreateRippleImage(parent)
    if parent.ClipsDescendants ~= true then
        parent.ClipsDescendants = true
    end

    local RippleImage = Instance.new('ImageLabel')

    RippleImage.Name = 'Ripple'
    RippleImage.Parent = parent
    RippleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RippleImage.BackgroundTransparency = 1
    RippleImage.ZIndex = 8
    RippleImage.Image = 'rbxassetid://95828101007163'
    RippleImage.ImageTransparency = 0.8
    RippleImage.ScaleType = Enum.ScaleType.Fit
    RippleImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    RippleImage.Position = UDim2.new((Mouse.X - RippleImage.AbsolutePosition.X) / parent.AbsoluteSize.X, 0, (Mouse.Y - RippleImage.AbsolutePosition.Y) / parent.AbsoluteSize.Y, 0)

    return RippleImage
end

function Ripple(parent)
    spawn(function()
        local rippleImage = CreateRippleImage(parent)

        Tween(rippleImage, {
            0.3,
            'Linear',
            'InOut',
        }, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0),
        })
        Tween(parent, {
            0.1,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(1.1, 0, 1.1, 0),
        })
        wait(0.15)
        Tween(rippleImage, {
            0.3,
            'Linear',
            'InOut',
        }, {ImageTransparency = 1})
        Tween(parent, {
            0.1,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(1, 0, 1, 0),
        })
        wait(0.3)
        rippleImage:Destroy()
    end)
end

local isUIOpen = false
local isSwitchingTab = false

local function UpdateTabTransparency(tabIcon, transparency)
    Services.TweenService:Create(tabIcon, TweenInfo.new(0.1), {ImageTransparency = transparency}):Play()
    Services.TweenService:Create(tabIcon.TabText, TweenInfo.new(0.1), {TextTransparency = transparency}):Play()
end

function switchTab(tabData)
    local ClickEffect = Instance.new('Frame')

    ClickEffect.Parent = tabData[1]
    ClickEffect.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    ClickEffect.BackgroundTransparency = 0.7
    ClickEffect.Size = UDim2.new(0, 0, 0, 0)
    ClickEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
    ClickEffect.AnchorPoint = Vector2.new(0.5, 0.5)
    ClickEffect.ZIndex = 10

    game:GetService('TweenService'):Create(ClickEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()
    spawn(function()
        wait(0.5)
        ClickEffect:Destroy()
    end)

    if isSwitchingTab then
        return
    else
        local currentTab = Library.currentTab

        if currentTab == nil then
            tabData[2].Visible = true
            Library.currentTab = tabData

            UpdateTabTransparency(tabData[1], 0)

            return
        elseif currentTab[1] ~= tabData[1] then
            isSwitchingTab = true
            Library.currentTab = tabData

            UpdateTabTransparency(currentTab[1], 0.2)
            UpdateTabTransparency(tabData[1], 0)

            currentTab[2].Visible = false
            tabData[2].Visible = true

            task.wait(0.1)

            isSwitchingTab = false
        end
    end
end

function drag(dragFrame, dragHandle)
    local isDragging = nil
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function UpdatePosition(input)
        local delta = input.Position - dragStart

        dragFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    (dragHandle or dragFrame).InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = dragFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)
    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    Services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and isDragging then
            UpdatePosition(input)
        end
    end)
end

function Library.new(self, title, _)
    local nextFunc = next
    local children, index = Services.CoreGui:GetChildren()

    while true do
        local child

        index, child = nextFunc(children, index)

        if index == nil then
            break
        end
        if child.Name == 'Linni' then
            child:Destroy()
        end
    end

    MainXEColor = Color3.fromRGB(20, 20, 30)
    Background = Color3.fromRGB(40, 40, 60)
    zyColor = Color3.fromRGB(30, 30, 45)
    beijingColor = Color3.fromRGB(50, 50, 70)

    local ScreenGui = Instance.new('ScreenGui')
    local TabMainXE = Instance.new('Frame')
    local MainXECorner = Instance.new('UICorner')
    local SideBar = Instance.new('Frame')
    local SideBarCorner = Instance.new('UICorner')
    local SideFrame = Instance.new('Frame')
    local SideGradient = Instance.new('UIGradient')
    local TabButtons = Instance.new('ScrollingFrame')
    local TabButtonsLayout = Instance.new('UIListLayout')
    local ScriptTitle = Instance.new('TextLabel')
    local TitleGradient = Instance.new('UIGradient')
    local OpenButton = Instance.new('TextButton')
    local OpenButtonGradient = Instance.new('UIGradient')
    local DropShadowHolder = Instance.new('Frame')
    local DropShadow = Instance.new('ImageLabel')
    local MainXECorner2 = Instance.new('UICorner')
    local ShadowGradient = Instance.new('UIGradient')
    local TitleGradient2 = Instance.new('UIGradient')
    local WelcomeLabel = Instance.new('TextLabel')

    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end

    ScreenGui.Name = 'Linni'
    ScreenGui.Parent = Services.CoreGui

    function UiDestroy()
        ScreenGui:Destroy()
    end

    function ToggleUILib()
        if isHidden then
            isHidden = false
            ScreenGui.Enabled = true
        else
            ScreenGui.Enabled = false
            isHidden = true
        end
    end

    local Translations = {
        ['zh-cn'] = {
            WelcomeUI = '欢迎使用MR-S',
            OpenUI = '打开UI',
            HideUI = '隐藏UI',
            Currently = '当前：',
        },
    }
    local LocalPlayer = game:GetService('Players').LocalPlayer
    local countryRegion = game:GetService('LocalizationService'):GetCountryRegionForPlayerAsync(LocalPlayer)
    local countryToLang = {
        CN = 'zh-cn',
    }
    local currentLang = Translations[countryToLang[countryRegion]] and countryToLang[countryRegion] or 'zh-cn'

    local MainXE = (function(name, parent, anchorPoint, position, size, backgroundColor, zIndex, draggable)
        local Frame = Instance.new('Frame')

        Frame.Name = name
        Frame.Parent = parent
        Frame.AnchorPoint = anchorPoint
        Frame.Position = position
        Frame.Size = size
        Frame.BackgroundColor3 = backgroundColor
        Frame.ZIndex = zIndex
        Frame.Active = true
        Frame.Draggable = draggable
        Frame.Visible = true

        return Frame
    end)('MainXE', ScreenGui, Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 0, 0, 0), MainXEColor, 1, true)

    local ViewSizeX = Services.Players.LocalPlayer:GetMouse().ViewSizeX

    MainXE.Size = UDim2.new(0, math.clamp(ViewSizeX * 0.8, 500, 800), 0, math.clamp(ViewSizeX * 0.6, 400, 600))

    local NeonBorder = Instance.new('Frame')

    NeonBorder.Name = 'NeonBorder'
    NeonBorder.Parent = MainXE
    NeonBorder.BackgroundTransparency = 1
    NeonBorder.Size = UDim2.new(1, 10, 1, 10)
    NeonBorder.Position = UDim2.new(0, -5, 0, -5)
    NeonBorder.ZIndex = 0

    local NeonGradient = Instance.new('UIGradient')

    NeonGradient.Parent = NeonBorder
    NeonGradient.Rotation = 45
    NeonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
    })

    game:GetService('TweenService'):Create(NeonGradient, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):Play()

    local MainStroke = Instance.new('UIStroke')

    MainStroke.Parent = MainXE
    MainStroke.Thickness = 3
    MainStroke.Color = Color3.fromRGB(0, 255, 255)
    MainStroke.Transparency = 0.5
    MainStroke.LineJoinMode = Enum.LineJoinMode.Round

    local DynamicBG = Instance.new('Frame')

    DynamicBG.Name = 'DynamicBG'
    DynamicBG.Parent = MainXE
    DynamicBG.BackgroundColor3 = MainXEColor
    DynamicBG.BackgroundTransparency = 0.7
    DynamicBG.Size = UDim2.new(1, 0, 1, 0)
    DynamicBG.ZIndex = -1

    for i = 0, 1, 0.1 do
        local linePos = i
        local GridLine = Instance.new('Frame')

        GridLine.Name = 'GridLine_H_' .. linePos
        GridLine.Parent = DynamicBG
        GridLine.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        GridLine.BorderSizePixel = 0
        GridLine.Size = UDim2.new(1, 0, 0, 1)
        GridLine.Position = UDim2.new(0, 0, linePos, 0)
        GridLine.ZIndex = 0
    end

    local ScanDot = Instance.new('Frame')

    ScanDot.Name = 'ScanDot'
    ScanDot.Parent = DynamicBG
    ScanDot.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    ScanDot.Size = UDim2.new(0, 6, 0, 6)
    ScanDot.Position = UDim2.new(0, 0, 0, 0)
    ScanDot.ZIndex = 2

    spawn(function()
        while true do
            game:GetService('TweenService'):Create(ScanDot, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 0, 0),
            }):Play()
            wait(2)
            game:GetService('TweenService'):Create(ScanDot, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Position = UDim2.new(1, -6, 1, -6),
            }):Play()
            wait(1)
            game:GetService('TweenService'):Create(ScanDot, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, 0, 0, 0),
            }):Play()
            wait(1)
        end
    end)

    WelcomeLabel.Name = 'WelcomeLabel'
    WelcomeLabel.Parent = MainXE
    WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = Translations[currentLang].WelcomeUI
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 32
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.TextTransparency = 1
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeLabel.Font = Enum.Font.GothamBold
    WelcomeLabel.Visible = true
    MainXECorner2.Parent = MainXE
    MainXECorner2.CornerRadius = UDim.new(0, 3)

    local CloseButton = Instance.new('TextButton')

    CloseButton.Name = 'CloseButton'
    CloseButton.Parent = MainXE
    CloseButton.AnchorPoint = Vector2.new(1, 0)
    CloseButton.Position = UDim2.new(1, -5, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = '❌'
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.ZIndex = 10

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 50, 50),
        }):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    DropShadowHolder.Name = 'DropShadowHolder'
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    DropShadowHolder.ZIndex = 0
    DropShadow.Name = 'DropShadow'
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)

    MainXE:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
        DropShadow.Size = UDim2.new(1, 50, 1, 50)
    end)

    DropShadow.ZIndex = 0
    DropShadow.Image = 'rbxassetid://95828101007163'
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0.2
    DropShadow.Size = UDim2.new(1, 43, 1, 43)
    DropShadow.ZIndex = 0
    DropShadow.Image = 'rbxassetid://95828101007163'
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    ShadowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })
    ShadowGradient.Parent = DropShadow

    game:GetService('TweenService'):Create(ShadowGradient, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {
        Rotation = 360,
        Offset = Vector2.new(1, 0),
    }):Play()

    function toggleui()
        isUIOpen = not isUIOpen

        spawn(function()
            if isUIOpen then
                wait(0.3)
            end
        end)
        Tween(MainXE, {
            0.3,
            'Sine',
            'InOut',
        }, {
            Size = UDim2.new(0, 609, 0, isUIOpen and 505 or 0),
        })
    end

    TabMainXE.Name = 'TabMainXE'
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMainXE.Size = UDim2.new(0, 448, 0, 353)
    TabMainXE.Visible = false
    MainXECorner.CornerRadius = UDim.new(0, 5.5)
    MainXECorner.Name = 'MainXEC'
    MainXECorner.Parent = MainXE
    SideBar.Name = 'SB'
    SideBar.Parent = MainXE
    SideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SideBar.BorderColor3 = MainXEColor
    SideBar.Size = UDim2.new(0, 0, 0, 0)
    SideBarCorner.CornerRadius = UDim.new(0, 6)
    SideBarCorner.Name = 'SBC'
    SideBarCorner.Parent = SideBar
    SideFrame.Name = 'Side'
    SideFrame.Parent = SideBar
    SideFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SideFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    SideFrame.BorderSizePixel = 0
    SideFrame.ClipsDescendants = true
    SideFrame.Position = UDim2.new(1, 0, 0, 0)
    SideFrame.Size = UDim2.new(0, 0, 0, 0)
    SideGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, zyColor),
        ColorSequenceKeypoint.new(1, zyColor),
    })
    SideGradient.Rotation = 90
    SideGradient.Name = 'SideG'
    SideGradient.Parent = SideFrame
    MainXE.Size = UDim2.new(0, 570, 0, 358)
    SideFrame.Size = UDim2.new(0, 110, 0, 357)
    SideBar.Size = UDim2.new(0, 8, 0, 357)
    TabMainXE.Visible = true
    ShadowGradient.Parent = DropShadow
    WelcomeLabel.Visible = false
    TabButtons.Name = 'TabBtns'
    TabButtons.Parent = SideFrame
    TabButtons.Active = true
    TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 0, 0.15, 0)
    TabButtons.Size = UDim2.new(0, 110, 0, 300)
    TabButtons.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabButtons.ScrollBarThickness = 0
    TabButtonsLayout.Name = 'TabBtnsL'
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonsLayout.Padding = UDim.new(0, 12)

    local SearchContainer = Instance.new('Frame')

    SearchContainer.Name = 'SearchContainer'
    SearchContainer.Parent = SideFrame
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Size = UDim2.new(1, 0, 0, 40)
    SearchContainer.Position = UDim2.new(0, 0, 0.07, 0)

    local SearchBar = Instance.new('TextBox')

    SearchBar.Name = 'SearchBar'
    SearchBar.Parent = SearchContainer
    SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    SearchBar.BackgroundTransparency = 0.3
    SearchBar.Size = UDim2.new(0.75, 0, 0, 30)
    SearchBar.Position = UDim2.new(0.05, 0, 0, 0)
    SearchBar.PlaceholderText = '搜索选项区...'
    SearchBar.Text = ''
    SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBar.Font = Enum.Font.GothamBold
    SearchBar.TextSize = 14
    SearchBar.ClearTextOnFocus = false

    local SearchBarCorner = Instance.new('UICorner')

    SearchBarCorner.CornerRadius = UDim.new(0, 6)
    SearchBarCorner.Parent = SearchBar

    local SearchBarPadding = Instance.new('UIPadding')

    SearchBarPadding.PaddingLeft = UDim.new(0, 10)
    SearchBarPadding.Parent = SearchBar

    local SearchIcon = Instance.new('ImageLabel')

    SearchIcon.Name = 'SearchIcon'
    SearchIcon.Parent = SearchBar
    SearchIcon.Image = 'rbxassetid://95828101007163'
    SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    SearchIcon.AnchorPoint = Vector2.new(1, 0.5)
    SearchIcon.Position = UDim2.new(1, -8, 0.5, 0)
    SearchIcon.Size = UDim2.new(0, 18, 0, 18)
    SearchIcon.BackgroundTransparency = 1

    local ClearSearchButton = Instance.new('TextButton')

    ClearSearchButton.Name = 'ClearButton'
    ClearSearchButton.Parent = SearchContainer
    ClearSearchButton.Text = 'X'
    ClearSearchButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    ClearSearchButton.BackgroundTransparency = 1
    ClearSearchButton.Font = Enum.Font.GothamBold
    ClearSearchButton.TextSize = 18
    ClearSearchButton.Position = UDim2.new(0.83, 0, 0, 5)
    ClearSearchButton.Visible = false
    ClearSearchButton.Size = UDim2.new(0, 0, 0, 0)

    game:GetService('TweenService'):Create(ClearSearchButton, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 25, 0, 25),
    }):Play()

    local searchBarRef = SearchBar

    SearchBar.GetPropertyChangedSignal(searchBarRef, 'Text'):Connect(function()
        local searchText = string.lower(SearchBar.Text)

        ClearSearchButton.Visible = searchText ~= ''

        local tabButtonsContainer = TabButtons
        local iterFunc, iterTable, iterIndex = ipairs(tabButtonsContainer:GetChildren())

        while true do
            local tabChild

            iterIndex, tabChild = iterFunc(iterTable, iterIndex)

            if iterIndex == nil then
                break
            end
            if tabChild:IsA('ImageLabel') and tabChild:FindFirstChild('TabText') then
                local tabTextLower = string.lower(tabChild.TabText.Text)

                tabChild.Visible = searchText == '' and true or string.find(tabTextLower, searchText)
            end
        end
    end)
    ClearSearchButton.MouseButton1Click:Connect(function()
        SearchBar.Text = ''
        ClearSearchButton.Visible = false
    end)
    SearchBar.Focused:Connect(function()
        game:GetService('TweenService'):Create(SearchBar, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()

        SearchIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end)
    SearchBar.FocusLost:Connect(function()
        game:GetService('TweenService'):Create(SearchBar, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()

        SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    end)

    ScriptTitle.Name = 'ScriptTitle'
    ScriptTitle.Parent = SideFrame
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = title
    ScriptTitle.TextColor3 = Color3.fromR
    
    GB(255, 255, 255)
    ScriptTitle.TextSize = 14
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Center
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })
    TitleGradient.Name = 'TitleG'
    TitleGradient.Parent = ScriptTitle

    game:GetService('TweenService'):Create(TitleGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)}):Play()

    OpenButton.Name = 'OpenBtn'
    OpenButton.Parent = ScreenGui
    OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    OpenButton.Position = UDim2.new(0, 10, 0.5, 0)
    OpenButton.Size = UDim2.new(0, 100, 0, 35)
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.Text = Translations[currentLang].OpenUI
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 14
    OpenButton.AutoButtonColor = false
    OpenButton.Visible = false

    local OpenButtonCorner = Instance.new('UICorner')

    OpenButtonCorner.CornerRadius = UDim.new(0, 8)
    OpenButtonCorner.Parent = OpenButton
    OpenButtonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(155, 89, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 255)),
    })
    OpenButtonGradient.Rotation = 45
    OpenButtonGradient.Name = 'OpenBtnG'
    OpenButtonGradient.Parent = OpenButton

    game:GetService('TweenService'):Create(OpenButtonGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 405}):Play()

    OpenButton.MouseButton1Click:Connect(function()
        MainXE.Visible = true
        OpenButton.Visible = false
    end)

    local MinimizeButton = Instance.new('TextButton')

    MinimizeButton.Name = 'MinimizeBtn'
    MinimizeButton.Parent = MainXE
    MinimizeButton.AnchorPoint = Vector2.new(1, 0)
    MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
    MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = '➖'
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.ZIndex = 10

    MinimizeButton.MouseEnter:Connect(function()
        game:GetService('TweenService'):Create(MinimizeButton, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(255, 200, 50)}):Play()
    end)
    MinimizeButton.MouseLeave:Connect(function()
        game:GetService('TweenService'):Create(MinimizeButton, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    MinimizeButton.MouseButton1Click:Connect(function()
        MainXE.Visible = false
        OpenButton.Visible = true
    end)

    drag(MainXE)

    local LibraryFunctions = {}

    function LibraryFunctions:addTab(tabName, tabIcon)
        local TabContainer = Instance.new('Frame')
        local TabContainerCorner = Instance.new('UICorner')
        local TabContainerLayout = Instance.new('UIListLayout')
        local TabContainerPadding = Instance.new('UIPadding')
        local TabScroll = Instance.new('ScrollingFrame')
        local TabScrollLayout = Instance.new('UIListLayout')
        local TabScrollPadding = Instance.new('UIPadding')
        local TabButton = Instance.new('ImageLabel')
        local TabText = Instance.new('TextLabel')

        TabContainer.Name = tabName
        TabContainer.Parent = TabMainXE
        TabContainer.BackgroundColor3 = beijingColor
        TabContainer.BackgroundTransparency = 0.3
        TabContainer.Position = UDim2.new(0.02, 0, 0.035, 0)
        TabContainer.Size = UDim2.new(0.96, 0, 0.93, 0)
        TabContainer.Visible = false
        TabContainerCorner.CornerRadius = UDim.new(0, 8)
        TabContainerCorner.Parent = TabContainer
        TabContainerLayout.Parent = TabContainer
        TabContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContainerLayout.Padding = UDim.new(0, 5)
        TabContainerPadding.Parent = TabContainer
        TabContainerPadding.PaddingLeft = UDim.new(0, 10)
        TabContainerPadding.PaddingTop = UDim.new(0, 10)
        TabScroll.Name = 'Scroll'
        TabScroll.Parent = TabContainer
        TabScroll.Active = true
        TabScroll.BackgroundTransparency = 1
        TabScroll.BorderSizePixel = 0
        TabScroll.Size = UDim2.new(1, -20, 1, -20)
        TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabScroll.ScrollBarThickness = 4
        TabScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
        TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabScrollLayout.Parent = TabScroll
        TabScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabScrollLayout.Padding = UDim.new(0, 8)
        TabScrollPadding.Parent = TabScroll
        TabScrollPadding.PaddingLeft = UDim.new(0, 5)
        TabScrollPadding.PaddingTop = UDim.new(0, 5)
        TabButton.Name = tabName
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(0, 100, 0, 25)
        TabButton.Image = tabIcon
        TabButton.ImageTransparency = 0.2
        TabButton.ScaleType = Enum.ScaleType.Fit
        TabText.Name = 'TabText'
        TabText.Parent = TabButton
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(0, 30, 0, 0)
        TabText.Size = UDim2.new(0, 70, 0, 25)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = tabName
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 12
        TabText.TextTransparency = 0.2
        TabText.TextXAlignment = Enum.TextXAlignment.Left

        local tabData = {TabButton, TabContainer}

        TabButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                switchTab(tabData)
            end
        end)

        if Library.currentTab == nil then
            switchTab(tabData)
        end

        local TabFunctions = {}

        function TabFunctions:addSection(sectionName)
            local SectionFrame = Instance.new('Frame')
            local SectionCorner = Instance.new('UICorner')
            local SectionTitle = Instance.new('TextLabel')
            local SectionTitleGradient = Instance.new('UIGradient')
            local SectionContent = Instance.new('Frame')
            local SectionContentLayout = Instance.new('UIListLayout')
            local SectionContentPadding = Instance.new('UIPadding')

            SectionFrame.Name = sectionName
            SectionFrame.Parent = TabScroll
            SectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            SectionFrame.BackgroundTransparency = 0.2
            SectionFrame.Size = UDim2.new(1, -15, 0, 40)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = SectionFrame
            SectionTitle.Name = 'Title'
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.Size = UDim2.new(1, -20, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = '◆ ' .. sectionName
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 13
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitleGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255)),
            })
            SectionTitleGradient.Parent = SectionTitle
            SectionContent.Name = 'Content'
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 28)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 6)
            SectionContentPadding.Parent = SectionContent
            SectionContentPadding.PaddingLeft = UDim.new(0, 10)
            SectionContentPadding.PaddingBottom = UDim.new(0, 10)

            local SectionFunctions = {}

            function SectionFunctions:addButton(buttonText, callback)
                local ButtonFrame = Instance.new('Frame')
                local ButtonCorner = Instance.new('UICorner')
                local ButtonLabel = Instance.new('TextButton')
                local ButtonGradient = Instance.new('UIGradient')

                ButtonFrame.Name = buttonText
                ButtonFrame.Parent = SectionContent
                ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                ButtonFrame.Size = UDim2.new(1, -20, 0, 32)
                ButtonFrame.ClipsDescendants = true
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = ButtonFrame
                ButtonLabel.Name = 'Button'
                ButtonLabel.Parent = ButtonFrame
                ButtonLabel.BackgroundTransparency = 1
                ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
                ButtonLabel.Font = Enum.Font.GothamSemibold
                ButtonLabel.Text = buttonText
                ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ButtonLabel.TextSize = 13
                ButtonGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 85)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 65)),
                })
                ButtonGradient.Rotation = 90
                ButtonGradient.Parent = ButtonFrame

                ButtonLabel.MouseEnter:Connect(function()
                    game:GetService('TweenService'):Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
                end)
                ButtonLabel.MouseLeave:Connect(function()
                    game:GetService('TweenService'):Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
                end)
                ButtonLabel.MouseButton1Click:Connect(function()
                    Ripple(ButtonFrame)

                    if callback then
                        callback()
                    end
                end)
            end

            function SectionFunctions:addToggle(toggleName, flagName, defaultValue, callback)
                local ToggleFrame = Instance.new('Frame')
                local ToggleCorner = Instance.new('UICorner')
                local ToggleLabel = Instance.new('TextLabel')
                local ToggleButton = Instance.new('Frame')
                local ToggleButtonCorner = Instance.new('UICorner')
                local ToggleCircle = Instance.new('Frame')
                local ToggleCircleCorner = Instance.new('UICorner')

                local isToggled = defaultValue or false

                Library.flags[flagName] = isToggled

                ToggleFrame.Name = toggleName
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                ToggleFrame.Size = UDim2.new(1, -20, 0, 32)
                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Parent = ToggleFrame
                ToggleLabel.Name = 'Label'
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                ToggleLabel.Font = Enum.Font.GothamSemibold
                ToggleLabel.Text = toggleName
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.TextSize = 13
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleButton.Name = 'ToggleBtn'
                ToggleButton.Parent = ToggleFrame
                ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
                ToggleButton.Position = UDim2.new(1, -10, 0.5, 0)
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 100)
                ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
                ToggleButtonCorner.Parent = ToggleButton
                ToggleCircle.Name = 'Circle'
                ToggleCircle.Parent = ToggleButton
                ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                ToggleCircle.Position = isToggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
                ToggleCircleCorner.Parent = ToggleCircle

                local function UpdateToggle()
                    isToggled = not isToggled
                    Library.flags[flagName] = isToggled

                    game:GetService('TweenService'):Create(ToggleButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = isToggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 100),
                    }):Play()
                    game:GetService('TweenService'):Create(ToggleCircle, TweenInfo.new(0.2), {
                        Position = isToggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    }):Play()

                    if callback then
                        callback(isToggled)
                    end
                end

                ToggleFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateToggle()
                    end
                end)

                if defaultValue and callback then
                    callback(defaultValue)
                end
            end

            function SectionFunctions:addSlider(sliderName, flagName, minValue, maxValue, defaultValue, callback)
                local SliderFrame = Instance.new('Frame')
                local SliderCorner = Instance.new('UICorner')
                local SliderLabel = Instance.new('TextLabel')
                local SliderValueLabel = Instance.new('TextLabel')
                local SliderBar = Instance.new('Frame')
                local SliderBarCorner = Instance.new('UICorner')
                local SliderFill = Instance.new('Frame')
                local SliderFillCorner = Instance.new('UICorner')
                local SliderKnob = Instance.new('Frame')
                local SliderKnobCorner = Instance.new('UICorner')

                local currentValue = defaultValue or minValue

                Library.flags[flagName] = currentValue

                SliderFrame.Name = sliderName
                SliderFrame.Parent = SectionContent
                SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                SliderFrame.Size = UDim2.new(1, -20, 0, 50)
                SliderCorner.CornerRadius = UDim.new(0, 6)
                SliderCorner.Parent = SliderFrame
                SliderLabel.Name = 'Label'
                SliderLabel.Parent = SliderFrame
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                SliderLabel.Size = UDim2.new(0.6, 0, 0, 18)
                SliderLabel.Font = Enum.Font.GothamSemibold
                SliderLabel.Text = sliderName
                SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.TextSize = 13
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderValueLabel.Name = 'Value'
                SliderValueLabel.Parent = SliderFrame
                SliderValueLabel.BackgroundTransparency = 1
                SliderValueLabel.Position = UDim2.new(0.6, 0, 0, 5)
                SliderValueLabel.Size = UDim2.new(0.35, 0, 0, 18)
                SliderValueLabel.Font = Enum.Font.GothamBold
                SliderValueLabel.Text = tostring(currentValue)
                SliderValueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
                SliderValueLabel.TextSize = 13
                SliderValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                SliderBar.Name = 'Bar'
                SliderBar.Parent = SliderFrame
                SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                SliderBar.Position = UDim2.new(0, 10, 0, 28)
                SliderBar.Size = UDim2.new(1, -20, 0, 12)
                SliderBarCorner.CornerRadius = UDim.new(1, 0)
                SliderBarCorner.Parent = SliderBar
                SliderFill.Name = 'Fill'
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
                SliderFill.Size = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 1, 0)
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill
                SliderKnob.Name = 'Knob'
                SliderKnob.Parent = SliderBar
                SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderKnob.Position = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 0.5, 0)
                SliderKnob.Size = UDim2.new(0, 18, 0, 18)
                SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderKnob.ZIndex = 2
                SliderKnobCorner.CornerRadius = UDim.new(1, 0)
                SliderKnobCorner.Parent = SliderKnob

                local isDragging = false

                local function UpdateSlider(input)
                    local sliderPos = SliderBar.AbsolutePosition.X
                    local sliderSize = SliderBar.AbsoluteSize.X
                    local mousePos = input.Position.X
                    local relativePos = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                    local newValue = math.floor(minValue + (maxValue - minValue) * relativePos)

                    currentValue = newValue
                    Library.flags[flagName] = currentValue
                    SliderValueLabel.Text = tostring(currentValue)

                    game:GetService('TweenService'):Create(SliderFill, TweenInfo.new(0.1), {
                        Size = UDim2.new(relativePos, 0, 1, 0),
                    }):Play()
                    game:GetService('TweenService'):Create(SliderKnob, TweenInfo.new(0.1), {
                        Position = UDim2.new(relativePos, 0, 0.5, 0),
                    }):Play()

                    if callback then
                        callback(currentValue)
                    end
                end

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDragging = true

                        UpdateSlider(input)
                    end
                end)
                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDragging = false
                    end
                end)
                Services.UserInputService.InputChanged:Connect(function(input)
                    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)

                if callback then
                    callback(currentValue)
                end
            end

            function SectionFunctions:addDropdown(dropdownName, flagName, options, defaultOption, callback)
                local DropdownFrame = Instance.new('Frame')
                local DropdownCorner = Instance.new('UICorner')
                local DropdownLabel = Instance.new('TextLabel')
                local DropdownButton = Instance.new('TextButton')
                local DropdownButtonCorner = Instance.new('UICorner')
                local DropdownArrow = Instance.new('TextLabel')
                local DropdownList = Instance.new('Frame')
                local DropdownListCorner = Instance.new('UICorner')
                local DropdownListLayout = Instance.new('UIListLayout')

                local isOpen = false
                local selectedOption = defaultOption or options[1]

                Library.flags[flagName] = selectedOption

                DropdownFrame.Name = dropdownName
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                DropdownFrame.Size = UDim2.new(1, -20, 0, 32)
                DropdownFrame.ClipsDescendants = false
                DropdownCorner.CornerRadius = UDim.new(0, 6)
                DropdownCorner.Parent = DropdownFrame
                DropdownLabel.Name = 'Label'
                DropdownLabel.Parent = DropdownFrame
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
                DropdownLabel.Size = UDim2.new(0.4, 0, 1, 0)
                DropdownLabel.Font = Enum.Font.GothamSemibold
                DropdownLabel.Text = dropdownName
                DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownLabel.TextSize = 13
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownButton.Name = 'Button'
                DropdownButton.Parent = DropdownFrame
                DropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
                DropdownButton.Position = UDim2.new(0.45, 0, 0.15, 0)
                DropdownButton.Size = UDim2.new(0.5, 0, 0.7, 0)
                DropdownButton.Font = Enum.Font.GothamSemibold
                DropdownButton.Text = selectedOption
                DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                DropdownButton.TextSize = 12
                DropdownButton.AutoButtonColor = false
                DropdownButtonCorner.CornerRadius = UDim.new(0, 4)
                DropdownButtonCorner.Parent = DropdownButton
                DropdownArrow.Name = 'Arrow'
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
                DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
                DropdownArrow.Font = Enum.Font.GothamBold
                DropdownArrow.Text = '▼'
                DropdownArrow.TextColor3 = Color3.fromRGB(150, 150, 150)
                DropdownArrow.TextSize = 10
                DropdownList.Name = 'List'
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
                DropdownList.Position = UDim2.new(0.45, 0, 1, 5)
                DropdownList.Size = UDim2.new(0.5, 0, 0, 0)
                DropdownList.ClipsDescendants = true
                DropdownList.Visible = false
                DropdownList.ZIndex = 10
                DropdownListCorner.CornerRadius = UDim.new(0, 4)
                DropdownListCorner.Parent = DropdownList
                DropdownListLayout.Parent = DropdownList
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownListLayout.Padding = UDim.new(0, 2)

                for _, option in ipairs(options) do
                    local OptionButton = Instance.new('TextButton')
                    local OptionCorner = Instance.new('UICorner')

                    OptionButton.Name = option
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                    OptionButton.BackgroundTransparency = 0.5
                    OptionButton.Size = UDim2.new(1, -4, 0, 25)
                    OptionButton.Position = UDim2.new(0, 2, 0, 0)
                    OptionButton.Font = Enum.Font.GothamSemibold
                    OptionButton.Text = option
                    OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                    OptionButton.TextSize = 11
                    OptionButton.AutoButtonColor = false
                    OptionButton.ZIndex = 11
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionButton

                    OptionButton.MouseEnter:Connect(function()
                        game:GetService('TweenService'):Create(OptionButton, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
                    end)
                    OptionButton.MouseLeave:Connect(function()
                        game:GetService('TweenService'):Create(OptionButton, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
                    end)
                    OptionButton.
                    
                    MouseButton1Click:Connect(function()
                        selectedOption = option
                        Library.flags[flagName] = selectedOption
                        DropdownButton.Text = option
                        isOpen = false

                        game:GetService('TweenService'):Create(DropdownList, TweenInfo.new(0.2), {
                            Size = UDim2.new(0.5, 0, 0, 0),
                        }):Play()
                        game:GetService('TweenService'):Create(DropdownArrow, TweenInfo.new(0.2), {
                            Rotation = 0,
                        }):Play()

                        task.delay(0.2, function()
                            DropdownList.Visible = false
                        end)

                        if callback then
                            callback(option)
                        end
                    end)
                end

                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen

                    if isOpen then
                        DropdownList.Visible = true

                        game:GetService('TweenService'):Create(DropdownList, TweenInfo.new(0.2), {
                            Size = UDim2.new(0.5, 0, 0, #options * 27),
                        }):Play()
                        game:GetService('TweenService'):Create(DropdownArrow, TweenInfo.new(0.2), {
                            Rotation = 180,
                        }):Play()
                    else
                        game:GetService('TweenService'):Create(DropdownList, TweenInfo.new(0.2), {
                            Size = UDim2.new(0.5, 0, 0, 0),
                        }):Play()
                        game:GetService('TweenService'):Create(DropdownArrow, TweenInfo.new(0.2), {
                            Rotation = 0,
                        }):Play()

                        task.delay(0.2, function()
                            DropdownList.Visible = false
                        end)
                    end
                end)

                if callback and defaultOption then
                    callback(defaultOption)
                end
            end

            function SectionFunctions:addTextbox(textboxName, flagName, placeholderText, defaultText, callback)
                local TextboxFrame = Instance.new('Frame')
                local TextboxCorner = Instance.new('UICorner')
                local TextboxLabel = Instance.new('TextLabel')
                local TextboxInput = Instance.new('TextBox')
                local TextboxInputCorner = Instance.new('UICorner')

                local currentText = defaultText or ''

                Library.flags[flagName] = currentText

                TextboxFrame.Name = textboxName
                TextboxFrame.Parent = SectionContent
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                TextboxFrame.Size = UDim2.new(1, -20, 0, 32)
                TextboxCorner.CornerRadius = UDim.new(0, 6)
                TextboxCorner.Parent = TextboxFrame
                TextboxLabel.Name = 'Label'
                TextboxLabel.Parent = TextboxFrame
                TextboxLabel.BackgroundTransparency = 1
                TextboxLabel.Position = UDim2.new(0, 10, 0, 0)
                TextboxLabel.Size = UDim2.new(0.4, 0, 1, 0)
                TextboxLabel.Font = Enum.Font.GothamSemibold
                TextboxLabel.Text = textboxName
                TextboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxLabel.TextSize = 13
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextboxInput.Name = 'Input'
                TextboxInput.Parent = TextboxFrame
                TextboxInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
                TextboxInput.Position = UDim2.new(0.45, 0, 0.15, 0)
                TextboxInput.Size = UDim2.new(0.5, 0, 0.7, 0)
                TextboxInput.Font = Enum.Font.GothamSemibold
                TextboxInput.Text = currentText
                TextboxInput.PlaceholderText = placeholderText or '输入...'
                TextboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                TextboxInput.TextSize = 12
                TextboxInput.ClearTextOnFocus = false
                TextboxInputCorner.CornerRadius = UDim.new(0, 4)
                TextboxInputCorner.Parent = TextboxInput

                local TextboxPadding = Instance.new('UIPadding')

                TextboxPadding.PaddingLeft = UDim.new(0, 8)
                TextboxPadding.Parent = TextboxInput

                TextboxInput.Focused:Connect(function()
                    game:GetService('TweenService'):Create(TextboxInput, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(45, 45, 70),
                    }):Play()
                end)
                TextboxInput.FocusLost:Connect(function(enterPressed)
                    game:GetService('TweenService'):Create(TextboxInput, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
                    }):Play()

                    currentText = TextboxInput.Text
                    Library.flags[flagName] = currentText

                    if callback then
                        callback(currentText, enterPressed)
                    end
                end)
            end

            function SectionFunctions:addKeybind(keybindName, flagName, defaultKey, callback)
                local KeybindFrame = Instance.new('Frame')
                local KeybindCorner = Instance.new('UICorner')
                local KeybindLabel = Instance.new('TextLabel')
                local KeybindButton = Instance.new('TextButton')
                local KeybindButtonCorner = Instance.new('UICorner')

                local currentKey = defaultKey or Enum.KeyCode.Unknown
                local isListening = false

                Library.flags[flagName] = currentKey

                KeybindFrame.Name = keybindName
                KeybindFrame.Parent = SectionContent
                KeybindFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                KeybindFrame.Size = UDim2.new(1, -20, 0, 32)
                KeybindCorner.CornerRadius = UDim.new(0, 6)
                KeybindCorner.Parent = KeybindFrame
                KeybindLabel.Name = 'Label'
                KeybindLabel.Parent = KeybindFrame
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Position = UDim2.new(0, 10, 0, 0)
                KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindLabel.Font = Enum.Font.GothamSemibold
                KeybindLabel.Text = keybindName
                KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindLabel.TextSize = 13
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                KeybindButton.Name = 'Button'
                KeybindButton.Parent = KeybindFrame
                KeybindButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
                KeybindButton.Position = UDim2.new(0.65, 0, 0.15, 0)
                KeybindButton.Size = UDim2.new(0.3, 0, 0.7, 0)
                KeybindButton.Font = Enum.Font.GothamBold
                KeybindButton.Text = currentKey.Name or '无'
                KeybindButton.TextColor3 = Color3.fromRGB(0, 200, 255)
                KeybindButton.TextSize = 11
                KeybindButton.AutoButtonColor = false
                KeybindButtonCorner.CornerRadius = UDim.new(0, 4)
                KeybindButtonCorner.Parent = KeybindButton

                KeybindButton.MouseButton1Click:Connect(function()
                    isListening = true
                    KeybindButton.Text = '...'

                    game:GetService('TweenService'):Create(KeybindButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(60, 60, 90),
                    }):Play()
                end)

                Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if isListening and input.UserInputType == Enum.UserInputType.Keyboard then
                        isListening = false
                        currentKey = input.KeyCode
                        Library.flags[flagName] = currentKey
                        KeybindButton.Text = currentKey.Name

                        game:GetService('TweenService'):Create(KeybindButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(35, 35, 50),
                        }):Play()
                    elseif not isListening and input.KeyCode == currentKey and not gameProcessed then
                        if callback then
                            callback(currentKey)
                        end
                    end
                end)
            end

            function SectionFunctions:addColorPicker(colorPickerName, flagName, defaultColor, callback)
                local ColorPickerFrame = Instance.new('Frame')
                local ColorPickerCorner = Instance.new('UICorner')
                local ColorPickerLabel = Instance.new('TextLabel')
                local ColorDisplay = Instance.new('Frame')
                local ColorDisplayCorner = Instance.new('UICorner')
                local ColorDisplayStroke = Instance.new('UIStroke')
                local ColorPickerPopup = Instance.new('Frame')
                local ColorPickerPopupCorner = Instance.new('UICorner')
                local ColorPickerGradient = Instance.new('Frame')
                local ColorPickerGradientCorner = Instance.new('UICorner')
                local ColorPickerSelector = Instance.new('Frame')
                local ColorPickerSelectorCorner = Instance.new('UICorner')
                local HueSlider = Instance.new('Frame')
                local HueSliderCorner = Instance.new('UICorner')
                local HueSliderGradient = Instance.new('UIGradient')
                local HueSliderKnob = Instance.new('Frame')
                local HueSliderKnobCorner = Instance.new('UICorner')

                local currentColor = defaultColor or Color3.fromRGB(255, 0, 0)
                local isPopupOpen = false
                local currentHue, currentSat, currentVal = Color3.toHSV(currentColor)

                Library.flags[flagName] = currentColor

                ColorPickerFrame.Name = colorPickerName
                ColorPickerFrame.Parent = SectionContent
                ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                ColorPickerFrame.Size = UDim2.new(1, -20, 0, 32)
                ColorPickerFrame.ClipsDescendants = false
                ColorPickerCorner.CornerRadius = UDim.new(0, 6)
                ColorPickerCorner.Parent = ColorPickerFrame
                ColorPickerLabel.Name = 'Label'
                ColorPickerLabel.Parent = ColorPickerFrame
                ColorPickerLabel.BackgroundTransparency = 1
                ColorPickerLabel.Position = UDim2.new(0, 10, 0, 0)
                ColorPickerLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ColorPickerLabel.Font = Enum.Font.GothamSemibold
                ColorPickerLabel.Text = colorPickerName
                ColorPickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerLabel.TextSize = 13
                ColorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left
                ColorDisplay.Name = 'Display'
                ColorDisplay.Parent = ColorPickerFrame
                ColorDisplay.AnchorPoint = Vector2.new(1, 0.5)
                ColorDisplay.Position = UDim2.new(1, -10, 0.5, 0)
                ColorDisplay.Size = UDim2.new(0, 50, 0, 20)
                ColorDisplay.BackgroundColor3 = currentColor
                ColorDisplayCorner.CornerRadius = UDim.new(0, 4)
                ColorDisplayCorner.Parent = ColorDisplay
                ColorDisplayStroke.Parent = ColorDisplay
                ColorDisplayStroke.Color = Color3.fromRGB(255, 255, 255)
                ColorDisplayStroke.Thickness = 1
                ColorDisplayStroke.Transparency = 0.5
                ColorPickerPopup.Name = 'Popup'
                ColorPickerPopup.Parent = ColorPickerFrame
                ColorPickerPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                ColorPickerPopup.Position = UDim2.new(0.5, 0, 1, 5)
                ColorPickerPopup.AnchorPoint = Vector2.new(0.5, 0)
                ColorPickerPopup.Size = UDim2.new(0, 200, 0, 0)
                ColorPickerPopup.ClipsDescendants = true
                ColorPickerPopup.Visible = false
                ColorPickerPopup.ZIndex = 15
                ColorPickerPopupCorner.CornerRadius = UDim.new(0, 6)
                ColorPickerPopupCorner.Parent = ColorPickerPopup
                ColorPickerGradient.Name = 'Gradient'
                ColorPickerGradient.Parent = ColorPickerPopup
                ColorPickerGradient.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                ColorPickerGradient.Position = UDim2.new(0, 10, 0, 10)
                ColorPickerGradient.Size = UDim2.new(1, -20, 0, 120)
                ColorPickerGradient.ZIndex = 16
                ColorPickerGradientCorner.CornerRadius = UDim.new(0, 4)
                ColorPickerGradientCorner.Parent = ColorPickerGradient

                local SaturationGradient = Instance.new('UIGradient')

                SaturationGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
                })
                SaturationGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                })
                SaturationGradient.Parent = ColorPickerGradient

                local BrightnessOverlay = Instance.new('Frame')

                BrightnessOverlay.Name = 'BrightnessOverlay'
                BrightnessOverlay.Parent = ColorPickerGradient
                BrightnessOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                BrightnessOverlay.BackgroundTransparency = 0
                BrightnessOverlay.Size = UDim2.new(1, 0, 1, 0)
                BrightnessOverlay.ZIndex = 17

                local BrightnessGradient = Instance.new('UIGradient')

                BrightnessGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
                })
                BrightnessGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0),
                })
                BrightnessGradient.Rotation = 90
                BrightnessGradient.Parent = BrightnessOverlay

                local BrightnessCorner = Instance.new('UICorner')

                BrightnessCorner.CornerRadius = UDim.new(0, 4)
                BrightnessCorner.Parent = BrightnessOverlay

                ColorPickerSelector.Name = 'Selector'
                ColorPickerSelector.Parent = ColorPickerGradient
                ColorPickerSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerSelector.Size = UDim2.new(0, 12, 0, 12)
                ColorPickerSelector.AnchorPoint = Vector2.new(0.5, 0.5)
                ColorPickerSelector.Position = UDim2.new(currentSat, 0, 1 - currentVal, 0)
                ColorPickerSelector.ZIndex = 20
                ColorPickerSelectorCorner.CornerRadius = UDim.new(1, 0)
                ColorPickerSelectorCorner.Parent = ColorPickerSelector

                local SelectorStroke = Instance.new('UIStroke')

                SelectorStroke.Parent = ColorPickerSelector
                SelectorStroke.Color = Color3.fromRGB(0, 0, 0)
                SelectorStroke.Thickness = 2

                HueSlider.Name = 'HueSlider'
                HueSlider.Parent = ColorPickerPopup
                HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSlider.Position = UDim2.new(0, 10, 0, 140)
                HueSlider.Size = UDim2.new(1, -20, 0, 15)
                HueSlider.ZIndex = 16
                HueSliderCorner.CornerRadius = UDim.new(1, 0)
                HueSliderCorner.Parent = HueSlider
                HueSliderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                })
                HueSliderGradient.Parent = HueSlider
                HueSliderKnob.Name = 'Knob'
                HueSliderKnob.Parent = HueSlider
                HueSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSliderKnob.Size = UDim2.new(0, 10, 0, 19)
                HueSliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
                HueSliderKnob.Position = UDim2.new(currentHue, 0, 0.5, 0)
                HueSliderKnob.ZIndex = 18
                HueSliderKnobCorner.CornerRadius = UDim.new(0, 3)
                HueSliderKnobCorner.Parent = HueSliderKnob

                local HueKnobStroke = Instance.new('UIStroke')

                HueKnobStroke.Parent = HueSliderKnob
                HueKnobStroke.Color = Color3.fromRGB(0, 0, 0)
                HueKnobStroke.Thickness = 1

                local function UpdateColor()
                    currentColor = Color3.fromHSV(currentHue, currentSat, currentVal)
                    Library.flags[flagName] = currentColor
                    ColorDisplay.BackgroundColor3 = currentColor
                    ColorPickerGradient.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)

                    if callback then
                        callback(currentColor)
                    end
                end

                local isDraggingGradient = false
                local isDraggingHue = false

                ColorPickerGradient.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingGradient = true
                    end
                end)
                ColorPickerGradient.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingGradient = false
                    end
                end)
                HueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingHue = true
                    end
                end)
                HueSlider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingHue = false
                    end
                end)

                Services.UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if isDraggingGradient then
                            local gradientPos = ColorPickerGradient.AbsolutePosition
                            local gradientSize = ColorPickerGradient.AbsoluteSize
                            local mousePos = Vector2.new(input.Position.X, input.Position.Y)
                            local relativeX = math.clamp((mousePos.X - gradientPos.X) / gradientSize.X, 0, 1)
                            local relativeY = math.clamp((mousePos.Y - gradientPos.Y) / gradientSize.Y, 0, 1)

                            currentSat = relativeX
                            currentVal = 1 - relativeY

                            ColorPickerSelector.Position = UDim2.new(relativeX, 0, relativeY, 0)

                            UpdateColor()
                        elseif isDraggingHue then
                            local huePos = HueSlider.AbsolutePosition.X
                            local hueSize = HueSlider.AbsoluteSize.X
                            local mouseX = input.Position.X
                            local relativeHue = math.clamp((mouseX - huePos) / hueSize, 0, 1)

                            currentHue = relativeHue

                            HueSliderKnob.Position = UDim2.new(relativeHue, 0, 0.5, 0)

                            UpdateColor()
                        end
                    end
                end)

                ColorDisplay.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isPopupOpen = not isPopupOpen

                        if isPopupOpen then
                            ColorPickerPopup.Visible = true

                            game:GetService('TweenService'):Create(ColorPickerPopup, TweenInfo.new(0.2), {
                                Size = UDim2.new(0, 200, 0, 170),
                            }):Play()
                        else
                            game:GetService('TweenService'):Create(ColorPickerPopup, TweenInfo.new(0.2), {
                                Size = UDim2.new(0, 200, 0, 0),
                            }):Play()

                            task.delay(0.2, function()
                                ColorPickerPopup.Visible = false
                            end)
                        end
                    end
                end)

                if callback then
                    callback(currentColor)
                end
            end

            function SectionFunctions:addLabel(labelText)
                local LabelFrame = Instance.new('Frame')
                local LabelCorner = Instance.new('UICorner')
                local LabelTextElement = Instance.new('TextLabel')

                LabelFrame.Name = 'Label'
                LabelFrame.Parent = SectionContent
                LabelFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
                LabelFrame.BackgroundTransparency = 0.5
                LabelFrame.Size = UDim2.new(1, -20, 0, 25)
                LabelCorner.CornerRadius = UDim.new(0, 4)
                LabelCorner.Parent = LabelFrame
                LabelTextElement.Name = 'Text'
                LabelTextElement.Parent = LabelFrame
                LabelTextElement.BackgroundTransparency = 1
                LabelTextElement.Position = UDim2.new(0, 10, 0, 0)
                LabelTextElement.Size = UDim2.new(1, -20, 1, 0)
                LabelTextElement.Font = Enum.Font.Gotham
                LabelTextElement.Text = labelText
                LabelTextElement.TextColor3 = Color3.fromRGB(180, 180, 180)
                LabelTextElement.TextSize = 12
                LabelTextElement.TextXAlignment = Enum.TextXAlignment.Left

                local LabelFunctions = {}

                function LabelFunctions:setText(newText)
                    LabelTextElement.Text = newText
                end

                return LabelFunctions
            end

            function SectionFunctions:addSeparator()
                local SeparatorFrame = Instance.new('Frame')
                local SeparatorLine = Instance.new('Frame')
                local SeparatorGradient = Instance.new('UIGradient')

                SeparatorFrame.Name = 'Separator'
                SeparatorFrame.Parent = SectionContent
                SeparatorFrame.BackgroundTransparency = 1
                SeparatorFrame.Size = UDim2.new(1, -20, 0, 10)
                SeparatorLine.Name = 'Line'
                SeparatorLine.Parent = SeparatorFrame
                SeparatorLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SeparatorLine.BorderSizePixel = 0
                SeparatorLine.Position = UDim2.new(0, 0, 0.5, 0)
                SeparatorLine.Size = UDim2.new(1, 0, 0, 1)
                SeparatorGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 90)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 100, 150)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 90)),
                })
                SeparatorGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.8),
                    NumberSequenceKeypoint.new(0.5, 0.3),
                    NumberSequenceKeypoint.new(1, 0.8),
                })
                SeparatorGradient.Parent = SeparatorLine
            end

            return SectionFunctions
        end

        return TabFunctions
    end

    function LibraryFunctions:addNotification(title, message, duration)
        local NotificationGui = Instance.new('ScreenGui')
        local NotificationFrame = Instance.new('Frame')
        local NotificationCorner = Instance.new('UICorner')
        local NotificationTitle = Instance.new('TextLabel')
        local NotificationMessage = Instance.new('TextLabel')
        local NotificationGradient = Instance.new('UIGradient')
        local NotificationStroke = Instance.new('UIStroke')

        if syn and syn.protect_gui then
            syn.protect_gui(NotificationGui)
        end

        NotificationGui.Name = 'Notification'
        NotificationGui.Parent = Services.CoreGui
        NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        NotificationFrame.Name = 'Frame'
        NotificationFrame.Parent = NotificationGui
        NotificationFrame.AnchorPoint = Vector2.new(1, 1)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        NotificationFrame.Position = UDim2.new(1, -20, 1, -20)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame.ClipsDescendants = true
        NotificationCorner.CornerRadius = UDim.new(0, 8)
        NotificationCorner.Parent = NotificationFrame
        NotificationStroke.Parent = NotificationFrame
        NotificationStroke.Color = Color3.fromRGB(0, 180, 255)
        NotificationStroke.Thickness = 1
        NotificationStroke.Transparency = 0.5
        NotificationTitle.Name = 'Title'
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundTransparency = 1
        NotificationTitle.Position = UDim2.new(0, 10, 0, 8)
        NotificationTitle.Size = UDim2.new(1, -20, 0, 20)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = title or '通知'
        NotificationTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
        NotificationTitle.TextSize = 14
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotificationMessage.Name = 'Message'
        NotificationMessage.Parent = NotificationFrame
        NotificationMessage.BackgroundTransparency = 1
        NotificationMessage.Position = UDim2.new(0, 10, 0, 30)
        NotificationMessage.Size = UDim2.new(1, -20, 0, 40)
        NotificationMessage.Font = Enum.Font.Gotham
        NotificationMessage.Text = message or ''
        NotificationMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationMessage.TextSize = 12
        NotificationMessage.TextXAlignment = Enum.TextXAlignment.Left
        NotificationMessage.TextYAlignment = Enum.TextYAlignment.Top
        NotificationMessage.TextWrapped = true
        NotificationGradient.Color = ColorSequence.new({
            ColorSequenceKey
            
            point.new(0, Color3.fromRGB(30, 30, 50)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35)),
        })
        NotificationGradient.Rotation = 90
        NotificationGradient.Parent = NotificationFrame

        game:GetService('TweenService'):Create(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 80),
        }):Play()

        task.delay(duration or 3, function()
            game:GetService('TweenService'):Create(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
            }):Play()

            task.delay(0.3, function()
                NotificationGui:Destroy()
            end)
        end)
    end

    function LibraryFunctions:setTheme(themeColors)
        if themeColors.MainColor then
            MainXEColor = themeColors.MainColor
            MainXE.BackgroundColor3 = MainXEColor
        end
        if themeColors.BackgroundColor then
            Background = themeColors.BackgroundColor
        end
        if themeColors.SidebarColor then
            zyColor = themeColors.SidebarColor

            SideGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, zyColor),
                ColorSequenceKeypoint.new(1, zyColor),
            })
        end
        if themeColors.AccentColor then
            beijingColor = themeColors.AccentColor
        end
    end

    function LibraryFunctions:destroy()
        ScreenGui:Destroy()
    end

    function LibraryFunctions:hide()
        MainXE.Visible = false
        OpenButton.Visible = true
    end

    function LibraryFunctions:show()
        MainXE.Visible = true
        OpenButton.Visible = false
    end

    function LibraryFunctions:toggle()
        if MainXE.Visible then
            LibraryFunctions:hide()
        else
            LibraryFunctions:show()
        end
    end

    Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            LibraryFunctions:toggle()
        end
    end)

    return LibraryFunctions
end

function Library:getFlag(flagName)
    return Library.flags[flagName]
end

function Library:setFlag(flagName, value)
    Library.flags[flagName] = value
end

local Blacklist = {}
local BlacklistEnabled = false
local BlacklistedPlayers = {}

function Blacklist:enable()
    BlacklistEnabled = true
end

function Blacklist:disable()
    BlacklistEnabled = false
end

function Blacklist:addPlayer(playerName)
    if not table.find(BlacklistedPlayers, playerName) then
        table.insert(BlacklistedPlayers, playerName)
    end
end

function Blacklist:removePlayer(playerName)
    local index = table.find(BlacklistedPlayers, playerName)

    if index then
        table.remove(BlacklistedPlayers, index)
    end
end

function Blacklist:isBlacklisted(playerName)
    return table.find(BlacklistedPlayers, playerName) ~= nil
end

function Blacklist:getBlacklist()
    return BlacklistedPlayers
end

function Blacklist:clearBlacklist()
    BlacklistedPlayers = {}
end

function Blacklist:checkLocalPlayer()
    local LocalPlayer = Services.Players.LocalPlayer

    if BlacklistEnabled and Blacklist:isBlacklisted(LocalPlayer.Name) then
        return true
    end

    return false
end

Library.Blacklist = Blacklist

local ConfigSystem = {}
local ConfigFolder = 'LinniConfigs'

function ConfigSystem:init()
    if not isfolder(ConfigFolder) then
        makefolder(ConfigFolder)
    end
end

function ConfigSystem:saveConfig(configName)
    ConfigSystem:init()

    local configData = {}

    for flagName, flagValue in pairs(Library.flags) do
        if typeof(flagValue) == 'Color3' then
            configData[flagName] = {
                Type = 'Color3',
                R = flagValue.R,
                G = flagValue.G,
                B = flagValue.B,
            }
        elseif typeof(flagValue) == 'EnumItem' then
            configData[flagName] = {
                Type = 'EnumItem',
                EnumType = tostring(flagValue.EnumType),
                Name = flagValue.Name,
            }
        else
            configData[flagName] = {
                Type = typeof(flagValue),
                Value = flagValue,
            }
        end
    end

    local jsonData = Services.HttpService:JSONEncode(configData)

    writefile(ConfigFolder .. '/' .. configName .. '.json', jsonData)
end

function ConfigSystem:loadConfig(configName)
    ConfigSystem:init()

    local filePath = ConfigFolder .. '/' .. configName .. '.json'

    if isfile(filePath) then
        local jsonData = readfile(filePath)
        local configData = Services.HttpService:JSONDecode(jsonData)

        for flagName, flagData in pairs(configData) do
            if flagData.Type == 'Color3' then
                Library.flags[flagName] = Color3.new(flagData.R, flagData.G, flagData.B)
            elseif flagData.Type == 'EnumItem' then
                Library.flags[flagName] = Enum[flagData.EnumType][flagData.Name]
            else
                Library.flags[flagName] = flagData.Value
            end
        end

        return true
    end

    return false
end

function ConfigSystem:deleteConfig(configName)
    ConfigSystem:init()

    local filePath = ConfigFolder .. '/' .. configName .. '.json'

    if isfile(filePath) then
        delfile(filePath)

        return true
    end

    return false
end

function ConfigSystem:getConfigs()
    ConfigSystem:init()

    local configs = {}

    if isfolder(ConfigFolder) then
        local files = listfiles(ConfigFolder)

        for _, file in ipairs(files) do
            local fileName = file:match('([^/\\]+)%.json$')

            if fileName then
                table.insert(configs, fileName)
            end
        end
    end

    return configs
end

Library.ConfigSystem = ConfigSystem

local Watermark = {}
local WatermarkGui = nil
local WatermarkFrame = nil
local WatermarkText = nil
local WatermarkVisible = false

function Watermark:create(text)
    if WatermarkGui then
        WatermarkGui:Destroy()
    end

    WatermarkGui = Instance.new('ScreenGui')
    WatermarkFrame = Instance.new('Frame')
    WatermarkText = Instance.new('TextLabel')

    local WatermarkCorner = Instance.new('UICorner')
    local WatermarkGradient = Instance.new('UIGradient')
    local WatermarkStroke = Instance.new('UIStroke')

    if syn and syn.protect_gui then
        syn.protect_gui(WatermarkGui)
    end

    WatermarkGui.Name = 'LinniWatermark'
    WatermarkGui.Parent = Services.CoreGui
    WatermarkGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    WatermarkFrame.Name = 'Frame'
    WatermarkFrame.Parent = WatermarkGui
    WatermarkFrame.AnchorPoint = Vector2.new(0, 0)
    WatermarkFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    WatermarkFrame.Position = UDim2.new(0, 10, 0, 10)
    WatermarkFrame.Size = UDim2.new(0, 0, 0, 25)
    WatermarkFrame.AutomaticSize = Enum.AutomaticSize.X
    WatermarkCorner.CornerRadius = UDim.new(0, 6)
    WatermarkCorner.Parent = WatermarkFrame
    WatermarkStroke.Parent = WatermarkFrame
    WatermarkStroke.Color = Color3.fromRGB(0, 180, 255)
    WatermarkStroke.Thickness = 1
    WatermarkStroke.Transparency = 0.5
    WatermarkGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30)),
    })
    WatermarkGradient.Rotation = 90
    WatermarkGradient.Parent = WatermarkFrame
    WatermarkText.Name = 'Text'
    WatermarkText.Parent = WatermarkFrame
    WatermarkText.BackgroundTransparency = 1
    WatermarkText.Position = UDim2.new(0, 10, 0, 0)
    WatermarkText.Size = UDim2.new(0, 0, 1, 0)
    WatermarkText.AutomaticSize = Enum.AutomaticSize.X
    WatermarkText.Font = Enum.Font.GothamBold
    WatermarkText.Text = text or 'Linni Hub'
    WatermarkText.TextColor3 = Color3.fromRGB(255, 255, 255)
    WatermarkText.TextSize = 12

    local TextPadding = Instance.new('UIPadding')

    TextPadding.PaddingRight = UDim.new(0, 10)
    TextPadding.Parent = WatermarkText

    WatermarkVisible = true

    return Watermark
end

function Watermark:setText(text)
    if WatermarkText then
        WatermarkText.Text = text
    end
end

function Watermark:show()
    if WatermarkGui then
        WatermarkGui.Enabled = true
        WatermarkVisible = true
    end
end

function Watermark:hide()
    if WatermarkGui then
        WatermarkGui.Enabled = false
        WatermarkVisible = false
    end
end

function Watermark:toggle()
    if WatermarkVisible then
        Watermark:hide()
    else
        Watermark:show()
    end
end

function Watermark:destroy()
    if WatermarkGui then
        WatermarkGui:Destroy()
        WatermarkGui = nil
        WatermarkFrame = nil
        WatermarkText = nil
        WatermarkVisible = false
    end
end

function Watermark:setPosition(position)
    if WatermarkFrame then
        WatermarkFrame.Position = position
    end
end

Library.Watermark = Watermark

local FPSCounter = {}
local FPSGui = nil
local FPSLabel = nil
local FPSConnection = nil

function FPSCounter:create()
    if FPSGui then
        FPSGui:Destroy()
    end

    FPSGui = Instance.new('ScreenGui')
    FPSLabel = Instance.new('TextLabel')

    local FPSFrame = Instance.new('Frame')
    local FPSCorner = Instance.new('UICorner')

    if syn and syn.protect_gui then
        syn.protect_gui(FPSGui)
    end

    FPSGui.Name = 'LinniFPS'
    FPSGui.Parent = Services.CoreGui
    FPSFrame.Name = 'Frame'
    FPSFrame.Parent = FPSGui
    FPSFrame.AnchorPoint = Vector2.new(1, 0)
    FPSFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    FPSFrame.BackgroundTransparency = 0.3
    FPSFrame.Position = UDim2.new(1, -10, 0, 10)
    FPSFrame.Size = UDim2.new(0, 80, 0, 25)
    FPSCorner.CornerRadius = UDim.new(0, 6)
    FPSCorner.Parent = FPSFrame
    FPSLabel.Name = 'Label'
    FPSLabel.Parent = FPSFrame
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Size = UDim2.new(1, 0, 1, 0)
    FPSLabel.Font = Enum.Font.GothamBold
    FPSLabel.Text = 'FPS: 0'
    FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    FPSLabel.TextSize = 12

    local frameCount = 0
    local lastTime = tick()

    FPSConnection = Services.RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1

        local currentTime = tick()

        if currentTime - lastTime >= 1 then
            local fps = math.floor(frameCount / (currentTime - lastTime))

            FPSLabel.Text = 'FPS: ' .. fps

            if fps >= 60 then
                FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
            elseif fps >= 30 then
                FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                FPSLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            end

            frameCount = 0
            lastTime = currentTime
        end
    end)

    return FPSCounter
end

function FPSCounter:destroy()
    if FPSConnection then
        FPSConnection:Disconnect()
        FPSConnection = nil
    end
    if FPSGui then
        FPSGui:Destroy()
        FPSGui = nil
        FPSLabel = nil
    end
end

function FPSCounter:show()
    if FPSGui then
        FPSGui.Enabled = true
    end
end

function FPSCounter:hide()
    if FPSGui then
        FPSGui.Enabled = false
    end
end

Library.FPSCounter = FPSCounter

local PlayerList = {}

function PlayerList:getPlayers()
    local players = {}

    for _, player in ipairs(Services.Players:GetPlayers()) do
        table.insert(players, player.Name)
    end

    return players
end

function PlayerList:getPlayerByName(name)
    return Services.Players:FindFirstChild(name)
end

function PlayerList:getLocalPlayer()
    return Services.Players.LocalPlayer
end

function PlayerList:getCharacter(player)
    if typeof(player) == 'string' then
        player = PlayerList:getPlayerByName(player)
    end

    if player then
        return player.Character
    end

    return nil
end

function PlayerList:getHumanoid(player)
    local character = PlayerList:getCharacter(player)

    if character then
        return character:FindFirstChildOfClass('Humanoid')
    end

    return nil
end

function PlayerList:getRootPart(player)
    local character = PlayerList:getCharacter(player)

    if character then
        return character:FindFirstChild('HumanoidRootPart')
    end

    return nil
end

function PlayerList:getHead(player)
    local character = PlayerList:getCharacter(player)

    if character then
        return character:FindFirstChild('Head')
    end

    return nil
end

function PlayerList:getDistance(player1, player2)
    local root1 = PlayerList:getRootPart(player1)
    local root2 = PlayerList:getRootPart(player2)

    if root1 and root2 then
        return (root1.Position - root2.Position).Magnitude
    end

    return math.huge
end

function PlayerList:getClosestPlayer(ignoreTeam)
    local localPlayer = PlayerList:getLocalPlayer()
    local localRoot = PlayerList:getRootPart(localPlayer)

    if not localRoot then
        return nil
    end

    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= localPlayer then
            if ignoreTeam and player.Team == localPlayer.Team then
                continue
            end

            local distance = PlayerList:getDistance(localPlayer, player)

            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer, closestDistance
end

Library.PlayerList = PlayerList

local ESP = {}
local ESPEnabled = false
local ESPObjects = {}
local ESPConnection = nil

function ESP:create(player, options)
    options = options or {}

    local espData = {
        Player = player,
        Box = nil,
        Name = nil,
        Distance = nil,
        HealthBar = nil,
        Tracer = nil,
    }

    if options.Box ~= false then
        local box = Drawing.new('Square')

        box.Visible = false
        box.Color = options.BoxColor or Color3.fromRGB(255, 0, 0)
        box.Thickness = 1
        box.Filled = false

        espData.Box = box
    end

    if options.Name ~= false then
        local name = Drawing.new('Text')

        name.Visible = false
        name.Color = options.NameColor or Color3.fromRGB(255, 255, 255)
        name.Size = 13
        name.Center = true
        name.Outline = true
        name.Text = player.Name

        espData.Name = name
    end

    if options.Distance then
        local distance = Drawing.new('Text')

        distance.Visible = false
        distance.Color = options.DistanceColor or Color3.fromRGB(200, 200, 200)
        distance.Size = 12
        distance.Center = true
        distance.Outline = true

        espData.Distance = distance
    end

    if options.Tracer then
        local tracer = Drawing.new('Line')

        tracer.Visible = false
        tracer.Color = options.TracerColor or Color3.fromRGB(255, 255, 0)
        tracer.Thickness = 1

        espData.Tracer = tracer
    end

    ESPObjects[player] = espData

    return espData
end

function ESP:remove(player)
    local espData = ESPObjects[player]

    if espData then
        if espData.Box then
            espData.Box:Remove()
        end
        if espData.Name then
            espData.Name:Remove()
        end
        if espData.Distance then
            espData.Distance:Remove()
        end
        if espData.HealthBar then
            espData.HealthBar:Remove()
        end
        if espData.Tracer then
            espData.Tracer:Remove()
        end

        ESPObjects[player] = nil
    end
end

function ESP:enable()
    ESPEnabled = true

    if not ESPConnection then
        ESPConnection = Services.RunService.RenderStepped:Connect(function()
            if not ESPEnabled then
                return
            end

            local camera = workspace.CurrentCamera
            local localPlayer = Services.Players.LocalPlayer

            for player, espData in pairs(ESPObjects) do
                local character = player.Character
                local rootPart = character and character:FindFirstChild('HumanoidRootPart')
                local head = character and character:FindFirstChild('Head')
                local humanoid = character and character:FindFirstChildOfClass('Humanoid')

                if rootPart and head and humanoid then
                    local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                    local headPos = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

                    if onScreen then
                        local boxHeight = math.abs(headPos.Y - legPos.Y)
                        local boxWidth = boxHeight * 0.6

                        if espData.Box then
                            espData.Box.Size = Vector2.new(boxWidth, boxHeight)
                            espData.Box.Position = Vector2.new(screenPos.X - boxWidth / 2, headPos.Y)
                            espData.Box.Visible = true
                        end

                        if espData.Name then
                            espData.Name.Position = Vector2.new(screenPos.X, headPos.Y - 15)
                            espData.Name.Visible = true
                        end

                        if espData.Distance then
                            local localRoot = PlayerList:getRootPart(localPlayer)

                            if localRoot then
                                local dist = (rootPart.Position - localRoot.Position).Magnitude

                                espData.Distance.Text = math.floor(dist) .. 'm'
                                espData.Distance.Position = Vector2.new(screenPos.X, legPos.Y + 5)
                                espData.Distance.Visible = true
                            end
                        end

                        if espData.Tracer then
                            espData.Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                            espData.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            espData.Tracer.Visible = true
                        end
                    else
                        if espData.Box then
                            espData.Box.Visible = false
                        end
                        if espData.Name then
                            espData.Name.Visible = false
                        end
                        if espData.Distance then
                            espData.Distance.Visible = false
                        end
                        if espData.Tracer then
                            espData.Tracer.Visible = false
                        end
                    end
                else
                    if espData.Box then
                        espData.Box.Visible = false
                    end
                    if espData.Name then
                        espData.Name.Visible = false
                    end
                    if espData.Distance then
                        espData.Distance.Visible = false
                    end
                    if espData.Tracer then
                        espData.Tracer.Visible = false
                    end
                end
            end
        end)
    end
end

function ESP:disable()
    ESPEnabled = false

    for _, espData in pairs(ESPObjects) do
        if espData.Box then
            espData.Box.Visible = false
        end
        if espData.Name then
            espData.Name.Visible = false
        end
        if espData.Distance then
            espData.Distance.Visible = false
        end
        if espData.Tracer then
            espData.Tracer.Visible = false
        end
    end
end

function ESP:destroy()
    ESP:disable()

    if ESPConnection then
        ESPConnection:Disconnect()
        ESPConnection = nil
    end

    for player, _ in pairs(ESPObjects) do
        ESP:remove(player)
    end
end

Library.ESP = ESP

return Library



