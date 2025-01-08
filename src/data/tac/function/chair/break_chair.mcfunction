advancement revoke @s only tac:chair_break
execute with entity @s:
    $execute as @n[tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:chair/break_chair/action
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack