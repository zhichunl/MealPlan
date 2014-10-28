//
//  PFCustomer.h
//  MealPlanCust
//
//  Created by Zhichun Li on 10/26/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PFCustomer : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (retain) NSArray *history_order;
@property (retain) NSArray *order;
@property (retain) NSString *password;
@property (retain) NSString *username;
@property (retain) NSString *FBID;
@end
