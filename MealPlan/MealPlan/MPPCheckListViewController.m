//
//  MPPCheckListViewController.m
//  MealPlan
//
//  Created by Yuyang Guo on 14-11-17.
//  Copyright (c) 2014年 X2YZ. All rights reserved.
//

#import "MPPGlobals.h"
#import "MPPCheckListViewController.h"
#import <Parse/Parse.h>

@interface MPPCheckListViewController ()

@property (nonatomic) PFObject *deliverer;

@end

@implementation MPPCheckListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsUserID]);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"reuseIdentifier"];
    [self getDelivererInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"My Profile";
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", [self.deliverer objectForKey:@"Name"] ];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Phone Number: %@", [self.deliverer objectForKey:@"phone_number"] ];
 ;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) getDelivererInfo {
    PFQuery *query = [PFQuery queryWithClassName:@"Deliverer"];
    [query whereKey:@"user_id_twitter_digit" equalTo: [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultsUserID]];
    self.deliverer = [[query findObjects] firstObject];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
