//
//  ShoppingItem.h
//  UITableViewDemo2
//
//  Created by Alexander Porshnev on 4/25/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL completed;

- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
