//
//  PFRestaurants.m
//  MealPlanCust
//
//  Created by Zhichun Li on 10/26/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "PFRestaurants.h"
#import <Parse/PFObject+Subclass.h>

@implementation PFRestaurants
+(NSString *)parseClassName{
    return @"Business";
}
@dynamic address;
@dynamic business_hours;
@dynamic expected_delivery_time;
@dynamic history_order;
@dynamic location;
@dynamic menu;
@dynamic order;
@dynamic password;
@dynamic phone_number;
@dynamic restaurant_name;
@dynamic username;
@end
