#import "AirDropOpener.h"
#import <AppKit/AppKit.h>

@implementation AirDropOpener

- (void)openAirDrop {
    NSString *path =
        @"/System/Library/CoreServices/Finder.app/Contents/Applications/AirDrop.app";
    NSLog(@"[AirDropOpener] opening %@", path);

    NSTask *t = [[NSTask alloc] init];
    t.launchPath = @"/usr/bin/open";
    t.arguments = @[path];

    NSError *err = nil;
    if (![t launchAndReturnError:&err]) {
        NSLog(@"[AirDropOpener] launch failed: %@", err);
        return;
    }
    [t waitUntilExit];
    NSLog(@"[AirDropOpener] open exited %d", t.terminationStatus);
}

@end
