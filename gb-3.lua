local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- 创建主GUI
local ClassChangerGUI = Instance.new("ScreenGui")
ClassChangerGUI.Name = "ClassChangerUI"
ClassChangerGUI.Parent = game:GetService("CoreGui")
ClassChangerGUI.ResetOnSpawn = false
ClassChangerGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 创建主框架
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ClassChangerGUI

-- 主框架圆角
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

-- 主框架边框
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleBarCorner = MainCorner:Clone()
TitleBarCorner.CornerRadius = UDim.new(0, 6)
TitleBarCorner.Parent = TitleBar

-- 标题文字
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "🔥时代潮流职业切换"  -- 解码后
TitleText.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.GothamMedium
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -28, 0, 0)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local CloseButtonCorner = MainCorner:Clone()
CloseButtonCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ClassChangerGUI:Destroy()
end)

-- 滚动框架
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -10, 1, -38)
ScrollFrame.Position = UDim2.new(0, 5, 0, 33)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = MainFrame

-- 按钮容器
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, 0, 0, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = ScrollFrame

-- 按钮列表布局
local ButtonListLayout = Instance.new("UIListLayout")
ButtonListLayout.Padding = UDim.new(0, 4)
ButtonListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonListLayout.Parent = ButtonContainer

ButtonListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonListLayout.AbsoluteContentSize.Y + 5)
end)

-- 创建职业按钮的函数
local function CreateClassButton(buttonName, serverArgs)
    local ClassButton = Instance.new("TextButton")
    ClassButton.Name = buttonName
    ClassButton.Size = UDim2.new(0.95, 0, 0, 32)
    ClassButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ClassButton.Text = buttonName
    ClassButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    ClassButton.Font = Enum.Font.Gotham
    ClassButton.TextSize = 13
    ClassButton.Parent = ButtonContainer
    
    local ButtonCorner = MainCorner:Clone()
    ButtonCorner.Parent = ClassButton
    
    -- 鼠标悬停效果
    ClassButton.MouseEnter:Connect(function()
        ClassButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    ClassButton.MouseLeave:Connect(function()
        ClassButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    -- 点击事件：切换职业
    ClassButton.MouseButton1Click:Connect(function()
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("Regiment"):WaitForChild("ChangeClass"):FireServer(unpack(serverArgs))
        
        -- 点击反馈
        ClassButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        task.delay(0.3, function()
            ClassButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
    end)
end

-- 创建各个职业按钮
CreateClassButton("🔥线列兵", {
    "LineInfantry",
    5,
    "French",
    "Infantry"
})

CreateClassButton("🔥军官", {
    "Officer",
    5,
    "French",
    "Infantry"
})

CreateClassButton("🔥旗手", {
    "Seaman",
    5,
    "French",
    "Infantry"
})

CreateClassButton("🔥乐手", {
    "Musician",
    5,
    "French",
    "Infantry"
})

CreateClassButton("🔥工兵", {
    "Sapper",
    5,
    "French",
    "Infantry"
})

-- 窗口拖拽功能
local isDragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)
