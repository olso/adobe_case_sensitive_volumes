# Installing Adobe CC on case-sensitive drives (Mac OS X)

**@olso tries to continue**
1. Found `InitErrorCaseSensitiveVolume` in `Creative Cloud Installer.app/Contents/Resources/Dictionary/en_US.json`
2. Downloaded Cutter
3. Searched for `InitErrorCaseSensitiveVolume` string
4. No idea how to use it lol, I don't do low level stuff
5. Remember reading something about `dtruss` on HN
6. https://stackoverflow.com/questions/33476432/is-there-a-workaround-for-dtrace-cannot-control-executables-signed-with-restri#comment102149999_46689409
7. `codesign --remove-signature Creative\ Cloud\ Installer.app/Contents/MacOS/Install`
8. `sudo dtruss -fn make &> dtruss.log` (this will wait for make to run and attach itself to it)
9. `make run` and wait for the error to appear, then `ctrl+c`
10. look at the `dtruss.log` output
11. fuck these are low level calls, I need something that can show me objectivec funcnames/classnames, fuuuuck
12. lets try `sudo dtruss -a -s -fn make &> dtruss.log` and repeat
13. uuuu these are some nice method names bruh
14. fuck
15. https://github.com/quarkslab/iMITMProtect/blob/master/override
16. 

**DISCONTINUED, since it seems that with new MacOS it became impossible to know which MacOS X API let you get disk informations and I don't have anymore a Mac, I'm really SORRY for Adobe users, if for any case you have a spare Mac that is able to run latest MacOS X we could try to figure out how to do it**

Well, everybody knows that Adobe are a **[censored]** company.
Their products are the defacto standard for image/video editing and designing, but their codebase really suck. No excuses.

The problem addressed here is that Creative Studio™ refuses to install on a case-sensitive drive on Mac OS X.
And it doesn't just refuse to install on a case-sensitive drive, but it also requires to install on your *boot* drive as well! Srsly?

Well, there's a solution. [@tzvetkoff](https://github.com/tzvetkoff/adobe_case_sensitive_volumes) made a fork of [this](https://bitbucket.org/lokkju/adobe_case_sensitive_volumes), after trying I found that his code was unmantained and was working only for Adobe CS6 and for old Apple Mac OS X versions.

I've forked the code to update it for CC (Creative Cloud) and for make it more easy to use on new architectures, maybe someone will need it.

One another interesting thing was that his code wasn't working for new Mac OS X since Apple deprecated support for i386 kernel, so fix this issue would had its advantages.

## Prerequisites

1.  `Xcode`

    You can install it from [Apple AppStore](https://itunes.apple.com/app/xcode/id497799835).
2.  Command Line Tools for Xcode.

    You can install it from terminal launching `sudo xcode-select --install`
    
    Alternatively you can install it from Xcode's `Preferences` -> `Downloads`.

## A step-by-step installation instructions

1.  Create a `.sparsebundle` pseudo-image to install CC inside it:

    ``` bash
    mkdir -p ~/Documents/Adobe
    cd ~/Documents/Adobe
    hdiutil create -size 30g -type SPARSEBUNDLE -nospotlight -volname 'AdobeCC' -fs 'Journaled HFS+' ~/Documents/Adobe/AdobeCC.sparsebundle
    ```

2.  Mount the newly created image and create a `/Adobe` directory inside

    ``` bash
    open ~/Documents/Adobe/AdobeCC.sparsebundle
    mkdir -p /Volumes/AdobeCC/Adobe
    ```

3.  Create an extra `/Applications/Adobe` folder on the boot drive (we will trick the installer with this temporary directory.)
    ``` bash
    mkdir -p /Applications/Adobe
    ```

4.  Get the hack, compile it, and run it

    OK, at this point you'll need to edit the `Makefile` and set the `CS6_INSTALLER_PATH` variable to point to the `Install.app` directory.
    The current one tries to find it automatically, but it *may* fail...

    ``` bash
    cd ~/Documents/Adobe
    git clone https://github.com/RubensRainelli/adobe_case_sensitive_volumes.git
    cd adobe_case_sensitive_volumes
    make
    sudo make run
    ```

5.  When asked, select `/Applications/Adobe` for installation directory rather than just `/Applications`, but **don't** click the `Install` button!!
    Remember, **don't** click the `Install` button just yet.

6.  Now, time to do one more hack - remove the `/Applications/Adobe` directory and replace it with a symlink to the `/Adobe` directory from the SparseBundle.

    ``` bash
    rm -rf /Applications/Adobe
    ln -s /Volumes/AdobeCC/Adobe/ /Applications/Adobe
    ```

7.  Now click the `Install` button

8.  You can now safely delete the intermediate files and probably move the SparseBundle somewhere easier to mount by just clicking it (the Desktop, probably?)

    ``` bash
    mv ~/Documents/Adobe/AdobeCC.sparsebundle ~/Desktop/AdobeCC.sparsebundle
    rm -rf ~/Documents/Adobe
    ```

9.  That's it!

    Just remember that you'll need to mount the SparseBundle every time you need to use Adobe's products.


## Thanks

[lokkju](https://bitbucket.org/lokkju), for writing [that awesome article and code](https://bitbucket.org/lokkju/adobe_case_sensitive_volumes)

[@tzvetkoff](https://github.com/tzvetkoff/adobe_case_sensitive_volumes) for his improved code I've forked and updated for making it compatible with newer Mac OS X and newer Adobe CC

[Rashed97](https://github.com/Rashed97/adobe_case_sensitive_volumes) for some other improvements that make it working on newer MacOS X
