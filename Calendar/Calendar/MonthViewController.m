//
//  MonthViewController.m
//  Calendar
//
//  Created by RunliSong on 15/2/1.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "MonthViewController.h"
#import "DayViewController.h"
#import "DaysInMonthCollectionViewCell.h"
#import "YearViewController.h"
#import "Utilities.h"
#import "ResultTableViewCell.h"

@interface MonthViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *monthCollection;
- (IBAction)backToYear:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)goToToday:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *eventTable;

@end

@implementation MonthViewController
{
    NSMutableArray *daysarray;
    NSArray *monthName;
    YearViewController *datesInfor;
    NSString *years;
    NSString *months;
    NSString *days;
    NSDateFormatter *dateInformation;
    NSLocale *location;
    NSArray *events;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // register nib
    [_eventTable registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"Result"];
    
    // Do any additional setup after loading the view.
    daysarray = [[NSMutableArray alloc] init];
    monthName = [[NSArray alloc] initWithObjects:@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER", nil];
    [daysarray addObject:@"S"];
    [daysarray addObject:@"M"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"W"];
    [daysarray addObject:@"T"];
    [daysarray addObject:@"F"];
    [daysarray addObject:@"S"];
    dateInformation = [[NSDateFormatter alloc]init];
    NSLog(@"month: %li, year: %li", (long)_month, (long)_year);
    [self getDaysInMonth];
    NSString *yt = [NSString stringWithFormat:@"%li",(long)_year];
    [_backButton setTitle:yt forState:UIControlStateNormal];
    location = [NSLocale currentLocale];
    [[self monthCollection]setDataSource:self];
    [[self monthCollection]setDelegate:self];
    [[self eventTable]setDataSource:self];
    [[self eventTable]setDelegate:self];
    
    // first date of the month
    NSString *startDateString = [NSString stringWithFormat:@"%i-%i-%i", (int)_year, (int)_month, 1];
    Utilities *ult = [Utilities new];
    
    // last date of the month
    NSString *endDateString = [NSString stringWithFormat:@"%i-%i-%i", (int)_year, (int)_month, (int)[ult getAllDaysOfMonth:(int)_month inYear:(int)_year].count];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:startDateString];
    NSDate *endDate = [formatter dateFromString:endDateString];
    
    // get all events in this month
    events = [Utilities getEventsBetweenDate:startDate andEndDate:endDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)getDaysInMonth {
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSString *placeHolder = @" ";
    for (int i = 0; i < arr.count; i++) {
        
        NSDateComponents *component = [arr objectAtIndex:i];
        if ((int)component.day == 1) {
            int day = (int)component.weekday;
            
            for (int j = 1; j < day; j++) {
                [daysarray addObject:placeHolder];
            }
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        }
        else
            [daysarray addObject:[NSString stringWithFormat:@"%i", (int)component.day]];
        
    }
    
    return daysarray;
}
#pragma mark collection view methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger totalDays = 0;
    NSLog(@"%lu", (unsigned long)[arr count]);
    NSLog(@"%ld", (long)((NSDateComponents *)[arr objectAtIndex:0]).weekday);
    totalDays += 7;
    totalDays += [arr count];
    totalDays += ((NSDateComponents *)[arr objectAtIndex:0]).weekday - 1;
    return totalDays;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)_month inYear:(int)_year];
    NSInteger selected = indexPath.item - 7 - ((NSDateComponents *)[arr objectAtIndex:0]).weekday +2;
    
    
    if(selected >0)
    {
        dvc.weekdaytitle = ((NSDateComponents *)[arr objectAtIndex:selected]).weekday-1;
        dvc.datenum = selected;
        dvc.monthOfTheDay = _month;
        dvc.yearOfTheDay = _year;
        [self presentViewController:dvc animated:YES completion:nil];
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"day";
    DaysInMonthCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    
    [[cell dayName]setText:[daysarray objectAtIndex:indexPath.item]];
    
    return cell;
}
#pragma mark table view methods
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToYear:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)goToToday:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];
    
    NSDate *sysdate = [NSDate date];
    NSLog(@"%@",sysdate);
    [dateInformation setDateFormat:@"yyyy"];
    years = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"M"];
    months = [dateInformation stringFromDate:sysdate];
    [dateInformation setDateFormat:@"dd"];
    days = [dateInformation stringFromDate:sysdate];
    
    NSLog(@"year %@,month%@,day%@",years,months,days);
    NSInteger nowyear = [years integerValue];
    NSInteger nowMonth = [months integerValue];
    NSInteger nowDay = [days integerValue];
    
    long week;
    Utilities *utl = [Utilities new];
    NSArray *arr = [utl getAllDaysOfMonth:(int)nowMonth inYear:(int)nowyear];
    for (int g = 0; g<arr.count; g++) {
        if(((NSDateComponents *)[arr objectAtIndex:g]).day == nowDay)
        {
            week = ((NSDateComponents *)[arr objectAtIndex:g]).weekday;
        }
        
    }
    dvc.weekdaytitle = week;
    dvc.datenum = nowDay;
    dvc.monthTitle = monthName[nowMonth -1];
    dvc.monthOfTheDay = nowMonth;
    dvc.yearOfTheDay = nowyear;
    [self presentViewController:dvc animated:YES completion:nil];
    

}
@end
