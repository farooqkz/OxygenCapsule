--[[
Oxygen Capsule mod for Minetest
Copyright (C) 2017,2018 Farooq Karimi Zadeh <farooghkarimizadeh at gmail dot com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
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
