//
//  Preferences.m
//  zinc
//
//  Created by Dana Basken on 5/25/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

- (id)init {
    if (self = [super init]) {
        [self setPreference: @"rsyncPath" toDefaultIfNeeded: @"/usr/bin/rsync"];
        [self setPreference: @"rsyncArgs" toDefaultIfNeeded: @"-azPq"];
    }
    return self;
}

- (void)setPreference:(NSString *)name toDefaultIfNeeded:(NSString *)value {
    if ([self getPreference: name] == nil) {
        NSLog(@"setting preference '%@' to default of '%@'", name, value);
        [self setPreference: name toValue: value];
    }
}

- (NSString *)getPreference:(NSString *)name {
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey: name];
    if (value == nil) {
        value = @"";
    }
    return value;
}

- (void)setPreference:(NSString *)name toValue:(NSString *)value {
    [[NSUserDefaults standardUserDefaults] setObject: value forKey: name];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
