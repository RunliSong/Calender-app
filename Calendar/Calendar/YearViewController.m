//
//  YearViewController.m
//  Calendar
//
//  Created by RunliSong on 15/1/28.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "YearViewController.h"
#import "MonthInYearCollectionViewCell.h"
#import "DayViewController.h"
#import "Utilities.h"
#import "MonthViewController.h"
#import "SearchEventViewController.h"

@interface YearViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myYear;
- (IBAction)changeYear:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *yearCollection;
- (IBAction)searchEvent:(id)sender;
- (IBAction)addNewEvent:(id)sender;
- (IBAction)goToday:(id)sender;
@end

@implementation YearViewController{
    NSMutableArray *arrayOfMonths;
    NSMutableArray *arrayOfDays;
    NSArray *monthName;
    NSString *years;
    NSString *months;
    NSString *days;
    NSDateFormatter *dateInformation;
    NSLocale *location;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrayOfMonths = [[NSMutableArray alloc] init];
    monthName = [[NSArray alloc] initWithObjects:@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER", nil];
    location = [NSLocale currentLocale];
    
    dateInformation = [[NSDateFormatter alloc]init];
    [dateInformation setDateFormat:@"yyyy"];
    NSDate *sysdate = [NSDate date];
    if (!_currentYear) {
        years = [dateInformation stringFromDate:sysdate];
        _currentYear = [years intValue];
    }
    [_myYear setText:[NSString stringWithFormat:@"%i", (int)_currentYear]];
    [[self yearCollection]setDataSource:self];
    [[self yearCollection]setDelegate:self];
    
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
#pragma mark collection view methods
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"%i", indexPath.item);
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    MonthViewController *mvc = [story instantiateViewControllerWithIdentifier:@"monthViewController"];
    mvc.year = _currentYear;
    mvc.month = indexPath.item + 1;
    [self presentViewController:mvc animated:YES completion:nil];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifer = @"Month";
    MonthInYearCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:Cellidentifer forIndexPath:indexPath];
    [[cell myMonthName]setText:[monthName objectAtIndex:indexPath.item]];
    
    if (cell.selected == true) {
        _selectedMonth = (int)indexPath;
    }
    return cell;
}

- (IBAction)changeYear:(id)sender {
    ((UISegmentedControl *)sender).momentary = YES;
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            _currentYear--;
            years = [NSString stringWithFormat:@"%li",(long)_currentYear];
            [_myYear setText:years];
            
            break;
        default:
            _currentYear++;
            years = [NSString stringWithFormat:@"%li",(long)_currentYear];
            [_myYear setText:years];
            
            break;
    }

}
- (IBAction)searchEvent:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Kris" bundle:nil];
    SearchEventViewController *sevc = [story instantiateViewControllerWithIdentifier:@"Search"];
  
    [self presentViewController:sevc animated:YES completion:nil];
}

- (IBAction)addNewEvent:(id)sender {
}

- (IBAction)goToday:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"James" bundle:nil];
    DayViewController *dvc = [story instantiateViewControllerWithIdentifier:@"dayViewController"];

    [dateInformation setDateFormat:@"yyyy"];
    NSDate *sysdate = [NSDate date];
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
