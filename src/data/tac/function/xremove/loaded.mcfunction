execute as @e[type=item_display, tag=tac] at @s run function ./ff_replace
# MORE TODO. Everything needs to be logged in storage, and for every one removed, remove in ff_replace
# - Store the UUID as well as the location
# - For every selected to eliminate, remove itself from 'the list'.
# - The next area to search (area.mcfunciton) should be the a position linked to the next element in the list. 
# - The list should be composed like ["myuuid":[0,0,0],"myuuid":[0,0,0]]