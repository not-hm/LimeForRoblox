repeat task.wait() until game:IsLoaded() and workspace.CurrentCamera
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/main/library.lua"))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Network = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Packages"):WaitForChild("Client"):FindFirstChild("Network"))
repeat task.wait() until Network
local MainFrame = Library:CreateMain()
local TabSections = {
	Combat = MainFrame:CreateTab("1"),
	Exploit = MainFrame:CreateTab("2"),
	Move = MainFrame:CreateTab("3"),
	Player = MainFrame:CreateTab("4"),
	Visual = MainFrame:CreateTab("5"),
	World = MainFrame:CreateTab("6"),
	Manager = MainFrame:CreateManager()
}

local function IsAlive(v)
	return v and v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0
end

local function CheckForWall(v)
	local Raycast = RaycastParams.new()
	Raycast.FilterType = Enum.RaycastFilterType.Exclude
	Raycast.FilterDescendantsInstances = {LocalPlayer.Character}
	local Direction = v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position
	local Result = workspace:Raycast(LocalPlayer.Character.PrimaryPart.Position, Direction, Raycast)
	if Result and Result.Instance and not v:IsAncestorOf(Result.Instance) then
		return false
	end
	return true
end

local function GetNearestEntity(MaxDist, EntityCheck, EntitySort, EntityTeam, EntityWall, EntityDirection)
	local Entity
	local MinDist = math.huge
	for _, v in pairs(workspace:GetChildren()) do
		if v:IsA("Model") and v.Name ~= LocalPlayer.Name and IsAlive(v) then
			local IsEntity = false
			if not EntityCheck then
				if not EntityWall or CheckForWall(v) then
					IsEntity = true
				end
			else
				for _, plr in pairs(Players:GetPlayers()) do
					if plr.Name == v.Name and (not EntityTeam or plr.TeamColor ~= LocalPlayer.TeamColor) then
						if not EntityWall or CheckForWall(v) then
							IsEntity = true
						end
					end
				end
			end
			if IsEntity then
				local Direction = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Unit
				local Angle = math.deg(LocalPlayer.Character.PrimaryPart.CFrame.LookVector:Angle(Direction))
				if EntityDirection >= 360 or Angle <= EntityDirection / 2 then
					local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude
					if EntitySort == "Distance" and Distance <= MaxDist and (not MinDist or Distance < MinDist) then
						MinDist = Distance
						Entity = v
					elseif EntitySort == "Furthest" and Distance <= MaxDist and (not MinDist or Distance > MinDist) then
						MinDist = Distance
						Entity = v
					elseif EntitySort == "Health" and Distance <= MaxDist and v:FindFirstChild("Humanoid") and (not MinDist or v.Humanoid.Health < MinDist) then
						MinDist = v.Humanoid.Health
						Entity = v
					elseif EntitySort == "Threat" and Distance <= MaxDist and v:FindFirstChild("Humanoid") and (not MinDist or v.Humanoid.Health > MinDist) then
						MinDist = v.Humanoid.Health
						Entity = v
					end
				end
			end
		end
	end
	return Entity
end

