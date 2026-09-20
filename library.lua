repeat task.wait() until game:IsLoaded() and workspace.CurrentCamera

-- Lime UI library.  The library deliberately keeps all state in one table and
-- uses event driven updates; the old version created a polling thread for
-- almost every control and wrote the config twice per second.
local function getService(name)
    local service = game:GetService(name)
    return cloneref and cloneref(service) or service
end

local UserInputService = getService("UserInputService")
local TweenService = getService("TweenService")
local TextService = getService("TextService")
local HttpService = getService("HttpService")
local RunService = getService("RunService")
local Players = getService("Players")
local SoundService = getService("SoundService")
local StarterGui = getService("StarterGui")
local CoreGui = getService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function noop() end
local function safeCall(fn, ...)
    if type(fn) ~= "function" then return end
    task.spawn(function() pcall(fn, ...) end)
end

local Library = {
    Visual = {Hud = true, Arraylist = true, Watermark = true},
    DeviceType = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled) and "Touch" or "Mouse",
    Stopped = false,
    Uninject = false,
}

--// Configuration ----------------------------------------------------------
local makefolder = makefolder or noop
local isfolder = isfolder or function() return false end
local writefile = writefile or noop
local isfile = isfile or function() return false end
local readfile = readfile or function() return "" end
local delfile = delfile or noop

local LimeFolder = "Lime"
local ConfigsFolder = LimeFolder .. "/configs"
local CurrentGameFolder = ConfigsFolder .. "/" .. tostring(game.PlaceId)
local CurrentGameConfig = LimeFolder .. "/" .. tostring(game.PlaceId) .. ".lua"
local ConfigTable = {Libraries = {ToggleButton = {}, MiniToggle = {}, Slider = {}, Dropdown = {}}}
local dirty = false
local saveQueued = false

pcall(function()
    if not isfolder(LimeFolder) then makefolder(LimeFolder) end
    if not isfolder(ConfigsFolder) then makefolder(ConfigsFolder) end
    if not isfolder(CurrentGameFolder) then makefolder(CurrentGameFolder) end
end)

local function markDirty()
    dirty = true
    if saveQueued then return end
    saveQueued = true
    task.delay(0.35, function()
        saveQueued = false
        if dirty and not Library.Stopped then
            dirty = false
            pcall(writefile, CurrentGameConfig, HttpService:JSONEncode(ConfigTable))
        end
    end)
end

pcall(function()
    if isfile(CurrentGameConfig) then
        local raw = readfile(CurrentGameConfig)
        if raw and raw ~= "" then
            local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
            if ok and type(decoded) == "table" then
                ConfigTable = decoded
                ConfigTable.Libraries = ConfigTable.Libraries or {}
                for _, key in ipairs({"ToggleButton", "MiniToggle", "Slider", "Dropdown"}) do
                    ConfigTable.Libraries[key] = ConfigTable.Libraries[key] or {}
                end
            end
        end
    end
end)

local function saveNow()
    dirty = false
    pcall(writefile, CurrentGameConfig, HttpService:JSONEncode(ConfigTable))
end

local function config(kind, name, defaults)
    local bucket = ConfigTable.Libraries[kind]
    bucket[name] = bucket[name] or defaults
    return bucket[name]
end

--// Small UI helpers --------------------------------------------------------
local function draggable(frame)
    local dragging, start, origin
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, start, origin = true, input.Position, frame.Position
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - start
            frame.Position = UDim2.new(origin.X.Scale, origin.X.Offset + d.X, origin.Y.Scale, origin.Y.Offset + d.Y)
        end
    end)
end

local function listHeight(container)
    local layout = container:FindFirstChildOfClass("UIListLayout")
    return layout and layout.AbsoluteContentSize.Y or 0
end

local function refreshHeight(container, holder)
    local layout = container:FindFirstChildOfClass("UIListLayout")
    if not layout then return end
    local function update()
        local h = layout.AbsoluteContentSize.Y
        container.Size = UDim2.new(container.Size.X.Scale, container.Size.X.Offset, 0, h)
        if holder then holder.Size = UDim2.new(holder.Size.X.Scale, holder.Size.X.Offset, 0, h + 28) end
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
    update()
end

local function button(parent, text, height)
    local b = Instance.new("TextButton")
    b.Parent, b.Size, b.Text = parent, UDim2.new(1, 0, 0, height or 28), text or ""
    b.AutoButtonColor, b.Font, b.TextSize = false, Enum.Font.SourceSans, 18
    b.TextColor3, b.BackgroundColor3 = Color3.new(1, 1, 1), Color3.fromRGB(30, 30, 30)
    b.BackgroundTransparency, b.BorderSizePixel = 0.23, 0
    return b
end

