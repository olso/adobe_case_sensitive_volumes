# CC_INSTALLER_PATH=/Volumes/Creative\ Cloud\ Installer/Creative\ Cloud\ Installer.app/Contents/MacOS/Install
CC_INSTALLER_PATH=/Volumes/Adobe/Creative\ Cloud\ Installer.app/Contents/MacOS/Install

lib_override_volume_sensitivity_check.dylib: src/override_volume_sensitivity_check.c 
#	gcc -DDEBUG -ggdb -arch i386 -arch x86_64 -Wall -framework CoreServices -o lib_override_volume_sensitivity_check.dylib -dynamiclib src/override_volume_sensitivity_check.c
	gcc -DDEBUG -ggdb -arch x86_64 -Wall -framework CoreServices -o lib_override_volume_sensitivity_check.dylib -dynamiclib src/override_volume_sensitivity_check.c

.PHONY: clean run

test:
	@echo $(CC_INSTALLER_PATH)

clean:
	rm -rf ./*.dylib* *~ core

run: lib_override_volume_sensitivity_check.dylib
	# run with sudo
	# ln -sf /Volumes/Adobe/Adobe\ Creative\ Cloud/ /Applications/Adobe\ Creative\ Cloud
	# ln -sf /Volumes/Adobe/Utilities/Adobe\ Creative\ Cloud/ /Applications/Utilities/Adobe\ Creative\ Cloud
	# ln -sf /Volumes/Adobe/Utilities/Adobe\ Application\ Manager/ /Applications/Utilities/Adobe\ Application\ Manager
	# ln -sf /Volumes/Adobe/Utilities/Adobe\ Installers /Applications/Utilities/Adobe\ Installers
	#
	# run without sudo
	DYLD_INSERT_LIBRARIES=$(shell pwd)/lib_override_volume_sensitivity_check.dylib $(CC_INSTALLER_PATH)

# ifneq ($(shell whoami),root)
# 	@echo "You are not root. Please rerun this command as root (sudo make run)"
# else
# 	ln -sf /Volumes/Adobe/Adobe\ Creative\ Cloud/ /Applications/Adobe\ Creative\ Cloud
# 	ln -sf /Volumes/Adobe/Utilities/Adobe\ Creative\ Cloud/ /Applications/Utilities/Adobe\ Creative\ Cloud
# 	ln -sf /Volumes/Adobe/Utilities/Adobe\ Application\ Manager/ /Applications/Utilities/Adobe\ Application\ Manager
# 	ln -sf /Volumes/Adobe/Utilities/Adobe\ Installers /Applications/Utilities/Adobe\ Installers
# 	DYLD_INSERT_LIBRARIES=$(shell pwd)/lib_override_volume_sensitivity_check.dylib $(CC_INSTALLER_PATH)
# endif