local function GetGoal()
	for _, v in pairs(workspace.WORLDPARTS:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == "GoalHitbox" then
			return v
		end
	end
end

local function GetPosition(pos)
	return Vector3.new(math.floor((pos.X / 3) + 0.5) * 3,math.floor((pos.Y / 3) + 0.5) * 3,math.floor((pos.Z / 3) + 0.5) * 3)
end

local function IsAtPosition(pos)
	for _, v in pairs(workspace:WaitForChild("Blocks"):GetChildren()) do
		if v:IsA("BasePart") then
			if GetPosition(v.Position) == pos then
				return true
			end
		end
	end
	return false
end

local function CheckTool(toolname)
	for _, v in pairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") and v.Name:lower():match(toolname) then
			return v
		end
	end
end

local AntiBot
task.defer(function()
	AntiBot = TabSections.Combat:CreateToggle({
		Name = "Anti Bot",
		Callback = function(callback)
		end
	})
end)

local AutoClicker
task.defer(function()
	if Library.DeviceType == "Mouse" then
		local MaxCPS, MinCPS, CCPS = nil, nil, nil
		local RandomCPS, CDelay = false, nil
		AutoClicker = TabSections.Combat:CreateToggle({
			Name = "Auto Clicker",
			Callback = function(callback)
				if callback then
					task.spawn(function()
						repeat
							if IsAlive(LocalPlayer.Character) then
								local Tool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
								if RandomCPS then
									CCPS = math.random(MinCPS, MaxCPS)
								else
									CCPS = MaxCPS
								end
								if CCPS ~= nil then
									CDelay = 1 / CCPS
								end
								if Tool and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
									Tool:Activate()
								end
							end
							task.wait(CDelay or 0.1)
						until not AutoClicker.Enabled
					end)
				end
			end
		})
		AutoClicker:CreateMiniToggle({
			Name = "Randomize",
			Callback = function(callback)
				if callback then
					RandomCPS = true
				else
					RandomCPS = false
				end
			end
		})
		AutoClicker:CreateSlider({
			Name = "Max",
			Min = 0,
			Max = 20,
			Default = 10,
			Callback = function(callback)
				if callback then
					MaxCPS = callback
				end
			end
		})
		AutoClicker:CreateSlider({
			Name = "Min",
			Min = 0,
			Max = 20,
			Default = 8,
			Callback = function(callback)
				if callback then
					MinCPS = callback
				end
			end
		})
	end
end)

local AutoGapple
task.defer(function()
	AutoGapple = TabSections.Combat:CreateToggle({
		Name = "Auto Gapple",
		Callback = function(callback)
			repeat
				task.wait()
				if IsAlive(LocalPlayer.Character) then
					if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health < 30 then
						if not LocalPlayer.Character:FindFirstChild("Golden_Apple") then
							local Apple = LocalPlayer.Backpack:FindFirstChild("Golden_Apple")
							if Apple then
								LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Apple)
							end
						else
							Network.Fire("Request_ConsumableUse", "Golden_Apple")
						end
					end
				end
			until not AutoGapple.Enabled
		end
	})
end)

local KillAura
local KillAuraEntity
task.defer(function()
	local WallCheck, TeamCheck, SortType, ADirection = true, false, nil, nil
	local Distance, ADelay, AType = nil, nil, "Legit"
	KillAura = TabSections.Combat:CreateToggle({
		Name = "Kill Aura",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						if AType == "Blatant" then
							ADelay = 0.1
						elseif AType == "Legit" then
							ADelay = math.random(20, 60) / 100
						end
						if IsAlive(LocalPlayer.Character) then
							local Entity = GetNearestEntity(Distance, AntiBot.Enabled, SortType, TeamCheck, WallCheck, ADirection)
							if Entity and Entity.PrimaryPart then
								KillAuraEntity = Entity
								local Sword = CheckTool("sword")
								if Sword then
									Network.Fire("RequestSwordHit", Entity)
								end
							else
								KillAuraEntity = nil
							end
						end
						task.wait(ADelay)
					until not KillAura.Enabled
					KillAuraEntity = nil
				end)
			end
		end
	})
	KillAura:CreateDropdown({
		Name = "Kill_Aura_Type",
		List = {"Legit", "Blatant"},
		Default = "Blatant",
		Callback = function(callback)
			if callback then
				AType = callback
			end
		end
	})
	KillAura:CreateDropdown({
		Name = "Kill_Aura_Sort",
		List = {"Furthest", "Health", "Threat", "Distance"},
		Default = "Distance",
		Callback = function(callback)
			if callback then
				SortType = callback
			end
		end
	})
	KillAura:CreateSlider({
		Name = "Direction",
		Min = 0,
		Max = 360,
		Default = 360,
		Callback = function(callback)
			if callback then
				ADirection = callback
			end
		end
	})
	KillAura:CreateSlider({
		Name = "Distance",
		Min = 0,
		Max = 18,
		Default = 16,
		Callback = function(callback)
			if callback then
				Distance = callback
			end
		end
	})
	KillAura:CreateMiniToggle({
		Name = "Through Walls",
		Callback = function(callback)
			if callback then
				WallCheck = false
			else
				WallCheck = true
			end
		end
	})
	KillAura:CreateMiniToggle({
		Name = "Team",
		Callback = function(callback)
			if callback then
				TeamCheck = true
			else
				TeamCheck = false
			end
		end
	})
end)

local InfiniteAura
task.defer(function()
	InfiniteAura = TabSections.Exploit:CreateToggle({
		Name = "Infinite Aura",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						local Sword = CheckTool("sword")
						if Sword then
							for _, v in pairs(Players:GetPlayers()) do
								if IsAlive(v.Character) and v ~= LocalPlayer then
									Network.Fire("RequestBowHit", v.Character)
								end
							end
						end
					until not InfiniteAura.Enabled
				end)
			end
		end
	})
