//
//  PFCustomer.m
//  MealPlanCust
//
//  Created by Zhichun Li on 10/26/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "PFCustomer.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFCustomer

+ (NSString *)parseClassName{
    return @"Customer";
}

@dynamic history_order;
@dynamic order;
@dynamic password;
@dynamic username;
@dynamic FBID;
@end
