//
//  DataCenter.m
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "DataCenter.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PFCustomer.h"
#import "PFRestaurants.h"

@implementation DataCenter

+(instancetype)sharedCenter{
    static DataCenter *sharedCenter = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        sharedCenter = [[self alloc]init];
    });
    return sharedCenter;
}

-(void)registerUser:(id<FBGraphUser>)user delegate:(id<AlertToMoveOn>)del{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFCustomer *userStore = [PFCustomer object];
        userStore.history_order = @[];
        userStore.order = @[];
        userStore.username = user.name;
        userStore.password = @"password";
        userStore.FBID = user.objectID;
        [userStore save];
        [del moveOnToTableView];
    });
}

-(void)loginUser:(id<FBGraphUser>)user delegate:(id<AlertToMoveOn>)delegate{
    PFQuery *query = [PFCustomer query];
    NSString *fbid = user.objectID;
    [query whereKey:@"FBID" equalTo:fbid];
    __weak DataCenter*weaksel = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        weaksel.currentUser = (PFCustomer *)[query getFirstObject];
        [delegate moveOnToTableView];
    });
}

-(void)fetchForBusiness:(id<RestaurantsDataFetched>)delegate{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFQuery *query = [PFRestaurants query];
        [query whereKey:@"expected_delivery_time" greaterThanOrEqualTo:[NSDate date]];
        NSMutableArray *objects = [[query findObjects] mutableCopy];
        NSMutableArray *businesses = [NSMutableArray array];
        for (PFRestaurants *r in objects){
            PFRestaurants *fr = (PFRestaurants *)[r fetchIfNeeded];
            [businesses addObject:fr];
        }
        [objects sortUsingComparator:^NSComparisonResult(PFRestaurants *r1, PFRestaurants*r2) {
            return [r1.expected_delivery_time compare:r2.expected_delivery_time];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate dataFetched:[businesses copy]];
        });
    });
}

@end
