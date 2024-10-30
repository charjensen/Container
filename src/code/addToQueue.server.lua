local ReplicatedStorage = game:GetService("ReplicatedStorage")
local cellData = require(script.Parent.owner.Value.ProximityPrompt.cellData)

local function addToQueue(player, obj)
	
	local item = cellData.createItem(obj)
	cellData.addToQueue(item)
	
end

ReplicatedStorage.containerEvents.addToQueue.OnServerEvent:Connect(addToQueue)