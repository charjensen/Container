local cellData = {}

cellArray = {}
items = {}
cellWidth = script.Parent.Configuration:GetAttribute("width")
cellHeight = script.Parent.Configuration:GetAttribute("height")
ReplicatedStorage = game:GetService("ReplicatedStorage")

addToQueue = ReplicatedStorage.containerEvents.addToQueue

for i = 0, cellWidth - 1, 1 do

	cellArray[i] = {}

	for j = 0, cellHeight - 1, 1 do

		cellArray[i][j] = 0

	end

end

function cellData.fill(button)

	local x = button.PosX.Value
	local y = button.PosY.Value
	local endPosX = x + button.SizeX.Value - 1
	local endPosY = y + button.SizeY.Value - 1

	for i = x, endPosX, 1 do

		for j = y, endPosY, 1 do

			cellArray[i][j] = 1

		end

	end

end

function cellData.fillArray(items)
	
	for index, item in ipairs(items) do

		cellData.fill(item)

	end
	
end

function cellData.empty(button)

	local prevX = button.PosX.Value
	local prevY = button.PosY.Value
	local endPosX = prevX + button.SizeX.Value - 1
	local endPosY = prevY + button.SizeY.Value - 1

	for i = prevX, endPosX, 1 do

		for j = prevY, endPosY, 1 do

			cellArray[i][j] = 0

		end

	end

end

function cellData.emptyArray()

	for i = 0, cellWidth - 1, 1 do

		for j = 0, cellHeight - 1, 1 do

			cellArray[i][j] = 0

		end

	end

end

function cellData.moveBack(button, origin)

	--cellData.empty(button)
	button.Holding.Value = false
	button.Position = origin

end

function cellData.isValidSpot(button, nextFramePos, origin)
	
	local notValid = true

	local endPosI = nextFramePos.Value.x.Value + (button.SizeX.Value - 1)
	local endPosJ = nextFramePos.Value.y.Value + (button.SizeY.Value - 1)
	
	if (endPosI > cellWidth - 1 or endPosJ > cellHeight - 1) then
		
		cellData.moveBack(button, origin)
		--cellData.fill(button)
		return false

	end

	for i = nextFramePos.Value.x.Value, endPosI, 1 do

		for j = nextFramePos.Value.y.Value, endPosJ, 1 do

			if (cellArray[i][j] == 1) then 

				cellData.moveBack(button, origin)
				--cellData.fill(button)
				notValid = false
				break

			end

		end

	end

	--lol
	return notValid

end

function cellData.move(button, nextFramePos, origin, ogName)
	
	if cellData.isValidSpot(button, nextFramePos, origin) then

		button.Holding.Value = false

		local nextPos = nextFramePos.Value.Position
		local nextX = nextFramePos.Value.x.Value
		local nextY = nextFramePos.Value.y.Value

		button.Position = nextPos
		button.PosX.Value = nextX
		button.PosY.Value = nextY
		origin = button.Position

		local buttonName = ogName
		local buttonId = button.Id.Value
		local buttonPosX = button.PosX.Value
		local buttonPosY = button.PosY.Value
		local buttonPositionX = button.Position.X.Scale
		local buttonPositionY = button.Position.Y.Scale

		local send = {
			buttonName,
			buttonId,
			buttonPosX,
			buttonPosY,
			buttonPositionX,
			buttonPositionY,
		}

		addToQueue:FireServer(send)

	end
	
end

function cellData.change(l, w, obj)

	cellArray[l][w] = obj

end

function cellData.createItem(button)
	
	local buttonToSend = ReplicatedStorage.items:FindFirstChild(button[1])
	local copy = buttonToSend:Clone()
	
	copy.Id.Value = button[2]
	copy.PosX.Value = button[3]
	copy.PosY.Value = button[4]
	copy.Position = UDim2.new(button[5], 0, button[6], 0)
	
	return copy
	
end

function cellData.addItem(item)
	
	table.insert(items, item)
	
end

function cellData.addToQueue(item)

	item.Parent = script.Parent.queue

end

function cellData.returnItemSize()

	return #items

end

function cellData.printArray()
	
	for i = 0, #cellArray, 1 do
		
		for j = 0, #cellArray[0], 1 do

			print(cellArray[i][j])

		end
		
	end
	
end

function cellData.returnArray()

	return cellArray

end

return cellData
