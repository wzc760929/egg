-- [[ ★egg man HUB - SMOOTH ANIMATION EDITION + SETTINGS ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager") 

-- 删除旧的GUI以保证干净
for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end
end
for _, v in ipairs(lp:WaitForChild("PlayerGui"):GetChildren()) do
    if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end
end

-- 设置全局变量
getgenv().NWKZ_Anchor = false
getgenv().NWKZ_AutoCast = false
getgenv().PP_Noclip = false
getgenv().PP_WalkSpeed = 16
getgenv().PP_AutoSell = false
getgenv().PP_SellDelay = 5

getgenv().PP_AutoSkillAll = false
getgenv().PP_Skill_Z = false
getgenv().PP_Skill_X = false
getgenv().PP_Skill_C = false
getgenv().PP_Skill_V = false

local skillKeys = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}

-- [[ 1. 创建ScreenGui ]] --
local sg = Instance.new("ScreenGui")
sg.Name = "PPINGYYY_Hub_Ultimate"
sg.ResetOnSpawn = false

local success, err = pcall(function()
    sg.Parent = game:GetService("CoreGui")
end)
if not success then
    sg.Parent = lp:WaitForChild("PlayerGui")
end

local MainSize = UDim2.new(0, 420, 0, 250)
local tweenInfoMain = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- [[ 2. 主窗口 ]] --
local Main = Instance.new("Frame", sg)
Main.Size = MainSize
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Main.BackgroundTransparency = 0.25
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainBorder = Instance.new("UIStroke", Main)
MainBorder.Color = Color3.fromRGB(0, 255, 150)
MainBorder.Thickness = 2
MainBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- [[ 3. 标题栏 ]] --
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Text = "蛋蛋超人的脚本"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(0.81, 0, 0.25, 0)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- [[ 4. 选项卡菜单结构 ]] --
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, 0, 1, -40)
Container.Position = UDim2.new(0, 0, 0, 40)
Container.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Container)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.BorderSizePixel = 0
Sidebar.ClipsDescendants = true

local Pages = Instance.new("Frame", Container)
Pages.Size = UDim2.new(1, -130, 1, -10)
Pages.Position = UDim2.new(0, 125, 0, 5)
Pages.BackgroundTransparency = 1

local function createTabButton(text, posIndex)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.85, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, 8 + (posIndex * 35))
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn:SetAttribute("Index", posIndex)
    return btn
end

