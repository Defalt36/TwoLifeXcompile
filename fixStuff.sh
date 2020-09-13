cd ..

#Fix winsock letter case
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/win32/SocketClientWin32.cpp;
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/win32/SocketServerWin32.cpp;
sed -i 's/<Winsock.h>/<winsock.h>/' minorGems/network/unix/SocketPollUnix.cpp;

#Link to float.h instead of the old values.h in order to build map.cpp
sed -i 's/<values.h>/<float.h>/' OneLife/server/map.cpp;