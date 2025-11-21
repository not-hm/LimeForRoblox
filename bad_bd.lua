repeat task.wait() until game:IsLoaded()
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/not-hm/LimeForRoblox/main/library.lua'))()

local cloneref = cloneref or function(obj)
    return obj
end
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local userInputService = cloneref(game:GetService('UserInputService'))
local textService = cloneref(game:GetService('TextChatService'))
local playersService = cloneref(game:GetService('Players'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lighting = cloneref(game:GetService('Lighting'))

local lplr = playersService.lplr
local bd = loadstring(game:HttpGet('https://raw.githubusercontent.com/not-hm/LimeForRoblox/main/helper.lua'))()
bd.Constant = {
	Blocks = {
		Names = {'Blocks', 'WoodPlanksBlock', 'StoneBlock', 'IronBlock', 'BricksBlocks', 'DiamondBlock'},
		Types = {
			Blocks = 'Clay',
			WoodPlanksBlock = 'WoodPlanks',
			StoneBlock = 'Stone',
			IronBlock = 'Iron',
			BricksBlocks = 'Bricks',
			DiamondBlock = 'Diamond'
        }
	}
}

local Tabs = {
    Combat = Library:CreateWindow('Combat'),
    Exploit = Library:CreateWindow('Exploit')
    Move = Library:CreateWindow('Move')
    Player = Library:CreateWindow('Player')
    Visual = Library:CreateWindow('Visual')
    World = Library:CreateWindow('World')
}

local function IsAlive(v)
	return v and v.PrimaryPart and v:FindFirstChildOfClass('Humanoid') and v:FindFirstChildOfClass('Humanoid').Health > 0
end

local function CheckForWall(v)
	local Raycast = RaycastParams.new()
	Raycast.FilterType = Enum.RaycastFilterType.Exclude
	Raycast.FilterDescendantsInstances = {lplr.Character}
	local Direction = v.PrimaryPart.Position - lplr.Character.PrimaryPart.Position
	local Result = workspace:Raycast(lplr.Character.PrimaryPart.Position, Direction, Raycast)
	if Result and Result.Instance and not v:IsAncestorOf(Result.Instance) then
		return false
	end
	return true
end

local function GetNearestEntity(MaxDist, EntityCheck, EntitySort, EntityTeam, EntityWall, EntityDirection)
	local Entity
	local MinDist = math.huge
	for _, v in pairs(workspace:GetChildren()) do
		if v:IsA('Model') and v.Name ~= lplr.Name and IsAlive(v) then
			local IsEntity = false
			if not EntityCheck then
				if not EntityWall or CheckForWall(v) then
					IsEntity = true
				end
			else
				for _, plr in pairs(playersService:GetPlayers()) do
					if plr.Name == v.Name and (not EntityTeam or plr.TeamColor ~= lplr.TeamColor) then
						if not EntityWall or CheckForWall(v) then
							IsEntity = true
						end
					end
				end
			end
			if IsEntity then
				local Direction = (v.PrimaryPart.Position - lplr.Character.PrimaryPart.Position).Unit
				local Angle = math.deg(lplr.Character.PrimaryPart.CFrame.LookVector:Angle(Direction))
				if EntityDirection >= 360 or Angle <= EntityDirection / 2 then
					local Distance = (v.PrimaryPart.Position - lplr.Character.PrimaryPart.Position).Magnitude
					if EntitySort == 'Distance' and Distance <= MaxDist and (not MinDist or Distance < MinDist) then
						MinDist = Distance
						Entity = v
					elseif EntitySort == 'Furthest' and Distance <= MaxDist and (not MinDist or Distance > MinDist) then
						MinDist = Distance
						Entity = v
					elseif EntitySort == 'Health' and Distance <= MaxDist and v:FindFirstChild('Humanoid') and (not MinDist or v.Humanoid.Health < MinDist) then
						MinDist = v.Humanoid.Health
						Entity = v
					elseif EntitySort == 'Threat' and Distance <= MaxDist and v:FindFirstChild('Humanoid') and (not MinDist or v.Humanoid.Health > MinDist) then
						MinDist = v.Humanoid.Health
						Entity = v
					end
				end
			end
		end
	end
	return Entity
end

local function GetBed(MaxDist)
	local Bed
	local MinDist = math.huge
	for _, v in pairs(workspace:GetDescendants()) do
		if v.Parent:IsA('Model') and v.Parent.Name == 'Bed' and v.Name == 'Block' and v.Parent:GetAttribute('Team') ~= lplr.Team.Name then
			local Distance = (v.Position - lplr.Character.PrimaryPart.Position).Magnitude
			if Distance < MinDist and Distance <= MaxDist then
				MinDist = Distance
				Bed = v
			end
		end
	end
	return Bed
end

local function GetPosition(pos)
	return Vector3.new(math.floor((pos.X / 3) + 0.5) * 3,math.floor((pos.Y / 3) + 0.5) * 3,math.floor((pos.Z / 3) + 0.5) * 3)
end

local function IsAtPosition(pos)
	for _, v in pairs(workspace:WaitForChild('Map'):GetDescendants()) do
		if v:IsA('BasePart') and v.Name == 'Block' then
			if GetPosition(v.Position) == pos then
				return true
			end
		end
	end
	return false
end

local function GetBlocks()
	local Prioritized = {'Clay', 'Bricks', 'WoodPlanks', 'Stone', 'Iron', 'Diamond'}
	local Stored = {}
	for _, storage in ipairs({lplr.Backpack, lplr.Character}) do
		for _, block in ipairs(storage:GetChildren()) do
			if table.find(bd.Constant.Blocks.Names, block.Name) then
				local BlockType = bd.Constant.Blocks.Types[block.Name]
				if BlockType and not Stored[BlockType] then
					local Inventory = bd.Entity.LocalEntity.Inventory
					if Inventory and Inventory[block.Name] and Inventory[block.Name] > 0 then
						Stored[BlockType] = block
					end
				end
			end
		end
	end
	for _, v in ipairs(Prioritized) do
		if Stored[v] then
			return Stored[v], v
		end
	end
	return nil, nil
end

local function GetTool(toolname)
	for _, v in pairs(lplr.Backpack:GetChildren()) do
		if v:IsA('Tool') and v.Name:lower():match(toolname) then
			return v
		end
	end
end

local function CheckTool(toolname)
	for _, v in pairs(lplr.Character:GetChildren()) do
		if v:IsA('Tool') and v.Name:lower():match(toolname) then
			return v
		end
	end
end

local AntiBot
task.defer(function()
	AntiBot = Tabs.Combat:CreateToggle({
		Name = 'Anti Bot',
		Callback = function(callback)
		end
	})
end)