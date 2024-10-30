local PlayerService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local container = script.Parent
local cellData = require(script.Parent.cellData)
local cellArray = cellData.returnArray()
local activePlayers = {}
local changeQueue = {}

local function onPress(player)
	
	local playerGui = player.PlayerGui:FindFirstChild("Container")
	local containerGui = script.Parent.Container
	
	if playerGui == nil then
		
		local copyGui = containerGui:Clone()
		copyGui.Parent = player.PlayerGui
		copyGui.Enabled = true
		
	end
	
	player.Character.Humanoid.WalkSpeed = 0
	activePlayers[#activePlayers+1] = player
	
	if playerGui ~= nil and playerGui.Enabled == true then
		
		playerGui:Destroy()
		player.Character.Humanoid.WalkSpeed = 16
		table.remove(activePlayers, player)
		
	end
	
end

local function update()
	
	local queue = script.Parent.queue:GetChildren()
	local updateItem = table.remove(queue, queue[0])
	local containerItems = script.Parent.Container.cells.background.items
	
	--MAKE SURE TO CHECK FOR ID
	local needsUpdate = containerItems:FindFirstChild(updateItem.Name)
	needsUpdate.Position = updateItem.Position
	needsUpdate.PosX.Value = updateItem.PosX.Value
	needsUpdate.PosY.Value = updateItem.PosY.Value
	
	for index, player in ipairs(activePlayers) do
		
		local send = {
			updateItem.Name,
			updateItem.Position,
			updateItem.PosX.Value,
			updateItem.PosY.Value,
			updateItem.Id.Value
		}
		
		ReplicatedStorage.containerEvents.removeFromContainer:FireAllClients(send)
		
	end
	
end

container.Triggered:Connect(onPress)
script.Parent.queue.ChildAdded:Connect(update)