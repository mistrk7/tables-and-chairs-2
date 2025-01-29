advancement revoke @s only tac:table_break

# Logic
execute with entity @s:
    $execute as @n[tag=table,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:table/break_table/action
    $data remove entity @e[limit=1,tag=table,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack 