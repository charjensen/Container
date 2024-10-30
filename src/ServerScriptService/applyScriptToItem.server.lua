local items = script.Parent.cells.background.items:GetChildren()

for index, item in ipairs(items) do
	
	if item:IsA("ImageLabel") then
		
		local scriptClone = script.Parent.itemScript:Clone()
		scriptClone.Parent = item
		
	end
	
end

script.Parent.itemScript.Enabled = false