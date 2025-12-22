
execute at @s[tag=chk.table.legs] run setblock ~ ~ ~ air
execute at @s[tag=tac.sawmill]:
    scoreboard players add destroy-count tac.main 1
    setblock ~ ~-1 ~ minecraft:barrel replace

execute at @s[tag=chk.chair, tag=!chk.interaction]:
    scoreboard players add destroy-count tac.main 1
    kill @n[tag=chk.interaction,distance=..0.61]
    kill @s
    
execute at @s[tag=chk.table, tag=!chk.interaction]:
    scoreboard players add destroy-count tac.main 1
    kill @n[tag=chk.table.top,distance=..0.5]
    kill @n[tag=chk.interaction,distance=..0.5]
    kill @s

execute at @s[tag=chk.bench, tag=!chk.interaction]:
    scoreboard players add destroy-count tac.main 1
    kill @n[tag=chk.interaction,distance=..0.61]
    kill @s

execute at @s[tag=tac.sawmill]:
    setblock ~ ~-1 ~ minecraft:barrel replace
    scoreboard players add destroy-count tac.main 1

kill @s