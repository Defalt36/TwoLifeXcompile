
<p><img alt="Friendly Advice" title="" src="exclude-dir/cover.png" /></p>

<h2>What is This?</h2>
<p>
This project was adapted from the original OneLifeXcompile as an attempt to provide
a simple way for to provide the tool for anyone to build, modify and even contribute
to the game Two Hours One Life.
</p>

<h2>Before You Start</h2>
<p>
Windows Subsystem for Linux (WSL) was the main tool used for testing of the scripts
in this repository. Other tools such as Virtual box may be able to make use of the
scripts here, but have in mind it might not work.
</p>

<p>
You can see a guide on how to activate WSL on Windows 10 here:<br />
<a href="https://docs.microsoft.com/en-us/windows/wsl/install-win10">https://docs.microsoft.com/en-us/windows/wsl/install-win10</a>
</p>

<p>
After this, you should restart your machine and install a linux distribution from the
Microsoft store (follow the full guide on the link.)<br />
</p>

<p>
The scripts here were tested using WSL 1 and the linux distribution Ubuntu 20.04 LTS.
</p>

<h2>Do I have to read all of this? This stuff is boring, why can't I just build the game?</h2>
<p>
I got you, fam. Run this from wsl: <br />
<code>wget https://raw.githubusercontent.com/Defalt36/TwoLifeXcompile/master/doEverything.sh;./doEverything.sh</code>
</p>

<h2>Preparing Your Work Diretory</h2>
<p>
After you set up WSL on your machine open the CMD and type 'wsl' and you should see
the terminal of your linux distribution.
</p>

<p>
Now use the command 'cd' to navigate to the folder you want to place your files. In
my case I use '<code>cd /mnt/c/Users/defalt/Desktop</code>' to go to my desktop and then I create
the folder 'workdir' either by inputing '<code>mkdir workdir</code>' on the terminal or just
create the folder using Windows Explorer.<br />

Note my desktop is located at the 'C' drive, or '/mnt/c' in WSL. If the folder you
want to open is in another drive, for example 'D' you will have to open '/mnt/d'
instead.
</p>

<p>
Now I just open my work directory with '<code>cd workdir</code>'. You should also open your
directory. Check the end of the terminal line to see if you are in the correct folder.
For me it is: <br />
<code>defalt@DEFALT-PC:/mnt/c/Users/defalt/Desktop/workdir</code><br />

Alternatively instead of just opening your work directory you can run:<br />
<code>ln -s "The path to your work directory" ~/workdir</code><br />

This create a shortcut that will let you find you work directory easily using:<br />
<code>cd ~/workdir</code>
</p>

<p>
Now run '<code>sudo apt-get install git</code>'<br />
This will install git, so we can clone this repository.<br />

Then run '<code>git clone https://github.com/Defalt36/TwoLifeXcompile.git</code>'<br />
It should create a clone of this into your workdir.
</p>

<h2>Preparing Your Enviroment</h2>

<p>
The following scripts will install the required components to build the game in your
linux distribution. You just have to run then once as long as you don't uninstall or
use another distribution.
</p>

<p>
First open TwoLifeXcompile folder. You can open it from your work directory using:<br />
<code>cd TwoLifeXcompile</code><br />

Then run:<br />
<code>./getBasics.sh</code><br />
<code>./getMingw-w64.sh</code><br />

If you want to be able to build the editor, run:<br />
<code>./installMissingLibraries.sh</code><br />
</p>

<h2>Preparing The Game Files</h2>

<p>
First you will have to clone the game files. The command './removeAndCloneAgain.sh'
should do this for you, but have in mind it will delete the game repositories you
previously cloned (if any).<br />
</p>

<p>
After successfully cloning the game repositories to your work directory run:<br />
<code>./getSDLforWin.sh</code><br />
<code>./fixStuff.sh</code><br />
<code>./applyLocalRequirements.sh</code><br />
</p>

<h2>Building The Game</h2>
<p>
Before you start, if you already tried to compile anything run this command to remove
the files generated from previously builds.<br />
<code>./cleanOldBuilds.sh</code>
</p>

<p>
Now you are ready for compiling the game. You have currently three options on how to
do this.
</p>

<p>
<ol>
<li><code>./compileAndMove.sh</code></li>
<li><code>./compileForWindowsWithoutEOLChanges.sh</code></li>
<li><code>./buildTestSystem.sh</code></li>
</ol>
</p>

<p>
The first will compile the game using the scripts that were copied to OneLife/build,
and then move the game to the folder windows_builds in your work directory.<br />

The second will do basically the same as the first but it is much faster. The reason
for this is that it does not convert the unix-style line endings to windows-style. It
doesn't seem to cause any major problems.<br />

Now for the third. This on is very similar to pullAndBuildTestSystem.sh from the game
scripts, in fact it is derived from it. It will clone the game repositories if they are
missing and compile the game, editor and server for you, modifing some files so it will
be ready to be used for testing. Be warned you will be editing the repositories files
when you use the editor. You may want to make a backup of the OneLifeData7 repository.
</p>

<h2>Ok, But What Does All This Stuff Actually Do?</h2>

<p>
Most scripts here keep the same function as the original ones. You can read about what
they do in this tutorial:
https://onehouronelife.com/forums/viewtopic.php?id=1438
</p>

<p>
<code>fixStuff.sh</code><br />
The next script fix some paths in the game repositories that prevent you from compiling
the game components. Alternatively you could create symlinks for correct paths in your
system, but if you want to keep it simple, just run it.
</p>

<p>
<code>installMissingLibraries.sh</code><br />
You may have a lot of libraries in your system, but it seems you have to have them installed
at your compiler for it to work. This script install the ones you need.
</p>

<p>
<code>resetServer.sh</code><br />
Forget to press control-c when exiting the server or you just want a fresh map? This script
will send all your server files to oblivion.
</p>

<p>
<code>exclude-list.txt</code><br />
When you run ./applyLocalRequirements.sh some files from TwoLifeXcompile will be copied to
the game folders with the sole exception being the files listed here. The folder exclude-dir
and some files you may need are included for your convenience.
</p>

<h2>Note About Missing DLLs</h2>

<p>
After some time I started getting an error when starting the editor. It says I miss
some dlls from libSDL, libpng and libz.<br />

If you experience that problem, just copy the dlls from 'OneLife/build/win32' from this
repository to the same folder as the exe requiring these files.<br />

Removing the "OneLife/build/win32" line from 'exclude-list.txt' should include
these files in '2hol_(x)' the next time you compile the game.
</p>