//
//  Preferences.h
//  zinc
//
//  Created by Dana Basken on 5/25/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

- (id)init;
- (NSString *)getPreference:(NSString *)name;
- (void)setPreference:(NSString *)name toValue:(NSString *)value;

@end
