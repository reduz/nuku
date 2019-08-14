#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking nuku
/usr/bin/ld  -dynamic-linker=/lib/ld-linux.so.2  -s -L. -o nuku link.res
if [ $? != 0 ]; then DoExitLink nuku; fi
