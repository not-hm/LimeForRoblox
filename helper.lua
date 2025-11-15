--[[
    Cheat-Engine (bad exec) helper

    Reports say rewrite is undetected
    by @._stav // sstvskids
]]

local cloneref = cloneref or function(obj)
    return obj
end
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local httpService = cloneref(game:GetService('HttpService'))
local sounds = {'rbxassetid://111007032707310', 'rbxassetid://81851569676153', 'rbxassetid://108304966836429'}

return {
    CombatService = {
        KnockBackApplied = replicatedStorage.Modules.Knit.Services.CombatService.RE:FindFirstChild('KnockBackApplied')
    },
    EffectsController = {
        PlaySound = function(pos)
            local Part = Instance.new('Part')
            Part.Size = Vector3.new(0.5, 0.5, 0.5)
            Part.CanCollide = false
            Part.CanTouch = false
            Part.CanQuery = false
            Part.Transparency = 1
            Part.Position = pos
            Part.Parent = workspace

            local Sound = Instance.new('Sound')
            Sound.SoundId = sounds[math.random(1, #sounds)]
            Sound.Parent = Part
            
            Sound:Play()
            Sound.Ended:Connect(function()
                Part:Destroy()
            end)
        end
    },
    MatchController = {
        EnterQueue = function(mode)
            return replicatedStorage.Modules.Knit.Services.MatchService.RF.EnterQueue:FireServer(mode)
        end
    },
    ServerData = {
        Submode = httpService:JSONDecode(replicatedStorage.Modules.ServerData.Cache.Value)
    },
    ToolService = {
        ToggleBlockSword = function(tog, tool)
            return replicatedStorage.Modules.Knit.Services.ToolService.RF.ToggleBlockSword:FireServer(tog, tool)
        end,
        AttackPlayerWithSword = function(character, crit, tool)
            return replicatedStorage.Modules.Knit.Services.ToolService.RF.AttackPlayerWithSword:FireServer(character, crit, tool, "'")
        end
    }
}