end)

local Nuker
task.defer(function()
	Nuker = TabSections.Exploit:CreateToggle({
		Name = "Nuker",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait(2)
						local Pickaxe = CheckTool("pickaxe")
						if Pickaxe then
							for _, v in pairs(workspace:GetDescendants()) do
								if v:IsA("BasePart") then
									Network.Fire("Request_BreakBlock", v.Position)    
								end
							end
						end
					until not Nuker.Enabled
				end)
			end
		end
	})
end)

local Flight
task.defer(function()
	local OldGravity = workspace.Gravity
	local NewY, OldY
	local Speed
	Flight = TabSections.Move:CreateToggle({
		Name = "Flight",
		Callback = function(callback)
			if callback then
				NewY = 0
				OldY = LocalPlayer.Character.PrimaryPart.Position.Y
				task.spawn(function()
					repeat
						task.wait()
						if IsAlive(LocalPlayer.Character) then
							if workspace.Gravity ~= 0 then
								workspace.Gravity = 0
							end
							local MoveDirection = LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection
							LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(MoveDirection.X * Speed, LocalPlayer.Character.PrimaryPart.Velocity.Y, MoveDirection.Z * Speed)
							LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(LocalPlayer.Character.PrimaryPart.Position.X, OldY + NewY, LocalPlayer.Character.PrimaryPart.Position.Z) * LocalPlayer.Character.PrimaryPart.CFrame.Rotation
							if UserInputService:IsKeyDown("Space") and not UserInputService:GetFocusedTextBox() then
								NewY += 0.8
							elseif UserInputService:IsKeyDown("LeftShift") and not UserInputService:GetFocusedTextBox() then
								NewY -= 0.8
							end
							if Library.DeviceType == "Touch" then
								if  LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Jump then
									NewY += 0.8
								end
							end
						end
					until not Flight.Enabled
					LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(LocalPlayer.Character.PrimaryPart.Position)
					OldY = LocalPlayer.Character.PrimaryPart.Position.Y
					workspace.Gravity = OldGravity
				end)
			end
		end
	})
	Flight:CreateSlider({
		Name = "Speed",
		Min = 0,
		Max = 150,
		Default = 28,
		Callback = function(callback)
			if callback then
				Speed = callback
			end
		end
	})
end)

local NoSlowDown
task.defer(function()
	local Signal
	NoSlowDown = TabSections.Move:CreateToggle({
		Name = "No Slow Down",
		Callback = function(callback)
			if callback then
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
				Signal = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
					if IsAlive(LocalPlayer.Character) then
						if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed ~= 16 then
							LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
						end
					end
				end)
			else
				if Signal then
					Signal:Disconnect()
					Signal = nil
				end
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
			end
		end
	})
end)

local Speed
task.defer(function()
	local AutoJump = false
	local Speeds
	Speed = TabSections.Move:CreateToggle({
		Name = "Speed",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if not Flight.Enabled and IsAlive(LocalPlayer.Character) and LocalPlayer.Character.PrimaryPart then
							local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
							local MoveDirection = Humanoid.MoveDirection
							LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(MoveDirection.X * Speeds, LocalPlayer.Character.PrimaryPart.Velocity.Y, MoveDirection.Z * Speeds)
							if AutoJump and Humanoid.FloorMaterial ~= Enum.Material.Air and not Humanoid.Jump then
								Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
							end
						end
					until not Speed.Enabled
				end)
			end
		end
	})
	Speed:CreateMiniToggle({
		Name = "Auto Jump",
		Callback = function(callback)
			if callback then
				AutoJump = true
			else
				AutoJump = false
			end
		end
	})
	Speed:CreateSlider({
		Name = "Speeds",
		Min = 0,
		Max = 150, 
		Default = 28,
		Callback = function(callback)
			if callback then
				Speeds = callback
			end
		end
	})
end)