function Library:CreateMain()
    local Main = {}
    local gui = Instance.new("ScreenGui")
    gui.Name, gui.ResetOnSpawn, gui.ZIndexBehavior = HttpService:GenerateGUID(false), false, Enum.ZIndexBehavior.Sibling
    gui.Parent = (RunService:IsStudio() and PlayerGui) or (gethui and gethui()) or CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Parent, mainFrame.Size, mainFrame.BackgroundTransparency = gui, UDim2.new(1, 0, 1, 0), 1
    mainFrame.Visible = false
    if Library.DeviceType == "Mouse" then draggable(mainFrame) end

    local hud = Instance.new("Frame")
    hud.Parent, hud.Size, hud.BackgroundTransparency = gui, UDim2.new(1, 0, 1, 0), 1
    local watermark = Instance.new("TextLabel")
    watermark.Parent, watermark.Position, watermark.Size = hud, UDim2.new(0, 20, 0, 15), UDim2.new(0, 345, 0, 30)
    watermark.BackgroundTransparency, watermark.Text, watermark.TextColor3 = 1, "Lime", Color3.fromRGB(255, 0, 127)
    watermark.Font, watermark.TextSize, watermark.TextXAlignment = Enum.Font.SourceSans, 24, Enum.TextXAlignment.Left

    local arrayFrame = Instance.new("Frame")
    arrayFrame.Parent, arrayFrame.Position, arrayFrame.Size = hud, UDim2.new(0.7935, 0, 0, 15), UDim2.new(0.1965, 0, 0.855, 0)
    arrayFrame.BackgroundTransparency = 1
    local arrayLayout = Instance.new("UIListLayout", arrayFrame)
    arrayLayout.HorizontalAlignment, arrayLayout.SortOrder = Enum.HorizontalAlignment.Right, Enum.SortOrder.LayoutOrder
    local arrayItems, widthCache = {}, {}
    local function relayout()
        local entries = {}
        for name, label in pairs(arrayItems) do
            entries[#entries + 1] = {name = name, label = label, width = widthCache[name] or 0}
        end
        table.sort(entries, function(a, b) return a.width > b.width end)
        for i, entry in ipairs(entries) do entry.label.LayoutOrder = i end
    end
    local function addArray(name)
        if arrayItems[name] then return end
        local label = Instance.new("TextLabel")
        label.Parent, label.BackgroundTransparency, label.BorderSizePixel = arrayFrame, 0.75, 0
        label.BackgroundColor3, label.Font, label.TextColor3 = Color3.new(0, 0, 0), Enum.Font.SourceSans, Color3.fromRGB(255, 0, 127)
        label.Text, label.TextSize, label.TextXAlignment = "  " .. name .. "  ", 19, Enum.TextXAlignment.Right
        widthCache[name] = TextService:GetTextSize(label.Text, label.TextSize, label.Font, Vector2.new(2000, 50)).X
        label.Size = UDim2.new(0, widthCache[name], 0, 22)
        arrayItems[name] = label
        relayout()
    end
    local function removeArray(name)
        if arrayItems[name] then arrayItems[name]:Destroy(); arrayItems[name] = nil; widthCache[name] = nil; relayout() end
    end

    function Main:CreateManager() return {} end
    function Main:CreateLine(origin, destination)
        local line = Instance.new("Frame")
        line.Parent, line.AnchorPoint = hud, Vector2.new(0.5, 0.5)
        line.Position = UDim2.new(0, (origin.X + destination.X) / 2, 0, (origin.Y + destination.Y) / 2)
        line.Size = UDim2.new(0, (origin - destination).Magnitude, 0, 1)
        line.BackgroundColor3 = Color3.new(1, 1, 1)
        line.Rotation = math.deg(math.atan2(destination.Y - origin.Y, destination.X - origin.X))
        return line
    end
    function Main:CreateTargetHUD(_, _, _, here) end

    local function applyVisuals()
        hud.Visible = Library.Visual.Hud
        arrayFrame.Visible = Library.Visual.Arraylist
        watermark.Visible = Library.Visual.Watermark
    end
    applyVisuals()

    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.RightShift then mainFrame.Visible = not mainFrame.Visible end
    end)

    function Main:CreateTab(kind)
        local tab = {}
        local holder = Instance.new("Frame")
        holder.Parent, holder.Size, holder.BackgroundColor3 = mainFrame, UDim2.new(0, 220, 0, 28), Color3.fromRGB(20, 20, 20)
        holder.BackgroundTransparency, holder.BorderSizePixel = 0.03, 0
        if Library.DeviceType == "Mouse" then draggable(holder) end
        local name = ({["1"]="Combat", ["2"]="Exploit", ["3"]="Move", ["4"]="Player", ["5"]="Visual", ["6"]="World"})[tostring(kind)] or tostring(kind)
        local title = button(holder, name, 28)
        title.TextXAlignment = Enum.TextXAlignment.Left
        local list = Instance.new("Frame", holder)
        list.Position, list.Size, list.BackgroundTransparency = UDim2.new(0, 0, 1, 0), UDim2.new(1, 0, 0, 0), 1
        local layout = Instance.new("UIListLayout", list)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        function tab:CreateToggle(def)
            def = def or {}
            local nameKey = tostring(def.Name or "Toggle")
            local saved = config("ToggleButton", nameKey, {Enabled = def.Enabled == true, Keybind = def.Keybind or "Euro", MiniKeybind = {Visibility = false, Position = UDim2.new(0.5, 0, 0.5, 0)}})
            saved.MiniKeybind = saved.MiniKeybind or {Visibility = false, Position = UDim2.new(0.5, 0, 0.5, 0)}
            local toggle = {Name = nameKey, Enabled = saved.Enabled == true, Keybind = saved.Keybind or "Euro", AutoDisable = def.AutoDisable == true, Callback = def.Callback or noop}
            local main = button(list, nameKey, 28)
            main.TextXAlignment = Enum.TextXAlignment.Left
            local menu = Instance.new("Frame", list); menu.Size = UDim2.new(1, 0, 0, 0); menu.BackgroundTransparency = 1
            local menuLayout = Instance.new("UIListLayout", menu); menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
            menu.Visible = false
            refreshHeight(menu, nil)
            local function changed()
                saved.Enabled = toggle.Enabled; markDirty()
                main.BackgroundColor3 = toggle.Enabled and Color3.fromRGB(232, 30, 100) or Color3.fromRGB(30, 30, 30)
                if toggle.Enabled then addArray(nameKey) else removeArray(nameKey) end
                safeCall(toggle.Callback, toggle.Enabled)
            end
            main.MouseButton1Click:Connect(function() toggle.Enabled = not toggle.Enabled; changed() end)
            if toggle.Enabled then changed() end
            function toggle:CreateDropdown(definition)
                definition = definition or {}; local dname = tostring(definition.Name or "Dropdown")
                local savedD = config("Dropdown", dname, {Default = definition.Default})
                local value = savedD.Default ~= nil and savedD.Default or definition.Default
                local dbutton = button(menu, dname .. ": " .. tostring(value or "None"), 28)
                dbutton.TextXAlignment = Enum.TextXAlignment.Left
                dbutton.MouseButton1Click:Connect(function()
                    local listValues = definition.List or {}; if #listValues == 0 then return end
                    local index = table.find(listValues, value) or 0; value = listValues[index % #listValues + 1]
                    savedD.Default = value; dbutton.Text = dname .. ": " .. tostring(value); markDirty(); safeCall(definition.Callback, value)
                end)
                if value ~= nil then safeCall(definition.Callback, value) end
                return definition
            end
            function toggle:CreateSlider(definition)
                definition = definition or {}; local sname = tostring(definition.Name or "Slider")
                local min, max = definition.Min or 0, definition.Max or 100
                local savedS = config("Slider", sname, {Default = definition.Default})
                local value = math.clamp(tonumber(savedS.Default) or tonumber(definition.Default) or min, min, max)
                local slider = button(menu, sname .. ": " .. tostring(value), 28)
                slider.TextXAlignment = Enum.TextXAlignment.Left
                local dragging = false
                local function set(input)
                    local ratio = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    value = math.floor((min + (max - min) * ratio) * 10 + 0.5) / 10; savedS.Default = value
                    slider.Text = sname .. ": " .. tostring(value); markDirty(); safeCall(definition.Callback, value)
                end
                slider.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true; set(i) end end)
                slider.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
                UserInputService.InputChanged:Connect(function(i) if dragging then set(i) end end)
                safeCall(definition.Callback, value); return definition
            end
            function toggle:CreateMiniToggle(definition)
                definition = definition or {}; local mname = tostring(definition.Name or "MiniToggle")
                local savedM = config("MiniToggle", mname, {Enabled = definition.Enabled == true})
                local mini = button(menu, mname .. ": " .. (savedM.Enabled and "On" or "Off"), 28)
                mini.TextXAlignment = Enum.TextXAlignment.Left
                mini.MouseButton1Click:Connect(function() savedM.Enabled = not savedM.Enabled; mini.Text = mname .. ": " .. (savedM.Enabled and "On" or "Off"); markDirty(); safeCall(definition.Callback, savedM.Enabled) end)
                if savedM.Enabled then safeCall(definition.Callback, true) end
                return definition
            end
            return toggle
        end
        title.MouseButton1Click:Connect(function() mainFrame.Visible = true end)
        return tab
    end

    local visualConnection = Library.Visual
    local oldVisual = visualConnection
    task.spawn(function()
        while not Library.Stopped do
            task.wait(1)
            if oldVisual ~= Library.Visual then oldVisual = Library.Visual; applyVisuals() end
        end
    end)
    return Main
end

function Library:Unload()
    if Library.Stopped then return end
    Library.Stopped, Library.Uninject = true, true
    saveNow()
end

return Library
