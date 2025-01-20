
tag @s add reverting
data modify storage tac:main convert.orig_playerGameType set from entity @s playerGameType
data modify storage tac:main convert.orig_pos_0 set from entity @s Pos[0]
data modify storage tac:main convert.orig_pos_1 set from entity @s Pos[1]
data modify storage tac:main convert.orig_pos_2 set from entity @s Pos[2]
data modify storage tac:main convert.orig_dimension set from entity @s Dimension
gamemode spectator

execute run function ~/teleport with storage tac:main convert:
	# Teleport to the next batch of tables and chairs, and wait for the chunks to load
	$execute in minecraft:$(search_dimension) run tp ~ ~ ~
	$say $(search_dimension)
	as @p[tag=reverting] at @s run tp @s @n[type=item_display, tag=tac]

	execute if entity @n[type=item_display, tag=tac] run say TP'd: waiting for chunks to load...
	execute unless entity @n[type=item_display, tag=tac] run say Cancelled-ish: No furniture detected
	execute unless entity @n[type=item_display, tag=tac] run function ./area/finish with storage tac:main convert
	execute unless entity @n[type=item_display, tag=tac] run data modify storage tac:main convert.search_dimension set value "overworld"


	schedule function ./area/delay-execute 4s replace:
		say b
		execute with storage tac:main convert:
			say c
			$execute in minecraft:$(search_dimension) as @p[tag=reverting] at @n[type=item_display, tag=tac] run function tac:xremove/area/execute