local Step
task.defer(function()
	local Excluded = {}
	local Raycast = RaycastParams.new() 
	for _,plr in pairs(workspace:GetDescendants()) do
		if plr:IsA("Model") and IsAlive(plr) and not table.find(Excluded,plr) then
			table.insert(Excluded,plr)
		end
	end
	Raycast.FilterType = Enum.RaycastFilterType.Exclude
	Raycast.FilterDescendantsInstances = Excluded
	Step = TabSections.Move:CreateToggle({
		Name = "Step",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if IsAlive(LocalPlayer.Character) then
							local Direction = LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection * 1.8
							if Direction.Magnitude > 0 then
								local Result = workspace:Raycast(LocalPlayer.Character.PrimaryPart.Position, Direction, Raycast)
								if Result and Result.Instance then
									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X,28,LocalPlayer.Character.PrimaryPart.Velocity.Z)
								end
							end
						end
					until not Step.Enabled
				end)
			end
		end
	})
end)

local Chams
task.defer(function()
	local function Highlight(v)
		if not v:FindFirstChildWhichIsA("Highlight") then
			local Highlight = Instance.new("Highlight")
			Highlight.FillTransparency = 1
			Highlight.OutlineTransparency = 0.45
			Highlight.OutlineColor = Color3.new(1,1,1)
			Highlight.Parent = v
		end
	end
	local function RemoveHighlight(v)
		local Highlight = v:FindFirstChildWhichIsA("Highlight")
		if Highlight then
			Highlight:Destroy()
		end
	end
	Chams = TabSections.Visual:CreateToggle({
		Name = "Chams",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						for _,v in pairs(workspace:GetChildren()) do
							if v:IsA("Model") and IsAlive(v) and v.Name ~= LocalPlayer.Name then
								if not AntiBot.Enabled or Players:FindFirstChild(v.Name) then
									Highlight(v)
								else
									RemoveHighlight(v)
								end
							end
						end
					until not Chams.Enabled
					for _,v in pairs(workspace:GetChildren()) do
						if v:IsA("Model") and IsAlive(v) and v.Name ~= LocalPlayer.Name then
							RemoveHighlight(v)
						end
					end
				end)
			end
		end
	})
end)

local ClickGUI
task.defer(function()
	ClickGUI = TabSections.Visual:CreateToggle({
		Name = "ClickGUI",
		AutoDisable = true,
		Callback = function(callback)
		end
	})
	local QuitLime = ClickGUI:CreateMiniToggle({
		Name = "Quit",
		Callback = function(callback)
			if callback then
				Library.Uninject = true
			end
		end
	})
end)

local ESP
task.defer(function()
	local function AddBoxes(v)
		if not v:FindFirstChildWhichIsA("BillboardGui") then
			local Frame, UIStoke = nil, nil
			local BillboardGui = Instance.new("BillboardGui")
			BillboardGui.Parent = v
			BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			BillboardGui.Active = true
			BillboardGui.AlwaysOnTop = true
			BillboardGui.LightInfluence = 1.000
			BillboardGui.Size = UDim2.new(4.5,0,6.5,0)
			if BillboardGui and not BillboardGui:FindFirstChildWhichIsA("Frame") then
				Frame = Instance.new("Frame")
				Frame.Parent = BillboardGui
				Frame.AnchorPoint = Vector2.new(0.5,0.5)
				Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Frame.BackgroundTransparency = 1.000
				Frame.BorderColor3 = Color3.fromRGB(0,0,0)
				Frame.Position = UDim2.new(0.5,0,0.5,0)
				Frame.Size = UDim2.new(0.949999988,0,0.949999988,0)
				if Frame and not Frame:FindFirstChildWhichIsA("UIStroke") then
					UIStoke = Instance.new("UIStroke")
					UIStoke.Parent = Frame
					UIStoke.Color = Color3.fromRGB(255,255,255)
					UIStoke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
					UIStoke.LineJoinMode = Enum.LineJoinMode.Miter
					UIStoke.Thickness = 2
					UIStoke.Transparency = 0
				end
			end
		end
	end
	local function RemoveBoxes(v)
		local BillboardGui = v:FindFirstChildWhichIsA("BillboardGui")
		if BillboardGui then
			BillboardGui:Destroy()
		end
	end
	ESP = TabSections.Visual:CreateToggle({
		Name = "ESP",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						for _,v in pairs(workspace:GetChildren()) do
							if v:IsA("Model") and IsAlive(v) and v.Name ~= LocalPlayer.Name then
								if not AntiBot.Enabled or Players:FindFirstChild(v.Name) then
									AddBoxes(v)
								else
									RemoveBoxes(v)
								end
							end
						end
					until not ESP.Enabled
					for _,v in pairs(workspace:GetChildren()) do
						if v:IsA("Model") and IsAlive(v) and v.Name ~= LocalPlayer.Name then
							RemoveBoxes(v)
						end
					end
				end)
			end
		end
	})
