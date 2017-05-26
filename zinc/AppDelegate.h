//
//  AppDelegate.h
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Animation.h"
#import "Preferences.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    Animation* animation;
    Preferences* preferences;
    NSStatusItem* statusItem;
    BOOL syncing;
    NSString* sourceDirectory;
    NSString* destinationPath;
    NSMutableArray* exclusions;
    NSStoryboard *storyBoard;
    NSWindowController *myController;
}

@end

