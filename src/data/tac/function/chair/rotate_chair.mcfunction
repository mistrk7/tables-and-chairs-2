advancement revoke @s only tac:chair_rotate

# locate and rotate chair
execute run with entity @s:
    $execute at @e[sort=nearest,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] as @n[type=item_display,tag=chair,distance=0..0.8,tag=!tucked-in] run playsound minecraft:item.brush.brushing.generic block @a ~ ~ ~ 0.7 1.2
    $execute at @e[sort=nearest,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] as @n[type=item_display,tag=chair,distance=0..0.8,tag=!tucked-in] run playsound minecraft:block.wood.hit block @a ~ ~ ~ 0.1 1.1
    $execute at @e[sort=nearest,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] as @n[type=item_display,tag=chair,distance=0..0.8,tag=!tucked-in] run execute at @s run rotate @s ~90 ~
    $data remove entity @n[tag=chair,sort=nearest,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction