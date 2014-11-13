//
//  PaymentViewController.m
//  MealPlanCust
//
//  Created by Zhichun Li on 11/4/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "PaymentViewController.h"
#import "PTKView.h"
#import "Stripe.h"

@interface PaymentViewController ()<PTKViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) PTKView *paymentView;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIAlertView *alertView;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PTKView *view = [[PTKView alloc] initWithFrame:CGRectMake(40, 100, 290, 55)];
    self.paymentView = view;
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Not a valid card" message:@"please enter in a valid card!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    self.paymentView.delegate = self;
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton addTarget:self action:@selector(_save) forControlEvents:UIControlEventAllTouchEvents];
    self.saveButton.frame = CGRectMake(150, 500, 80, 40);
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.paymentView];
    [self.view addSubview:self.saveButton];
    
}

-(void)_edit{
    
}

- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid{

}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
   
}

-(void)_save{
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error) {
            [self.alertView show];
        } else {
            [self createBackendChargeWithToken:token];
        }
    }];
}


- (void)createBackendChargeWithToken:(STPToken *)token{
    NSURL *url = [NSURL URLWithString:@"https://mealplanpp.appspot.com"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"stripeToken=%@", token.tokenId];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
