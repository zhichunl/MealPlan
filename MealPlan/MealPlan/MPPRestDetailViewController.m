//
//  MPPRestDetailViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-11-16.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPRestDetailViewController.h"

#import "MPPButton.h"
#import "PureLayout.h"
#import <Foundation/Foundation.h>

static CGFloat const MPPRestDetailViewController_PaddingX = 20.0;
static CGFloat const MPPRestDetailViewController_PaddingY = 20.0;

@interface MPPRestDetailViewController ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;

@property (nonatomic) UILabel *addressHeader;
@property (nonatomic) UILabel *addressBody;
@property (nonatomic) UILabel *pickupTimeHeader;
@property (nonatomic) UILabel *pickupTimeBody;
@property (nonatomic) UILabel *deliveryTimeHeader;
@property (nonatomic) UILabel *deliveryTimeBody;
@property (nonatomic) UILabel *ordersHeader;
@property (nonatomic) UILabel *ordersBody;

@property (nonatomic) MPPButton *statusButton;
@property (nonatomic) NSMutableArray *orderCounts;
@property (nonatomic) NSArray *orderItems;
@property (nonatomic) int orderStatus;// 0: waiting for pickup
                                       // 1: waiting for delivery
                                       // 2: delivered
@property (nonatomic) NSArray *allOrders;
@end

@implementation MPPRestDetailViewController

- (void)loadView {
    [super loadView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMM dd, yyyy HH:mm";
    
    NSString *addressString = [self.restaurant objectForKey:@"address"];
    NSString *pickupTimeString = [dateFormatter stringFromDate:[self.restaurant objectForKey:@"deliverer_pickup_time"]];
    NSString *deliveryTimeString = [dateFormatter stringFromDate:[self.restaurant objectForKey:@"expected_delivery_time"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    // Content view
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    // Address header
    self.addressHeader = [self headerLabelWithText:[@"Address" uppercaseString]];
    [self.contentView addSubview:self.addressHeader];
    
    // Address body
    self.addressBody = [self bodyLabelWithText:addressString];
    [self.contentView addSubview:self.addressBody];
    
    // Pickup time header
    self.pickupTimeHeader = [self headerLabelWithText:[@"Pickup Time" uppercaseString]];
    [self.contentView addSubview:self.pickupTimeHeader];
    
    // Pickup time body
    self.pickupTimeBody = [self bodyLabelWithText:pickupTimeString];
    [self.contentView addSubview:self.pickupTimeBody];
    
    // Delivery time header
    self.deliveryTimeHeader = [self headerLabelWithText:[@"Delivery time" uppercaseString]];
    [self.contentView addSubview:self.deliveryTimeHeader];
    
    // Delivery time body
    self.deliveryTimeBody = [self bodyLabelWithText:deliveryTimeString];
    [self.contentView addSubview:self.deliveryTimeBody];
    
    // Orders header
    self.ordersHeader = [self headerLabelWithText:[@"Orders" uppercaseString]];
    [self.contentView addSubview:self.ordersHeader];
    
    // Orders body
    self.ordersBody = [self bodyLabelWithText:nil];   // Order text updated asynchronously
    [self.contentView addSubview:self.ordersBody];
    
    // Status button
    self.statusButton = [MPPButton button];
    [self.statusButton setTitle:@"Picked up!" forState:UIControlStateNormal];
    [self.statusButton addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.statusButton];
    
    // Constraints
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
    [self.contentView autoConstrainAttribute:ALAttributeHeight
                                 toAttribute:ALAttributeHeight
                                      ofView:self.view
                                  withOffset:0
                                    relation:NSLayoutRelationGreaterThanOrEqual];
    [self.contentView autoPinEdge:ALEdgeBottom
                           toEdge:ALEdgeBottom
                           ofView:self.deliveryTimeBody
                       withOffset:MPPRestDetailViewController_PaddingY
                         relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.addressHeader autoPinEdgeToSuperviewEdge:ALEdgeTop
                                         withInset:MPPRestDetailViewController_PaddingY];
    [self.addressHeader autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                         withInset:MPPRestDetailViewController_PaddingX];
    
    [self.addressBody autoPinEdge:ALEdgeTop
                           toEdge:ALEdgeBottom
                           ofView:self.addressHeader
                       withOffset:MPPRestDetailViewController_PaddingY];
    [self.addressBody autoPinEdge:ALEdgeLeft
                           toEdge:ALEdgeLeft
                           ofView:self.addressHeader
                       withOffset:MPPRestDetailViewController_PaddingX];
    
    [self.pickupTimeHeader autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.addressBody
                            withOffset:MPPRestDetailViewController_PaddingY];
    [self.pickupTimeHeader autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressHeader];
    
    [self.pickupTimeBody autoPinEdge:ALEdgeTop
                              toEdge:ALEdgeBottom
                              ofView:self.pickupTimeHeader
                          withOffset:MPPRestDetailViewController_PaddingY];
    [self.pickupTimeBody autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressBody];
    
    [self.deliveryTimeHeader autoPinEdge:ALEdgeTop
                                  toEdge:ALEdgeBottom
                                  ofView:self.pickupTimeBody
                              withOffset:MPPRestDetailViewController_PaddingY];
    [self.deliveryTimeHeader autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressHeader];
    
    [self.deliveryTimeBody autoPinEdge:ALEdgeTop
                                toEdge:ALEdgeBottom
                                ofView:self.deliveryTimeHeader
                            withOffset:MPPRestDetailViewController_PaddingY];
    [self.deliveryTimeBody autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressBody];
    
    [self.ordersHeader autoPinEdge:ALEdgeTop
                            toEdge:ALEdgeBottom
                            ofView:self.deliveryTimeBody
                        withOffset:MPPRestDetailViewController_PaddingY];
    [self.ordersHeader autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressHeader];
    
    [self.ordersBody autoPinEdge:ALEdgeTop
                          toEdge:ALEdgeBottom
                          ofView:self.ordersHeader
                      withOffset:MPPRestDetailViewController_PaddingY];
    [self.ordersBody autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.addressBody];
    
    [self.statusButton autoPinEdge:ALEdgeTop
                            toEdge:ALEdgeBottom
                            ofView:self.ordersBody
                        withOffset:2*MPPRestDetailViewController_PaddingY];
    [self.statusButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.restaurant objectForKey:@"restaurant_name"];
    
    // Fetch menu items only after view has loaded
    [self fetchOrdersAndStatus];
}

- (void)fetchOrdersAndStatus {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.orderItems = [self queryForMenuItems];
        [self queryForMenuCountsAndStatus];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateOrdersStringWithItems:self.orderItems];
            if (self.orderItems.count > 0) {
                PFObject *firstOrder = [self.orderItems firstObject];
                [self updateStatusButtonStringWithCurrentStatus:[firstOrder objectForKey:@"Status"]];
            }
        });
    });
}

