execute as @e[type=interaction,tag=table] at @s unless block ~ ~ ~ #minecraft:trapdoors[half=top] run function tac:table/break_table/destroy
schedule function ~/ 8s