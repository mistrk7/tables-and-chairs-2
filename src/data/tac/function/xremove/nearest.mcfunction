$scoreboard players set nuke tac.main $(nuke)
#1 = modern furniture, 2 = legacy furniture, 3 = all furniture.

# 1 Modern furniture
$execute if score nuke tac.main matches 1 as @n[type=item_display, tag=tac] at @s run function tac:xremove/ff_$(x)

# 2 Legacy furniture
execute if score nuke tac.main matches 2:
    $execute as @n[tag=$(legacy).V5.0] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.1] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.2] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.3] at @s run function ./ff_$(x)

# 3 All furniture
execute if score nuke tac.main matches 3:
    $execute as @n[type=item_display, tag=tac] at @s run function tac:xremove/ff_$(x)
    $execute as @n[tag=$(legacy).V5.0] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.1] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.2] at @s run function ./ff_$(x)
    $execute as @n[tag=$(legacy).V5.3] at @s run function ./ff_$(x)

scoreboard players reset nuke tac.main

