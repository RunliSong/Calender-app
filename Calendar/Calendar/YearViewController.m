//
//  YearViewController.m
//  Calendar
//
//  Created by RunliSong on 15/1/28.
//  Copyright (c) 2015年 Deakin University. All rights reserved.
//

#import "YearViewController.h"
#import "MonthInYearCollectionViewCell.h"
#import "Utilities.h"
#import "MonthViewController.h"

@interface YearViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myYear;
- (IBAction)changeYear:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *yearCollection;
@end

@implementation YearViewController{
    NSMutableArray *arrayOfMonths;
    NSMutableArray *arrayOfDays;
    NSArray *monthName;
    NSString *years;
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
    years = [dateInformation stringFromDate:sysdate];
    _currentYear = [years intValue];
    [_myYear setText:years];
    [self getMonthsInAyear];
    [[self yearCollection]setDataSource:self];
    [[self yearCollection]setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getMonthsInAyear {
    
    int year = 2015;
    for (int month = 1; month<13; month++) {
        Utilities *utl = [Utilities new];
        NSArray *arr = [utl getAllDaysOfMonth:month inYear:year];
        arrayOfDays = [[NSMutableArray alloc] init];
        NSString *stringToDisplay;
        NSString *placeHolder = @" ";
        for (int i = 0; i < arr.count; i++) {
            
            NSDateComponents *component = [arr objectAtIndex:i];
            if ((int)component.day == 1) {
                int day = (int)component.weekday;
                
                for (int j = 1; j < day; j++) {
                    placeHolder = [placeHolder stringByAppendingString:placeHolder];
                }
                
                stringToDisplay =[NSString stringWithFormat:@"%@%i", placeHolder,(int)component.day];
            }
            
            else if (component.weekday != 6) {
                stringToDisplay = [NSString stringWithFormat:@" %i", (int)component.day];
            }
            else {
                stringToDisplay = [NSString stringWithFormat:@" %i\n", (int)component.day];
            }
            
            [arrayOfDays addObject:stringToDisplay];
            
        }
        [arrayOfMonths addObject:arrayOfDays];
    }
    
    return arrayOfMonths;
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
    
    
    //[[cell myWeekDays]setText:@"S  M  T  W  T  F  S"];
    
    [[cell myMonthName]setText:[monthName objectAtIndex:indexPath.item]];
    //    NSString *monthString = @"";
    //    for (NSString *s in [arrayOfMonths objectAtIndex:indexPath.row]) {
    //        monthString = [monthString stringByAppendingString:s];
    //    }
    //
    //    [[cell mydaysInMonth]setText:monthString];
    
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
@end
