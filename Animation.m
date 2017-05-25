//
//  Animation.m
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import "Animation.h"

@implementation Animation

- (id)initWithImagesPrefixedBy:(NSString *)prefix withType:(NSString *)type {

    if (self = [super init]) {
        
        running = NO;
        frames = 0;
        frame = 0;

        NSMutableArray *result = [NSMutableArray array];
        [[[NSBundle mainBundle] pathsForResourcesOfType: type inDirectory: nil] enumerateObjectsUsingBlock: ^(NSString *obj, NSUInteger idx, BOOL *stop) {
            NSString *path = [obj lastPathComponent];
            if ([path hasPrefix: prefix]) {
                [result addObject: [NSImage imageNamed: path]];
            }
        }];
        images = [NSArray arrayWithArray: result];
        frames = [images count];

        [NSTimer scheduledTimerWithTimeInterval: 0.05
                                         target: self
                                       selector: @selector(nextFrame)
                                       userInfo: nil
                                        repeats: YES];

    }
    
    return self;

}

- (void)nextFrame {
    if (running) {
        frame++;
        if (frame >= frames) {
            frame = 0;
        }
        [self setFrame: frame];
    }
}

- (void)setFrame:(unsigned long)index {
    _statusItem.button.image = [images objectAtIndex: index];
    _statusItem.button.image.size = CGSizeMake(20, 28);
}

- (void)start {
    running = YES;
}

- (void)stop {
    running = NO;
}

@end
