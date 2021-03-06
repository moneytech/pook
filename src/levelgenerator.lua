DIRECTIONS = {
	v3(0, 0, 1),  --^
	v3(-1, 0, 0), --<
	v3(1, 0, 0),  -->
	v3(0, 0, -1)  --v
}

SIGNS = { -1, 1 }

local function RandomPlatformOffset()
	return math.random(4, 5)
end

local function CheckCollision(xMin1, xMax1, zMin1, zMax1, xMin2, xMax2, zMin2, zMax2)
	return xMin1 < xMax2 and xMax1 > xMin2 and zMin1 < zMax2 and zMax1 > zMin2
end

local function ConfigurePlatform( platform)
	local success = false
	while not success do
		dir = DIRECTIONS[math.random(1, 4)]
		local prev = platforms[math.random(1, #platforms)]
		local newScale = v3(math.random(3, 6), math.random(2, 5), math.random(3, 6))
		local newPos = v3(prev.p.x + (prev.s.x + newScale.x + RandomPlatformOffset()) * dir.x,
				prev.p.y + (prev.s.y + newScale.y + RandomPlatformOffset()) * SIGNS[math.random(1, 2)],
				prev.p.z + (prev.s.z + newScale.z + RandomPlatformOffset()) * dir.z
		)

		local hasCollision
		for i, v in pairs(platforms) do
			if CheckCollision(newPos.x - newScale.x, newPos.x + newScale.x, newPos.z - newScale.z, newPos.z + newScale.z,
				v.p.x - v.s.x, v.p.x + v.s.x, v.p.z - v.s.z, v.p.z + v.s.z) then
				hasCollision = true
				break
			end
		end

		if not hasCollision then
			platform:Init(newPos.x, newPos.y, newPos.z, newScale.x, newScale.y, newScale.z)
			success = true
			if newPos.x - newScale.x < levelMinX then levelMinX = newPos.x - newScale.x end
			if newPos.x + newScale.x > levelMaxX then levelMaxX = newPos.x + newScale.x end
			if newPos.z - newScale.z < levelMinZ then levelMinZ = newPos.z - newScale.z end
			if newPos.z + newScale.z > levelMaxZ then levelMaxZ = newPos.z + newScale.z end
		end
	end

end

function GenerateLevel(numPlatforms)
	local initialPlatform = platformPool:get()
	initialPlatform:Init(0, -2, 0, 5, 5, 5)
	levelMinX = -5
	levelMaxX = 5
	levelMinZ = -5
	levelMaxZ = 5

	for i = 1, numPlatforms - 1 do
		ConfigurePlatform(platformPool:get())
	end

	local midPlat = platforms[math.floor(#platforms/2)];
	midPlat.p.y = midPlat.p.y + 15
	player.p = v3(midPlat.p.x, midPlat.p.y + midPlat.s.y + 5, midPlat.p.z)

	for i, v in pairs(platforms) do
		v:AddCollider()
	end
end