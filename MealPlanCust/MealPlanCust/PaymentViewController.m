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

@interface PaymentViewController ()<PTKViewDelegate>
@property (weak, nonatomic) PTKView *paymentView;
@property (weak, nonatomic) UIButton *saveButton;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PTKView *view = [[PTKView alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    self.paymentView = view;
    self.paymentView.delegate = self;
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(145, 45, 30, 10)];
    self.saveButton = saveButton;
    [self.saveButton addTarget:self action:@selector(_save) forControlEvents:UIControlEventAllTouchEvents];
    [self.view addSubview:self.paymentView];
    [self.view addSubview:self.saveButton];
    
}

- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid{
}

-(void)_save{
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error) {
            exit(1);
        } else {
            [self createBackendChargeWithToken:token];
        }
    }];
}


- (void)createBackendChargeWithToken:(STPToken *)token{
    NSURL *url = [NSURL URLWithString:@"https://example.com/token"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