local Tab1Btn = createTabButton("🎣 钓鱼", 0)
local Tab2Btn = createTabButton("⚡ 技能", 1)
local Tab3Btn = createTabButton("🛠️ 工具", 2)
local Tab4Btn = createTabButton("🏝️ 传送", 3)
local Tab5Btn = createTabButton("⚙️ 设置", 4)
local function createPage()
    local page = Instance.new("ScrollingFrame", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
    page.Visible = false
    return page
end

local Page1 = createPage()
local Page2 = createPage()
local Page3 = createPage()
local Page4 = createPage()
local Page5 = createPage()

local activePage = nil 
local activeBtn = nil

local function showPage(targetPage, targetBtn)
    if activePage == targetPage then return end
    local tweenInfoElastic = TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    local tweenInfoPage = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if activeBtn then
        local oldIndex = activeBtn:GetAttribute("Index") or 0
        TweenService:Create(activeBtn, tweenInfoElastic, {
            Size = UDim2.new(0.85, 0, 0, 30),
            Position = UDim2.new(0.05, 0, 0, 8 + (oldIndex * 35)),
            TextColor3 = Color3.fromRGB(150, 150, 150),
            BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        }):Play()
    end
    local newIndex = targetBtn:GetAttribute("Index") or 0
    TweenService:Create(targetBtn, tweenInfoElastic, {
        Size = UDim2.new(1.05, 0, 0, 30),
        Position = UDim2.new(0.05, 0, 0, 8 + (newIndex * 35)),
        TextColor3 = Color3.fromRGB(0, 255, 150),
        BackgroundColor3 = Color3.fromRGB(25, 40, 32)
    }):Play()
    activeBtn = targetBtn
    if activePage then activePage.Visible = false end
    targetPage.Position = UDim2.new(0, 0, 0, 15)
    targetPage.CanvasPosition = Vector2.new(0, 0)
    targetPage.Visible = true
    TweenService:Create(targetPage, tweenInfoPage, {Position = UDim2.new(0, 0, 0, 0)}):Play()
    activePage = targetPage
end

Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3, Tab3Btn) end)
Tab4Btn.MouseButton1Click:Connect(function() showPage(Page4, Tab4Btn) end)
Tab5Btn.MouseButton1Click:Connect(function() showPage(Page5, Tab5Btn) end)
local function createNormalButton(parent, text, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end
local CastBtn = createNormalButton(Page1, "自动抛竿: OFF", 5)
local AnchorBtn = createNormalButton(Page1, "锚定（居中）: OFF", 42)

-- 自动售卖开关
local AutoSellBtn = createNormalButton(Page1, "自动售卖: OFF", 79)

-- 售卖延迟标签
local SellDelayLabel = Instance.new("TextLabel", Page1)
SellDelayLabel.Size = UDim2.new(1, -10, 0, 20)
SellDelayLabel.Position = UDim2.new(0, 0, 0, 116)
SellDelayLabel.Text = "售卖延迟: 5 秒"
SellDelayLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SellDelayLabel.Font = Enum.Font.Gotham
SellDelayLabel.TextSize = 11
SellDelayLabel.BackgroundTransparency = 1

-- 延迟增加
local SellDelayUpBtn = Instance.new("TextButton", Page1)
SellDelayUpBtn.Size = UDim2.new(0.46, 0, 0, 30)
SellDelayUpBtn.Position = UDim2.new(0.02, 0, 0, 140)
SellDelayUpBtn.Text = "增加延迟 (+)"
SellDelayUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SellDelayUpBtn.TextColor3 = Color3.new(1, 1, 1)
SellDelayUpBtn.Font = Enum.Font.GothamBold
SellDelayUpBtn.TextSize = 10
Instance.new("UICorner", SellDelayUpBtn).CornerRadius = UDim.new(0, 5)

-- 延迟减少
local SellDelayDownBtn = Instance.new("TextButton", Page1)
SellDelayDownBtn.Size = UDim2.new(0.46, 0, 0, 30)
SellDelayDownBtn.Position = UDim2.new(0.51, 0, 0, 140)
SellDelayDownBtn.Text = "减少延迟 (-)"
SellDelayDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SellDelayDownBtn.TextColor3 = Color3.new(1, 1, 1)
SellDelayDownBtn.Font = Enum.Font.GothamBold
SellDelayDownBtn.TextSize = 10
Instance.new("UICorner", SellDelayDownBtn).CornerRadius = UDim.new(0, 5)

-- 手动全部出售
local SellBtn = Instance.new("TextButton", Page1)
SellBtn.Size = UDim2.new(0.95, 0, 0, 32)
SellBtn.Position = UDim2.new(0.025, 0, 0, 176)
SellBtn.Text = "💰 全部出售"
SellBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
SellBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.TextSize = 10
Instance.new("UICorner", SellBtn).CornerRadius = UDim.new(0, 6)

-- 技能
local SkillAllBtn = createNormalButton(Page2, "自动所有技能: OFF", 5)
local function createGridSkillBtn(keyName, posIndex, varName)
    local btn = Instance.new("TextButton", Page2)
    btn.Size = UDim2.new(0.46, 0, 0, 30)
    local xPos = (posIndex % 2 == 0) and 0.02 or 0.51
    local yPos = 45 + (math.floor(posIndex / 2) * 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.Text = "自动技能 ["..keyName.."]: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(function()
        getgenv()[varName] = not getgenv()[varName]
        btn.Text = "自动技能 ["..keyName.."]: " .. (getgenv()[varName] and "ON" or "OFF")
        btn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 45)
        btn.TextColor3 = getgenv()[varName] and Color3.new(1,1,1) or Color3.fromRGB(200, 200, 200)
    end)
end
createGridSkillBtn("V", 0, "PP_Skill_V")
createGridSkillBtn("Z", 1, "PP_Skill_Z")
createGridSkillBtn("X", 2, "PP_Skill_X")
createGridSkillBtn("C", 3, "PP_Skill_C")

