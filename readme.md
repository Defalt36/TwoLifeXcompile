<h2><a href="https://github.com/Defalt36/LifeCompiler">THIS PROJECT IS ARCHIVED IN FAVOUR OF THIS.</a></h2>

<p><img alt="Friendly Advice" title="" src="exclude-dir/cover.png" /></p>

<h2>What is This?</h2>
<p>
This project was adapted from the original OneLifeXcompile as an attempt to provide the tool for anyone to build, modify and even contribute
to the game Two Hours One Life.
</p>

<h2>Before You Start</h2>
<p>
Windows Subsystem for Linux (WSL) was the main tool used for testing of the scripts
in this repository. Other tools such as Virtual box may be able to make use of the
scripts here, but have in mind it might not work. WSL 2 was not tested.
</p>

<p>
You can see a guide on how to activate WSL on Windows 10 here:<br />
<a href="https://docs.microsoft.com/en-us/windows/wsl/install-win10">WSL Installation Guide for Windows 10</a>
</p>

<p>
If your in a hurry enter the folder exclude-dir in this repository and then run the batch file
'activateWSLthenRestart.bat' as an administrator. Be warned it will restart your machine.<br />
After you computer reboots install <a href="https://www.microsoft.com/store/apps/9n6svws3rx71">Ubuntu 20.04 LTS</a> from the Microsoft
store. Open it and define a user and password.<br />
</p>

<h2>Do I have to read all of the following? This stuff is boring, why can't I just build the game?</h2>
<p>
I got you, fam. Run this from wsl: <br />
<code>wget https://raw.githubusercontent.com/Defalt36/TwoLifeXcompile/master/doEverything.sh;chmod +x doEverything.sh;sudo ./doEverything.sh</code>
</p>

<h2>Preparing Your Work Directory</h2>
<p>
After you set up WSL on your machine open the CMD and type 'wsl' and you should see
the terminal of your linux distribution. Alternatively you can run 'openTerminalHere.bat'
from the repository files.
</p>

<p>
If you don't already have a work directory create a folder and name it 'workdir', then move
the 'TwoLifeXcompile' repository to it or proceed to get instructions on how to acquire it.
</p>

<p>
To download the repository directly to your workdir first open WSL from CMD. Then use the
command 'cd' to navigate to the folder you want to place your files. In
my case I use '<code>cd /mnt/c/Users/defalt/Desktop/workdir</code>' as that is where my workdir
is located. '/mnt/c' is the corresponding path of C: on WSL.<br />

Now run '<code>sudo apt-get install git</code>', wait for it to complete and then run
'<code>git clone https://github.com/Defalt36/TwoLifeXcompile.git</code>'.
After the command completes, check to see if 'TwoLifeXcompile' was cloned into the right folder.
</p>

<p>
For convenience you can type:<br />
<code>ln -s "The path to your work directory" ~/workdir</code><br />

This create a shortcut that will let you find you work directory easily using:<br />
<code>cd ~/workdir</code>
</p>

<h2>Preparing Your Enviroment</h2>

<p>
The following scripts will install the required components to build the game in your
linux distribution. You just have to run then once as long as you don't uninstall or
use another distribution.
</p>

<p>
Make sure you have the correct folder opened in the terminal. Check the end of the line
to see if you are in the TwoLifeXcompile folder.
For me it is: <br />
<code>defalt@DEFALT-PC:/mnt/c/Users/defalt/Desktop/workdir/TwoLifeXcompile</code><br />
</p>

Run:<br />
<code>./getBasics.sh</code><br />

Run this if you want to be able to build the editor:<br />
<code>./installMissingLibraries.sh</code><br />
</p>

<h2>Preparing The Game Files</h2>

<p>
First you will have to clone the game files. The command <code>./replaceClonedFolders.sh</code>
should do this for you, but have in mind it will delete the game repositories you
previously cloned (if any).<br />
Note that command will clone the minorGems, OneLife and OneLifeData7 repositories from the
TwoHoursOneLife github account. To clone from other sources you can use:
<code>./cloneAlternative.sh</code>.
</p>

<p>
After successfully cloning the game repositories to your work directory run:<br />
<code>./applyLocalRequirements.sh</code><br />
</p>

<h2>Building The Game</h2>
<p>
Before you start, if you already tried to compile anything run this command to remove
the files generated from previously builds.<br />
<code>./perform.sh --cleanall</code>
</p>

