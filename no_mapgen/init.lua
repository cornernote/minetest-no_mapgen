--[[

No Mapgen for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-no_mapgen
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-no_mapgen/master/LICENSE

]]--

minetest.set_mapgen_params({mgname = "singlenode", flags = "nolight", water_level = -31000})

--[[
local mapgen_disabled = minetest.setting_getbool("mapgen_disabled")
local mapgen_flat = minetest.setting_getbool("mapgen_flat")

-- set mapgen to singlenode
if mapgen_disabled or mapgen_flat then
    minetest.register_on_mapgen_init(function(mgparams)
        minetest.set_mapgen_params({mgname="singlenode", water_level=-32000})
    end)
end

-- make the world flat
if mapgen_flat then

	-- generate flat
	minetest.register_on_generated(function(minp, maxp)
		if minp.y >= -40 and minp.y <= 40 then
			for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				minetest.env:add_node({x = x, y = 0, z = z}, {name="no_mapgen:bedrock"})
				minetest.env:add_node({x = x, y = 1, z = z}, {name="default:dirt_with_grass"})
			end
			end
		end
	end)
	
	-- bedrock
	minetest.register_node("no_mapgen:bedrock", {
		description = "Bedrock",
		tiles = {"default_cobble.png"},
		is_ground_content = true,
		groups = {unbreakable=1,not_in_creative_inventory=1},
	})

	-- don't let players go below y=0
	local bedrock_timer = 1
	minetest.register_globalstep(function(dtime)
		bedrock_timer = bedrock_timer - dtime
		if bedrock_timer > 0 then return end
		for k,player in ipairs(minetest.get_connected_players()) do
			bedrock_timer = 1
			local pos = player:getpos()
			if pos.y < 0 then
				-- teleport them back to y=3
				player:setpos({x=pos.x,y=3,z=pos.z})
				-- build some ground under them
				if minetest.env:get_node({x=pos.x,y=0,z=pos.z}).name == "air" then
					for x=-2,2 do
					for z=-2,2 do
						minetest.env:set_node({x=pos.x+x,y=0,z=pos.z+z}, {name="no_mapgen:bedrock"})
					end
					end
				end
			end
		end
	end)

end
]]--

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
