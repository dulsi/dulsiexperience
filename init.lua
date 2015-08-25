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
    minetest.env:add_entity({x=pos.x,y=pos.y-1,z=pos.z}, "qt_mobs:snowman")
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
