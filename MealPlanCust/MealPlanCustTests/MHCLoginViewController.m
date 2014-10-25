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

@interface MHCLoginViewController ()<UIAlertViewDelegate, FBLoginViewDelegate>
@property (atomic, assign) BOOL registered;
@property (strong, nonatomic) UIAlertView *message;
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
        PFQuery *forUser = [PFUser query];
        [forUser whereKey:@"profileID" equalTo:user.objectID];
        [forUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if ([objects count] == 0){
                //[[FBUDataCenter sharedCenter] registerUser:user];
            }
            else {
                //[[FBUDataCenter sharedCenter] loginUser:user];
            }
        }];
        self.registered = YES;
    }
}

//the action after user login.
//-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
//    [self _loadAlertView];
//}


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