-- 工具
local NoclipBtn = createNormalButton(Page3, "无碰撞（穿墙）: OFF", 5)
local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 45)
SpeedLabel.Text = "移动速度: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 11
SpeedLabel.BackgroundTransparency = 1
local SpeedUpBtn = Instance.new("TextButton", Page3)
SpeedUpBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedUpBtn.Position = UDim2.new(0.02, 0, 0, 70)
SpeedUpBtn.Text = "增加速度 (+)"
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedUpBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedUpBtn.Font = Enum.Font.GothamBold
SpeedUpBtn.TextSize = 10
Instance.new("UICorner", SpeedUpBtn).CornerRadius = UDim.new(0, 5)
local SpeedDownBtn = Instance.new("TextButton", Page3)
SpeedDownBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedDownBtn.Position = UDim2.new(0.51, 0, 0, 70)
SpeedDownBtn.Text = "减少速度 (-)"
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedDownBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedDownBtn.Font = Enum.Font.GothamBold
SpeedDownBtn.TextSize = 10
Instance.new("UICorner", SpeedDownBtn).CornerRadius = UDim.new(0, 5)

-- ====== 加载飞行按钮 ======
local FlyLoadBtn = Instance.new("TextButton", Page3)
FlyLoadBtn.Size = UDim2.new(0.95, 0, 0, 32)
FlyLoadBtn.Position = UDim2.new(0.025, 0, 0, 110)
FlyLoadBtn.Text = "🚀 加载飞行"
FlyLoadBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
FlyLoadBtn.TextColor3 = Color3.new(1, 1, 1)
FlyLoadBtn.Font = Enum.Font.GothamBold
FlyLoadBtn.TextSize = 10
Instance.new("UICorner", FlyLoadBtn).CornerRadius = UDim.new(0, 6)

-- ====== 新增：夜视开关 ======
local NightVisionBtn = Instance.new("TextButton", Page3)
NightVisionBtn.Size = UDim2.new(0.95, 0, 0, 32)
NightVisionBtn.Position = UDim2.new(0.025, 0, 0, 148)
NightVisionBtn.Text = "🌙 夜视: OFF"
NightVisionBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NightVisionBtn.TextColor3 = Color3.new(1, 1, 1)
NightVisionBtn.Font = Enum.Font.GothamBold
NightVisionBtn.TextSize = 10
Instance.new("UICorner", NightVisionBtn).CornerRadius = UDim.new(0, 6)

-- 保存原始光照设置（用于夜视恢复）
local Lighting = game:GetService("Lighting")
local nvOn = false
local originalNV = {
    Technology = Lighting.Technology,
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    ClockTime = Lighting.ClockTime
}

-- 传送函数
local function createTeleportButton(parent, name, x, y, z, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.Text = "🏝️ " .. name
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        end
    end)
end

createTeleportButton(Page4, "初始岛屿", -236, 6, 56, 5)
createTeleportButton(Page4, "竹子岛", -1226, 5, -23, 42)
createTeleportButton(Page4, "核弹岛", 74, 6, 1216, 79)
createTeleportButton(Page4, "主权岛屿", -1285, 6, 1240, 116)
createTeleportButton(Page4, "鲈鱼岛", 150.8, 9.3, -1457.8, 153)
createTeleportButton(Page4, "冰霜岛屿", -1524.3, 6.8, -1321.0, 190)
createTeleportButton(Page4, "椰子岛", 1479.7, 9.1, -1498.0, 227)
createTeleportButton(Page4, "琥珀岛", 1267.8, 6.8, 1428.0, 264)
createTeleportButton(Page4, "战场岛", 1559.5, 47.0, -38.6, 301)
createTeleportButton(Page4, "迷雾峰岛", 2642.0, 6.8, -81, 338)

-- ================== NPC 追踪（工具页） ==================
-- 分类标签
local NPCLabel = Instance.new("TextLabel", Page3)
NPCLabel.Size = UDim2.new(1, -10, 0, 20)
NPCLabel.Position = UDim2.new(0, 0, 0, 190)
NPCLabel.Text = "🤖 NPC 追踪"
NPCLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
NPCLabel.Font = Enum.Font.GothamBold
NPCLabel.TextSize = 12
NPCLabel.BackgroundTransparency = 1

-- Maoshan 按钮 (左)
local NpcBtnMaoshan = Instance.new("TextButton", Page3)
NpcBtnMaoshan.Size = UDim2.new(0.43, 0, 0, 28)
NpcBtnMaoshan.Position = UDim2.new(0.05, 0, 0, 215)
NpcBtnMaoshan.Text = "🚀 Maoshan"
NpcBtnMaoshan.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NpcBtnMaoshan.TextColor3 = Color3.new(1, 1, 1)
NpcBtnMaoshan.Font = Enum.Font.GothamBold
NpcBtnMaoshan.TextSize = 10
Instance.new("UICorner", NpcBtnMaoshan).CornerRadius = UDim.new(0, 5)

