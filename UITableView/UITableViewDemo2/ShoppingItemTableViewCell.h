//
//  ShoppingItemTableViewCell.h
//  UITableViewDemo2
//
//  Created by Alexander Porshnev on 4/26/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingItemTableViewCell : UITableViewCell

- (void)configureWithShoppingItem:(ShoppingItem *)shoppingItem;

@end

NS_ASSUME_NONNULL_END
