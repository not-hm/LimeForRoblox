repeat task.wait() until game:IsLoaded()
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local SoundService = cloneref(game:GetService("SoundService"))
local TextService = cloneref(game:GetService("TextService"))
local HttpService = cloneref(game:GetService("HttpService"))
local RunService = cloneref(game:GetService("RunService"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Lighting = cloneref(game:GetService("Lighting"))
local Players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local LocalPlayer = cloneref(Players.LocalPlayer)
local PlayerGui = cloneref(LocalPlayer.PlayerGui)
local Library = {
	Visual = {
		Hud = true,
		Arraylist = true,
		Watermark = true
	},
	DeviceType = nil,
	Stopped = false,
	Uninject = false
}

local AutoSave = true
local ConfigName = nil
local LimeFolder = "Lime"
local ConfigsFolder = LimeFolder .. "/configs"
local KillsultsTable = LimeFolder .. "/killsults.lua"
local CurrentGameFolder = ConfigsFolder .. "/" .. game.PlaceId
local CurrentGameConfig = LimeFolder .. "/" .. game.PlaceId .. ".lua"
local ConfigTable = {Libraries = {ToggleButton = {}, MiniToggle = {}, Slider = {}, Dropdown = {}}}
local Manager, ManagerMenu, ManagerBox, ManagerDelete, ManagerCreate, ManagerLoad
loadstring(game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/refs/heads/main/data.lua"))()

if not isfolder(LimeFolder) then makefolder(LimeFolder) end
if not isfolder(ConfigsFolder) then makefolder(ConfigsFolder) end
if not isfolder(CurrentGameFolder) then makefolder(CurrentGameFolder) end
if not isfile(KillsultsTable) then writefile(KillsultsTable, game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/main/killsults.lua")) end
if isfile(CurrentGameConfig) then
	local GetMain = readfile(CurrentGameConfig)
	if GetMain and GetMain ~= "" then
		local Success, OldSettings = pcall(HttpService.JSONDecode, HttpService, GetMain)
		if Success and OldSettings then
			ConfigTable = OldSettings
		end
	end
end

task.spawn(function()
	while AutoSave do
		task.wait(0.5)
		if not Library.Uninject then
			writefile(CurrentGameConfig, HttpService:JSONEncode(ConfigTable))
		else
			AutoSave = false
		end
	end
end)

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
	if not Library.DeviceType then
		Library.DeviceType = "Touch"
		task.spawn(function()
			StarterGui:SetCore("SendNotification", { 
				Title = "Lime",
				Text = "Loaded. Press click the icon.",
				Icon = "rbxassetid://12435962893",
				Duration = 3,
			})
		end)
	end
elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
	if not Library.DeviceType then
		Library.DeviceType = "Mouse"
		task.spawn(function()
			StarterGui:SetCore("SendNotification", { 
				Title = "Lime",
				Text = "Loaded. Press RightShift",
				Icon = "rbxassetid://12435962893",
				Duration = 3,
			})
		end)
	end
elseif UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
	if not Library.DeviceType then
		Library.DeviceType = "Mouse"
		task.spawn(function()
			StarterGui:SetCore("SendNotification", { 
				Title = "Lime",
				Text = "Loaded. Press RightShift",
				Icon = "rbxassetid://12435962893",
				Duration = 3,
			})
		end)
	end
end

local function MakeDraggable(v)
	local Dragging, Input2, StartDragging, StartPos = nil, nil, nil, nil
	local function Update(Input)
		local Delta = Input.Position - StartDragging
		v.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
	end

	v.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			StartDragging = Input.Position
			StartPos = v.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	v.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			Input2 = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == Input2 and Dragging then
			Update(Input)
		end
	end)
end

local function GetChildrenY(obj)
	local OldY = 0
	for _, v in ipairs(obj:GetChildren()) do
		if v:IsA("GuiObject") then
			OldY += v.AbsoluteSize.Y + v.Position.Y.Offset
		end
	end
	return UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, 0, OldY)
end

local function PlaySound(id)
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://" .. id
	Sound.Parent = SoundService
	Sound:Play()
	Sound.Ended:Connect(function()
		Sound:Destroy()
	end)
end

function Library:CreateMain()
	local Main = {}

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = HttpService:GenerateGUID(false)
	ScreenGui.ResetOnSpawn = false
	if RunService:IsStudio() then
		ScreenGui.Parent = PlayerGui
	elseif game.PlaceId == 11630038968 or game.PlaceId == 10810646982 then
		if CoreGui then
			ScreenGui.Parent = CoreGui
		else
			ScreenGui.Parent = PlayerGui:FindFirstChild("MainGui")
		end
	else
		if CoreGui then
			ScreenGui.Parent= CoreGui
		else
			ScreenGui.Parent = PlayerGui:FindFirstChild("MainGui")
		end
	end

	local MainFrame
	if Library.DeviceType == "Mouse" then
		MainFrame = Instance.new("Frame")
		MainFrame.Parent = ScreenGui
		MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.Size = UDim2.new(1, 0, 1, 0)
		MainFrame.Visible = false
	elseif Library.DeviceType == "Touch" then
		MainFrame = Instance.new("ScrollingFrame")
		MainFrame.Parent = ScreenGui
		MainFrame.Active = true
		MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Size = UDim2.new(1, 0, 1, 0)
		MainFrame.CanvasPosition = Vector2.new(240, 0)
		MainFrame.CanvasSize = UDim2.new(2.5, 0, 0, 0)
		MainFrame.ScrollBarThickness = 8
		MainFrame.Visible = false
	end

	task.defer(function()
		local NewX = 0
		if MainFrame then
			for _, v in ipairs(MainFrame:GetChildren()) do
				if v:IsA("GuiObject") then
					v.Position = UDim2.new(0, NewX, 0, 0)
					NewX = NewX + v.Size.X.Offset + 18
				end
			end
		end
	end)

	local MainOpen, UICorner_2
	if Library.DeviceType == "Touch" then
		MainOpen = Instance.new("TextButton")
		MainOpen.Parent = ScreenGui
		MainOpen.AnchorPoint = Vector2.new(0.5, 0.5)
		MainOpen.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		MainOpen.BackgroundTransparency = 0.550
		MainOpen.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainOpen.BorderSizePixel = 0
		MainOpen.Position = UDim2.new(0.5, 0, 0.0380000018, 0)
		MainOpen.Size = UDim2.new(0, 25, 0, 25)
		MainOpen.ZIndex = 5
		MainOpen.Font = Enum.Font.SourceSans
		MainOpen.Text = "Lime"
		MainOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
		MainOpen.TextScaled = true
		MainOpen.TextSize = 14.000
		MainOpen.TextWrapped = true

		UICorner_2 = Instance.new("UICorner")
		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = MainOpen

		MainOpen.MouseButton1Click:Connect(function()
			MainFrame.Visible = not MainFrame.Visible
		end)
	end

	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = MainFrame
	UIPadding.PaddingLeft = UDim.new(0, 20)
	UIPadding.PaddingTop = UDim.new(0, 22)

	local HudFrame = Instance.new("Frame")
	HudFrame.Parent = ScreenGui
	HudFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HudFrame.BackgroundTransparency = 1.000
	HudFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HudFrame.BorderSizePixel = 0
	HudFrame.Size = UDim2.new(1, 0, 1, 0)

	local KeybindFrame = Instance.new("Frame")
	KeybindFrame.Parent = ScreenGui
	KeybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KeybindFrame.BackgroundTransparency = 1.000
	KeybindFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeybindFrame.Size = UDim2.new(1, 0, 1, 0)
	KeybindFrame.Visible = true

	local Watermark = Instance.new("TextLabel")
	Watermark.Parent = HudFrame
	Watermark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Watermark.BackgroundTransparency = 1.000
	Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Watermark.BorderSizePixel = 0
	Watermark.Position = UDim2.new(0, 20, 0, 15)
	Watermark.Size = UDim2.new(0, 345, 0, 30)
	Watermark.RichText = true
	Watermark.Text = "Lime"
	Watermark.Font = Enum.Font.SourceSans
	Watermark.TextColor3 = Color3.fromRGB(255, 0, 127)
	Watermark.TextScaled = true
	Watermark.TextSize = 14.000
	Watermark.TextWrapped = true
	Watermark.TextXAlignment = Enum.TextXAlignment.Left
	Watermark.ZIndex = -1

	local WatermarkGradient = Instance.new("UIGradient")
	WatermarkGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 230, 255))}
	WatermarkGradient.Parent = Watermark

	local ArrayTable = {}
	local ArrayFrame = Instance.new("Frame")
	ArrayFrame.Parent = HudFrame
	ArrayFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ArrayFrame.BackgroundTransparency = 1.000
	ArrayFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ArrayFrame.BorderSizePixel = 0
	ArrayFrame.Position = UDim2.new(0.793529391, 0, 0, 15)
	ArrayFrame.Size = UDim2.new(0.196470603, 0, 0.855223835, 0)

	local UIListLayout_4 = Instance.new("UIListLayout")
	UIListLayout_4.Parent = ArrayFrame
	UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

	local function AddArray(name)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Parent = ArrayFrame
		TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BackgroundTransparency = 0.75
		TextLabel.TextTransparency = 1
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = "  " .. name .. "  "
		TextLabel.TextColor3 = Color3.fromRGB(255, 0, 127)
		TextLabel.TextSize = 19
		TextLabel.TextWrapped = true
		TextLabel.ZIndex = -1
		TextLabel.Name = name
		TextLabel.TextYAlignment = Enum.TextYAlignment.Center
		TextLabel.TextXAlignment = Enum.TextXAlignment.Right

		local TextGradient = Instance.new("UIGradient")
		TextGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 230, 255))}
		TextGradient.Parent = TextLabel

		local MaxWidth = ArrayFrame.AbsoluteSize.X
		local TextSize = game.TextService:GetTextSize("  " .. name .. "  ", TextLabel.TextSize, TextLabel.Font, Vector2.new(MaxWidth, math.huge))
		TextLabel.Size = UDim2.new(0, TextSize.X - TextSize.X, 0, 23)
		local NewSize = UDim2.new(0, TextSize.X, 0, 22)
		if name == "" then
			NewSize = UDim2.new(0, 0, 0, 0)
		end

		local ArrayIn = TweenService:Create(TextLabel, TweenInfo.new(0.2), {Size = NewSize, Position = UDim2.new(1, -TextSize.X, 0, 0)})
		if ArrayIn then
			ArrayIn:Play()
			ArrayIn.Completed:Connect(function()
				TextLabel.TextTransparency = 0
			end)
		end

		table.insert(ArrayTable, TextLabel)
		table.sort(ArrayTable, function(a, b) return game.TextService:GetTextSize(a.Text, a.TextSize, a.Font, Vector2.new(MaxWidth, math.huge)).X > game.TextService:GetTextSize(b.Text, b.TextSize, b.Font, Vector2.new(MaxWidth, math.huge)).X end)
		for i, v in ipairs(ArrayTable) do
			v.LayoutOrder = i
		end
	end

	local function RemoveArray(name)
		local MaxWidth = ArrayFrame.AbsoluteSize.X
		table.sort(ArrayTable, function(a, b) return game.TextService:GetTextSize(a.Text, a.TextSize, a.Font, Vector2.new(MaxWidth, math.huge)).X > game.TextService:GetTextSize(b.Text, b.TextSize, b.Font, Vector2.new(MaxWidth, math.huge)).X end)
		for i, v in ipairs(ArrayTable) do
			if v.Text == "  " .. name .. "  " then
				v.TextTransparency = 1
				local TextSize = game.TextService:GetTextSize("  " .. name .. "  ", v.TextSize, v.Font, Vector2.new(MaxWidth, math.huge))
				local ArrayOut = TweenService:Create(v, TweenInfo.new(0.1), {Size = UDim2.new(0.01, -TextSize + TextSize, 0, 20)})
				if ArrayOut then
					ArrayOut:Play()
					ArrayOut.Completed:Connect(function()
						v:Destroy()
						table.remove(ArrayTable, i)
					end)
				end
			end
		end
		for i, v in ipairs(ArrayTable) do
			v.LayoutOrder = i
		end
	end

	function Main:CreateManager()
		local Managers = {}

		Manager = Instance.new("Frame")
		Manager.Parent = MainFrame
		Manager.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Manager.BackgroundTransparency = 0.030
		Manager.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Manager.BorderSizePixel = 0
		Manager.Position = UDim2.new(0, 222, 0, 0)
		Manager.Size = UDim2.new(0, 220, 0, 28)
		if not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
			MakeDraggable(Manager)
		end

		local ManagerName = Instance.new("TextLabel")
		ManagerName.Parent = Manager
		ManagerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerName.BackgroundTransparency = 1.000
		ManagerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerName.BorderSizePixel = 0
		ManagerName.Position = UDim2.new(0, 5, 0, 0)
		ManagerName.Size = UDim2.new(0, 145, 1, 0)
		ManagerName.Font = Enum.Font.SourceSans
		ManagerName.Text = "Manager"
		ManagerName.TextColor3 = Color3.fromRGB(255, 255, 255)
		ManagerName.TextSize = 20.000
		ManagerName.TextWrapped = true
		ManagerName.TextXAlignment = Enum.TextXAlignment.Left

		local ManagerIcon = Instance.new("ImageLabel")
		ManagerIcon.Parent = Manager
		ManagerIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		ManagerIcon.BackgroundColor3 = Color3.fromRGB(145, 145, 145)
		ManagerIcon.BackgroundTransparency = 1.000
		ManagerIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerIcon.BorderSizePixel = 0
		ManagerIcon.Position = UDim2.new(0.930000007, 0, 0.5, 0)
		ManagerIcon.Size = UDim2.new(0, 20, 0, 20)
		ManagerIcon.Image = "rbxassetid://12403099678"

		local ManagerList = Instance.new("Frame")
		ManagerList.Parent = Manager
		ManagerList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerList.BackgroundTransparency = 1.000
		ManagerList.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerList.BorderSizePixel = 0
		ManagerList.Position = UDim2.new(0, 0, 1, 0)
		ManagerList.Size = UDim2.new(1, 0, 0, 0)

		local UIListLayout_3 = Instance.new("UIListLayout")
		UIListLayout_3.Parent = ManagerList
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

		ManagerMenu = Instance.new("Frame")
		ManagerMenu.Parent = ManagerList
		ManagerMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ManagerMenu.BackgroundTransparency = 0.150
		ManagerMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerMenu.BorderSizePixel = 0
		ManagerMenu.Position = UDim2.new(0, 0, 25, 0)
		ManagerMenu.Size = UDim2.new(1, 0, 0, 125)

		local UIListLayout_5 = Instance.new("UIListLayout")
		UIListLayout_5.Parent = ManagerMenu
		UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder

		task.spawn(function()
			local FolderTable = {}
			repeat
				task.wait()
				if ManagerMenu and isfolder(CurrentGameFolder) then
					for _, v in ipairs(listfiles(CurrentGameFolder)) do
						if isfile(v) and not table.find(FolderTable, v) then
							table.insert(FolderTable, v)
							for _, b in pairs(ManagerMenu:GetChildren()) do
								if b:IsA("TextLabel") and b.Text ~= v then
									local TextLabel_1 = Instance.new("TextLabel")
									TextLabel_1.Parent = ManagerMenu
									TextLabel_1.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
									TextLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
									TextLabel_1.BorderSizePixel = 0
									TextLabel_1.Size = UDim2.new(1, 0, 0, 25)
									TextLabel_1.Font = Enum.Font.SourceSans
									TextLabel_1.Text = v
									TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel_1.TextSize = 14.000
									break
								end
							end
						elseif not isfile(v) and table.find(FolderTable, v) then
							table.remove(FolderTable, v)
							for _ , b in pairs(ManagerMenu:GetChildren()) do
								if b:IsA("TextLabel") and b.Text == v then
									b:Destroy()
								end
							end
						end
					end
				end
			until Library.Stopped
		end)

		local ManagerText = Instance.new("TextLabel")
		ManagerText.Parent = ManagerMenu
		ManagerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerText.BackgroundTransparency = 1.000
		ManagerText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerText.BorderSizePixel = 0
		ManagerText.LayoutOrder = -1
		ManagerText.Size = UDim2.new(1, 0, 0, 28)
		ManagerText.Font = Enum.Font.SourceSans
		ManagerText.Text = "Available Config:"
		ManagerText.TextColor3 = Color3.fromRGB(255, 255, 255)
		ManagerText.TextSize = 16.000
		ManagerText.TextTransparency = 0.350

		local ManagerControl = Instance.new("Frame")
		ManagerControl.Parent = ManagerList
		ManagerControl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		ManagerControl.BackgroundTransparency = 0.15
		ManagerControl.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerControl.BorderSizePixel = 0
		ManagerControl.Size = UDim2.new(1, 0, 0, 28)

		ManagerBox = Instance.new("TextBox")
		ManagerBox.Parent = ManagerControl
		ManagerBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerBox.BackgroundTransparency = 1.000
		ManagerBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerBox.BorderSizePixel = 0
		ManagerBox.Position = UDim2.new(0, 5, 0, 0)
		ManagerBox.Size = UDim2.new(0, 125, 1, 0)
		ManagerBox.Font = Enum.Font.SourceSans
		ManagerBox.PlaceholderText = "Name"
		ManagerBox.Text = ""
		ManagerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		ManagerBox.TextSize = 18.000
		ManagerBox.TextWrapped = true
		ManagerBox.TextXAlignment = Enum.TextXAlignment.Left
		ManagerBox.FocusLost:Connect(function()
			ConfigName = ManagerBox.Text
		end)

		ManagerDelete = Instance.new("ImageButton")
		ManagerDelete.Parent = ManagerControl
		ManagerDelete.AnchorPoint = Vector2.new(0.5, 0.5)
		ManagerDelete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerDelete.BackgroundTransparency = 1.000
		ManagerDelete.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerDelete.BorderSizePixel = 0
		ManagerDelete.Position = UDim2.new(0.930000007, 0, 0.5, 0)
		ManagerDelete.Size = UDim2.new(0, 20, 0, 20)
		ManagerDelete.AutoButtonColor = true
		ManagerDelete.Image = "rbxassetid://15921650550"
		ManagerDelete.MouseButton1Click:Connect(function()
			if isfile(CurrentGameConfig) and ConfigName then
				local OldConfig = ConfigsFolder .. "/" .. game.PlaceId .. "/" .. ConfigName .. ".lua"
				if isfile(OldConfig) then
					delfile(OldConfig)
				end
			end
		end)

		ManagerCreate = Instance.new("ImageButton")
		ManagerCreate.Parent = ManagerControl
		ManagerCreate.AnchorPoint = Vector2.new(0.5, 0.5)
		ManagerCreate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerCreate.BackgroundTransparency = 1.000
		ManagerCreate.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerCreate.BorderSizePixel = 0
		ManagerCreate.Position = UDim2.new(0.730000019, 0, 0.5, 0)
		ManagerCreate.Size = UDim2.new(0, 20, 0, 20)
		ManagerCreate.AutoButtonColor = true
		ManagerCreate.Image = "rbxassetid://9063830322"
		ManagerCreate.MouseButton1Click:Connect(function()
			if isfile(CurrentGameConfig) and ConfigName then
				local NewConfig = ConfigsFolder .. "/" .. game.PlaceId .. "/" .. ConfigName .. ".lua"
				if not isfile(NewConfig) then
					writefile(NewConfig, readfile(CurrentGameConfig))
				end
			end
		end)

		ManagerLoad = Instance.new("ImageButton")
		ManagerLoad.Parent = ManagerControl
		ManagerLoad.AnchorPoint = Vector2.new(0.5, 0.5)
		ManagerLoad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ManagerLoad.BackgroundTransparency = 1.000
		ManagerLoad.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ManagerLoad.BorderSizePixel = 0
		ManagerLoad.Position = UDim2.new(0.829999983, 0, 0.5, 0)
		ManagerLoad.Size = UDim2.new(0, 18, 0, 18)
		ManagerLoad.AutoButtonColor = true
		ManagerLoad.Image = "rbxassetid://15911231575"
		ManagerLoad.MouseButton1Click:Connect(function()
			if isfolder(CurrentGameFolder) and isfile(CurrentGameConfig) and ConfigName then
				local GetConfig = ConfigsFolder .. "/" .. game.PlaceId .. "/" .. ConfigName .. ".lua"
				if isfile(GetConfig) then
					Library.Uninject = true
					Library.Stopped = true
					task.wait(2)
					writefile(CurrentGameConfig, readfile(GetConfig))
					loadstring(game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/refs/heads/main/Loader.lua"))()
				end
			end
		end)

		return Managers
	end

	local TargetFrame = Instance.new("Frame")
	TargetFrame.Parent = HudFrame
	TargetFrame.AnchorPoint = Vector2.new(0, 0.5)
	TargetFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TargetFrame.BackgroundTransparency = 0.15
	TargetFrame.BorderSizePixel = 0
	TargetFrame.Size = UDim2.new(0, 231, 0, 50)
	TargetFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TargetFrame.Visible = false
	MakeDraggable(TargetFrame)

	local TargetImage = Instance.new("ImageLabel")
	TargetImage.Parent = TargetFrame
	TargetImage.AnchorPoint = Vector2.new(0, 0.5)
	TargetImage.BackgroundTransparency = 1
	TargetImage.Position = UDim2.new(0, 5, 0.5, 0)
	TargetImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TargetImage.Size = UDim2.new(0, 40, 0, 40)

	local TargetName = Instance.new("TextLabel")
	TargetName.Parent = TargetFrame
	TargetName.BackgroundTransparency = 1
	TargetName.Font = Enum.Font.SourceSansBold
	TargetName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TargetName.TextColor3 = Color3.fromRGB(255, 255, 255)
	TargetName.TextSize = 18
	TargetName.TextWrapped = true
	TargetName.TextXAlignment = Enum.TextXAlignment.Left

	local HealthBack = Instance.new("Frame")
	HealthBack.Parent = TargetFrame
	HealthBack.AnchorPoint = Vector2.new(0, 0.5)
	HealthBack.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	HealthBack.BackgroundTransparency = 0.35
	HealthBack.Position = UDim2.new(0, 50, 0.75, 0)
	HealthBack.Size = UDim2.new(0, 100, 0, 8)
	HealthBack.BorderSizePixel = 0

	local HealthFront = Instance.new("Frame")
	HealthFront.Parent = HealthBack
	HealthFront.AnchorPoint = Vector2.new(0, 0.5)
	HealthFront.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
	HealthFront.Position = UDim2.new(0, 0, 0.5, 0)
	HealthFront.Size = UDim2.new(0, 50, 0, 8)
	HealthFront.BorderSizePixel = 0

	local TargetGradient = Instance.new("UIGradient")
	TargetGradient.Parent = HealthFront
	TargetGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 230, 255))}

	function Main:CreateTargetHUD(name, thumbnail, humanoid, ishere)
		local TargetHUD = {}

		if ishere then
			TargetFrame.Visible = true
			if name and humanoid then
				TargetImage.Image = thumbnail
				TargetName.Text = name

				local Calculation = humanoid.Health / humanoid.MaxHealth
				local NewTextSize = game:GetService("TextService"):GetTextSize(TargetName.Text, TargetName.TextSize, TargetName.Font, Vector2.new(9999, 50))
				local Width = NewTextSize.X + TargetImage.Size.X.Offset + 20
				local NewSize_2 = UDim2.new(0, Width, 0, 50)

				TargetFrame.Size = NewSize_2
				HealthBack.Size = UDim2.new(0, NewTextSize.X, 0, 8)
				TargetName.Size = UDim2.new(0, NewTextSize.X, 0, NewTextSize.Y)
				TargetName.Position = UDim2.new(0, HealthBack.Position.X.Offset, 0.12, 0)

				if humanoid.Health > 0 then
					TweenService:Create(HealthFront, TweenInfo.new(0.5), {Size = UDim2.new(Calculation, 0, 0, 8)}):Play()
				elseif humanoid.Health < 0 then
					TweenService:Create(HealthFront, TweenInfo.new(0.5), {Size = UDim2.new(-0, 0, 0, 8)}):Play()
				else
					TweenService:Create(HealthFront, TweenInfo.new(0.5), {Size = UDim2.new(-0, 0, 0, 8)}):Play()
				end
			end
		else
			TargetFrame.Visible = false
		end

		return TargetHUD
	end

	function Main:CreateLine(Origin, Destination)
		local Position = (Origin + Destination) / 2
		local Line = Instance.new("Frame")
		Line.Name = "Line"
		Line.AnchorPoint = Vector2.new(0.5, 0.5)
		Line.Parent = HudFrame
		Line.Position = UDim2.new(0, Position.X, 0, Position.Y)
		Line.Size = UDim2.new(0, (Origin - Destination).Magnitude, 0, 0.02)
		Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Line.BorderColor3 = Color3.fromRGB(255, 255, 255)
		Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))

		return Line
	end

	task.spawn(function()
		repeat
			task.wait()
			if Library.Visual then
				HudFrame.Visible = Library.Visual.Hud
				ArrayFrame.Visible = Library.Visual.Arraylist
				Watermark.Visible = Library.Visual.Watermark
			end
			if Library.Uninject then
				ScreenGui:Destroy()
				task.wait(1.5)
				Library.Uninject = false
				Library.Stopped = true
				PlaySound(190478398)
				StarterGui:SetCore("SendNotification", { 
					Title = MarketplaceService:GetProductInfo(game.PlaceId).Name,
					Text = "Closed.",
					Icon = "rbxassetid://182496371",
					Duration = 2,
				})
			end
		until Library.Stopped
	end)

	UserInputService.InputBegan:Connect(function(Input, isTyping)
		if Input.KeyCode == Enum.KeyCode.RightShift and not isTyping then
			MainFrame.Visible = not MainFrame.Visible
		end
	end)

	function Main:CreateTab(types)
		local Tabs = {}

		local TabHolder = Instance.new("Frame")
		TabHolder.ZIndex = 2
		TabHolder.Parent = MainFrame
		TabHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		TabHolder.BackgroundTransparency = 0.030
		TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabHolder.BorderSizePixel = 0
		TabHolder.Size = UDim2.new(0, 220, 0, 28)
		if not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
			MakeDraggable(TabHolder)
		end

		local TabName = Instance.new("TextLabel")
		TabName.ZIndex = 2
		TabName.Parent = TabHolder
		TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabName.BackgroundTransparency = 1.000
		TabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabName.BorderSizePixel = 0
		TabName.Position = UDim2.new(0, 8, 0, 0)
		TabName.Size = UDim2.new(0, 145, 1, 0)
		TabName.Font = Enum.Font.SourceSans
		TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabName.TextSize = 20.000
		TabName.TextWrapped = true
		TabName.TextXAlignment = Enum.TextXAlignment.Left

		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.ZIndex = 2
		ImageLabel.Parent = TabHolder
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.935, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0, 20, 0, 20)

		local TogglesList = Instance.new("Frame")
		TogglesList.ZIndex = 2
		TogglesList.Parent = TabHolder
		TogglesList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TogglesList.BackgroundTransparency = 1.000
		TogglesList.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TogglesList.BorderSizePixel = 0
		TogglesList.Position = UDim2.new(0, 0, 1, 0)
		TogglesList.Size = UDim2.new(1, 0, 0, 0)

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Parent = TogglesList
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		if types == "1" then
			TabName.Text = "Combat"
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 85, 127)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=138185990548352"
		elseif types == "2" then
			TabName.Text = "Exploit"
			ImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 187)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=71954798465945"
		elseif types == "3" then
			TabName.Text = "Move"
			ImageLabel.ImageColor3 = Color3.fromRGB(82, 246, 255)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=91366694317593"
		elseif types == "4" then
			TabName.Text = "Player"
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 127)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=103157697311305"
		elseif types == "5" then
			TabName.Text = "Visual"
			ImageLabel.ImageColor3 = Color3.fromRGB(170, 85, 255)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=118420030502964"
		elseif types == "6" then
			TabName.Text = "World"
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 170, 0)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=76313147188124"
		end

		function Tabs:CreateToggle(ToggleButton)
			ToggleButton.MiniKeybind = ToggleButton.MiniKeybind or {}
			ToggleButton = {
				Name = ToggleButton.Name,
				Enabled = ToggleButton.Enabled or false,
				Keybind = ToggleButton.Keybind or "Euro",
				AutoDisable = ToggleButton.AutoDisable or false,
				MiniKeybind = {
					Visibility = ToggleButton.MiniKeybind.Visibility or false,
					Position = ToggleButton.MiniKeybind.Position or UDim2.new(0.5, 0, 0.5, 0)
				},
				Callback = ToggleButton.Callback or function() end,
			}
			if not ConfigTable.Libraries.ToggleButton[ToggleButton.Name] then
				ConfigTable.Libraries.ToggleButton[ToggleButton.Name] = {
					Enabled = ToggleButton.Enabled,
					Keybind = ToggleButton.Keybind,
					MiniKeybind = {
						Visibility = ToggleButton.MiniKeybind.Visibility,
						Position = ToggleButton.MiniKeybind.Position
					},
				}
			else
				ToggleButton.Enabled = ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Enabled
				ToggleButton.Keybind = ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Keybind
				ToggleButton.MiniKeybind.Visibility = ConfigTable.Libraries.ToggleButton[ToggleButton.Name].MiniKeybind.Visibility
				ToggleButton.MiniKeybind.Position = ConfigTable.Libraries.ToggleButton[ToggleButton.Name].MiniKeybind.Position
			end

			local ToggleMain = Instance.new("TextButton")
			ToggleMain.Parent = TogglesList
			ToggleMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			ToggleMain.BackgroundTransparency = 0.230
			ToggleMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleMain.BorderSizePixel = 0
			ToggleMain.Size = UDim2.new(1, 0, 0, 28)
			ToggleMain.AutoButtonColor = false
			ToggleMain.Font = Enum.Font.SourceSans
			ToggleMain.Text = ""
			ToggleMain.ZIndex = 2
			ToggleMain.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleMain.TextSize = 14.000

			local ToggleName = Instance.new("TextLabel")
			ToggleName.Parent = ToggleMain
			ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleName.BackgroundTransparency = 1.000
			ToggleName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleName.BorderSizePixel = 0
			ToggleName.Position = UDim2.new(0, 8, 0, 0)
			ToggleName.Size = UDim2.new(0, 145, 1, 0)
			ToggleName.Font = Enum.Font.SourceSans
			ToggleName.Text = ToggleButton.Name
			ToggleName.ZIndex = 2
			ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleName.TextSize = 18.000
			ToggleName.TextWrapped = true
			ToggleName.TextXAlignment = Enum.TextXAlignment.Left

			local OpenMenu = Instance.new("TextButton")
			OpenMenu.Parent = ToggleMain
			OpenMenu.AnchorPoint = Vector2.new(0.5, 0.5)
			OpenMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			OpenMenu.BackgroundTransparency = 1.000
			OpenMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
			OpenMenu.BorderSizePixel = 0
			OpenMenu.Position = UDim2.new(0.935, 0, 0.5, 0)
			OpenMenu.Size = UDim2.new(0, 25, 0, 25)
			OpenMenu.Font = Enum.Font.SourceSans
			OpenMenu.ZIndex = 2
			OpenMenu.Text = ">"
			OpenMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
			OpenMenu.TextScaled = true
			OpenMenu.TextSize = 14.000
			OpenMenu.TextWrapped = true

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 230, 255))}
			UIGradient.Parent = ToggleMain
			UIGradient.Enabled = true

			local IsToggleMenu =  false
			local ToggleMenu, ScrollingMenu, UIListLayout_2
			if Library.DeviceType == "Mouse" then
				ToggleMenu = Instance.new("Frame")
				ToggleMenu.Parent = TogglesList
				ToggleMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ToggleMenu.BackgroundTransparency = 0.150
				ToggleMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleMenu.BorderSizePixel = 0
				ToggleMenu.Position = UDim2.new(0, 0, 25, 0)
				ToggleMenu.Size = UDim2.new(1, 0, 0, 0)
				ToggleMenu.Visible = false

				UIListLayout_2 = Instance.new("UIListLayout")
				UIListLayout_2.Parent = ToggleMenu
				UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			elseif Library.DeviceType == "Touch" then
				ToggleMenu = Instance.new("Frame")
				ToggleMenu.Parent = TogglesList
				ToggleMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ToggleMenu.BackgroundTransparency = 1
				ToggleMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleMenu.BorderSizePixel = 0
				ToggleMenu.Position = UDim2.new(0, 0, 25, 0)
				ToggleMenu.Size = UDim2.new(1, 0, 0, 125)
				ToggleMenu.Visible = false

				ScrollingMenu = Instance.new("ScrollingFrame")
				ScrollingMenu.Parent = ToggleMenu
				ScrollingMenu.Active = true
				ScrollingMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ScrollingMenu.BackgroundTransparency = 0.150
				ScrollingMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingMenu.BorderSizePixel = 0
				ScrollingMenu.Size = UDim2.new(1, 0, 0, 125)
				ScrollingMenu.ScrollBarThickness = 0

				UIListLayout_2 = Instance.new("UIListLayout")
				UIListLayout_2.Parent = ScrollingMenu
				UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			end

			local Keybinds
			if Library.DeviceType == "Mouse" then
				Keybinds = Instance.new("TextBox")
				Keybinds.Parent = ToggleMenu
				Keybinds.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				Keybinds.BackgroundTransparency = 1.000
				Keybinds.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Keybinds.BorderSizePixel = 0
				Keybinds.LayoutOrder = -1
				Keybinds.Size = UDim2.new(1, 0, 0, 28)
				Keybinds.Font = Enum.Font.SourceSans
				Keybinds.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
				Keybinds.PlaceholderText = "None"
				Keybinds.Text = ""
				Keybinds.TextColor3 = Color3.fromRGB(255, 255, 255)
				Keybinds.TextSize = 18.000
				UserInputService.InputBegan:Connect(function(Input, isTyping)
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						if Keybinds:IsFocused() then
							ToggleButton.Keybind = Input.KeyCode.Name
							Keybinds.PlaceholderText = ""
							Keybinds.Text = Input.KeyCode.Name
							Keybinds:ReleaseFocus()
							ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Keybind = ToggleButton.Keybind
						elseif ToggleButton.Keybind == "Backspace" then
							ToggleButton.Keybind = "Euro"
							Keybinds.Text = ""
							Keybinds.PlaceholderText = "None"
							Keybinds:ReleaseFocus()
							ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Keybind = ToggleButton.Keybind
						end       
					end
					task.spawn(function()
						repeat
							task.wait()
							if ToggleButton.Keybind ~= "Euro" then
								Keybinds.PlaceholderText = ""
								Keybinds.Text = ToggleButton.Keybind
							end
							if Library.Uninject then
								task.wait(1.5)
								if Keybinds and ToggleButton.Keybind then
									Keybinds.Text = ""
									ToggleButton.Keybind = "Euro"
									Keybinds.PlaceholderText = "None"
								end
							end
						until Library.Stopped
					end)
				end)
			elseif Library.DeviceType == "Touch" then
				local SmallKeybinds, IsKeybind = nil, false
				Keybinds = Instance.new("TextButton")
				Keybinds.Parent = ScrollingMenu
				Keybinds.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Keybinds.BackgroundTransparency = 1.000
				Keybinds.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Keybinds.BorderSizePixel = 0
				Keybinds.LayoutOrder = -1
				Keybinds.Position = UDim2.new(0.273255825, 0, 2.98461533, 0)
				Keybinds.Size = UDim2.new(1, 0, 0, 34)
				Keybinds.Text = "Show"
				Keybinds.Font = Enum.Font.SourceSans
				Keybinds.TextColor3 = Color3.fromRGB(255, 255, 255)
				Keybinds.TextSize = 16.000
				Keybinds.Visible = true

				local function CreateMiniKeybind()
					local NewSize4 = game:GetService("TextService"):GetTextSize(ToggleButton.Name, 14, Enum.Font.Roboto, Vector2.new(200, math.huge))
					local MiniKeybind = Instance.new("TextButton")
					MiniKeybind.Parent = KeybindFrame
					MiniKeybind.AnchorPoint = Vector2.new(0.5, 0.5)
					MiniKeybind.BackgroundTransparency = 0.750
					MiniKeybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
					MiniKeybind.BorderSizePixel = 0
					MiniKeybind.Position = ToggleButton.MiniKeybind.Position or UDim2.new(0.5, 0, 0.5, 0)
					MiniKeybind.Size = UDim2.new(0, 65, 0, NewSize4.Y + 15)
					MiniKeybind.Font = Enum.Font.SourceSans
					MiniKeybind.Text = ToggleButton.Name
					MiniKeybind.Name = ToggleButton.Name
					MiniKeybind.TextColor3 = Color3.fromRGB(0, 0, 0)
					MiniKeybind.TextScaled = true
					MiniKeybind.TextSize = 14.000
					MiniKeybind.TextWrapped = true
					MiniKeybind.TextScaled = true
					MakeDraggable(MiniKeybind)

					local function MiniKeyClicked()
						if ToggleButton.Enabled then
							AddArray(ToggleButton.Name)
							MiniKeybind.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
							ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Enabled = ToggleButton.Enabled
							TweenService:Create(ToggleMain, TweenInfo.new(0.4), {Transparency = 0,BackgroundColor3 = Color3.fromRGB(232, 30, 100)}):Play()
						else
							RemoveArray(ToggleButton.Name)
							MiniKeybind.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
							ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Enabled = ToggleButton.Enabled
							TweenService:Create(ToggleMain, TweenInfo.new(0.4), {Transparency = 0.230,BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
						end
					end
					
					task.spawn(function()
						repeat
							task.wait()
							if ToggleButton.Enabled then
								MiniKeybind.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
							else
								MiniKeybind.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
							end
						until Library.Stopped
					end)
					
					MiniKeybind.MouseButton1Click:Connect(function()
						ToggleButton.Enabled = not ToggleButton.Enabled
						MiniKeyClicked()
						if ToggleButton.Callback then
							ToggleButton.Callback(ToggleButton.Enabled)
						end
					end)

					MiniKeybind:GetPropertyChangedSignal("Position"):Connect(function()
						ToggleButton.MiniKeybind.Position = MiniKeybind.Position
						ConfigTable.Libraries.ToggleButton[ToggleButton.Name].MiniKeybind.Position = MiniKeybind.Position
					end)
				end
				
				Keybinds.MouseButton1Click:Connect(function()
					IsKeybind = not IsKeybind
					ToggleButton.MiniKeybind.Visibility = IsKeybind
					ConfigTable.Libraries.ToggleButton[ToggleButton.Name].MiniKeybind.Visibility = IsKeybind
					if IsKeybind then
						Keybinds.TextTransparency = 0.5
						CreateMiniKeybind()
					else
						for _, v in ipairs(KeybindFrame:GetChildren()) do
							if v.Name == ToggleButton.Name then
								v:Destroy()
							end
						end
						Keybinds.TextTransparency = 0
					end
				end)
				
				if ToggleButton.MiniKeybind.Visibility then
					IsKeybind = true
					Keybinds.TextTransparency = 0.5
					CreateMiniKeybind()
				end
			end
			
			local MenuTween = "C"
			task.spawn(function()
				repeat
					task.wait()
					if MenuTween == "O" then
						for _, v in pairs(ToggleMenu:GetChildren()) do
							if v:IsA("GuiObject") then
								v.Visible = true
							end
						end
					elseif MenuTween == "C" then
						for _, v in pairs(ToggleMenu:GetChildren()) do
							if v:IsA("GuiObject") then
								v.Visible = false
							end
						end
					end
				until Library.Stopped
			end)

			local function ToggleButtonClicked()
				if ToggleButton.Enabled then
					TweenService:Create(ToggleMain, TweenInfo.new(0.4), {Transparency = 0,BackgroundColor3 = Color3.fromRGB(232, 30, 100)}):Play()
					AddArray(ToggleButton.Name)
					ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Enabled = ToggleButton.Enabled
				else
					TweenService:Create(ToggleMain, TweenInfo.new(0.4), {Transparency = 0.230,BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
					RemoveArray(ToggleButton.Name)
					ConfigTable.Libraries.ToggleButton[ToggleButton.Name].Enabled = ToggleButton.Enabled
				end
			end

			task.spawn(function()
				repeat
					task.wait(1)
					if ToggleButton.AutoDisable then
						if ToggleButton.Enabled then
							ToggleButton.Enabled = false
							ToggleButtonClicked()

							if ToggleButton.Callback then
								ToggleButton.Callback(ToggleButton.Enabled)
							end
						end
					end
					if Library.Uninject then
						task.wait(1.5)
						if ToggleButton.Enabled then
							ToggleButton.Enabled = false
							ToggleButtonClicked()

							if ToggleButton.Callback then
								ToggleButton.Callback(ToggleButton.Enabled)
							end
						end
					end
				until Library.Stopped
			end)

			if ToggleButton.Enabled then
				ToggleButton.Enabled = true
				ToggleButtonClicked()

				if ToggleButton.Callback then
					ToggleButton.Callback(ToggleButton.Enabled)
				end
			end

			ToggleMain.MouseButton1Click:Connect(function()
				ToggleButton.Enabled = not ToggleButton.Enabled
				ToggleButtonClicked()

				if ToggleButton.Callback then
					ToggleButton.Callback(ToggleButton.Enabled)
				end
			end)

			ToggleMain.MouseButton2Click:Connect(function()
				IsToggleMenu = not IsToggleMenu
				if IsToggleMenu then
					ToggleMenu.Visible = true
					TweenService:Create(OpenMenu, TweenInfo.new(0.4), {Rotation = 90}):Play()
					if GetChildrenY(ToggleMenu) then
						local OpeningMenu = TweenService:Create(ToggleMenu, TweenInfo.new(0.4), {Size = GetChildrenY(ToggleMenu)})
						if OpeningMenu then
							OpeningMenu:Play()
							OpeningMenu.Completed:Connect(function()
								MenuTween = "O"
								ToggleMenu.AutomaticSize = Enum.AutomaticSize.Y
							end)
						end
					end
				else
					TweenService:Create(OpenMenu, TweenInfo.new(0.4), {Rotation = 0}):Play()
					local ClosingMenu = TweenService:Create(ToggleMenu, TweenInfo.new(0.4), {Size = UDim2.new(1, 0, 0, 0)})
					if ClosingMenu then
						MenuTween = "C"
						ClosingMenu:Play()
						ToggleMenu.AutomaticSize = Enum.AutomaticSize.None
						ClosingMenu.Completed:Connect(function()
							ToggleMenu.Visible = false
						end)
					end
				end
			end)

			OpenMenu.MouseButton1Click:Connect(function()
				IsToggleMenu = not IsToggleMenu
				if IsToggleMenu then
					ToggleMenu.Visible = true
					TweenService:Create(OpenMenu, TweenInfo.new(0.4), {Rotation = 90}):Play()
					if GetChildrenY(ToggleMenu) then
						local OpeningMenu = TweenService:Create(ToggleMenu, TweenInfo.new(0.4), {Size = GetChildrenY(ToggleMenu)})
						if OpeningMenu then
							OpeningMenu:Play()
							OpeningMenu.Completed:Connect(function()
								MenuTween = "O"
								ToggleMenu.AutomaticSize = Enum.AutomaticSize.Y
							end)
						end
					end
				else
					TweenService:Create(OpenMenu, TweenInfo.new(0.4), {Rotation = 0}):Play()
					local ClosingMenu = TweenService:Create(ToggleMenu, TweenInfo.new(0.4), {Size = UDim2.new(1, 0, 0, 0)})
					if ClosingMenu then
						MenuTween = "C"
						ClosingMenu:Play()
						ToggleMenu.AutomaticSize = Enum.AutomaticSize.None
						ClosingMenu.Completed:Connect(function()
							ToggleMenu.Visible = false
						end)
					end
				end
			end)

			if ToggleButton.Keybind then
				UserInputService.InputBegan:Connect(function(Input, isTyping)
					if Input.KeyCode == Enum.KeyCode[ToggleButton.Keybind] and not isTyping then
						ToggleButton.Enabled = not ToggleButton.Enabled
						ToggleButtonClicked()

						if ToggleButton.Callback then
							ToggleButton.Callback(ToggleButton.Enabled)
						end
					end
				end)
			end
			
			function ToggleButton:CreateTextBox(TextBox)
				TextBox = {
					Name = TextBox.Name or "-",
					Text = TextBox.Text or "",
					Callback = TextBox.Callback or function() end
				}

				local TextBoxHolder = Instance.new("TextBox")
				TextBoxHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				TextBoxHolder.BackgroundTransparency = 1
				TextBoxHolder.BorderSizePixel = 0
				TextBoxHolder.Size = UDim2.new(1, 0, 0, 28)
				TextBoxHolder.Font = Enum.Font.SourceSans
				TextBoxHolder.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
				TextBoxHolder.PlaceholderText = TextBox.Name
				TextBoxHolder.Text = TextBox.Text
				TextBoxHolder.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBoxHolder.TextSize = 16
				if Library.DeviceType == "Touch" then
					TextBoxHolder.Parent = ScrollingMenu
				else
					TextBoxHolder.Parent = ToggleMenu
				end

				TextBoxHolder.FocusLost:Connect(function(enterPressed)
					TextBox.Text = TextBoxHolder.Text
					TextBox.Callback(TextBox.Text)
				end)

				return TextBox
			end

			function ToggleButton:CreateDropdown(Dropdown)
				Dropdown = {
					Name = Dropdown.Name,
					List = Dropdown.List or {},
					Default = Dropdown.Default,
					Callback = Dropdown.Callback or function() end
				}
				if not ConfigTable.Libraries.Dropdown[Dropdown.Name] then
					ConfigTable.Libraries.Dropdown[Dropdown.Name] = {
						Default = Dropdown.Default
					}
				else
					Dropdown.Default = ConfigTable.Libraries.Dropdown[Dropdown.Name].Default
				end

				local Selected
				local DropdownHolder = Instance.new("TextButton")
				DropdownHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				DropdownHolder.BackgroundTransparency = 1.000
				DropdownHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropdownHolder.BorderSizePixel = 0
				DropdownHolder.Size = UDim2.new(1, 0, 0, 28)
				DropdownHolder.AutoButtonColor = false
				DropdownHolder.Font = Enum.Font.SourceSans
				DropdownHolder.Text = ""
				DropdownHolder.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownHolder.TextSize = 16.000
				DropdownHolder.TextWrapped = true
				DropdownHolder.TextXAlignment = Enum.TextXAlignment.Left
				if Library.DeviceType == "Touch" then
					DropdownHolder.Parent = ScrollingMenu
				elseif Library.DeviceType == "Mouse" then
					DropdownHolder.Parent = ToggleMenu
				end

				local DropdownSelected = Instance.new("TextLabel")
				DropdownSelected.Parent = DropdownHolder
				DropdownSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownSelected.BackgroundTransparency = 1.000
				DropdownSelected.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropdownSelected.BorderSizePixel = 0
				DropdownSelected.Size = UDim2.new(0, 215, 1, 0)
				DropdownSelected.Font = Enum.Font.SourceSans
				DropdownSelected.Text = Dropdown.Default or "None"
				DropdownSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownSelected.TextSize = 18.000
				DropdownSelected.TextWrapped = true
				DropdownSelected.TextXAlignment = Enum.TextXAlignment.Right

				local DropdownMode = Instance.new("TextLabel")
				DropdownMode.Parent = DropdownHolder
				DropdownMode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownMode.BackgroundTransparency = 1.000
				DropdownMode.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropdownMode.BorderSizePixel = 0
				DropdownMode.Position = UDim2.new(0, 8, 0, 0)
				DropdownMode.Size = UDim2.new(0, 45, 1, 0)
				DropdownMode.Font = Enum.Font.SourceSans
				DropdownMode.Text = "Mode"
				DropdownMode.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownMode.TextSize = 18.000
				DropdownMode.TextWrapped = true
				DropdownMode.TextXAlignment = Enum.TextXAlignment.Left

				local CurrentDropdown = 1
				DropdownHolder.MouseButton1Click:Connect(function()
					DropdownSelected.Text = Dropdown.List[CurrentDropdown]
					Dropdown.Callback(Dropdown.List[CurrentDropdown])
					Selected = Dropdown.List[CurrentDropdown]
					CurrentDropdown = CurrentDropdown % #Dropdown.List + 1
					ConfigTable.Libraries.Dropdown[Dropdown.Name].Default = Selected
				end)

				if Dropdown.Default then
					DropdownSelected.Text = Dropdown.Default
					Dropdown.Callback(Dropdown.Default)
				else
					DropdownSelected.Text = Dropdown.List[1]
					Dropdown.Callback(Dropdown.List[1])
				end

				return Dropdown
			end

			function ToggleButton:CreateSlider(Slider)
				Slider = {
					Name = Slider.Name,
					Min = Slider.Min or 0,
					Max = Slider.Max or 100,
					Default = Slider.Default,
					Callback = Slider.Callback or function() end
				}
				if not ConfigTable.Libraries.Slider[Slider.Name] then
					ConfigTable.Libraries.Slider[Slider.Name] = {
						Default = Slider.Default
					}
				else
					Slider.Default = ConfigTable.Libraries.Slider[Slider.Name].Default
				end

				local Value
				local Dragged = false
				local SliderMain = Instance.new("Frame")
				SliderMain.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				SliderMain.BackgroundTransparency = 1.000
				SliderMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMain.BorderSizePixel = 0
				SliderMain.Size = UDim2.new(1, 0, 0, 42)
				if Library.DeviceType == "Touch" then
					SliderMain.Parent = ScrollingMenu
				elseif Library.DeviceType == "Mouse" then
					SliderMain.Parent = ToggleMenu
				end

				local SliderName = Instance.new("TextLabel")
				SliderName.Parent = SliderMain
				SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderName.BackgroundTransparency = 1.000
				SliderName.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderName.BorderSizePixel = 0
				SliderName.Position = UDim2.new(0, 8, 0, 5)
				SliderName.Size = UDim2.new(1, 0, 0, 15)
				SliderName.Font = Enum.Font.SourceSans
				SliderName.Text = Slider.Name
				SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderName.TextSize = 18.000
				SliderName.TextWrapped = true
				SliderName.TextXAlignment = Enum.TextXAlignment.Left

				local SliderValue = Instance.new("TextBox")
				SliderValue.Parent = SliderMain
				SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.BackgroundTransparency = 1.000
				SliderValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderValue.Position = UDim2.new(0, 35, 0, 5)
				SliderValue.BorderSizePixel = 0
				SliderValue.Size = UDim2.new(0, 180, 0, 15)
				SliderValue.Font = Enum.Font.SourceSans
				SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.TextSize = 18.000
				SliderValue.TextWrapped = true
				SliderValue.TextXAlignment = Enum.TextXAlignment.Right

				local SliderBack = Instance.new("TextButton")
				SliderBack.Parent = SliderMain
				SliderBack.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
				SliderBack.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderBack.BorderSizePixel = 0
				SliderBack.Position = UDim2.new(0, 8, 0, 25)
				SliderBack.AutoButtonColor = false
				SliderBack.Size = UDim2.new(0, 207, 0, 8)
				SliderBack.Text = ""

				local SliderFront = Instance.new("Frame")
				SliderFront.Parent = SliderBack
				SliderFront.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
				SliderFront.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderFront.BorderSizePixel = 0
				SliderFront.Size = UDim2.new(0, 50, 1, 0)
				SliderFront.Interactable = false

				local SliderGradient = Instance.new("UIGradient")
				SliderGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(138, 230, 255))}
				SliderGradient.Parent = SliderFront

				local function UpdateValue(Input)
					local MouseX = math.clamp(Input.Position.X, SliderMain.AbsolutePosition.X, SliderMain.AbsolutePosition.X + SliderMain.AbsoluteSize.X)
					Value = math.floor(((MouseX - SliderMain.AbsolutePosition.X) / SliderMain.AbsoluteSize.X) * (Slider.Max - Slider.Min) + Slider.Min + 0.05) * 10 / 10
					SliderFront.Size = UDim2.new((Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
					SliderValue.Text = Value
					Slider.Callback(Value)
					ConfigTable.Libraries.Slider[Slider.Name].Default = Value
				end

				SliderBack.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragged = true
						local MouseX = math.clamp(UserInputService:GetMouseLocation().X, SliderMain.AbsolutePosition.X, SliderMain.AbsolutePosition.X + SliderMain.AbsoluteSize.X)
						Value = math.floor(((MouseX - SliderMain.AbsolutePosition.X) / SliderMain.AbsoluteSize.X) * (Slider.Max - Slider.Min) + Slider.Min + 0.05) * 10 / 10
						SliderFront.Size = UDim2.new((Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
						SliderValue.Text = Value
						Slider.Callback(Value)
					end
				end)

				SliderBack.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragged = false
					end
				end)

				UserInputService.InputChanged:Connect(function(Input)
					if Dragged and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
						UpdateValue(Input)
					end
				end)

				SliderValue.FocusLost:Connect(function(Return)
					if not Return then return end
					local NumValue = tonumber(SliderValue.Text)
					if NumValue then
						Value = math.clamp(NumValue, Slider.Min, Slider.Max)
						SliderFront.Size = UDim2.new((Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
						SliderValue.Text = Value
						Slider.Callback(Value)
					else
						SliderValue.Text = Value
					end
				end)

				if Slider.Default then
					Value = math.clamp(Slider.Default, Slider.Min, Slider.Max)
					SliderFront.Size = UDim2.new((Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
					SliderValue.Text = Value
					Slider.Callback(Value)
				else
					Value = math.clamp(0, Slider.Min, Slider.Max)
					SliderFront.Size = UDim2.new((Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
					SliderValue.Text = Value
					Slider.Callback(Value)
				end

				return Slider
			end

			function ToggleButton:CreateMiniToggle(MiniToggle)
				MiniToggle = {
					Name = MiniToggle.Name,
					Enabled = MiniToggle.Enabled or false,
					Callback = MiniToggle.Callback or function() end
				}
				if not ConfigTable.Libraries.MiniToggle[MiniToggle.Name] then
					ConfigTable.Libraries.MiniToggle[MiniToggle.Name] = {
						Enabled = MiniToggle.Enabled,
					}
				else
					MiniToggle.Enabled = ConfigTable.Libraries.MiniToggle[MiniToggle.Name].Enabled
				end

				local MiniToggleMain = Instance.new("Frame")
				MiniToggleMain.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				MiniToggleMain.BackgroundTransparency = 1.000
				MiniToggleMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MiniToggleMain.BorderSizePixel = 0
				MiniToggleMain.Size = UDim2.new(1, 0, 0, 28)
				if Library.DeviceType == "Touch" then
					MiniToggleMain.Parent = ScrollingMenu
				elseif Library.DeviceType == "Mouse" then
					MiniToggleMain.Parent = ToggleMenu
				end

				local MiniToggleName = Instance.new("TextLabel")
				MiniToggleName.Parent = MiniToggleMain
				MiniToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MiniToggleName.BackgroundTransparency = 1.000
				MiniToggleName.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MiniToggleName.BorderSizePixel = 0
				MiniToggleName.Position = UDim2.new(0, 8, 0, 0)
				MiniToggleName.Size = UDim2.new(0, 175, 1, 0)
				MiniToggleName.Font = Enum.Font.SourceSans
				MiniToggleName.Text = MiniToggle.Name
				MiniToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
				MiniToggleName.TextSize = 18.000
				MiniToggleName.TextWrapped = true
				MiniToggleName.TextXAlignment = Enum.TextXAlignment.Left

				local MiniToggleClick = Instance.new("TextButton")
				MiniToggleClick.Parent = MiniToggleMain
				MiniToggleClick.AnchorPoint = Vector2.new(0.5, 0.5)
				MiniToggleClick.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MiniToggleClick.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MiniToggleClick.BorderSizePixel = 0
				MiniToggleClick.Position = UDim2.new(0.935, 0, 0.5, 0)
				MiniToggleClick.Size = UDim2.new(0, 18, 0, 18)
				MiniToggleClick.AutoButtonColor = false
				MiniToggleClick.Font = Enum.Font.SourceSans
				MiniToggleClick.Text = "x"
				MiniToggleClick.TextTransparency = 1
				MiniToggleClick.TextColor3 = Color3.fromRGB(255, 255, 255)
				MiniToggleClick.TextSize = 18.000
				MiniToggleClick.TextWrapped = true
				MiniToggleClick.TextScaled = true
				MiniToggleClick.TextYAlignment = Enum.TextYAlignment.Center
				MiniToggleClick.TextXAlignment = Enum.TextXAlignment.Center

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MiniToggleClick

				local function MiniToggleClicked()
					if MiniToggle.Enabled then
						TweenService:Create(MiniToggleClick, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
						ConfigTable.Libraries.MiniToggle[MiniToggle.Name].Enabled = MiniToggle.Enabled
					else
						TweenService:Create(MiniToggleClick, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
						ConfigTable.Libraries.MiniToggle[MiniToggle.Name].Enabled = MiniToggle.Enabled
					end
				end

				if MiniToggle.Enabled then
					MiniToggle.Enabled = true
					MiniToggleClicked()

					if MiniToggle.Callback then
						MiniToggle.Callback(MiniToggle.Enabled)
					end
				end

				MiniToggleClick.MouseButton1Click:Connect(function()
					MiniToggle.Enabled = not MiniToggle.Enabled
					MiniToggleClicked()

					if MiniToggle.Callback then
						MiniToggle.Callback(MiniToggle.Enabled)
					end
				end)

				return MiniToggle
			end

			return ToggleButton
		end

		return Tabs	
	end	
	return Main	
end

return Library