-- Taoist 按钮 (右)  ← 已修正
local NpcBtnTaoist = Instance.new("TextButton", Page3)
NpcBtnTaoist.Size = UDim2.new(0.43, 0, 0, 28)
NpcBtnTaoist.Position = UDim2.new(0.52, 0, 0, 215)
NpcBtnTaoist.Text = "🚀 Taoist"
NpcBtnTaoist.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NpcBtnTaoist.TextColor3 = Color3.new(1, 1, 1)
NpcBtnTaoist.Font = Enum.Font.GothamBold
NpcBtnTaoist.TextSize = 10
Instance.new("UICorner", NpcBtnTaoist).CornerRadius = UDim.new(0, 5)

-- 自动追踪开关
local NpcAutoBtn = Instance.new("TextButton", Page3)
NpcAutoBtn.Size = UDim2.new(0.95, 0, 0, 28)
NpcAutoBtn.Position = UDim2.new(0.025, 0, 0, 250)
NpcAutoBtn.Text = "自动追踪: OFF"
NpcAutoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NpcAutoBtn.TextColor3 = Color3.new(1, 1, 1)
NpcAutoBtn.Font = Enum.Font.GothamBold
NpcAutoBtn.TextSize = 10
Instance.new("UICorner", NpcAutoBtn).CornerRadius = UDim.new(0, 5)

-- 状态显示
local NpcStatus = Instance.new("TextLabel", Page3)
NpcStatus.Size = UDim2.new(1, -10, 0, 18)
NpcStatus.Position = UDim2.new(0, 0, 0, 283)
NpcStatus.Text = "就绪"
NpcStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
NpcStatus.Font = Enum.Font.Gotham
NpcStatus.TextSize = 10
NpcStatus.BackgroundTransparency = 1
CastBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_AutoCast = not getgenv().NWKZ_AutoCast
    CastBtn.Text = "自动抛竿: " .. (getgenv().NWKZ_AutoCast and "ON" or "OFF")
    CastBtn.BackgroundColor3 = getgenv().NWKZ_AutoCast and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

AnchorBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = not getgenv().NWKZ_Anchor
    AnchorBtn.Text = "锚定（居中）: " .. (getgenv().NWKZ_Anchor and "ON" or "OFF")
    AnchorBtn.BackgroundColor3 = getgenv().NWKZ_Anchor and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

AutoSellBtn.MouseButton1Click:Connect(function()
    getgenv().PP_AutoSell = not getgenv().PP_AutoSell
    AutoSellBtn.Text = "自动售卖: " .. (getgenv().PP_AutoSell and "ON" or "OFF")
    AutoSellBtn.BackgroundColor3 = getgenv().PP_AutoSell and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SellDelayUpBtn.MouseButton1Click:Connect(function()
    getgenv().PP_SellDelay = math.clamp(getgenv().PP_SellDelay + 1, 1, 60)
    SellDelayLabel.Text = "售卖延迟: " .. tostring(getgenv().PP_SellDelay) .. " 秒"
end)

SellDelayDownBtn.MouseButton1Click:Connect(function()
    getgenv().PP_SellDelay = math.clamp(getgenv().PP_SellDelay - 1, 1, 60)
    SellDelayLabel.Text = "售卖延迟: " .. tostring(getgenv().PP_SellDelay) .. " 秒"
end)

SellBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("SellFish") then
            RS.Events.SellFish:FireServer("All")
        elseif RS:FindFirstChild("SellFish") then
            RS.SellFish:FireServer("All")
        end
    end)
    SellBtn.Text = "SOLD OUT!"
    task.wait(0.4)
    SellBtn.Text = "💰 全部出售"
end)

