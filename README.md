# KOLmafia Clanfortune Script Readme

Ok, I've uploaded my script for this you can download it in Kolmafia with the CLI command:

`svn checkout https://github.com/stewbeef/clanfortune/branches/release`

###Note if you installed this before 2/21/2018
There was a bug and I was learning how to use github, so now the installation is on the release branch.  If you installed before 2/21/2018, then you'll need to remove it with `svn delete clanfortune`).  Then reinstall it with the command above.
##General Instructions
The following commands are available.  If a word is in these brackets **<>**, then that means it is just a placeholder for the information you will need to put in.  If it is in parathesis **()** that means it is the literal text of the command. If two words are seperated by a line **|**, then that means either word is valid, though it will probably change some part of the command.

Right now all commands are seperated by commans without spaces.  When I retool this, it will learn to accept trailing spaces and discard them.

##Commands

#### `clanfortune help`
  displays some of the information below, but it is pretty basic, and are other commands and things not listed.  I am still working on it.
  
#### `clanfortune defaults,<setting name>,<setting>`
  This command is used to set various defaults that are used if you provide no specific details when running command to respond to fortunes or make fortune requests.
  
* Proper *setting names* are...
  * `(1st|2nd|3rd) response`
  * `(1st|2nd|3rd) answer`
  * `(1st|2nd|3rd) contact`
* Proper settings are:
  * `(1st|2nd|3rd) response` - when responding to a fortune request, the 1st response is the food, the 2nd is the character, and the third is the favorite word.
  * `(1st|2nd|3rd) answer` - likewise, the settings for this determine the food, character, and word used when making a request.
  * `(1st|2nd|3rd) contact` - when automatically making requessts, this determines what players you will send it to.
* Examples:  To setup the defaults the way most bots are programmed to respond and you'll get matches, do this:

  * `defaults,1st response,beer`
  * `defaults,2nd response,robin`
  * `defaults,3rd response,thin`
  * `defaults,1st answer,pizza`
  * `defaults,2nd answer,batman`
  * `defaults,3rd answer,thick`
 
#### `defaults,info` - this sets the above response/answer choices to the settings used by most bots.  It does not set any contacts.

#### `print defaults` -- prints all set defaults

#### `npc,<name|type>` - this makes a fortune request to an NPC using the default answers specified above.
  Name and type options are below, along with the buffs they give.  Any of the names/options used to specify the same NPC work the same
* Name and Type options
  * *Gorgonzola* name/type = `gorgonzola`, `gorgonzola`, `the chief chef (npc)`, `mp`, `myst`, `mysticality`, `the chief chef`
    * *Results in Everybody Calls Him Gorgon: +100% myst, +50% MP, +5 myst stats/fight*
  * For *Gunther* name/type = `gunther`, `gunther`, `lord of the smackdown (npc)`, `hp`, `lord of the smackdown`, `mus`, `muscle`
    * Results in Gunther Than Thou: +100% mus, +50% HP, +5 mus stats/fight*
  * For *hangk* name/type = `booze`, `food`, `hangk`, `hangk (npc)`, `item`
    * Results in There's No N In Love: +50% food drops, +50% booze drops, +50% item drops*
  * For *Meatsmith* name/type = `gear`, `meat`, `meatsmith`, `meatsmith (npc)`, `the meatsmith`, `the meatsmith (npc)`
    * Results in Meet The Meat: +50% gear drops, +100% meat drops*
  * For *Shifty* name/type = `init`, `initiative`, `mox`, `moxie`, `shifty`, `shifty, the thief chief (npc)`, `the thief chief`
    * Results in They Call Me Shifty: +100% mox, +50% combat init, +5 mox stats/fight*
  * For *Susie* name/type = `arena master`, `familiar`, `susie`, `susie`, `the arena master`, `susie`, `the arena master (npc)`
    * Results in A Girl Named Sue: +5 familiar weight, +10 familiar damage, +5 familiar xp/fight*

#### `quicksend`
  sends default answers to each default contacts in order
#### `respond all`
  responds to all waiting requests with default answers
#### `status`
  shows current status on how many requests you have made and who is waiting for responses
#### `clan,<name|id>,food,name,word` -- sends a message to the player specified by `name` or `id` with the 3 answers selected.

#### `mail`
  prints clan fortune mail that you've received

#### `(respond|return),<name>,<food>,<character>,<word>`
  responds to the specified person's fortune request with the specified answers.

There's also a system for making answer templates and using them, which I will include details of later.


