//
//  DayViewController.m
//  Calendar
//
//  Created by RunliSong on 15/2/1.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "DayViewController.h"
#import "Utilities.h"
#import "Event.h"

@interface DayViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myWeekDay;
@property (strong, nonatomic) IBOutlet UILabel *myDate;
@property (strong, nonatomic) IBOutlet UITableView *dayEventsTableView;
- (IBAction)backToMonth:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *backMonth;

@end

@implementation DayViewController
{
    NSMutableArray *weekdays;
    NSArray *monthName;
    NSArray *events;
}

- (void)viewDidLoad {
    //register nib
    [_dayEventsTableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    
    weekdays = [[NSMutableArray alloc]init];
    [weekdays addObject:@"Saterday"];
    [weekdays addObject:@"Sunday"];
    [weekdays addObject:@"Monday"];
    [weekdays addObject:@"Yuesday"];
    [weekdays addObject:@"Wendesday"];
    [weekdays addObject:@"Thursday"];
    [weekdays addObject:@"Friday"];
    monthName = [[NSArray alloc] initWithObjects:@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER", nil];
    _monthTitle = monthName[_monthOfTheDay-1];
    
    [_backMonth setTitle:_monthTitle forState:UIControlStateNormal];
    NSLog(@"weekday: %li, date: %li", (long)_weekdaytitle, (long)_datenum);
    NSString *dates = [NSString stringWithFormat:@"%li",(long)_datenum];
    NSString *weekdayt = weekdays[_weekdaytitle];
    [self.myDate setText:dates];
    [self.myWeekDay setText:weekdayt];
    // Do any additional setup after loading the view.
    
    NSString *todayString = [NSString stringWithFormat:@"%i-%i-%i", (int)_yearOfTheDay, (int)_monthOfTheDay, 1];
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

- (IBAction)backToMonth:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
