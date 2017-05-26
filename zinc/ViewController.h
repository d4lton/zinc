//
//  ViewController.h
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Preferences.h"

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
    NSArray *preferenceNames;
    Preferences *preferences;
}

@property (weak) IBOutlet NSTableView *tableView;

@end

