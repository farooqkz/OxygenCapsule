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
    output = "oxygencapsule:oxygen_compressor",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "oxygencapsule:small_capsule_empty", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}

    }
})
