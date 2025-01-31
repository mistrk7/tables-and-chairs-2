# Replace item
data modify entity @n[type=minecraft:item, nbt={Item:{id:"minecraft:oak_trapdoor"}}, distance=0..0.8] Item set from entity @n[type=minecraft:item_display, distance=0..0.8] item

# Destroy the table
kill @n[type=item_display,tag=table,distance=0..0.4]
kill @s