#import "AirDropOpener.h"
#import <AppKit/AppKit.h>

@implementation AirDropOpener

- (BOOL)openAirDropWithError:(NSString **)errorOut {
    // Path to the AirDrop.app that lives inside Finder.app.
    // Launching it with /usr/bin/open is exactly what double-clicking it does.
    NSString *airdropPath =
        @"/System/Library/CoreServices/Finder.app/Contents/Applications/AirDrop.app";

    if (![[NSFileManager defaultManager] fileExistsAtPath:airdropPath]) {
        if (errorOut) {
            *errorOut = [NSString stringWithFormat:
                @"AirDrop.app not found at expected path:\n%@", airdropPath];
        }
        return NO;
    }

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/open";
    task.arguments  = @[airdropPath];

    @try {
        [task launch];
        [task waitUntilExit];
    } @catch (NSException *e) {
        if (errorOut) *errorOut = [NSString stringWithFormat:
            @"Failed to launch /usr/bin/open: %@", e.reason];
        return NO;
    }

    if (task.terminationStatus != 0) {
        if (errorOut) {
            *errorOut = [NSString stringWithFormat:
                @"/usr/bin/open exited with status %d", task.terminationStatus];
        }
        return NO;
    }
    return YES;
}

@end
