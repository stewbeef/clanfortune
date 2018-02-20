# clanfortune
KOLmafia Clanfortune Script
Edit: Fixed a bug!  Added new feature to quickly set defaults

Ok, I've uploaded my script for this you can download it in Kolmafia with the CLI command:

svn checkout https://github.com/stewbeef/clanfortune/branches/release
(um, remove the link bit that the chat added in though)
(if you installed this when there was a bug, you'll need to remove it with svn delete clanfortune)

clanfortune help
displays the following info below.  It's pretty basic.  There are other commands and things not listed.  Let me know if you have any questions.
For example
clanfortune defaults,1st contact,AverageChat
will make it so that the first contact it connects to is the AverageChat bot.
And I just realized I'll need to edit this later to the name for answers and responses.
And the other stuff we're using as defaults can be set with:
defaults,1st response,beer
defaults,2nd response,robin
defaults,3rd response,thin
defaults,1st answer,pizza
defaults,2nd answer,batman
defaults,3rd answer,thick

help info:
command in form npc|clan,name|id|choice,food,name,word
Basically, for npc options: npc,name|choice,food,name,word
for clan member options: clan,id,food,name,word
...or: clan,name,food,name,word

For npc options, the following can be entered:
For NPC gorgonzola name/choice = gorgonzola, gorgonzola, the chief chef (npc), mp, myst, mysticality, the chief chef
Results in Everybody Calls Him Gorgon: +100% myst, +50% MP, +5 myst stats/fight
For NPC gunther name/choice = gunther, gunther, lord of the smackdown (npc), hp, lord of the smackdown, mus, muscle
Results in Gunther Than Thou: +100% mus, +50% HP, +5 mus stats/fight
For NPC hangk name/choice = booze, food, hangk, hangk (npc), item
Results in There's No N In Love: +50% food drops, +50% booze drops, +50% item drops
For NPC meatsmith name/choice = gear, meat, meatsmith, meatsmith (npc), the meatsmith, the meatsmith (npc)
Results in Meet The Meat: +50% gear drops, +100% meat drops
For NPC shifty name/choice = init, initiative, mox, moxie, shifty, shifty, the thief chief (npc), the hief chief 
Results in They Call Me Shifty: +100% mox, +50% combat init, +5 mox stats/fight
For NPC susie name/choice = arena master, familiar, susie, susie, the arena master, susie, the arena master (npc)
Results in A Girl Named Sue: +5 familiar weight, +10 familiar damage, +5 familiar xp/fight

Making default choices:
defaults,1st contact,name -- saves name as first contact when sending requests
defaults,2nd contact,name -- saves name as second contact when sending requests
defaults,3rd contact,name -- saves name as third contact when sending requests
defaults,1st response,name -- saves name as first answer when when responding to requests
defaults,2nd response,name -- saves name as second answer when when responding to requests
defaults,3rd response,name -- saves name as third answer when when responding to requests
defaults,1st answer,name -- saves name as first answer when sending requests
defaults,2nd answer,name -- saves name as second answer when sending requests
defaults,3rd answer,name -- saves name as third answer when sending requests

defaults,info
Default 1st response: beer
Default 2nd response: robin
Default 3rd response: thin
Default 1st answer: pizza
Default 2nd answer: batman
Default 3rd answer: thick
print defaults -- prints all set defaults

quicksend -- sends default answers to each default contact in order
respond all -- responds to all waiting requests with default answers

status -- shows current status on how many requests you have made and who is waiting for responses
