#variables: type, mat, facing (0=south, 90=west, 180=north 270=east)

$summon minecraft:item_display ~ ~.6 ~ {Rotation:[$(facing).0f,0.0f],Tags:["$(type)","$(mat)","chair","tac_v0"], item:{id:"minecraft:armor_stand",components:{"minecraft:custom_model_data":{strings:["$(mat)_$(type)_chair"]}}},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,-0.1f,0.0f]}}
$summon minecraft:interaction ~ ~ ~ {response: True,Tags:["$(type)","$(mat)","chair","tac_v0"], width: 0.75f, height: 1.2f}



#/give @s minecraft:armor_stand[minecraft:max_stack_size=64,minecraft:entity_data={id:"armor_stand", Invisible:1b,Tags:["chair","tac"]},minecraft:custom_data={model:"chair",type:"basic",mat:"oak",tac:1b},minecraft:custom_model_data={strings:["oak_basic_chair"]}]


#/give @s minecraft:armor_stand[minecraft:entity_data={id:"armor_stand", Invisible:1b,Tags:["chair","tac"]},minecraft:custom_data={model:"chair",type:"basic",mat:"warped",tac:1b},minecraft:custom_model_data={strings:["warped_basic_chair"]}]