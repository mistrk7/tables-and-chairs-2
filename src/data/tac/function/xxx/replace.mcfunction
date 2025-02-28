# tac:x/replace : replaces all loaded T&C2 with vanilla equvalents (blocks and stairs)

execute as @e[tag=tac] run function ./zfunction/mdrn_replace

# tac:x/replace/nearest : replaces nearest T&C2 with vanilla equvalents (blocks and stairs)

function ~/nearest:
    execute as @n[tag=tac] run function ./zfunction/mdrn_replace