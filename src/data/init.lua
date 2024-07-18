print("main init")

_G.package.path = "./data/libs/?.lua;" .. _G.package.path
_G.package.cpath = "./data/libs/?.lua;" .. _G.package.cpath

_G.global = loadfile("data/global.lua")()

local loadfile = global.loadfile
global.debug = require("luadebug").init()
local dl = require("luadataloading")
global.dl = dl

--debug stuff
_G.protofs = {}
_G.protofs.debugInfo = {}
_G.protofs.debugInfo.cellCount = 0

--===== init =====--
local function initFiles() --ToDo: abstract
	global.justInitialized = true
	
	global.ut = loadfile("data/libs/UT.lua")()
	_G.ut = global.ut
	global.conf = loadfile("data/gameConf.lua")()
	global.input = loadfile("data/engine/input.lua")()
	_G.input = global.input
	global.Vector = loadfile("data/engine/classes/Vector.lua")()
	
	global.fse = loadfile("data/engine/fse.lua")()
	global.fse.init(10, 10)
	
	global.main = loadfile("data/engine/main.lua")()
	global.main.init(fse, renderer)
	
	global.renderer = loadfile("data/engine/renderer.lua")()
	global.renderer.init()
	
	global.game = loadfile("data/game/game.lua")()
	global.game.init()
	
	global.bladi = loadfile("data/bladi/bladi.lua")()
	global.bladi.init()
end
initFiles()

debug.log("main init done")