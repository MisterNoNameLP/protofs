--[[
	'bladi' is the main table wich should contain all data relevant for things happening here.
	it is accesable from everywhere in the system using 'global.bladi'.
]]
local bladi = {
	--dynamically loaded files.
	dyn = {}, 
}

--[[
	sets the default terminal prefix for all logging functions in this file.
	
	the 'nil, nil, 1' part is needed to work around an edge-case scenario caused by the initalisation process and not necessary usually.
]]
debug.setFuncPrefix("[BLADI]", nil, nil, 1)

function bladi.init()
	--set the logging prefix inside the 'bladi.init' function.
	debug.setFuncPrefix("[INIT]") 
	
	--do some logging
	debug.log("##### BLADI INIT START #####")
	
	--execute all files inside 'data/bladi/init' in specific order.
	debug.log("Execute init dir")
	global.dl.executeDir("data/bladi/init", "INIT_BLADI")
	
	--execute all files inside 'data/bladi/dyn' and puts the return values into the 'bladi.dyn' table.
	debug.log("Load dyn dir")
	global.dl.load({
		dir = "data/bladi/dyn",
		target = bladi.dyn,
		execute = true,
	})
	
	--dump the 'bladi.dyn' table
	do
		debug.log("Dumping 'bladi.dyn' table")
		
		--use the 'tostring' function from the UserfulThings library to convert the 'bladi.dyn' table into a human readable string.
		local serializedTable = ut.tostring(bladi.dyn)
		debug.log(serializedTable)
	end
	
	--some other logging functions
	debug.dlog("Some color highlighting")
	debug.warn("Some warning")
	debug.err("Something went wrong")
	debug.crucial("Something went very wrong")
	--debug.fatal("Okay lets just stop here") --stops the program.
	
	debug.log("##### BLADI INIT DONE #####")
end

function bladi.update(dt)
	debug.setFuncPrefix("[UPDATE]")
	
	--print when the 'B' key is pressed or released
	if input.keyPressed("b") then
		debug.log("B key just got pressed")
	elseif input.keyReleased("b") then
		debug.log("B key just got released")
	end
	
	--set pressure at cell 3 3 to '.1' as long as the 'V' key is pressed down.
	if input.keyDown("v") then
		global.fse.setPressure(3, 3, .1)
	end
end

function bladi.draw(dt)
	debug.setFuncPrefix("[UPDATE]")
	
end

return bladi