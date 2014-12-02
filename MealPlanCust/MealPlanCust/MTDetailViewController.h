//
//  MTDetailViewController.h
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFRestaurants.h"

@interface MTDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *deliveryTime;
@property (weak, nonatomic) IBOutlet UITableView *menuItems;
@property (strong, nonatomic) PFRestaurants *curRestaurant;
@property (strong, nonatomic) NSArray *menu;

-(void)settheMenu:(NSArray *)menu;
@end
