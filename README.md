Pretty straight forward Advertising Tool to use for In-game advertising in World of Warcraft.

Requires : AHK 2 + Autoit 3(Can use Compiled Version Without this)
Includes FAB free ware

Buttons Explanation : 
Login : Enter Accounts info onto World of Warcraft Opened Tabs(Except those disabled in Accounts Setting) And Login.

Logout : Enters /logout in all opened World of Warcraft Opened Tabs.

Paused/Started : Simple as it sounds, will start and stop sending key strokes to opened Tabs.

AFK MODE : Press a defined Key in Config(Space By Default) Each 1-2 Minutes to avoid getting kicked out of game while also not sending macro keystrokes.

Replace M6 CFG : Replaces M6.cfg file found in _Retail/WTF/ into all accounts found in WTF Folder.

Edit M6 CFG : Opens M6.cfg file at _Retail/WTF/

Run WoWs : Opens Desired Amount of WoW Defined in Config.

Block Firewall : Uses FAB to block World of Warcraft Through firewall.

Config : Opens Settings.

Accounts : Opens Account Manager.

Reload : Reloads Both Settings and Accounts from saved file in App directory.(In case of manual editing config file/s)




Config Settings : 

Sorting Section{

Starting Position X : X position where first tab gonna be placed on

Starting Position Y : Y Position where first tab gonna be placed on

Window Size X : X size of WoW tabs

Window Size Y : Y size of WoW tabs

}

LoginScree{

Login Static Pixel X : X position of a static pixel to detect login screen, Default value : 49 

Login Static Pixel Y : Y position of a static pixel to detect login screen, Default value : 29

Static Pixel Color : X,Y Pixel Color in Hex, Default value : 0x6D0C04

Remember Accounts : Tick if you have Checked Remember Account Checkbox in login screen

}

Settings{

Defaultpassword : used whenever no password entered in accounts config

MacroButtons : any charecter key

AFK Mode Button : Button to press while in AFK Mode ; Default value : {SPACE}

Accounts No : Amount of Accounts you are willing to control

}


Accounts Settings :

Name : Title of Account Tab

Email : Account Email

Password : Account Password

Min : Minimum Time between macro press

Max : Maximum Time between macro press

Group : set if you want Type to sync timers with another account/s(useful if you got several accounts in a specific realm)

Type :

1x Account : ""

2x Account : "" And /2

3x Account : "" And /3 And /3*2



Copyright 2024 Pou-Xlover

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
