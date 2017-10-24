CS6_INSTALLER_PATH=/Volumes/Creative\ Cloud\ Installer/Creative\ Cloud\ Installer.app/Contents/MacOS/Install

lib_override_volume_sensitivity_check.dylib: src/override_volume_sensitivity_check.c 
	gcc -DDEBUG -ggdb -arch i386 -arch x86_64 -Wall -framework CoreServices -o lib_override_volume_sensitivity_check.dylib -dynamiclib src/override_volume_sensitivity_check.c

.PHONY: clean run

test:
	@echo $(CS6_INSTALLER_PATH)

clean:
	rm -rf ./*.dylib* *~ core

run: lib_override_volume_sensitivity_check.dylib
ifneq ($(shell whoami),root)
	@echo "You are not root. Please rerun this command as root (sudo make run)"
else
	ln -s /Volumes/Adobe/Adobe\ Creative\ Cloud/ /Applications/Adobe\ Creative\ Cloud
	ln -s /Volumes/Adobe/Utilities/Adobe\ Creative\ Cloud/ /Applications/Utilities/Adobe\ Creative\ Cloud
	ln -s /Volumes/Adobe/Utilities/Adobe\ Application\ Manager/ /Applications/Utilities/Adobe\ Application\ Manager
	ln -s /Volumes/Adobe/Utilities/Adobe\ Installers /Applications/Utilities/Adobe\ Installers
	DYLD_INSERT_LIBRARIES=$(shell pwd)/lib_override_volume_sensitivity_check.dylib $(CS6_INSTALLER_PATH)
endif
