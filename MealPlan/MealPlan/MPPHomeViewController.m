//
//  MPPHomeViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-10-17.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPHomeViewController.h"
#import "PureLayout.h"

@interface MPPHomeViewController ()

@property UIImageView *doggie;

@end

@implementation MPPHomeViewController

- (void)loadView {
    [super loadView];
    
    self.doggie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doggie"]];
    self.doggie.translatesAutoresizingMaskIntoConstraints = NO;
    self.doggie.contentMode = UIViewContentModeScaleAspectFill;
    self.doggie.alpha = 0;
    [self.view addSubview:self.doggie];
    [self.doggie autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(showDoggie) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Woof!" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button autoCenterInSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view.
}

- (void)showDoggie {
    [UIView animateWithDuration:1 animations:^{
        self.doggie.alpha = 1;
    }];
}

@end
