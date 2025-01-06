#variables: type, mat, facing

$summon minecraft:item_display ~ ~.6 ~ {Tags:["$(type)","$(mat)","chair","t&c","v0"], item:{id:"minecraft:jungle_trapdoor",components:{"minecraft:custom_model_data":{strings:["$(mat)_$(type)_chair"]}}},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,-0.1f,0.0f]}}
$summon minecraft:interaction ~ ~ ~ {response: True,Tags:["$(type)","$(mat)","chair","t&c","v0"], width: 0.75f, height: 1.2f}

#0=south, 90=west, 180=north 270=east
$rotate @n[type=minecraft:item_display,tag=chair] $(facing) 0

#/give @s minecraft:jungle_trapdoor[minecraft:custom_data={model:"chair",type:"basic",mat:"oak",tac:1b},minecraft:custom_model_data={strings:["oak_basic_chair"]}]