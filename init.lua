dofile(minetest.get_modpath("qt_mobs").."/api.lua")

minetest.register_node(":qt_dungeons:jackolantern", {
	description = "Jack'o'lantern",
	tiles = {"pumpkin_top.png", "pumpkin_bottom.png", "pumpkin_side.png",
		"pumpkin_side.png", "pumpkin_side.png", "pumpkin_jackolantern.png"},
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	light_source = LIGHT_MAX-1,
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=1,flammable=2},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'qt_dungeons:pumpkin_block'},
			},
			{
				items = {'default:torch'},
			}
		}
	},
	sounds = default.node_sound_wood_defaults(),
 on_place = function(itemstack, placer, pointed_thing)
   local stack = ItemStack("qt_dungeons:jackolantern")
   local pos = pointed_thing.under
   if
    minetest.get_node({x=pos.x,y=pos.y,z=pos.z}).name=="default:snowblock" and
    minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name=="default:snowblock"
   then
    minetest.remove_node({x=pos.x,y=pos.y,z=pos.z})
    minetest.remove_node({x=pos.x,y=pos.y-1,z=pos.z})
    local p = pointed_thing.above
    p.y = p.y+1
    minetest.env:add_entity({x=pos.x,y=pos.y-1,z=pos.z}, "dulsiexperience:snowjack")
   else
    local ret = minetest.item_place(stack, placer, pointed_thing)
    if ret==nil then
     return itemstack
    else
     return ItemStack("qt_dungeons:jackolantern "..itemstack:get_count()-(1-ret:get_count()))
    end
   end
  end,
})

qt_mobs:register_mob("dulsiexperience:snowjack", {
	type = "animal",
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 2, 0.4},
	textures = {"snowjack.png"},
	visual = "mesh",
	mesh = "snowman.x",
	visual_size = {x=6, y=6},
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 100,
	drops = {
		{name = "default:snow",
		chance = 1,
		min = 2,
		max = 3,},
		{name = "qt_mobs:soul",
		chance = 2,
		min = 1,
		max = 1,},
	},
	drawtype = "front",
	water_damage = 10,
	lava_damage = 50,
	light_damage = 0,
	animation = {
		speed_normal = 0,
		stand_start = 0,
		stand_end = 0,
		walk_start = 0,
		walk_end = 0,
	},
	view_range = 5,
	sounds = {
		--random = "sheep",
	},
	on_rightclick = nil,
})