SkillAllBtn.MouseButton1Click:Connect(function()
    getgenv().PP_AutoSkillAll = not getgenv().PP_AutoSkillAll
    SkillAllBtn.Text = "自动所有技能: " .. (getgenv().PP_AutoSkillAll and "ON" or "OFF")
    SkillAllBtn.BackgroundColor3 = getgenv().PP_AutoSkillAll and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    getgenv().PP_Noclip = not getgenv().PP_Noclip
    NoclipBtn.Text = "无碰撞（穿墙）: " .. (getgenv().PP_Noclip and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = getgenv().PP_Noclip and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SpeedUpBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed + 10, 16, 250)
    SpeedLabel.Text = "移动速度: " .. tostring(getgenv().PP_WalkSpeed)
end)
SpeedDownBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed - 10, 16, 250)
    SpeedLabel.Text = "移动速度: " .. tostring(getgenv().PP_WalkSpeed)
end)

-- ====== 飞行加载按钮事件 ======
local flyLoaded = false
FlyLoadBtn.MouseButton1Click:Connect(function()
    if flyLoaded then
        FlyLoadBtn.Text = "⚠️ 已加载"
        FlyLoadBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        task.wait(0.8)
        FlyLoadBtn.Text = "🚀 加载飞行"
        FlyLoadBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
        return
    end
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        flyLoaded = true
        FlyLoadBtn.Text = "✅ 已加载"
        FlyLoadBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        task.wait(1)
        FlyLoadBtn.Text = "🚀 加载飞行"
        FlyLoadBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
    end)
end)

-- ====== 夜视按钮事件 ======
NightVisionBtn.MouseButton1Click:Connect(function()
    nvOn = not nvOn
    if nvOn then
        Lighting.Technology = Enum.Technology.Legacy
        Lighting.Brightness = 5
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 12
        NightVisionBtn.Text = "🌙 夜视: ON"
        NightVisionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        Lighting.Technology = originalNV.Technology
        Lighting.Brightness = originalNV.Brightness
        Lighting.Ambient = originalNV.Ambient
        Lighting.OutdoorAmbient = originalNV.OutdoorAmbient
        Lighting.GlobalShadows = originalNV.GlobalShadows
        Lighting.ClockTime = originalNV.ClockTime
        NightVisionBtn.Text = "🌙 夜视: OFF"
        NightVisionBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- ================== NPC 追踪事件 ==================
local npcAutoTrack = false
local NPC_LIST = {"Maoshan", "Taoist"}   -- 已修正

local function findAnyNpc()
    for _, name in ipairs(NPC_LIST) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                if string.find(string.lower(obj.Name), string.lower(name)) then
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hrp then return hrp, obj.Name end
                end
            end
        end
    end
    return nil, nil
end

local function teleportToNpc(name)
    local char = lp.Character
    if not char then return false, "角色未加载" end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false, "根部件丢失" end

    local target = nil
    local foundName = nil
    if name then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                if string.find(string.lower(obj.Name), string.lower(name)) then
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hrp then target = hrp; foundName = obj.Name; break end
                end
            end
        end
    else
        target, foundName = findAnyNpc()
    end

    if target then
        root.CFrame = CFrame.new(target.Position + Vector3.new(0, 2, 0))
        return true, "✅ 传送至 " .. foundName
    else
        return false, "❌ 未找到" .. (name and (" "..name) or "")
    end
end

-- Maoshan 按钮
NpcBtnMaoshan.MouseButton1Click:Connect(function()
    local success, msg = teleportToNpc("Maoshan")
    NpcStatus.Text = msg
    task.wait(1.5)
    if not npcAutoTrack then NpcStatus.Text = "就绪" end
end)

-- Taoist 按钮 (已修正)
NpcBtnTaoist.MouseButton1Click:Connect(function()
    local success, msg = teleportToNpc("Taoist")
    NpcStatus.Text = msg
    task.wait(1.5)
    if not npcAutoTrack then NpcStatus.Text = "就绪" end
end)

-- 自动追踪开关
NpcAutoBtn.MouseButton1Click:Connect(function()
    npcAutoTrack = not npcAutoTrack
    NpcAutoBtn.Text = "自动追踪: " .. (npcAutoTrack and "ON" or "OFF")
    NpcAutoBtn.BackgroundColor3 = npcAutoTrack and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
    NpcStatus.Text = npcAutoTrack and "追踪中..." or "已暂停"
    task.wait(1)
    if not npcAutoTrack then NpcStatus.Text = "就绪" end
end)
showPage(Page1, Tab1Btn)
-- 恢复按钮（黑底紫边白😈，文字居中）
local RestoreBtn = Instance.new("TextButton", sg)
RestoreBtn.Size = UDim2.new(0, 56, 0, 56)
RestoreBtn.Position = UDim2.new(0.45, 0, 0.45, 0)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
RestoreBtn.Text = "😈"
RestoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RestoreBtn.TextSize = 28
RestoreBtn.TextYAlignment = Enum.TextYAlignment.Center
RestoreBtn.BackgroundTransparency = 0
RestoreBtn.Visible = false
RestoreBtn.ZIndex = 999
local stroke = Instance.new("UIStroke", RestoreBtn)
stroke.Color = Color3.fromRGB(200, 100, 255)
stroke.Thickness = 4
Instance.new("UICorner", RestoreBtn).CornerRadius = UDim.new(1, 0)

-- 恢复按钮拖动
local resDragging, resDragInput, resDragStart, resStartPos
local function resUpdate(input)
    local delta = input.Position - resDragStart
    RestoreBtn.Position = UDim2.new(resStartPos.X.Scale, resStartPos.X.Offset + delta.X, resStartPos.Y.Scale, resStartPos.Y.Offset + delta.Y)
end
RestoreBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resDragging = true
        resDragStart = input.Position
        resStartPos = RestoreBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then resDragging = false end
        end)
    end
