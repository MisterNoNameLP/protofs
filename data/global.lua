local global = {}

function global.loadfile(path)
	local func, err = loadfile(path)
	if func == nil then
		print("Could not load file")
		error(err)
	end
	return func
end

return global