end)

local Fullbright
task.defer(function()
	local OldBrightness = Lighting.Brightness
	local OldAmbient = Lighting.Ambient
	local Signal1, Signal2
	Fullbright = TabSections.Visual:CreateToggle({
		Name = "Fullbright",
		Callback = function(callback)
			if callback then
				Lighting.Brightness = 5
				Lighting.Ambient = Color3.fromRGB(255, 255, 255)
				Signal1 = Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
					Lighting.Brightness = 5
				end)
				Signal2 = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
					Lighting.Ambient = Color3.fromRGB(255, 255, 255)
				end)
			else
				if Signal1 and Signal2 then
					Signal1:Disconnect()
					Signal1 = nil
					Signal2:Disconnect()
					Signal2 = nil
				end
				Lighting.Brightness = OldBrightness
				Lighting.Ambient = OldAmbient
			end
		end
	}) 
end)

local HUD
task.defer(function()
	local IsArray, IsWatermark = false, false
	HUD = TabSections.Visual:CreateToggle({
		Name = "HUD",
		Enabled = true,
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if not Library.Visual.Hud then
							Library.Visual.Hud = true
						end
						if IsArray then
							Library.Visual.Arraylist = IsArray
						else
							Library.Visual.Arraylist = false
						end
						if IsWatermark then
							Library.Visual.Watermark = true
						else
							Library.Visual.Watermark = false
						end
					until not HUD.Enabled
					Library.Visual.Hud = false
				end)
			end
		end
	})
	HUD:CreateMiniToggle({
		Name = "Arraylist",
		Enabled = true,
		Callback = function(callback)
			if callback then
				IsArray = true
			else
				IsArray = false
			end
		end
	})
	HUD:CreateMiniToggle({
		Name = "Watermark",
		Enabled = true,
		Callback = function(callback)
			if callback then
				IsWatermark = true
			else
				IsWatermark = false
			end
		end
	})
end)

local TargetHUD
task.defer(function()
	local TargetIcon
	TargetHUD = TabSections.Visual:CreateToggle({
		Name = "Target HUD",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if KillAura.Enabled then
							if KillAuraEntity then
								local LocalTarget = Players:GetPlayerFromCharacter(KillAuraEntity)
								if LocalTarget then
									TargetIcon = Players:GetUserThumbnailAsync(LocalTarget.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size48x48)
								else
									TargetIcon = "rbxassetid://14025674892"
								end
								MainFrame:CreateTargetHUD(KillAuraEntity.Name, TargetIcon, KillAuraEntity:FindFirstChildOfClass("Humanoid"), true)
							else
								MainFrame:CreateTargetHUD(LocalPlayer.Name, Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48), LocalPlayer.Character:FindFirstChildOfClass("Humanoid"), true)
							end
						else
							MainFrame:CreateTargetHUD(LocalPlayer.Name, Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48), LocalPlayer.Character:FindFirstChildOfClass("Humanoid"), true)
						end
					until not TargetHUD.Enabled
					MainFrame:CreateTargetHUD(LocalPlayer.Name, Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48), LocalPlayer.Character:FindFirstChildOfClass("Humanoid"), false)
				end)
			end
		end
	})
end)

local Tracers
task.defer(function()
	local Lines = {}
	local function UpdatePos(v)
		if IsAlive(v) then
			local Vector, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(v.PrimaryPart.Position)
			if OnScreen then
				local Origin = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2.3)
				local Destination = Vector2.new(Vector.X, Vector.Y)
				if not Lines[v] then
					Lines[v] = MainFrame:CreateLine(Origin, Destination)
				else
					local Line = Lines[v]
					Line.Position = UDim2.new(0, (Origin + Destination).X / 2, 0, (Origin + Destination).Y / 2)
					Line.Size = UDim2.new(0, (Origin - Destination).Magnitude, 0, 0.02)
					Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))
				end
			else
				if Lines[v] then
					Lines[v]:Destroy()
					Lines[v] = nil
				end
			end
		else
			if Lines[v] then
				Lines[v]:Destroy()
				Lines[v] = nil
			end
		end
	end
	Tracers = TabSections.Visual:CreateToggle({
		Name = "Tracers",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						for _, v in pairs(workspace:GetChildren()) do
							if v:IsA("Model") and IsAlive(v) and v.Name ~= LocalPlayer.Name then
								if AntiBot.Enabled then
									if Players:FindFirstChild(v.Name) then
										UpdatePos(v)
									else
										if Lines[v] then
											Lines[v]:Destroy()
											Lines[v] = nil
										end
									end
								else
									UpdatePos(v)
								end
							else
								if Lines[v] then
									Lines[v]:Destroy()
									Lines[v] = nil
								end
							end
						end
					until not Tracers.Enabled
					for _, v in pairs(Lines) do
						v:Destroy()
					end
					Lines = {}
				end)
			end
		end
	})
