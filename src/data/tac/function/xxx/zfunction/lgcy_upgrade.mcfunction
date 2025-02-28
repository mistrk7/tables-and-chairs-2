# Old Entities - executed for each.

# Legacy chair conversion
oldTypes = ['chk.chair.basic', 'chk.chair.simple', 'chk.chair.carved', 'chk.chair.fancy.1', 'chk.chair.throne']
newTypes = ['basic', 'neat', 'carved', 'refined', 'throne']

oldMats = ['chk.chair.acacia', 'chk.chair.bamboo', 'chk.chair.birch', 'chk.chair.cherry', 'chk.chair.crimson', 'chk.chair.dark_oak', 'chk.chair.jungle', 'chk.chair.mangrove', 'chk.chair.oak', 'chk.chair.pale_oak', 'chk.chair.spruce', 'chk.chair.warped']
newMats = ['acacia', 'bamboo', 'birch', 'cherry', 'crimson', 'dark_oak', 'jungle', 'mangrove', 'oak', 'pale_oak', 'spruce', 'warped']

execute if entity @s[tag=chk.chair, tag=!chk.interaction] at @s align xyz positioned ~.5 ~ ~.5:
    for x in range(len(oldTypes)):
        for y in range(len(oldMats)):
            execute if entity @s[tag=oldTypes[x], tag=oldMats[y]]:
                function tac:chair/summon_chair {mat: newMats[y], type: newTypes[x], facing: 0}
                data modify entity @n[type=item_display,tag=chair, distance=..1] Rotation set from entity @s Rotation

# Legacy bench conversion (temp)
execute if entity @s[tag=chk.bench, tag=!chk.interaction] at @s align xyz positioned ~.5 ~ ~.5:
    for x in range(len(oldTypes)):
        for y in range(len(oldMats)):
            execute if entity @s[tag=oldTypes[x], tag=oldMats[y]]:
                function tac:chair/summon_chair {mat: newMats[y], type: newTypes[x], facing: 0}
                data modify entity @n[type=item_display,tag=chair, distance=..1] Rotation set from entity @s Rotation

# Legacy sawmill conversion
execute at @s[tag=tac.sawmill] run setblock ~ ~-1 ~ minecraft:barrel replace

# Legacy table conversion

oldTypes = ['chk.table.basic.1', 'chk.table.basic.2', 'chk.table.carved.1', 'chk.table.carved.2']
newTypes = ['basic', 'basic', 'basic', 'basic']
# newTypes = ['basic', 'basic_pedestal', 'carved', 'carved_pedestal']

oldMats = ['chk.table.acacia', 'chk.table.bamboo', 'chk.table.birch', 'chk.table.cherry', 'chk.table.crimson', 'chk.table.dark_oak', 'chk.table.jungle', 'chk.table.mangrove', 'chk.table.oak', 'chk.table.pale_oak', 'chk.table.spruce', 'chk.table.warped']
newMats = ['acacia', 'bamboo', 'birch', 'cherry', 'crimson', 'dark_oak', 'jungle', 'mangrove', 'oak', 'pale_oak', 'spruce', 'warped']

execute if entity @s[tag=!chk.interaction, tag=chk.table.legs] at @s align xyz positioned ~.5 ~.5 ~.5:
    for x in range(len(oldTypes)):
        for y in range(len(oldMats)):
            execute if entity @s[tag=oldTypes[x], tag=oldMats[y]]:
                function tac:table/summon_table {mat: newMats[y], type: newTypes[x], state: 0}

kill @s