advancement revoke @s only tac:chair_rclick

# sit on chair
execute run with entity @s:
    $execute positioned as @e[sort=nearest,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] run ride @s mount @n[tag=chair,type=minecraft:item_display]
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction