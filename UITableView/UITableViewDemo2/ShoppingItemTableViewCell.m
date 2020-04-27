//
//  ShoppingItemTableViewCell.m
//  UITableViewDemo2
//
//  Created by Alexander Porshnev on 4/26/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "ShoppingItemTableViewCell.h"

@interface ShoppingItemTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *completedIndicatorView;

@end

@implementation ShoppingItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
}

- (void)configureWithShoppingItem:(ShoppingItem *)shoppingItem {
    self.titleLabel.text = shoppingItem.title;
    self.completedIndicatorView.hidden = !shoppingItem.completed;
}
            
- (void)setupViews {
    self.completedIndicatorView = [UIView new];
    self.completedIndicatorView.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:215.0/255.0 blue:75.0/255.0 alpha:255.0/255.0];
    self.completedIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.completedIndicatorView];
    [NSLayoutConstraint activateConstraints:@[
        [self.completedIndicatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.completedIndicatorView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.completedIndicatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.completedIndicatorView.widthAnchor constraintEqualToConstant:10.0]
    ]];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16.0],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16.0],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

@end
