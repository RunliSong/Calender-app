//
//  SearchResultTableViewController.m
//  Calendar
//
//  Created by Peng Gao on 31/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "ResultTableViewCell.h"
#import "Utilities.h"
#import "EventDetailViewController.h"

@interface SearchResultTableViewController ()
{
    UIView *footerView;
}
@end

@implementation SearchResultTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    //_events = [Utilities getAllEvents];
    [self.tableView reloadData];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Result" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.eventTitle.text = ((Event *)[_events objectAtIndex:indexPath.row]).title;
    // Configure the cell...
    NSDate *localTime = ((Event *)[_events objectAtIndex:indexPath.row]).localTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMMM-yyyy hh:mm a"];
    cell.eventLocalTime.text = [formatter stringFromDate:localTime];
    
    NSDate *otherTime = ((Event *)[_events objectAtIndex:indexPath.row]).otherTime;
    if (otherTime) {
        [cell.eventOtherTime setHidden:NO];
        NSString *otherTimeString = [formatter stringFromDate:otherTime];
        NSString *otherName = ((Event *)[_events objectAtIndex:indexPath.row]).otherName;
        if (otherTime) {
            otherTimeString = [otherTimeString stringByAppendingString:[NSString stringWithFormat:@"%c%@", 64, otherName]];
            
        }
        cell.eventOtherTime.text = otherTimeString;
    } else {
        [cell.eventOtherTime setHidden:YES];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"%@", [_events objectAtIndex:indexPath.row]);
    
    UIStoryboard *krisStoryboard = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    EventDetailViewController *edvc = (EventDetailViewController *)[krisStoryboard instantiateViewControllerWithIdentifier:@"EventDetail"];
    edvc.event = [_events objectAtIndex:indexPath.row];
    [self presentViewController:edvc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    footerView = [[UIView alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(5, 3, self.tableView.frame.size.width - 10,44)];
    
    [button setTitle:@"<<Back" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backToPrevious) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    return footerView;
}

- (void) backToPrevious {
    [self dismissViewControllerAnimated:YES completion:nil];
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
