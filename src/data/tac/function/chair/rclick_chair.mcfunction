advancement revoke @s only tac:chair_rclick

execute run with entity @s:
    $execute positioned as @e[sort=nearest,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] run function tac:chair/rclick_chair/action
    function ~/action:
        # If not holding a carpet or shears, sit on the chair
        unless items entity @s weapon.mainhand #minecraft:wool_carpets unless items entity @s weapon.mainhand minecraft:shears run ride @s mount @n[tag=chair,distance=0..0.8,type=minecraft:item_display]

        # If holding a carpet, add the carpet overlay
        if items entity @s weapon.mainhand #minecraft:wool_carpets with entity @s SelectedItem:
            
            # Drop the carpet if the chair already has one
            $execute unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:[""]}}}} unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:["$(id)"]}}}} run function tac:chair/rclick_chair/action/drop_carpet
            function ~/drop_carpet:
                execute positioned as @s anchored feet run summon minecraft:item ^ ^ ^ {Tags:["temp"],Item:{id:"minecraft:gray_carpet",count:1},Motion:[0.0,0.2,0.0]}
                data modify entity @n[type=item,tag=temp] Item.id set from entity @n[type=item_display,tag=chair,distance=..0.61] item.components."minecraft:custom_model_data".strings[0]
                tag @n[type=item,tag=temp] remove temp
            
            # Set the carpet
            $execute unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:["$(id)"]}}}} run function tac:chair/rclick_chair/action/set_carpet
            function ~/set_carpet:
                data modify entity @n[type=minecraft:item_display,tag=chair,distance=..0.61] item.components."minecraft:custom_model_data".strings[0] set from entity @s SelectedItem.id
                playsound minecraft:block.wool.place block @a ~ ~ ~
                item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
            
        # If holding shears, drop the carpet
        unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:[""]}}}} if items entity @s weapon.mainhand minecraft:shears:
            playsound minecraft:entity.sheep.shear block @a ~ ~ ~
            item modify entity @s weapon.mainhand {"function":"minecraft:set_damage","damage":-0.005,"add":true,"conditions":[]}
            execute as @n[type=item_display,tag=chair,distance=..0.61] run function tac:chair/rclick_chair/action/drop_carpet
            data modify entity @n[type=item_display,tag=chair,distance=..0.61] item.components."minecraft:custom_model_data".strings[0] set value ""

    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction