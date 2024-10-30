local cellsHeight = script.Parent.owner.Value.ProximityPrompt.Configuration:GetAttribute("height")
local cellsWidth = script.Parent.owner.Value.ProximityPrompt.Configuration:GetAttribute("width")
local cellData = require(script.Parent.owner.Value.ProximityPrompt.cellData)
local originPos = script.Parent.cells.background.originCell.Position

local function genCells()

	for i = 0, cellsWidth - 1, 1  do

		for j = 0, cellsHeight - 1, 1  do

			local cellCopy = script.Parent.cells.background.originCell:Clone()
			cellCopy.Name = "cell"
			cellCopy.Position = UDim2.new(originPos.X.Scale + i*(1/cellsWidth), originPos.X.Offset, originPos.Y.Scale + j*(1/cellsHeight), originPos.Y.Offset)
			cellCopy.x.Value = i
			cellCopy.y.Value = j
			cellCopy.Parent = script.Parent.cells.background

			cellData.change(i, j, 0)

		end

	end

	script.Parent.cells.background.originCell.Visible = false

end

genCells()