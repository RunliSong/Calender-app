//
//  EventSearchViewController.m
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EventSearchViewController.h"
#import "Utilities.h"



@interface EventSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDate;

@end

@implementation EventSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backToDayView:(UIButton *)sender {
    // back to day view
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)searchResult:(id)sender {
        NSArray *results = [Utilities getEventsWithTitle:_eventTitle.text description:_keyword.text startDate:_fromDate.date andEndDate:_toDate.date];
        if (results.count) {
            //go to show result
//            ResultsTableViewController *resultController = [[ResultsTableViewController alloc] init];
//            //resultController.events = results;
//            [self presentViewController:resultController animated:YES completion:nil];
//    
        }
        else {
            NSString *alertTitle = @"Can't find any event meets the condition";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't find anything" message:alertTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    NSArray *results = [Utilities getEventsWithTitle:_eventTitle.text description:_keyword.text startDate:_fromDate.date andEndDate:_toDate.date];
//    if (results.count) {
//        //go to show result
//        ResultsTableViewController *resultController = [[ResultsTableViewController alloc] init];
//        //resultController.events = results;
//        [self presentViewController:resultController animated:YES completion:nil];
//        
//    }
//    else {
//        NSString *alertTitle = @"Can't find any event meets the condition";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't find anything" message:alertTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//    }
//}


@end
