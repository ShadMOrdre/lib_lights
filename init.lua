
lib_lights = {}

local _lib_lights = {}



function lib_lights.register_nodes(node_name, node_desc, node_texture, node_craft_mat, node_sounds)

--CONNECTED LINKS

	lib_lights.register_chandelier_01(node_name .. "_chandelier_01", node_desc .. "chandelier_01", node_texture, node_craft_mat, node_sounds)
	lib_lights.register_lamp_01(node_name .. "_lamp_01", node_desc .. "lamp_01", node_texture, node_craft_mat, node_sounds)
	lib_lights.register_lamp_02(node_name .. "_lamp_02", node_desc .. "lamp_02", node_texture, node_craft_mat, node_sounds)
	lib_lights.register_lamp_bulb(node_name .. "_lamp_bulb", node_desc .. "lamp_bulb", node_texture, node_craft_mat, node_sounds)
	lib_lights.register_lamp_simple_01(node_name .. "_lamp_simple_01", node_desc .. "lamp_simple_01", node_texture, node_craft_mat, node_sounds)
	lib_lights.register_overhead_01(node_name .. "_overhead_01", node_desc .. "overhead_01", node_texture, node_craft_mat, node_sounds)


	
end


lib_lights.register_chandelier_01 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			wall_texture,
			wall_texture,
			"(overlay_alpha_light_chandelier_frame.png^" .. wall_texture .. "^overlay_alpha_light_chandelier_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_chandelier_bulb.png^lamp_2.png^overlay_alpha_light_chandelier_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_chandelier_frame.png^" .. wall_texture .. "^overlay_alpha_light_chandelier_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_chandelier_bulb.png^lamp_2.png^overlay_alpha_light_chandelier_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_chandelier_frame.png^" .. wall_texture .. "^overlay_alpha_light_chandelier_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_chandelier_bulb.png^lamp_2.png^overlay_alpha_light_chandelier_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_chandelier_frame.png^" .. wall_texture .. "^overlay_alpha_light_chandelier_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_chandelier_bulb.png^lamp_2.png^overlay_alpha_light_chandelier_bulb.png^[makealpha:255,126,126)",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
				{-0.375, -0.25, -0.5, 0.375, -0.125, -0.375}, -- NodeBox2
				{-0.375, -0.25, 0.375, 0.375, -0.125, 0.5}, -- NodeBox3
				{-0.5, -0.25, -0.375, -0.375, -0.125, 0.375}, -- NodeBox4
				{0.375, -0.25, -0.375, 0.5, -0.125, 0.375}, -- NodeBox5
				{-0.4375, -0.3125, -0.4375, -0.375, 0.0, -0.375}, -- NodeBox6
				{-0.4375, -0.3125, 0.375, -0.375, 0.0, 0.4375}, -- NodeBox7
				{0.375, -0.3125, 0.375, 0.4375, 0.0, 0.4375}, -- NodeBox8
				{0.375, -0.3125, -0.4375, 0.4375, 0.0, -0.375}, -- NodeBox9
				{-0.25, -0.3125, -0.25, -0.1875, 0.0, -0.1875}, -- NodeBox11
				{-0.25, -0.3125, 0.1875, -0.1875, 0.0, 0.25}, -- NodeBox12
				{0.1875, -0.3125, -0.25, 0.25, 0.0, -0.1875}, -- NodeBox10
				{0.1875, -0.3125, 0.1875, 0.25, 0.0, 0.25}, -- NodeBox13
				{-0.0625, -0.25, -0.375, 0.0625, -0.125, 0.375}, -- NodeBox14
				{-0.375, -0.25, -0.0625, 0.375, -0.125, 0.0625}, -- NodeBox15
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ '', wall_mat, '' },
			{ 'default:glass', wall_mat, 'default:glass'},
			{ wall_mat, wall_mat, wall_mat},
		}
	})

