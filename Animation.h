//
//  Animation.h
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface Animation : NSObject {
    NSArray *images;
    BOOL running;
    unsigned long frames;
    unsigned long frame;
}

@property (strong, nonatomic) NSStatusItem *statusItem;

- (id)initWithImagesPrefixedBy:(NSString *)prefix withType:(NSString *)type;
- (void)setFrame:(unsigned long)index;
- (void)start;
- (void)stop;

@end
