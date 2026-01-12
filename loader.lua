repeat task.wait() until game:IsLoaded()
if game.PlaceId == 11630038968 or game.PlaceId == 10810646982 or game.PlaceId == 139566161526375 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/refs/heads/main/bridge_duel.lua"))()
elseif game.PlaceId == 123941384302059 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/not-hm/LimeForRoblox/refs/heads/main/bridge_sky.lua"))()
else
	game:GetService("Chat"):Chat(game.Players.LocalPlayer.Character:WaitForChild("Head"), "I love eating AquaVClip feces")
end
