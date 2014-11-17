//
//  MPPLoginViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-10-17.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPGlobals.h"
#import <TwitterKit/TwitterKit.h>
#import "PureLayout.h"
#import "MPPLoginViewController.h"



@interface MPPLoginViewController ()

@property UIImageView *doggie;

@end

@implementation MPPLoginViewController

- (void)loadView {
    [super loadView];
    
//    self.doggie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doggie"]];
//    self.doggie.translatesAutoresizingMaskIntoConstraints = NO;
//    self.doggie.contentMode = UIViewContentModeScaleAspectFill;
//    self.doggie.alpha = 0;
//    [self.view addSubview:self.doggie];
//    [self.doggie autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.translatesAutoresizingMaskIntoConstraints = NO;
//    [button addTarget:self action:@selector(showDoggie) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Woof!" forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    [button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];

//    UIButton *startQRButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    startQRButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [startQRButton addTarget:self action:@selector(showQRScanner) forControlEvents:UIControlEventTouchUpInside];
//    [startQRButton setTitle:@"QR!" forState:UIControlStateNormal];
//    [self.view addSubview:startQRButton];
//    [startQRButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [startQRButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        [self digitSignedInWithUserId:session.userID];
    }];
    authenticateButton.center = self.view.center;
    [self.view addSubview:authenticateButton];
    // Do any additional setup after loading the view.
}

- (void)digitSignedInWithUserId: (NSString *)userID {
    NSLog(@"%@", userID);
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:UserDefaultsUserID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)showDoggie {
//    [UIView animateWithDuration:1 animations:^{
//        self.doggie.alpha = !self.doggie.alpha;
//    }];
//}

//- (void)showQRScanner {
//    MPPQRViewController *QRViewController = [[MPPQRViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:QRViewController];
//    [self presentViewController:navController animated:YES completion:nil];
//}

@end
