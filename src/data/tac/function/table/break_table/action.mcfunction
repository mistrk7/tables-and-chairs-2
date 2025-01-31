tag @s add table_break

data modify entity @s width set value 0.1
data modify entity @s height set value 0.1

# While tag is 'table break' check to see if the trapdoor was broken. If so, replace the item.
execute run function ./check:
    execute as @e[type=interaction,tag=table_break] at @s:

        execute if entity @n[type=minecraft:item, nbt={Item:{id:"minecraft:oak_trapdoor"}}, distance=0..0.8]:
            function ./destroy

        if entity @s[tag=table_break] run schedule function ./check 1t

# Count down until the table is expected to be broken
schedule function ./delay_end 2.5s replace:
    execute as @e[type=interaction,tag=table_break] at @s:
        tag @s remove table_break
        data modify entity @s width set value 1.001
        data modify entity @s height set value 0.1895