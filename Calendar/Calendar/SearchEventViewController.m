//
//  SearchEventViewController.m
//  Calendar
//
//  Created by Peng Gao on 31/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "SearchEventViewController.h"
#import "SearchResultTableViewController.h"
#import "Utilities.h"

@interface SearchEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *eventKeyword;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDate;
- (IBAction)backToPrevious:(id)sender;

@end

@implementation SearchEventViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_fromDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [_toDate setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)search:(id)sender {
    NSArray *result = [Utilities getEventsWithTitle:_eventTitle.text description:_eventKeyword.text startDate:_fromDate.date andEndDate:_toDate.date];
    if ([result count]) {
        SearchResultTableViewController *svc = [[SearchResultTableViewController alloc] init];
        svc.events = result;
        [self presentViewController:svc animated:YES completion:nil];

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No result" message:@"Can't find any relate event, please check conditions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
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

- (IBAction)backToPrevious:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
