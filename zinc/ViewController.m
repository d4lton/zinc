//
//  ViewController.m
//  zinc
//
//  Created by Dana Basken on 5/24/17.
//  Copyright © 2017 Dana Basken. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"initWithCoder");
    if (self = [super initWithCoder:aDecoder]) {
        preferenceNames = @[@"rsyncPath", @"rsyncArgs", @"srcPath", @"dstPath"];
        preferences = [[Preferences alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [preferenceNames count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    if ([identifier isEqualToString:@"Name"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier: identifier owner: self];
        cellView.textField.stringValue = [preferenceNames objectAtIndex: row];
        return cellView;
    } else if ([identifier isEqualToString:@"Value"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier: identifier owner: self];
        NSString *name = [preferenceNames objectAtIndex: row];
        NSString *value = [preferences getPreference: name];
        if (value == nil) {
            value = @"";
        }
        cellView.textField.stringValue = value;
        return cellView;
    } else {
        NSLog(@"Unknown column identifier: %@", identifier);
    }
    return nil;
}

- (IBAction)onEnterInTextField:(NSTextField *)textField {
    NSString *name = [preferenceNames objectAtIndex: _tableView.selectedRow];
    [preferences setPreference: name toValue: textField.stringValue];
    [_tableView reloadData];
}

@end
