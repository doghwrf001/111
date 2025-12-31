-- 职业切换UI脚本
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 创建主屏幕GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ClassSelectorUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 创建可拖动的Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "ClassSelector"
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Position = UDim2.new(0, 50, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Selectable = true

-- 添加标题
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "临时冷溪军团"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- 关闭按钮
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

-- 按钮容器
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, -10, 1, -40)
ButtonContainer.Position = UDim2.new(0, 5, 0, 35)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- 统一的按钮颜色
local BUTTON_COLOR = Color3.fromRGB(70, 130, 180)  -- 钢蓝色
local BUTTON_HOVER_COLOR = Color3.fromRGB(100, 160, 210)  -- 更亮的钢蓝色
local BUTTON_CLICK_COLOR = Color3.fromRGB(50, 110, 160)  -- 更深的钢蓝色

-- 职业配置
local Classes = {
    {
        Name = "列兵",
        Class = "LineInfantry",
        Description = "主要步兵单位，配备步枪进行线列作战"
    },
    {
        Name = "军官", 
        Class = "Officer",
        Description = "指挥单位，配备手枪和指挥刀，可以下达命令"
    },
    {
        Name = "水兵",
        Class = "Seaman", 
        Description = "海军单位，擅长航海和舰炮操作"
    },
    {
        Name = "乐手",
        Class = "Musician",
        Description = "音乐单位，通过演奏鼓舞士气或传递信号"
    },
    {
        Name = "工兵",
        Class = "Sapper",
        Description = "工程单位，负责建造防御工事和爆破任务"
    }
}

-- 创建职业按钮
local buttonHeight = 35
local buttonSpacing = 5

for i, classInfo in ipairs(Classes) do
    local button = Instance.new("TextButton")
    button.Name = classInfo.Class .. "Button"
    button.Size = UDim2.new(1, 0, 0, buttonHeight)
    button.Position = UDim2.new(0, 0, 0, (buttonHeight + buttonSpacing) * (i - 1))
    button.BackgroundColor3 = BUTTON_COLOR
    button.BorderSizePixel = 0
    button.Text = classInfo.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = false -- 禁用默认的按钮颜色效果
    
    -- 悬停效果
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(255, 0, 0) then -- 如果不是错误状态
            button.BackgroundColor3 = BUTTON_HOVER_COLOR
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(255, 0, 0) then -- 如果不是错误状态
            button.BackgroundColor3 = BUTTON_COLOR
        end
    end)
    
    -- 点击效果
    button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = BUTTON_CLICK_COLOR
    end)
    
    button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = BUTTON_HOVER_COLOR
    end)
    
    -- 按钮点击事件
    button.MouseButton1Click:Connect(function()
        -- 发送职业切换请求
        local args = {
            classInfo.Class,
            4,
            "British",
            "Infantry"
        }
        
        local success, error = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Regiment"):WaitForChild("ChangeClass"):FireServer(unpack(args))
        end)
        
        if success then
            -- 显示成功提示
            local originalText = button.Text
            button.Text = "✓ " .. classInfo.Name
            button.BackgroundColor3 = Color3.fromRGB(60, 180, 75) -- 成功绿色
            
            -- 2秒后恢复原状
            wait(2)
            button.Text = originalText
            button.BackgroundColor3 = BUTTON_COLOR
        else
            -- 显示错误提示
            local originalText = button.Text
            button.Text = "错误!"
            button.BackgroundColor3 = Color3.fromRGB(220, 60, 60) -- 错误红色
            
            -- 2秒后恢复原状
            wait(2)
            button.Text = originalText
            button.BackgroundColor3 = BUTTON_COLOR
        end
    end)
    
    button.Parent = ButtonContainer
end

-- 关闭按钮事件
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 添加到玩家GUI
MainFrame.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

-- 添加最小化功能
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 12
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = MainFrame

local isMinimized = false
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 200, 0, 30)

MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        -- 恢复
        MainFrame.Size = originalSize
        ButtonContainer.Visible = true
        isMinimized = false
    else
        -- 最小化
        MainFrame.Size = minimizedSize
        ButtonContainer.Visible = false
        isMinimized = true
    end
end)

-- 添加右键菜单来显示职业描述
for _, button in ipairs(ButtonContainer:GetChildren()) do
    if button:IsA("TextButton") then
        button.MouseButton2Click:Connect(function()
            local classInfo
            for _, info in ipairs(Classes) do
                if button.Name == info.Class .. "Button" then
                    classInfo = info
                    break
                end
            end
            
            if classInfo then
                -- 移除现有的提示框
                for _, child in ipairs(ButtonContainer:GetChildren()) do
                    if child.Name == "Tooltip" then
                        child:Destroy()
                    end
                end
                
                -- 创建提示框
                local tooltip = Instance.new("Frame")
                tooltip.Name = "Tooltip"
                tooltip.Size = UDim2.new(1, 10, 0, 50)
                tooltip.Position = UDim2.new(0, -5, 1, 5)
                tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                tooltip.BorderColor3 = Color3.fromRGB(100, 100, 100)
                tooltip.ZIndex = 10
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -10, 1, -10)
                label.Position = UDim2.new(0, 5, 0, 5)
                label.BackgroundTransparency = 1
                label.Text = classInfo.Description
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.TextSize = 10
                label.Font = Enum.Font.Gotham
                label.TextWrapped = true
                label.Parent = tooltip
                
                tooltip.Parent = ButtonContainer
                
                -- 3秒后自动消失
                wait(3)
                if tooltip and tooltip.Parent then
                    tooltip:Destroy()
                end
            end
        end)
    end
end

-- 添加保存位置功能
local UserInputService = game:GetService("UserInputService")

-- 保存位置
local function savePosition()
    if Player then
        -- 使用本地存储保存位置
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONEncode({
                X = MainFrame.Position.X.Offset,
                Y = MainFrame.Position.Y.Offset
            })
        end)
        
        if success then
            -- 这里可以保存到数据存储，暂时保存到脚本属性
            if not script:FindFirstChild("UIPosition") then
                local value = Instance.new("StringValue")
                value.Name = "UIPosition"
                value.Value = result
                value.Parent = script
            else
                script.UIPosition.Value = result
            end
        end
    end
end

-- 加载保存的位置
local function loadPosition()
    if script:FindFirstChild("UIPosition") then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(script.UIPosition.Value)
        end)
        
        if success and data then
            MainFrame.Position = UDim2.new(0, data.X, 0, data.Y)
        end
    end
end

-- 当拖动停止时保存位置
local isDragging = false

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if isDragging then
            isDragging = false
            savePosition()
        end
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- 检查是否点击在标题栏上
        local mousePos = UserInputService:GetMouseLocation()
        local framePos = MainFrame.AbsolutePosition
        local frameSize = MainFrame.AbsoluteSize
        
        if mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
           mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + 30 then
            isDragging = true
        end
    end
end)

-- 初始加载位置
loadPosition()
