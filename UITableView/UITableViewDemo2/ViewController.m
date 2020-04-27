//
//  ViewController.m
//  UITableViewDemo2
//
//  Created by Alexander Porshnev on 4/25/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingItem.h"
#import "ShoppingItemTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<ShoppingItem *> *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self fillInitialDataSource];
}

#pragma mark - Private views methods

- (void)setupViews {
    
    // NAvigation items setup
    self.navigationItem.title = @"Shopping List";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(showAddItemAlert)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                       target:self
                                                                                       action:@selector(toggleEditingMode)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    // Setup tableView
    self.tableView = [UITableView new];
    [self.tableView registerClass:ShoppingItemTableViewCell.class forCellReuseIdentifier:@"CellId"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    [cell configureWithShoppingItem:self.dataSource[indexPath.row]];
    return cell;
}

- (void)addItem:(NSString *)item {
    [self.dataSource addObject:[[ShoppingItem alloc] initWithTitle:item]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UIContextualAction *checkAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Check" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        weakSelf.dataSource[indexPath.row].completed = !weakSelf.dataSource[indexPath.row].completed;
//        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        ShoppingItemTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell configureWithShoppingItem:weakSelf.dataSource[indexPath.row]];
        completionHandler(YES);
    }];
    checkAction.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:215.0/255.0 blue:75.0/255.0 alpha:255.0/255.0];
    return [UISwipeActionsConfiguration configurationWithActions:@[checkAction]];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        completionHandler(YES);
    }];
    return [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ShoppingItem *item = self.dataSource[sourceIndexPath.row];
    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
    [self.dataSource insertObject:item atIndex:destinationIndexPath.row];
    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark - Handlers

- (void)showAddItemAlert {
    // Create UIAlertController instance
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New item"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // Configure text field
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"What do you want to buy?";
    }];
    
    // Configure Done action
    __weak typeof(self) weakSelf = self;
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *enteredText = alertController.textFields.firstObject.text;
        if (enteredText.length > 0) {
            [self addItem:enteredText];
        }
    }];
    
    //Configure  Cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    //Add actions into AlertController
    [alertController addAction:doneAction];
    [alertController addAction:cancelAction];
    
    // Present Alert Controller
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)toggleEditingMode {
    self.tableView.editing = !self.tableView.editing;
}

- (void)fillInitialDataSource {
    self.dataSource = [NSMutableArray arrayWithArray:@[
        [[ShoppingItem alloc] initWithTitle:@"Oranges"],
        [[ShoppingItem alloc] initWithTitle:@"Milk"],
        [[ShoppingItem alloc] initWithTitle:@"Cookies"],
        [[ShoppingItem alloc] initWithTitle:@"Apples"],
        [[ShoppingItem alloc] initWithTitle:@"Sweets"]
    ]];
}

@end
