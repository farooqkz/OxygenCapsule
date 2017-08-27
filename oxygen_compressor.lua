--[[
Oxygen Capsule mod for Minetest
Copyright (C) 2017  Faroogh Karimi Zadeh(FarooghKZ) <farooghkz@opmbx.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]
local is_power_source_connected = true -- TODO: use mesecons
local slots = {"slot1", "slot2", "slot3", "slot4"}
local function init_oxygen_compressor(pos) 
    local meta = minetest.get_meta(pos)
    if meta:get_string("init") == "yes" then
        return -- If node was already initialized, do nothing
    end
    local inv = meta:get_inventory()
    meta:set_string("formspec",
    "size[8,6]"..
    "list[context;capsules;2,0;4,1]"..
    "label[2,1;^ Empty or Half Capsules Here ^]]"..
    "list[current_player;main;0,2;8,4]"
    )
    meta:set_string("infotext", "Oxygen Compressor")
    for i, v in ipairs(slots) do
        meta:set_int(v, 0)
    end
    inv:set_size("main", 8*4)
    inv:set_size("capsules", 1*4)

    timer = minetest.get_node_timer(pos)
    if timer:is_started() then
        return
    end
    timer:start(1.0)

    meta:set_string("init", "yes")
    -- ^ we initialized this node's timer and metadata
end
minetest.register_node("oxygencapsule:oxygen_compressor", {
    description = "Oxygen Comressorr", 
    tiles = {"oxygen_compressor.png"},
    groups = {cracky=2},
    is_ground_content = false,
    can_dig = function(pos)
        local mymeta = minetest.get_meta(pos)
        local myinv = mymeta:get_inventory()
        return myinv:is_empty("capsules")
    end,
    on_construct = function(pos)
        init_oxygen_compressor(pos)
    end,
    on_timer = function(pos, elapsed)
        local mymeta = minetest.get_meta(pos)
        local myinv = mymeta:get_inventory()
        for i, v in ipairs(slots) do 
            local stack = myinv:get_stack("capsules", i)
            local stat = mymeta:get_int(v)
            local stackname = stack:get_name()
            if stackname == "oxygencapsule:small_capsule_empty" or stackname ==
                "oxygencapsule:small_capsule_half" then
                if stat == 10 then
                    if stackname == "oxygencapsule:small_capsule_empty" then
                        stack:replace("oxygencapsule:small_capsule_half")
                    else
                        stack:replace("oxygencapsule:small_capsule_full")
                    end
                    stat = 0
                else
                    stat = stat + 1
                end
            else
                stat = 0
            end
            myinv:set_stack("capsules", i, stack)
            mymeta:set_int(v, stat)
        end
        return true
    end
})