<p>
Now you are ready for compiling the game. You have currently four basic options on how
to do this using the repository scripts.
</p>

<p>
<ol>
<li><code>./fastBuildGame.sh</code></li>
<li><code>./buildTestSystem.sh</code></li>
<li><code>./createFullBuild.sh</code></li>
<li><code>./perform.sh -b g</code></li>
</ol>
</p>

<p>

'fastBuildGame.sh' will compile the game and then move the game to the folder windows_builds in your work directory.
It is faster because it does not convert the unix-style line endings to windows-style, an optional step.<br />

'buildTestSystem.sh' is very similar to pullAndBuildTestSystem.sh from the OneLife scripts; In
fact, it is derived from it. It will clone the game repositories if they are missing and compile
the game, editor and server for you, modifing some files so it will be ready to be used for
testing. Be warned you will be editing the repositories files when you use the editor. You may
want to make a backup of the OneLifeData7 repository.

'createFullBuild.sh' will compile the game, server and editor and move all their files to a single
folder in order to make a full build. If you are using this, remember to run the 'initiateServer.bat'
file before running the server. 'resetServer.bat' is included to delete the server files if you are
unable to run it due to a crash.

'perform.sh' is a multi utility script. It can build and run the game, server and editor depending on
the flags you use. This is useful for testing.

</p>

<h2>Building From Another Source</h2>

<p>
You can run './cloneAlternative.sh' to clone the game repositories under any name or user.
This is useful for cloning your own repositories. You can also clone the original game
repositories with it if you input 'jasonrohrer' as the user you want to clone from.<br />
The compile script recomended when building from other sources is 'buildTestSystem.sh'.
</p>

<h2>Ok, But What Does All This Stuff Actually Do?</h2>

<p>
Most forked scripts keep the same function as the original ones, and others were renamed. You can read about what
they do in this tutorial from the creator of the original project, Joriom:
https://onehouronelife.com/forums/viewtopic.php?id=1438
</p>

<p>
<code>exclude-list.txt</code><br />
When you run ./applyLocalRequirements.sh some files from TwoLifeXcompile will be copied to
the game folders with the sole exception being the files listed here. The folder exclude-dir
and some files you may use are included for your convenience.
</p>

<p>
<code>cloneAlternative.sh</code><br />
Used for cloning from other repositories, branches or users.
</p>

<p>
<code>installMissingLibraries.sh</code><br />
You may have a lot of libraries in your system, but you need to have them installed
to your compiler for it to work. This script install the ones you need.
</p>

<p>
<code>deleteAllServerFiles.sh</code><br />
Did you forget to press control-c when exiting the server or you just want a fresh map? This script
will send all your server files to oblivion, solving the problem.
</p>

<p>
<code>cleanServerMap.sh</code><br />
Less destructive version of the above.
</p>

<p>
<code>buildLatestTHOL.sh</code><br />
Will automatically build the lastest version of Two Hours One Life for you.
</p>

<p>
<code>buildLatestOHOL.sh</code><br />
Will automatically build the lastest version of One Hour One Life for you.
</p>

<p>
<code>perform.sh</code><br />
read next section.
</p>

<p>
<code>buildTestSystem.sh</code><br />
This will clone missing repositories if any and build a test system for experimenting with
the game.
</p>

<p>
<code>createFullBuild.sh</code><br />
Build the game, editor and server and puts them in a single folder.
</p>

<p>
<code>doEverything.sh</code><br />
Will install, download and run everything you need, then it will
build the game, editor and server. This should be run at your workdir.
</p>

<h2>Fast building</h2>

<p>
The 'perform.sh' script can be used to clean, build and open the applications quickly.<br />
Its '-c' option will clean only the files specified in the 'toClean' variable inside the script.<br />
The usage is <code>./perform.sh (FLAGS) (PARAMETERS)</code>.<br />
Flags: '-b' Build; '-r' Run; '-c' Clean; '-cleanall' Clean all build files.<br />
Parameters: 'g' Game; 'e' Editor; 's' Server.<br />
</p>

<p>
Example: <code>./perform.sh -cbr gs</code> This will clean the files specified, build the game and
server and then run both.
</p>

<h2>Known Issues</h2>

<p>
<ol>
<li>SDL won't install if it is in a folder with blank spaces in the path.</li>
</ol>
</p>
