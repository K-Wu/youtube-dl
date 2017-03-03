#!/bin/bash

# Run with as parameter a setup.py that works in the current directory
# e.g. no os.chdir()
# It will run twice, the first time will crash

set -e

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ ! -d wine-py2exe ]; then

    sudo apt-get install wine1.3 axel bsdiff

    mkdir wine-py2exe
    cd wine-py2exe
    export WINEPREFIX=`pwd`

    wget "https://www.python.org/ftp/python/3.3.5/python-3.3.5.msi"
    git clone https://github.com/lambacck/py2exe-3.git
    #axel -a "http://winetricks.org/winetricks"

    # http://appdb.winehq.org/objectManager.php?sClass=version&iId=21957
    echo "Follow python setup on screen"
    wine msiexec /i python-3.3.5.msi
    cd py2exe-3
    wine "C:\\Python33\\python.exe" setup.py install
    cd ..
    echo "Follow py2exe setup on screen"
    
    
    #echo "Follow Microsoft Visual C++ 2008 Redistributable Package setup on screen"
    #bash winetricks vcrun2008

    #rm py2exe-0.6.9.win32-py2.7.exe
    #rm python-2.7.msi
    #rm winetricks
    
    # http://bugs.winehq.org/show_bug.cgi?id=3591
    
    #mv drive_c/Python27/Lib/site-packages/py2exe/run-py3.3-win32.exe drive_c/Python27/Lib/site-packages/py2exe/run.exe.backup
    #bspatch drive_c/Python27/Lib/site-packages/py2exe/run.exe.backup drive_c/Python27/Lib/site-packages/py2exe/run.exe "$SCRIPT_DIR/SizeOfImage.patch"
    #mv drive_c/Python27/Lib/site-packages/py2exe/run_w.exe drive_c/Python27/Lib/site-packages/py2exe/run_w.exe.backup
    #bspatch drive_c/Python27/Lib/site-packages/py2exe/run_w.exe.backup drive_c/Python27/Lib/site-packages/py2exe/run_w.exe "$SCRIPT_DIR/SizeOfImage_w.patch"

    cd -
    
else

    export WINEPREFIX="$( cd wine-py2exe && pwd )"

fi

wine "C:\\Python33\\python.exe" "$1" py2exe > "py2exe.log" 2>&1 || true
#echo '# Copying python27.dll' >> "py2exe.log"
#cp "$WINEPREFIX/drive_c/windows/system32/python27.dll" build/bdist.win32/winexe/bundle-2.7/
wine "C:\\Python33\\python.exe" "$1" py2exe >> "py2exe.log" 2>&1
