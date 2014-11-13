//
//  MTDetailViewController.m
//  MealPlanCust
//
//  Created by Zhichun Li on 10/25/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "MTDetailViewController.h"
#import "PaymentViewController.h"

@interface MTDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.curRestaurant.restaurant_name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    [formatter setDateFormat:@"MM/dd HH:mm"];
    self.deliveryTime.text = [formatter stringFromDate: self.curRestaurant.expected_delivery_time];
    UINib *nib = [UINib nibWithNibName:@"UITableViewCell" bundle:nil];
    [self.menuItems registerNib:nib
         forCellReuseIdentifier:@"UITableViewCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payWithStripe:(id)sender {
    PaymentViewController *pvc = [[PaymentViewController alloc] init];
    pvc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)dismiss{
    [self.navigationController popToViewController:self animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSString *name = [self.menu objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.menu count];
}

@end