end
lib_lights.register_lamp_01 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			wall_texture,
			wall_texture,
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.125, 0.25, 0.125}, -- BASE
				{-0.25, -0.5, -0.25, 0.25, -0.125, 0.25}, -- BOTTOM
				{-0.25, -0.125, 0.1875, -0.1875, 0.3125, 0.25}, -- REARLEFT
				{0.1875, -0.125, 0.1875, 0.25, 0.3125, 0.25}, -- REARRIGHT
				{-0.25, 0.3125, -0.25, 0.25, 0.375, 0.25}, -- TOP
				{-0.25, -0.125, -0.25, -0.1875, 0.3125, -0.1875}, -- FRONTLEFT
				{0.1875, -0.125, -0.25, 0.25, 0.3125, -0.1875}, -- FRONTRIGHT
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ wall_mat, wall_mat, wall_mat },
			{ wall_mat, 'default:glass', wall_mat},
			{ wall_mat, wall_mat, wall_mat},
		}
	})

end
lib_lights.register_lamp_02 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			wall_texture,
			wall_texture,
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.0625, 0.125},
				{-0.3125, 0.0625, -0.3125, 0.3125, 0.25, 0.3125},
				{-0.25, 0.25, -0.25, 0.25, 0.3125, 0.25},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ wall_mat, wall_mat, wall_mat },
			{ '', 'default:glass', ''},
			{ '', wall_mat, ''},
		}
	})

end
lib_lights.register_lamp_bulb = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		connects_to = { "group:wall", "group:stone", "group:lib_architecture" },
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "connected",
			fixed = {
				{-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
			},
			connect_front = {
				{-0.0625, -0.0625, -0.5, 0.0625, 0.0625, -0.125},
			},
			connect_back = {
				{-0.0625, -0.0625, 0.125, 0.0625, 0.0625, 0.5},
			},
			connect_left = {
				{-0.5, -0.0625, -0.0625, -0.125, 0.0625, 0.0625},
			},
			connect_right = {
				{0.125, -0.0625, -0.0625, 0.5, 0.0625, 0.0625},
			},
			connect_bottom = {
				{-0.0625, -0.5, -0.0625, 0.0625, -0.125, 0.0625},
			},
			connect_top = {
				{-0.0625, 0.125, -0.0625, 0.0625, 0.5, 0.0625},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ '', wall_mat, '' },
			{ wall_mat, 'default:glass', wall_mat},
			{ '', wall_mat, ''},
		}
	})

end
lib_lights.register_lamp_simple_01= function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
			"(overlay_alpha_light_lamp_frame.png^" .. wall_texture .. "^overlay_alpha_light_lamp_frame.png^[makealpha:255,126,126)^(overlay_alpha_light_lamp_bulb.png^lamp_2.png^overlay_alpha_light_lamp_bulb.png^[makealpha:255,126,126)",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1 },
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125},
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ '', '', '' },
			{ '', 'default:glass', ''},
			{ '', wall_mat, ''},
		}
	})

end
lib_lights.register_overhead_01 = function(wall_name, wall_desc, wall_texture, wall_mat, wall_sounds)
	-- inventory node, and pole-type wall start item
	minetest.register_node("lib_lights:" .. wall_name, {
		description = wall_desc,
		drawtype = "nodebox",
		tiles = {
			wall_texture,
			"default_cloud.png",
			wall_texture,
			wall_texture,
			wall_texture,
			wall_texture,
		},
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = 14,
		is_ground_content = false,
		walkable = true,
		groups = { cracky = 3, wall = 1, stone = 2, lib_lights = 1},
		sounds = wall_sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.500000,0.250000,-0.250000,0.500000,0.407216,0.250000},
				{-0.500000,0.312500,-0.062500,0.500000,0.500000,0.062500}, 
			},
		},

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- crafting recipe
	minetest.register_craft({
		output = "lib_lights:" .. wall_name .. " 99",
		recipe = {
			{ wall_mat, wall_mat, wall_mat },
			{ 'default:glass', 'default:glass', 'default:glass'},
			{ '', '', ''},
		}
	})

end



--[[

lib_lights.register_nodes("cobble", "Cobblestone ", "default_cobble.png",
		"default:cobble", default.node_sound_stone_defaults())
lib_lights.register_nodes("mossycobble", "Mossy Cobblestone ", "default_mossycobble.png",
		"default:mossycobble", default.node_sound_stone_defaults())
lib_lights.register_nodes("desertcobble", "Desert Cobblestone ", "default_desert_cobble.png",
		"default:desert_cobble", default.node_sound_stone_defaults())

--]]


