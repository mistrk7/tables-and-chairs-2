execute as @e[type=interaction,tag=table] at @s unless block ~ ~ ~ oak_trapdoor[half=top] run function tac:table/break_table/destroy
schedule function ~/ 8s