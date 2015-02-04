//
//  DayViewController.m
//  Calendar
//
//  Created by RunliSong on 01/02/2015
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "DayViewController.h"
#import "Utilities.h"
#import "Event.h"
#import "ResultTableViewCell.h"
#import "EditViewController.h"
#import "SearchEventViewController.h"
#import "EventDetailViewController.h"

@interface DayViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myWeekDay;
@property (strong, nonatomic) IBOutlet UILabel *myDate;
@property (strong, nonatomic) IBOutlet UITableView *dayEventsTableView;
- (IBAction)backToMonth:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *backMonth;
- (IBAction)searchEvent:(id)sender;
- (IBAction)addNewEvent:(id)sender;


@end

@implementation DayViewController
{
    NSMutableArray *weekdays;
    NSArray *monthName;
    NSArray *events;
    NSDateFormatter *datefor;
}

- (void)viewDidLoad {
    //register nib
    [_dayEventsTableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    _dayEventsTableView.delegate = self;
    _dayEventsTableView.dataSource = self;
    weekdays = [[NSMutableArray alloc]init];
    [weekdays addObject:@"Saterday"];
    [weekdays addObject:@"Sunday"];
    [weekdays addObject:@"Monday"];
    [weekdays addObject:@"Yuesday"];
    [weekdays addObject:@"Wendesday"];
    [weekdays addObject:@"Thursday"];
    [weekdays addObject:@"Friday"];
    monthName = [[NSArray alloc] initWithObjects:@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER", nil];
    if (_pickedDate) {
        datefor = [[NSDateFormatter alloc] init];
        [datefor setDateFormat:@"yyyy"];
        NSString* years = [datefor stringFromDate:_pickedDate];
        [datefor setDateFormat:@"M"];
        NSString* months = [datefor stringFromDate:_pickedDate];
        [datefor setDateFormat:@"dd"];
        NSString* days = [datefor stringFromDate:_pickedDate];
        NSLog(@"year%@,month%@,date%@",years,months,days);
       _yearOfTheDay = [years integerValue];
        _monthOfTheDay = [months integerValue];
        _datenum = [days integerValue];
        
        
    }
    
    _monthTitle = monthName[_monthOfTheDay-1];
    NSString *ms = [NSString stringWithFormat:@"<%li %@",(long)_yearOfTheDay,_monthTitle];
    [_backMonth setTitle:ms forState:UIControlStateNormal];
    NSLog(@"weekday: %li, date: %li", (long)_weekdaytitle, (long)_datenum);
    NSString *dates = [NSString stringWithFormat:@"%li",(long)_datenum];
    NSString *weekdayt = weekdays[1];
    [self.myDate setText:dates];
    [self.myWeekDay setText:weekdayt];
    // Do any additional setup after loading the view.
    
    NSString *todayString = [NSString stringWithFormat:@"%i-%i-%i", (int)_yearOfTheDay, (int)_monthOfTheDay, (int)_datenum];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *todayDate = [formatter dateFromString:todayString];
    events = [Utilities getEventsBetweenDate:todayDate andEndDate:todayDate];
    _dayEventsTableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //should be number of events;
    
    return [events count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Result" forIndexPath:indexPath];
    if (events) {
        cell.eventTitle.text = ((Event *)[events objectAtIndex:indexPath.row]).title;
        NSDate *localTime = ((Event *)[events objectAtIndex:indexPath.row]).localTime;
        NSDate *otherTime = ((Event *)[events objectAtIndex:indexPath.row]).otherTime;
        cell.backgroundColor = [UIColor clearColor];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MMMM-dd hh:mm a"];
        cell.eventLocalTime.text = [formatter stringFromDate:localTime];
        
        if (otherTime) {
            [cell.eventOtherTime setHidden:NO];
            cell.eventOtherTime.text = [formatter stringFromDate:otherTime];
        }
        else {
            [cell.eventOtherTime setHidden:YES];
        }
        
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *krisStoryboard = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    EventDetailViewController *edvc = (EventDetailViewController *)[krisStoryboard instantiateViewControllerWithIdentifier:@"EventDetail"];
    edvc.event = [events objectAtIndex:indexPath.row];
    [self presentViewController:edvc animated:YES completion:nil];
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
- (IBAction)searchEvent:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    SearchEventViewController *sevc = [story instantiateViewControllerWithIdentifier:@"Search"];
    
    [self presentViewController:sevc animated:YES completion:nil];

}

- (IBAction)addNewEvent:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *sevc = [story instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    
    [self presentViewController:sevc animated:YES completion:nil];
}
@end
