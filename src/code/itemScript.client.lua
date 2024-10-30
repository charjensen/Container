local PlayerServce = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local mouse = PlayerServce.LocalPlayer:GetMouse()

local button = script.Parent
local originalName = button.Name
local container = script.Parent.Parent.Parent.Parent.Parent
local origin = button.Position
local holding = button.Holding
local nextFramePos = button.Parent.Parent.Parent.framePos
local xAnchor = 1/button.SizeX.Value * (1/2)
local yAnchor = 1/button.SizeY.Value * (1/2)
button.AnchorPoint = Vector2.new(xAnchor, yAnchor)
local enabled = true

local containerEvent = game.ReplicatedStorage.containerEvents.removeFromContainer

local cellData = require(button.Parent.Parent.Parent.Parent.owner.Value.ProximityPrompt.cellData)
local cellArray = cellData.returnArray()
local cellArraySizeX = #cellArray
local cellArraySizeY = #cellArray[0]
local itemPos = cellData.addItem(button)

button.Id.Value = cellData.returnItemSize()
button.Name = button.Name .. tostring(button.Id.Value)
holding.Value = false

local function onPress(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 and enabled == true then
		
		enabled = false
		origin = button.Position
		cellData.empty(button)
		holding.Value = true
		enabled = true
		
	end

end

local function release(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 and enabled == true then
		
		enabled = false
		cellData.move(button, nextFramePos, origin, originalName)
		enabled = true
		
	end

end

local function update()

	if holding.Value == true then

		local position = Vector2.new(mouse.X-button.Parent.Parent.AbsolutePosition.X, mouse.Y-button.Parent.Parent.AbsolutePosition.Y)
		local size = Vector2.new(button.Parent.Parent.AbsoluteSize.X, button.Parent.Parent.AbsoluteSize.Y)
		local normalizedPosition = position / size

		button.Position = UDim2.new(normalizedPosition.X, 0, normalizedPosition.Y, 0)

	end

end

local function poop(obj)
	
	cellData.emptyArray()
	
	if script.Parent.Name == obj[1] and script.Parent.Id.Value == obj[5] and enabled == true then
		
		enabled = false
		script.Parent.Position = obj[2]
		script.Parent.PosX.Value = obj[3]
		script.Parent.PosY.Value = obj[4]
		origin = button.Position
		script.Parent.Name = script.Parent.Name .. tostring(script.Parent.Id.Value)
		enabled = true
		
	end
	
	cellData.fillArray(button.Parent:GetChildren())
	
end

mouse.Move:Connect(update)
button.InputBegan:Connect(onPress)
button.InputEnded:Connect(release)
containerEvent.OnClientEvent:Connect(poop)