end)

local AntiVoid
task.defer(function()
	local Mode, LastPos
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(9e9, 6, 9e9)
	Part.Position = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, 3, LocalPlayer.Character.PrimaryPart.Position.Z)
	Part.Transparency = 1
	Part.Parent = workspace
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = false
	task.spawn(function()
		local LowY
		for _, f in pairs(workspace:WaitForChild("Blocks"):GetChildren()) do
			if f:IsA("Folder") then
				for _, v in ipairs(f:GetChildren()) do
					if v:IsA("BasePart") then
						local y = v.Position.Y - v.Size.Y * 0.5
						if not LowY or y < LowY then LowY = y end
					end
				end
				if LowY then
					Part.Position += Vector3.yAxis * (LowY - Part.Position.Y)
					LowY = nil
				end
			end
		end
	end)
	AntiVoid = TabSections.Player:CreateToggle({
		Name = "Anti Void",
		Callback = function(callback)
			if callback then
				Part.Transparency = 0.75
				task.spawn(function()
					repeat
						task.wait()
						if IsAlive(LocalPlayer.Character) then
							task.defer(function()
								if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").FloorMaterial ~= Enum.Material.Air then
									LastPos = LocalPlayer.Character.PrimaryPart.Position
								end
							end)
							if LocalPlayer.Character.PrimaryPart.Position.Y <= Part.Position.Y then
								if Mode == "Teleport" then
									LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(LastPos + Vector3.new(0, 6, 0))
								elseif Mode == "Bounce" then
									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, (math.floor(LastPos.Y) * 2.6), LocalPlayer.Character.PrimaryPart.Velocity.Z)
								end
							end
						end
					until not AntiVoid.Enabled
					Part.Transparency = 1
				end)
			end
		end
	})
	AntiVoid:CreateDropdown({
		Name = "AntiVoid_Type",
		List = {"Bounce", "Teleport"},
		Default = "Teleport",
		Callback = function(callback)
			if callback then
				Mode = callback
			end
		end
	})
end)

local NoClip
task.defer(function()
	NoClip = TabSections.Player:CreateToggle({
		Name = "No Clip",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if IsAlive(LocalPlayer.Character) then
							for _, torso in pairs(LocalPlayer.Character:GetChildren()) do
								if torso:IsA("MeshPart") and torso.Name:lower():match("torso") then
									if torso.CanCollide then
										torso.CanCollide = false
									end
								end
							end
							if LocalPlayer.Character.PrimaryPart.CanCollide then
								LocalPlayer.Character.PrimaryPart.CanCollide = false
							end
						end
					until not NoClip.Enabled
					for _, torso in pairs(LocalPlayer.Character:GetChildren()) do
						if torso:IsA("MeshPart") and torso.Name:lower():match("torso") then
							if not torso.CanCollide then
								torso.CanCollide = true
							end
						end
					end
					if not LocalPlayer.Character.PrimaryPart.CanCollide then
						LocalPlayer.Character.PrimaryPart.CanCollide = true
					end
				end)
			end
		end
	})
end)

local TimeChanger
task.defer(function()
	local OldClockTime = Lighting.ClockTime
	local NewClockTime
	TimeChanger = TabSections.World:CreateToggle({
		Name = "Time Changer",
		Callback = function(callback)
			if callback then
				task.spawn(function()
					repeat
						task.wait()
						if Lighting.ClockTime ~= NewClockTime then
							Lighting.ClockTime = NewClockTime
						end
					until not TimeChanger.Enabled
					Lighting.ClockTime = OldClockTime
				end)
			end
		end
	})
	TimeChanger:CreateSlider({
		Name = "Time",
		Min = 0,
		Max = 24,
		Default = 3,
		Callback = function(callback)
			if callback then
				NewClockTime = callback
			end
		end
	})
end)