lib_lights.register_nodes("sandstone", "Sandstone ", "default_sandstone.png",
		"default:sandstone", default.node_sound_stone_defaults())
lib_lights.register_nodes("desert_stone", "Desert Stone ", "default_desert_stone.png",
		"default:desert_stone", default.node_sound_stone_defaults())
lib_lights.register_nodes("stone", "Stone ", "default_stone.png",
		"default:stone", default.node_sound_stone_defaults())
lib_lights.register_nodes("obsidian", "Obsidian ", "default_obsidian.png",
		"default:obsidian", default.node_sound_stone_defaults())

		
--[[
		
lib_lights.register_nodes("sandstone_block", "Sandstone Block ", "default_sandstone_block.png",
		"default:sandstone_block", default.node_sound_stone_defaults())
lib_lights.register_nodes("desert_stone_block", "Desert Stone Block ", "default_desert_stone_block.png",
		"default:desert_stone_block", default.node_sound_stone_defaults())
lib_lights.register_nodes("stone_block", "Stone Block ", "default_stone_block.png",
		"default:stone_block", default.node_sound_stone_defaults())
lib_lights.register_nodes("obsidian_block", "Obsidian Block ", "default_obsidian_block.png",
		"default:obsidian_block", default.node_sound_stone_defaults())

lib_lights.register_nodes("sandstone_brick", "Sandstone Brick ", "default_sandstone_brick.png",
		"default:sandstonebrick", default.node_sound_stone_defaults())
lib_lights.register_nodes("desertstone_brick", "Desert Stone Brick ", "default_desert_stone_brick.png",
		"default:desert_stonebrick", default.node_sound_stone_defaults())
lib_lights.register_nodes("stone_brick", "Stone Brick ", "default_stone_brick.png",
		"default:stonebrick", default.node_sound_stone_defaults())
lib_lights.register_nodes("obsidian_brick", "Obsidian Brick ", "default_obsidian_brick.png",
		"default:obsidianbrick", default.node_sound_stone_defaults())

--]]
		
		
--[[
--lib_lights.register_nodes("glass", "Glass ", "default_glass.png", "default:glass", default.node_sound_stone_defaults())

lib_lights.register_nodes("tree", "Tree ", "default_tree.png", "default:tree", default.node_sound_stone_defaults())

lib_lights.register_nodes("wood", "Wood ", "default_wood.png", "default:wood", default.node_sound_stone_defaults())

lib_lights.register_nodes("jungletree", "Jungle Tree ", "default_jungletree.png", "default:jungletree", default.node_sound_stone_defaults())

lib_lights.register_nodes("junglewood", "Jungle Wood ", "default_junglewood.png", "default:junglewood", default.node_sound_stone_defaults())

lib_lights.register_nodes("acacia_tree", "Acacia Tree ", "default_acacia_tree.png", "default:acacia_tree", default.node_sound_stone_defaults())

lib_lights.register_nodes("acacia_wood", "Acacia Wood ", "default_acacia_wood.png", "default:acacia_wood", default.node_sound_stone_defaults())
--]]

lib_lights.register_nodes("steelblock", "Steel ", "default_steel_block.png",
		"default:steelblock", default.node_sound_metal_defaults())
lib_lights.register_nodes("copperblock", "Copper ", "default_copper_block.png",
		"default:copperblock", default.node_sound_metal_defaults())
lib_lights.register_nodes("tinblock", "Tin ", "default_tin_block.png",
		"default:tinblock", default.node_sound_metal_defaults())
lib_lights.register_nodes("bronzeblock", "Bronze ", "default_bronze_block.png",
		"default:bronzeblock", default.node_sound_metal_defaults())
lib_lights.register_nodes("goldblock", "Gold ", "default_gold_block.png",
		"default:goldblock", default.node_sound_stone_defaults())
lib_lights.register_nodes("diamondblock", "Diamond ", "default_diamond_block.png",
		"default:diamondblock", default.node_sound_stone_defaults())

lib_lights.register_nodes("glass", "Glass ", "default_glass.png",
		"default:glass", default.node_sound_stone_defaults())






