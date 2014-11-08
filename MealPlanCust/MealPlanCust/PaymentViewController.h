//
//  PaymentViewController.h
//  MealPlanCust
//
//  Created by Zhichun Li on 11/4/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stripe.h"

@interface PaymentViewController : UIViewController
- (void)createBackendChargeWithToken:(STPToken *)token;
@end
