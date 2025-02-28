
execute at @s[tag=chk.table.legs] run setblock ~ ~ ~ air
execute at @s[tag=tac.sawmill] run setblock ~ ~-1 ~ minecraft:barrel replace

execute at @s[tag=chk.chair, tag=!chk.interaction]:
    kill @n[tag=chk.interaction,distance=..0.61]
    kill @s
    
execute at @s[tag=chk.table, tag=!chk.interaction]:
    kill @n[tag=chk.table.top,distance=..0.5]
    kill @n[tag=chk.interaction,distance=..0.5]
    kill @s

kill @s