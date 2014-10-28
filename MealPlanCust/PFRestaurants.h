//
//  PFRestaurants.h
//  MealPlanCust
//
//  Created by Zhichun Li on 10/26/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PFRestaurants : PFObject<PFSubclassing>
+(NSString *)parseClassName;
@property (retain) NSString* address;
@property (retain) NSString* business_hours;
@property (retain) NSDate* expected_delivery_time;
@property (retain) NSArray* history_order;
@property (retain) PFGeoPoint *location;
@property (retain) NSArray* menu;
@property (retain) NSArray *order;
@property (retain) NSString *password;
@property (retain) NSString *phone_number;
@property (retain) NSString *restaurant_name;
@property (retain) NSString *username;
@end
