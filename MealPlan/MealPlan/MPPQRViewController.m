//
//  MPPQRViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-10-17.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPQRViewController.h"

@interface MPPQRViewController ()

@end

@implementation MPPQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
}


- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
