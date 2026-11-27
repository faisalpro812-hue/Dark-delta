
-- DARK DELTA V1.0
-- RED / BLACK / WHITE GUI
-- Roblox Studio LocalScript

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DarkDeltaV1"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local C = {
    Red = Color3.fromRGB(220,0,0),
    DarkRed = Color3.fromRGB(120,0,0),
    Black = Color3.fromRGB(10,10,10),
    Panel = Color3.fromRGB(19,19,19),
    Gray = Color3.fromRGB(35,35,35),
    White = Color3.fromRGB(255,255,255)
}

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,radius or 8)
    c.Parent = obj
end

local function stroke(obj,color,thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Parent = obj
end

-- FLOATING ARROW BUTTON
local arrow = Instance.new("TextButton")
arrow.Size = UDim2.fromOffset(55,55)
arrow.Position = UDim2.new(0,20,0.5,-27)
arrow.BackgroundColor3 = C.Red
arrow.Text = "➜"
arrow.TextColor3 = C.White
arrow.TextSize = 32
arrow.Font = Enum.Font.GothamBold
arrow.Parent = gui

corner(arrow,15)
stroke(arrow,C.White,1.5)

-- MAIN PANEL
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(560,390)
main.Position = UDim2.new(.5,-280,.5,-195)
main.BackgroundColor3 = C.Black
main.Visible = false
main.Parent = gui

corner(main,12)
stroke(main,C.Red,2)

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,48)
header.BackgroundColor3 = C.Red
header.Parent = main
corner(header,10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.fromOffset(12,0)
title.BackgroundTransparency = 1
title.Text = "DARK DELTA  |  V1.0"
title.TextColor3 = C.White
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(38,32)
minimize.Position = UDim2.new(1,-45,0,8)
minimize.BackgroundColor3 = C.Black
minimize.Text = "—"
minimize.TextColor3 = C.White
minimize.TextSize = 22
minimize.Parent = header
corner(minimize,6)

-- SIDEBAR
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0,145,1,-60)
sidebar.Position = UDim2.fromOffset(5,53)
sidebar.BackgroundColor3 = C.Panel
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 3
sidebar.CanvasSize = UDim2.new()
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0,5)
sideLayout.Parent = sidebar

-- CONTENT AREA
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1,-160,1,-60)
content.Position = UDim2.fromOffset(155,53)
content.BackgroundColor3 = C.Panel
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.CanvasSize = UDim2.new()
content.Parent = main

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0,8)
contentLayout.Parent = content

local sections = {
    "Home",
    "Movement",
    "Troll",
    "Visual",
    "Animations",
    "Social",
    "Defense",
    "Misc",
    "Player Profile",
    "Settings",
    "Speed Settings",
    "Jump Settings",
    "FPS Monitor",
    "Collectible Tracker",
    "All Players",
    "Clap Emote"
}

local function clearContent()
    for _,v in ipairs(content:GetChildren()) do
        if v:IsA("GuiObject") and v ~= contentLayout then
            v:Destroy()
        end
    end
end

local function makeLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-12,0,35)
    label.BackgroundColor3 = C.Gray
    label.Text = text
    label.TextColor3 = C.White
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Parent = content
    corner(label,6)
    return label
end

local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-12,0,39)
    button.BackgroundColor3 = C.Gray
    button.Text = text
    button.TextColor3 = C.White
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = content
    corner(button,7)
    stroke(button,C.Red,1)

    button.MouseButton1Click:Connect(function()
        callback(button)
    end)

    return button
end

local function makeToggle(name)
    local enabled = false

    makeButton(name.."  [ OFF ]",function(button)
        enabled = not enabled

        if enabled then
            button.Text = name.."  [ ON ]"
            button.BackgroundColor3 = C.Red
        else
            button.Text = name.."  [ OFF ]"
            button.BackgroundColor3 = C.Gray
        end
    end)
end

local function openPage(page)
    clearContent()
    makeLabel("DARK DELTA  /  "..string.upper(page))

    if page == "Home" then
        makeLabel("Welcome, "..player.DisplayName)
        makeLabel("Version: 1.0")
        makeLabel("Red Black White Edition")
        makeLabel("Select a tab from the left side")

    elseif page == "Player Profile" then
        makeLabel("Username: "..player.Name)
        makeLabel("Display Name: "..player.DisplayName)
        makeLabel("User ID: "..player.UserId)

    elseif page == "All Players" then
        for _,p in ipairs(Players:GetPlayers()) do
            makeLabel(p.Name)
        end

    elseif page == "FPS Monitor" then
        local fpsLabel = makeLabel("FPS: Calculating...")
        local frames = 0
        local elapsed = 0

        local connection
        connection = RunService.RenderStepped:Connect(function(dt)
            if not fpsLabel.Parent then
                connection:Disconnect()
                return
            end

            frames += 1
            elapsed += dt

            if elapsed >= 1 then
                fpsLabel.Text = "FPS: "..frames
                frames = 0
                elapsed = 0
            end
        end)

    elseif page == "Speed Settings" then
        makeLabel("Movement Demo Settings")
        makeToggle("Show Speed Controls")

    elseif page == "Jump Settings" then
        makeLabel("Jump Demo Settings")
        makeToggle("Show Jump Controls")

    elseif page == "Collectible Tracker" then
        makeLabel("Collectible Demo")
        makeToggle("Show Collectible Counter")

    else
        makeToggle("Enable "..page.." UI")
        makeToggle("Show "..page.." Status")
        makeToggle("Demo Option 1")
        makeToggle("Demo Option 2")
        makeToggle("Demo Option 3")
    end
end

-- CREATE SIDEBAR
for _,page in ipairs(sections) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-8,0,33)
    b.BackgroundColor3 = C.Black
    b.Text = page
    b.TextColor3 = C.White
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.Parent = sidebar
    corner(b,5)

    b.MouseButton1Click:Connect(function()
        openPage(page)
    end)
end

sideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    sidebar.CanvasSize = UDim2.new(0,0,0,sideLayout.AbsoluteContentSize.Y+10)
end)

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(0,0,0,contentLayout.AbsoluteContentSize.Y+10)
end)

-- OPEN / MINIMIZE
arrow.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

minimize.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- DRAG PANEL
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

openPage("Home")

print("DARK DELTA V1.0 LOADED")
