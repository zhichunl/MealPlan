//
//  MTTableViewCell.h
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTime;
@end
