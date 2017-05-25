//
//  AppDelegate.m
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

void callback(ConstFSEventStreamRef stream, void *callbackInfo, size_t numEvents, void *evPaths, const FSEventStreamEventFlags evFlags[], const FSEventStreamEventId evIds[]) {
    AppDelegate *delegate = (__bridge AppDelegate *)callbackInfo;
    if (delegate != nil) {
        [delegate onChange];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    sourceDirectory = @"/Users/dana/src";
    destinationPath = @"96.84.194.75:/data01/";
    
    exclusions = [NSMutableArray arrayWithCapacity: 20];
    [exclusions addObject: @".*"];
    
    syncing = NO;
    animation = [[Animation alloc] initWithImagesPrefixedBy: @"anime_dancer" withType: @"gif"];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSSquareStatusItemLength];

    NSMenu *menu = [[NSMenu alloc] init];
    
    [menu addItemWithTitle: @"About Zinc..." action: @selector(about:) keyEquivalent: @""];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItemWithTitle: @"Sync Now" action: @selector(sync) keyEquivalent: @""];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItemWithTitle: @"Quit" action:@selector(terminate:) keyEquivalent:@""];
    
    statusItem.menu = menu;
    
    animation.statusItem = statusItem;
    [animation setFrame: 0];
    
    [self startWatching: sourceDirectory];

}

- (void)startWatching:(NSString *)path {
    CFStringRef arg = CFStringCreateWithCString(kCFAllocatorDefault, [path UTF8String], kCFStringEncodingUTF8);
    CFArrayRef paths = CFArrayCreate(NULL, (const void**)&arg, 1, NULL);
    CFAbsoluteTime latency = 1.0;
    
    struct FSEventStreamContext context;
    context.info = (__bridge void *)self;

    FSEventStreamRef stream = FSEventStreamCreate(NULL, &callback, &context, paths, kFSEventStreamEventIdSinceNow, latency, kFSEventStreamCreateFlagNone);
    
    FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    FSEventStreamStart(stream);
}

- (void)about:(NSMenuItem*)sender {
    NSLog(@"ABOUT");
}

- (void)onChange {
    [self sync];
}

- (void)sync {
    if (!syncing) {
        [animation start];
        syncing = YES;
        NSTask* task = [[NSTask alloc] init];
        task.launchPath = @"/usr/bin/rsync";
        NSMutableArray* arguments = [NSMutableArray arrayWithCapacity: 20];
        [arguments addObject: @"-azPq"];
        for (id exclusion in exclusions) {
            [arguments addObject: [NSString stringWithFormat:@"--exclude=%@", (NSString*)exclusion]];
        }
        [arguments addObject: sourceDirectory];
        [arguments addObject: destinationPath];
        task.arguments = [NSArray arrayWithArray: arguments];
        NSLog(@"%@", task.arguments);
        task.terminationHandler = ^(NSTask *task) {
            NSLog(@"SYNC COMPLETE");
            [animation stop];
            syncing = NO;
        };
        [task launch];
    } else {
        NSLog(@"ALREADY SYNCING");
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

@end