- (void)updateOrdersStringWithItems:(NSArray *)orderItems {
    NSMutableString *ordersString = [[NSMutableString alloc] init];
    
    for (PFObject *orderItem in orderItems) {
        NSString *item = [orderItem objectForKey:@"details"];
        if (orderItem == [orderItems lastObject]) {
            [ordersString appendString:[NSString stringWithFormat:@"and %@.", item]];
        }
        else {
            [ordersString appendString:[NSString stringWithFormat:@"%@, ", item]];
        }
    }
    
    self.ordersBody.text = ordersString;
}

- (void)updateStatusButtonStringWithCurrentStatus:(NSString *)currentStatus {
    if ([currentStatus isEqualToString:@"closed"]) {
        self.statusButton.hidden = YES;
        return;
    }
    
    NSString *statusButtonString = nil;
    if ([currentStatus isEqualToString:@"waitingForPickup"]) {
        statusButtonString = @"Mark as picked up!";
    }
    else if ([currentStatus isEqualToString:@"readyToDeliver"]) {
        statusButtonString = @"Mark as delivered!";
    }
    
    [self.statusButton setTitle:statusButtonString forState:UIControlStateNormal];
}

- (void)changeStatus:(id)sender {
    // Update Parse database here
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getDayOfWeek {
    NSDateFormatter* day = [[NSDateFormatter alloc] init];
    day.dateFormat = @"eeee";
    NSLog(@"the day is: %@", [[day stringFromDate:[NSDate date]] lowercaseString]);
    return [[day stringFromDate:[NSDate date]] lowercaseString];
}

- (NSArray *)queryForMenuItems {
    PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
    [query whereKey:@"restaurant" equalTo: self.restaurant];
    [query whereKey:@"day_of_week" equalTo: [self getDayOfWeek]];
    NSArray *menus = [query findObjects];
    return menus;
}

- (void) queryForMenuCountsAndStatus {
    // build a list containing all the string of the objectIds of
    //NSMutableArray *orderItemObjectIds = [NSMutableArray array];
    self.orderCounts = [NSMutableArray array];
    for (PFObject *orderItem in self.orderItems) {
        //[orderItemObjectIds addObject: orderItem.objectId];
    
        PFQuery *query = [PFQuery queryWithClassName:@"Order"];
        [query whereKey:@"menu_item" containsAllObjectsInArray: [NSArray arrayWithObject: orderItem.objectId]];
        NSArray *orders = [query findObjects];
        [self.orderCounts addObject:@([orders count])];
    }
    // update the order status on this page
    PFQuery *query2 = [PFQuery queryWithClassName:@"Order"];
    [query2 whereKey:@"restaurant" equalTo:self.restaurant.objectId]; // TODO!!!!! Left off here equal doesn't work!!!!!!!
     self.allOrders = [query2 findObjects];
    self.orderStatus = 0;
    if ([self checkCheckedIn: self.allOrders]) {
        self.orderStatus = 1;
        if ([self checkAllDelivered: self.allOrders ]) {
            self.orderStatus = 2;
        }
    }
}


- (BOOL) checkCheckedIn: (NSArray *)orders{
    // check if all got picked up
    for (PFObject *order in orders) {
        if (![order objectForKey: @"checked_in"]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) checkAllDelivered: (NSArray *)orders{
    // check if all got picked up
    for (PFObject *order in orders) {
        
        if (![order objectForKey: @"delivered"]) {
            return NO;
        }
    }
    return YES;
}


#pragma mark - Helpers

- (UILabel *)headerLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:16];
    return label;
}

- (UILabel *)bodyLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = text;
    return label;
}

@end
