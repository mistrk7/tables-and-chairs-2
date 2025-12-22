# tac:x/replace : replaces all loaded T&C2 with vanilla equvalents (blocks and stairs)
scoreboard players set destroy-count tac.main 0
scoreboard players set #is-destroying tac.main 1

execute as @e[tag=tac] at @s run function ./zfunction/mdrn_replace
function ./zfunction/ztext_end

# tac:x/replace/nearest : replaces nearest T&C2 with vanilla equvalents (blocks and stairs)

function ~/nearest:
    execute as @n[tag=tac] at @s run function ./zfunction/mdrn_replace
    function ./zfunction/ztext_end