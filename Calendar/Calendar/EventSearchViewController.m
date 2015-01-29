//
//  EventSearchViewController.m
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "EventSearchViewController.h"

@interface EventSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDate;

@end

@implementation EventSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)searchResult:(UIButton *)sender {
    
}
- (IBAction)backToDayView:(UIButton *)sender {
    // back to day view
    [self dismissViewControllerAnimated:YES completion:nil];
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
