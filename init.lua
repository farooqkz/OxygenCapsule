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

dofile(minetest.get_modpath("oxygencapsule") .. "/oxygen_compressor.lua")
dofile(minetest.get_modpath("oxygencapsule") .. "/crafting.lua")
minetest.register_craftitem("oxygencapsule:small_capsule_full", {
    description = "Oxygen Capsule(full)",
    inventory_image = "oxygencapsule_small.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        if user:get_breath() < 10 then
            user:set_breath(user:get_breath() + 5)
            itemstack:replace("oxygencapsule:small_capsule_half")
            return itemstack
        end
    end
})
minetest.register_craftitem("oxygencapsule:small_capsule_half", {
    description = "Oxygen Capsule(half)",
    inventory_image = "oxygencapsule_small.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        if user:get_breath() < 10 then
            user:set_breath(user:get_breath() + 5)
            itemstack:replace("oxygencapsule:small_capsule_empty")
            return itemstack
        end

    end
})
minetest.register_craftitem("oxygencapsule:small_capsule_empty", {
    description = "Oxygen Capsule(empty)",
    inventory_image = "oxygencapsule_small.png",
    stack_max = 1
})

