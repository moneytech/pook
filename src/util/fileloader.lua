-- all hotswapped dependencies go here
if not firstLoadComplete or KeyPressed("r") then
	ObjLoader = dofile("src/util/parser.lua")
	v3 = dofile("src/util/vector.lua")
	dofile("src/core/tick.lua")
	dofile("src/util/input.lua")
	dofile("src/util/cam.lua")
	dofile("src/util/graphics.lua")
	dofile("src/util/pooler.lua")
	dofile("src/entities/cow.lua")
	dofile("src/entities/platform.lua")
	firstLoadComplete = true
end