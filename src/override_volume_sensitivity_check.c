#include <stdio.h>
// #include <stdlib.h>
#include <unistd.h>
#include <dlfcn.h>
#include "dyld-interposing.h"
// #include <CoreServices/CoreServices.h>

// static OSStatus _FSGetVolumeParms(FSVolumeRefNum volume, GetVolParmsInfoBuffer *buffer, ByteCount bufferSize) {
// 	OSStatus status = FSGetVolumeParms(volume,buffer,bufferSize);
// 	int isCaseSensitive = !!(buffer->vMExtendedAttributes & (1 << bIsCaseSensitive));

// 	printf("== FSGetVolumeParms - Is this getting called? ==\n");

// 	if(isCaseSensitive) {
// 		printf("== FSGetVolumeParms - say that the volume is case insensitive, though it is case sensitive. ==\n");
// 		buffer->vMExtendedAttributes &= ~(1 << bIsCaseSensitive);
// 	}

// 	return status;
// }
// DYLD_INTERPOSE(_FSGetVolumeParms, FSGetVolumeParms);

// @interface _NSFileManager : NSObject {
// }
// DYLD_INTERPOSE(_NSFileManager, NSFileManager);

void my__getattrlist() {
	printf("kek");
	// NSLog("hello world");
}
DYLD_INTERPOSE(my__getattrlist, getattrlist);

// void* pMalloc(size_t size) //would be nice if I didn't have to rename my function..
// {
//    printf("Allocated: %zu\n", size);
//    return malloc(size);
// }
// DYLD_INTERPOSE(pMalloc, malloc);

// void my_stat64() {

// 	printf("omg work pls");
// }
// DYLD_INTERPOSE(my_stat64, stat64);