end)
RestoreBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        resDragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == resDragInput and resDragging then resUpdate(input) end
end)

RestoreBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    RestoreBtn.Visible = false
    MinBtn.Text = "—"
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    RestoreBtn.Visible = true
    MinBtn.Text = "⬜"
end)

CloseBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = false
    getgenv().NWKZ_AutoCast = false
    getgenv().PP_Noclip = false
    getgenv().PP_AutoSell = false
    getgenv().PP_AutoSkillAll = false
    getgenv().PP_Skill_Z = false
    getgenv().PP_Skill_X = false
    getgenv().PP_Skill_C = false
    getgenv().PP_Skill_V = false
    sg:Destroy()
end)

-- 自动技能
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if getgenv().PP_AutoSkillAll then
                local randomKey = skillKeys[math.random(1, #skillKeys)]
                VirtualInputManager:SendKeyEvent(true, randomKey, false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, randomKey, false, game)
            end
            if getgenv().PP_Skill_Z then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            end
            if getgenv().PP_Skill_X then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            end
            if getgenv().PP_Skill_C then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
            end
            if getgenv().PP_Skill_V then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
            end
        end)
    end
end)

-- 无碰撞
RunService.Stepped:Connect(function()
    if getgenv().PP_Noclip and lp.Character then
        pcall(function()
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

-- 自动抛竿
task.spawn(function()
    while task.wait(1.5) do
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                local MainGui = lp.PlayerGui:FindFirstChild("MainGui")
                local char = lp.Character
                if char and MainGui and MainGui:FindFirstChild("Fishing") then
                    if not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then
                        if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then
                            RS.Events.Fishing:FireServer()
                        end
                    end
                end
            end)
        end
    end
end)
-- 锚定和速度
RunService.RenderStepped:Connect(function()
    if getgenv().NWKZ_Anchor then
        pcall(function()
            local MainGui = lp.PlayerGui:FindFirstChild("MainGui")
            if MainGui and MainGui:FindFirstChild("Fishing") and MainGui.Fishing.Visible then
                local bar = MainGui.Fishing.BarFrame.Bar
                bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                if RS:FindFirstChild("Fishing") then
                    RS.Fishing:FireServer("1")
                end
            end
        end)
    end
    pcall(function()
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
        end
    end)
end)

-- 自动售卖循环
task.spawn(function()
    while task.wait(getgenv().PP_SellDelay) do
        if getgenv().PP_AutoSell then
            pcall(function()
                if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("SellFish") then
                    RS.Events.SellFish:FireServer("All")
                elseif RS:FindFirstChild("SellFish") then
                    RS.SellFish:FireServer("All")
                end
            end)
        end
    end
end)
-- ================== NPC 自动追踪循环 ==================
task.spawn(function()
    while true do
        task.wait(1)
        if npcAutoTrack then
            local target, foundName = findAnyNpc()
            if target then
                local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(target.Position + Vector3.new(0, 2, 0))
                    NpcStatus.Text = "⚡ 自动飞抓: " .. foundName
                    task.wait(0.8)
                    if npcAutoTrack then NpcStatus.Text = "追踪中..." end
                end
            end
        end
    end
end)

-- 主窗口拖动
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
