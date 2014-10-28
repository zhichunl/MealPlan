//
//  DataCenter.h
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PFCustomer.h"

@protocol AlertToMoveOn;
@protocol RestaurantsDataFetched;

@interface DataCenter : NSObject
+(instancetype)sharedCenter;
-(void)registerUser:(id<FBGraphUser>)user delegate:(id<AlertToMoveOn>)del;
-(void)loginUser:(id<FBGraphUser>)user delegate:(id<AlertToMoveOn>)delegate;
-(void)fetchForBusiness:(id<RestaurantsDataFetched>)delegate;
@property (strong, nonatomic) PFCustomer* currentUser;
@end
@protocol AlertToMoveOn <NSObject>
-(void)moveOnToTableView;
@end

@protocol RestaurantsDataFetched <NSObject>
-(void)dataFetched:(NSArray *)businesses;
@end
