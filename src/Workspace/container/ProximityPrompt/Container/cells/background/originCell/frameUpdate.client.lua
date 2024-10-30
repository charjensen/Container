local currentFrame = script.Parent
local framePos = script.Parent.Parent.Parent.framePos
local event = script.Parent.Parent.Parent.Event

local function updateNextPos(input)

	framePos.Value = currentFrame

end

currentFrame.MouseMoved:Connect(updateNextPos)