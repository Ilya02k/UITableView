//
//  ShoppingItem.m
//  UITableViewDemo2
//
//  Created by Alexander Porshnev on 4/25/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "ShoppingItem.h"

@implementation ShoppingItem

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _completed = NO;
    }
    return self;
}

@end
