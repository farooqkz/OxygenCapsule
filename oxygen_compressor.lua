--[[
Oxygen Capsule mod for Minetest
Copyright (C) 2017  Farooq Karimi Zadeh(FarooqKZ) <farooghkz@opmbx.org>

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
local slots = {"slot1", "slot2", "slot3", "slot4"}
local function init_oxygen_compressor(pos) 
    local meta = minetest.get_meta(pos)
    if meta:get_string("init") == "yes" then
        return -- If node was already initialized, do nothing
    end
    local inv = meta:get_inventory()
    meta:set_string("formspec",
    "size[8,7.5]"..
    "list[context;fuel;2,1;1,1]"..
    "list[context;capsules;5,.5;2,2]"..
    "list[current_player;main;0,3.5;8,4]"
    )
    meta:set_string("infotext", "Oxygen Compressor")
    for i, v in ipairs(slots) do
        meta:set_int(v, 0)
    end
    inv:set_size("main", 8*4)
    inv:set_size("capsules", 2*2)
    inv:set_size("fuel", 1*1)

    timer = minetest.get_node_timer(pos)
    if timer:is_started() then
        return
    end
    timer:start(1.0)

    meta:set_string("init", "yes")
    -- ^ we have initialized this node's timer and metadata
end
minetest.register_node("oxygencapsule:oxygen_compressor", {
    description = "Oxygen Comressorr", 
    tiles = {"oxygen_compressor.png"},
    groups = {cracky=2},
    is_ground_content = false,
    can_dig = function(pos)
        local mymeta = minetest.get_meta(pos)
        local myinv = mymeta:get_inventory()
        return myinv:is_empty("capsules") and myinv:is_empty("fuel")
    end,
    on_construct = function(pos)
        init_oxygen_compressor(pos)
    end,
    on_timer = function(pos, elapsed)
        local mymeta = minetest.get_meta(pos)
        local myinv = mymeta:get_inventory()
        local fuelstack = myinv:get_stack("fuel", 1) 

        if fuelstack:get_name() ~= "homedecor:oil_extract" then
            return true 
        end -- so it's not the fuel which we want

        for i, v in ipairs(slots) do 
            local capstack = myinv:get_stack("capsules", i)
            local stat = mymeta:get_int(v)
            local stackname = capstack:get_name()
            empty_cap = "oxygencapsule:small_capsule_empty"
            half_cap = "oxygencapsule:small_capsule_half"
            full_cap = "oxygencapsule:small_capsule_full"

            if stackname == empty_cap or stackname == half_cap and fuelstack:get_count() > 0 then
                if stat == 10 then
                    if stackname == empty_cap then
                        capstack:replace(half_cap)
                    else
                        capstack:replace(full_cap)
                    end
                    stat = 0
                else
                    stat = stat + 1
                end
                fuelstack:set_count(fuelstack:get_count() - 1)
            else
                stat = 0
            end
            myinv:set_stack("capsules", i, capstack)
            mymeta:set_int(v, stat)
        end
        myinv:set_stack("fuel", 1, fuelstack)
        return true
    end
})
