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
-- ]]
minetest.register_craft({
    output = "oxygencapsule:small_capsule_empty",
    recipe = {
        {"", "default:steel_ingot", ""},
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"", "default:steel_ingot", ""}

    }
})
minetest.register_craft({
    output = "oxygencapsule:capsule_filler",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "oxygencapsule:small_capsule_empty", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}

    }
})
