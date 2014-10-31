//
//  MPPHomeTabViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-10-31.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPGlobals.h"
#import "MPPHomeTabViewController.h"
#import "MPPLoginViewController.h"


@interface MPPHomeTabViewController ()

@end

@implementation MPPHomeTabViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    if (![[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsUserID]) { // TODO change
        MPPLoginViewController *loginPage = [[MPPLoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginPage];
        [self presentViewController:navController animated:YES completion:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
