--[[

No Mapgen for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-no_mapgen
License: GPLv3

]]--


-- alias mapgen_* to air
if minetest.setting_getbool("mapgen_disabled") then
	minetest.register_alias("mapgen_air", "air")
	minetest.register_alias("mapgen_stone", "air")
	minetest.register_alias("mapgen_tree", "air")
	minetest.register_alias("mapgen_leaves", "air")
	minetest.register_alias("mapgen_apple", "air")
	minetest.register_alias("mapgen_water_source", "air")
	minetest.register_alias("mapgen_dirt", "air")
	minetest.register_alias("mapgen_sand", "air")
	minetest.register_alias("mapgen_gravel", "air")
	minetest.register_alias("mapgen_clay", "air")
	minetest.register_alias("mapgen_lava_source", "air")
	minetest.register_alias("mapgen_cobble", "air")
	minetest.register_alias("mapgen_mossycobble", "air")
	minetest.register_alias("mapgen_dirt_with_grass", "air")
	minetest.register_alias("mapgen_junglegrass", "air")
	minetest.register_alias("mapgen_stone_with_coal", "air")
	minetest.register_alias("mapgen_stone_with_iron", "air")
	minetest.register_alias("mapgen_mese", "air")
	minetest.register_alias("mapgen_desert_sand", "air")
	minetest.register_alias("mapgen_desert_stone", "air")
	minetest.register_alias("mapgen_papyrus", "air")
	minetest.register_alias("mapgen_cactus", "air")
	minetest.register_alias("mapgen_torch", "air")
	minetest.register_alias("mapgen_nyancat", "air")
	minetest.register_alias("mapgen_nyancat_rainbow", "air")
end

-- after generated, make the world flat
if minetest.setting_getbool("mapgen_flat") then
	minetest.register_on_generated(function(minp, maxp)
		for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
		for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local p = {x = x, y = y, z = z}
      -- set middle node to dirt_with_grass
			if y == 0 then
				minetest.env:add_node(p, {name="default:default:dirt_with_grass"})
			end
      -- set bottom nodes to stone
			if y < 0 then
				minetest.env:add_node(p, {name="default:stone"})
			end
      -- if mapgen is enabled, remove top nodes
			if not minetest.setting_getbool("mapgen_disabled") then
				if y > 0 then
					minetest.env:remove_node(p)
				end
			end
		end
		end
		end
	end)
	
end


-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))