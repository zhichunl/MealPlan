//
//  MHCLoginViewController.m
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "MHCLoginViewController.h"
#import "Parse/Parse.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DataCenter.h"
#import "MealTableTableViewController.h"
#import "CurrentOrdersTableViewController.h"
#import "SummaryViewController.h"
#import "PFCustomer.h"

@interface MHCLoginViewController ()<FBLoginViewDelegate, AlertToMoveOn>
@property (atomic, assign) BOOL registered;
@end

@implementation MHCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//fetching user info to upload to parse
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    if (!self.registered){
        PFQuery *forUser = [PFCustomer query];
        [forUser whereKey:@"FBID" equalTo:user.objectID];
        [forUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if ([objects count] == 0){
                [[DataCenter sharedCenter] registerUser:user delegate:self];
            }
            else {
                [[DataCenter sharedCenter] loginUser:user delegate:self];
            }
        }];
        self.registered = YES;
    }
}

-(void)moveOnToTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        UITabBarController *tabBar = [[UITabBarController alloc] init];
        MealTableTableViewController *table = [[MealTableTableViewController alloc] init];
        CurrentOrdersTableViewController *cO = [[CurrentOrdersTableViewController alloc] init];
        SummaryViewController *svc = [[SummaryViewController alloc] init];
        tabBar.viewControllers = @[table, cO, svc];
        [self.navigationController pushViewController:tabBar animated:YES];
    });
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    FBLoginView *loginView = [[FBLoginView alloc]initWithReadPermissions:
                              @[@"public_profile", @"email", @"user_friends"]];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 3*self.view.bounds.size.height/5);
    [self.view addSubview:loginView];
    self.registered = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


